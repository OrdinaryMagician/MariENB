/*
	menbdepthoffieldfilters.fx : MariENB dof shader routines.
	(C)2013-2017 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
VS_OUTPUT_POST VS_Pass( VS_INPUT_POST IN )
{
	VS_OUTPUT_POST OUT;
	OUT.vpos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord.xy = IN.txcoord.xy;
	return OUT;
}
/* helper functions */
/* photometric */
#define luminance(x) dot(x,float3(0.2126,0.7152,0.0722))
/* CCIR601 */
//#define luminance(x) dot(x,float3(0.299,0.587,0.114))
/* Focus */
float4 PS_ReadFocus( VS_OUTPUT_POST IN ) : COLOR
{
	if ( focuscircle < 0 ) return focusmanualvalue*0.001;
	float focusmax = tod_ind(focusmax);
	float2 fcenter = float2(focuscenter_x*0.01,focuscenter_y*0.01);
	float cfocus = min(tex2D(SamplerDepth,fcenter).x,focusmax*0.001);
	if ( focuscircle == 0 ) return cfocus;
	if ( focuscircle == 2 )
	{
		int i, j;
		float mfocus = 0.0;
		float2 px;
		[unroll] for( j=0; j<8; j++ ) [unroll] for( i=0; i<8; i++ )
		{
			px = float2((i+0.5)/8.0,(j+0.5)/8.0);
			mfocus += min(tex2D(SamplerDepth,px).x,focusmax*0.001);
		}
		return mfocus/64.0;
	}
	/* using polygons inscribed into a circle, in this case a triangle */
	float focusradius = tod_ind(focusradius);
	float focusmix = tod_ind(focusmix);
	float cstep = (1.0/3.0);
	float mfocus;
	float2 coord;
	float2 bof = float2(1.0,1.0/ScreenSize.w)*focusradius*0.01;
	float fan = focuscircleangle*2.0*pi;
	coord.x = fcenter.x+sin(fan)*bof.x;
	coord.y = fcenter.y+cos(fan)*bof.y;
	mfocus = cstep*min(tex2D(SamplerDepth,coord).x,focusmax*0.001);
	coord.x = fcenter.x+sin(fan+2.0*pi*cstep)*bof.x;
	coord.y = fcenter.y+cos(fan+2.0*pi*cstep)*bof.y;
	mfocus += cstep*min(tex2D(SamplerDepth,coord).x,focusmax*0.001);
	coord.x = fcenter.x+sin(fan+4.0*pi*cstep)*bof.x;
	coord.y = fcenter.y+cos(fan+4.0*pi*cstep)*bof.y;
	mfocus += cstep*min(tex2D(SamplerDepth,coord).x,focusmax*0.001);
	cfocus = (1.0-focusmix)*cfocus+focusmix*mfocus;
	return cfocus;
}
float4 PS_WriteFocus( VS_OUTPUT_POST IN ) : COLOR
{
	return max(lerp(tex2D(SamplerPrev,0.5).x,tex2D(SamplerCurr,0.5).x,
		saturate(FadeFactor)),0.0);
}
/* Depth of Field */
float4 PS_DoFPrepass( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float dofpow = tod_ind(dofpow);
	float dofmult = tod_ind(dofmult);
	float dofbump = tod_ind(dofbump);
	float doffixedfocuspow = tod_ind(doffixedfocuspow);
	float doffixedfocusmult = tod_ind(doffixedfocusmult);
	float doffixedfocusbump = tod_ind(doffixedfocusbump);
	float doffixedfocusblend = tod_ind(doffixedunfocusblend);
	float doffixedunfocuspow = tod_ind(doffixedunfocuspow);
	float doffixedunfocusmult = tod_ind(doffixedunfocusmult);
	float doffixedunfocusbump = tod_ind(doffixedunfocusbump);
	float doffixedunfocusblend = tod_ind(doffixedunfocusblend);
	float doffogpow = tod_ind(doffogpow);
	float doffogmult = tod_ind(doffogmult);
	float doffogbump = tod_ind(doffogbump);
	float doffogblend = tod_ind(doffogblend);
	float dep = tex2D(SamplerDepth,coord).x;
	float foc = tex2D(SamplerFocus,coord).x;
	/* cheap tilt */
	foc = foc+0.01*doftiltx*(doftiltxcenter-coord.x)
		+0.01*doftilty*(doftiltycenter-coord.y);
	float dff = abs(dep-doffixedfocusdepth);
	dff = clamp(pow(dff,doffixedfocuspow)*doffixedfocusmult
		+doffixedfocusbump,0.0,1.0);
	if ( dep > doffixedfocuscap ) dff = 1.0;
	float dfu = abs(dep-doffixedunfocusdepth);
	dfu = clamp(pow(dfu,doffixedunfocuspow)*doffixedunfocusmult
		+doffixedunfocusbump,0.0,1.0);
	float dfog = abs(dep-doffogdepth);
	dfog = clamp(pow(dfog,doffogpow)*doffogmult+doffogbump,0.0,1.0);
	if ( doffixedcut && (dep >= cutoff*0.000001) ) dfu *= 0;
	/* Change power of dof based on field of view */
	float relfovfactor = tod_ind(relfovfactor);
	float relfov = (FieldOfView-fovdefault)/fovdefault;
	dofpow = max(0,dofpow+relfov*relfovfactor);
	float dfc = abs(dep-foc);
	dfc = clamp(pow(dfc,dofpow)*dofmult+dofbump,0.0,1.0);
	if ( doffixedonly ) dfc *= 0;
	dfc += lerp(0.0,dfu,doffixedunfocusblend);
	if ( doffogenable ) dfc += fogfactor*lerp(0.0,dfog,doffogblend);
	dfc *= lerp(1.0,dff,doffixedfocusblend);
	dfc = saturate(dfc);
	float4 res = tex2D(SamplerColor,coord);
	res.a = dfc;
	return res;
}
/* helper code for simplifying these */
#define gcircle(x) float2(cos(x),sin(x))
float4 dofsample( float2 coord, float2 bsz, float blur, out float4 deps,
	out float4 dfcs )
{
	float4 res;
	float cstep = 2.0*pi*(1.0/3.0);
	float ang = 0.5*pi;
	res.r = tex2D(SamplerColor,coord+gcircle(ang)*bsz*dofpcha*0.1).r;
	deps.r = tex2D(SamplerDepth,coord+gcircle(ang)*bsz*dofpcha*0.1).x;
	dfcs.r = tex2D(SamplerColor,coord+gcircle(ang)*bsz*dofpcha*0.1).a;
	ang += cstep;
	res.g = tex2D(SamplerColor,coord+gcircle(ang)*bsz*dofpcha*0.1).g;
	deps.g = tex2D(SamplerDepth,coord+gcircle(ang)*bsz*dofpcha*0.1).x;
	dfcs.g = tex2D(SamplerColor,coord+gcircle(ang)*bsz*dofpcha*0.1).a;
	ang += cstep;
	res.b = tex2D(SamplerColor,coord+gcircle(ang)*bsz*dofpcha*0.1).b;
	deps.b = tex2D(SamplerDepth,coord+gcircle(ang)*bsz*dofpcha*0.1).x;
	dfcs.b = tex2D(SamplerColor,coord+gcircle(ang)*bsz*dofpcha*0.1).a;
	float l = luminance(res.rgb);
	float threshold = max((l-dofbthreshold)*dofbgain,0.0);
	res += lerp(0,res,threshold*blur);
	res.a = tex2D(SamplerColor,coord).a;
	deps.a = tex2D(SamplerDepth,coord).x;
	dfcs.a = res.a;
	return res;
}
/* gather blur pass  */
float4 PS_DoFGather( VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float dfc = tex2D(SamplerColor,coord).a;
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = 1.0/bresl;
	/*
	   Skip blurring areas that are perfectly in focus. The performance
	   gain is negligible in most cases, though.
	*/
	if ( dfc <= dofminblur ) return tex2D(SamplerColor,coord);
	float4 res = float4(0,0,0,0);
	float dep = tex2D(SamplerDepth,coord).x;
	float2 bsz = bof*dofpradius*dfc;
	float4 sc, ds, sd, sw, tw = float4(0,0,0,0);
	[unroll] for ( int i=0; i<32; i++ )
	{
		sc = dofsample(coord+poisson32[i]*bsz,bsz,dfc,ds,sd);
		sw.r = (ds.r>dep)?1.0:sd.r;
		sw.g = (ds.g>dep)?1.0:sd.g;
		sw.b = (ds.b>dep)?1.0:sd.b;
		sw.a = (ds.a>dep)?1.0:sd.a;
		tw += sw;
		res += sc*sw;
	}
	res /= tw;
	res.a = dfc;
	return res;
}
/* "bokeh" blur pass */
float4 PS_DoFBorkeh( VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float dfc = tex2D(SamplerColor,coord).a;
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = 1.0/bresl;
	float4 res = tex2D(SamplerColor,coord);
	res.a = 0.0;
	/*
	   Skip blurring areas that are perfectly in focus. The performance
	   gain is negligible in most cases, though.
	*/
	if ( dfc <= dofminblur ) return res;
	float dep = tex2D(SamplerDepth,coord).x;
	float2 sf = bof+(tex2D(SamplerNoise3,coord*(bresl/256.0)).xy*2.0-1.0)
		*dofbnoise*0.001;
	float2 sr = sf*dofbradius*dfc;
	int rsamples;
	float bstep, bw;
	float4 sc, ds, sd, sw, tw = float4(1,1,1,1);
	float2 rcoord;
	#define dofbrings 7
	#define dofbsamples 3
	[unroll] for ( int i=1; i<=dofbrings; i++ )
	{
		rsamples = i*dofbsamples;
		[unroll] for ( int j=0; j<rsamples; j++ )
		{
			bstep = pi*2.0/(float)rsamples;
			rcoord = gcircle(j*bstep)*i;
			bw = lerp(1.0,(float)i/(float)dofbrings,dofbbias);
			sc = dofsample(coord+rcoord*sr,sr*i,dfc,ds,sd);
			sw.r = (ds.r>dep)?1.0:sd.r;
			sw.g = (ds.g>dep)?1.0:sd.g;
			sw.b = (ds.b>dep)?1.0:sd.b;
			sw.a = (ds.a>dep)?1.0:sd.a;
			res += sc*sw*bw;
			tw += sw*bw;
		}
	}
	res /= tw;
	res.a = dfc;
	return res;
}
float4 PS_DoFPostBlur( VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float dfc = tex2D(SamplerColor,coord).a;
	if ( dofdebug ) return tex2D(SamplerDepth,coord).x;
	if ( dfcdebug ) return dfc;
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*dofpbradius;
	float2 ofs[16] =
	{
		float2(1.0,1.0), float2(-1.0,-1.0),
		float2(-1.0,1.0), float2(1.0,-1.0),
		
		float2(1.0,0.0), float2(-1.0,0.0),
		float2(0.0,1.0), float2(0.0,-1.0),
		
		float2(1.41,0.0), float2(-1.41,0.0),
		float2(0.0,1.41), float2(0.0,-1.41),
		
		float2(1.41,1.41), float2(-1.41,-1.41),
		float2(-1.41,1.41), float2(1.41,-1.41)
	};
	float4 res = tex2D(SamplerColor,coord);
	int i;
	[unroll] for ( i=0; i<16; i++ )
		res += tex2D(SamplerColor,coord+ofs[i]*bof*dfc);
	res /= 17.0;
	res.a = 1.0;
	return res;
}
/* focus point debug */
float4 PS_FocusDebug( VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !focusdisplay || (focuscircle < 0) ) return res;
	if ( focuscircle == 2 )
	{
		int i, j;
		float2 px;
		[unroll] for( j=0; j<8; j++ ) [unroll] for( i=0; i<8; i++ )
		{
			px = float2((i+0.5)/8.0,(j+0.5)/8.0);
			if ( distance(coord,px) < 0.005 )
				res.rgb = float3(1,0,0);
		}
		return res;
	}
	float2 fcenter = float2(focuscenter_x*0.01,focuscenter_y*0.01);
	if ( distance(coord,fcenter) < 0.005 ) res.rgb = float3(1,0,0);
	if ( focuscircle == 0 ) return res;
	float cstep = (1.0/3.0);
	float2 tcoord;
	float focusradius = tod_ind(focusradius);
	float2 bof = float2(1.0,1.0/ScreenSize.w)*focusradius*0.01;
	float fan = focuscircleangle*2.0*pi;
	tcoord.x = fcenter.x+sin(fan)*bof.x;
	tcoord.y = fcenter.y+cos(fan)*bof.y;
	if ( distance(coord,tcoord) < 0.005 ) res.rgb = float3(1,0,0);
	tcoord.x = fcenter.x+sin(fan+2.0*pi*cstep)*bof.x;
	tcoord.y = fcenter.y+cos(fan+2.0*pi*cstep)*bof.y;
	if ( distance(coord,tcoord) < 0.005 ) res.rgb = float3(1,0,0);
	tcoord.x = fcenter.x+sin(fan+4.0*pi*cstep)*bof.x;
	tcoord.y = fcenter.y+cos(fan+4.0*pi*cstep)*bof.y;
	if ( distance(coord,tcoord) < 0.005 ) res.rgb = float3(1,0,0);
	return res;
}
technique ReadFocus
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_ReadFocus();
		ZENABLE = FALSE;
		CullMode = NONE;
		ALPHATESTENABLE = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		AlphaBlendEnable = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
technique WriteFocus
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_WriteFocus();
		ZENABLE = FALSE;
		CullMode = NONE;
		ALPHATESTENABLE = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		AlphaBlendEnable = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
technique PostProcess
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_DoFPrepass();
		DitherEnable = FALSE;
		ZEnable = FALSE;
		CullMode = NONE;
		ALPHATESTENABLE = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		AlphaBlendEnable = FALSE;
		StencilEnable = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
technique PostProcess2
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_DoFGather();
		DitherEnable = FALSE;
		ZEnable = FALSE;
		CullMode = NONE;
		ALPHATESTENABLE = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		AlphaBlendEnable = FALSE;
		StencilEnable = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
technique PostProcess3
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_DoFPostBlur();
		DitherEnable = FALSE;
		ZEnable = FALSE;
		CullMode = NONE;
		ALPHATESTENABLE = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		AlphaBlendEnable = FALSE;
		StencilEnable = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
technique PostProcess4
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_FocusDebug();
		DitherEnable = FALSE;
		ZEnable = FALSE;
		CullMode = NONE;
		ALPHATESTENABLE = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		AlphaBlendEnable = FALSE;
		StencilEnable = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}

technique PostProcessB <string UIName="Bokeh DOF";>
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_DoFPrepass();
		DitherEnable = FALSE;
		ZEnable = FALSE;
		CullMode = NONE;
		ALPHATESTENABLE = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		AlphaBlendEnable = FALSE;
		StencilEnable = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
technique PostProcessB2
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_DoFBorkeh();
		DitherEnable = FALSE;
		ZEnable = FALSE;
		CullMode = NONE;
		ALPHATESTENABLE = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		AlphaBlendEnable = FALSE;
		StencilEnable = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
technique PostProcessB3
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_DoFPostBlur();
		DitherEnable = FALSE;
		ZEnable = FALSE;
		CullMode = NONE;
		ALPHATESTENABLE = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		AlphaBlendEnable = FALSE;
		StencilEnable = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
technique PostProcessB4
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_FocusDebug();
		DitherEnable = FALSE;
		ZEnable = FALSE;
		CullMode = NONE;
		ALPHATESTENABLE = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		AlphaBlendEnable = FALSE;
		StencilEnable = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}