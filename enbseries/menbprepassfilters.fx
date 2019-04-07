/*
	menbprepassfilters.fx : MariENB prepass shader routines.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
#define tod ENightDayFactor
#define ind EInteriorFactor
VS_OUTPUT_POST VS_Pass( VS_INPUT_POST IN )
{
	VS_OUTPUT_POST OUT;
	OUT.vpos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord.xy = IN.txcoord.xy;
	return OUT;
}
/* these are znear/zfar values for Skyrim, but MAY match Fallout too */
float depthlinear( float2 coord )
{
	float zNear = 0.0509804;
	float zFar = 3098.0392;
	float z = tex2D(SamplerDepth,coord).x;
	return (2*zNear)/(zFar+zNear-z*(zFar-zNear));
}
/* That "luma sharpen" thingy, added just because someone might want it */
float3 Sharpen( float3 res, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	if ( fixedx>0 ) bresl.x = fixedx;
	if ( fixedy>0 ) bresl.y = fixedy;
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*sharpradius;
	float4 crawling = tex2D(SamplerColor,coord+float2(0,-1)*bof);
	crawling += tex2D(SamplerColor,coord+float2(-1,0)*bof);
	crawling += tex2D(SamplerColor,coord+float2(1,0)*bof);
	crawling += tex2D(SamplerColor,coord+float2(0,1)*bof);
	crawling *= 0.25;
	float3 inmyskin = res-crawling.rgb;
	float thesewounds = dot(inmyskin,0.33);
	thesewounds = clamp(thesewounds,-sharpclamp,sharpclamp);
	float3 theywillnotheal = res+thesewounds*sharpblend;
	return theywillnotheal;
}
/* New and improved edge detection, generally useful for contour shading */
float3 Edge( float3 res, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	if ( fixedx>0 ) bresl.x = fixedx;
	if ( fixedy>0 ) bresl.y = fixedy;
	float edgefadepow = lerp(lerp(edgefadepow_n,edgefadepow_d,tod),
		lerp(edgefadepow_in,edgefadepow_id,tod),ind);
	float edgefademult = lerp(lerp(edgefademult_n,edgefademult_d,tod),
		lerp(edgefademult_in,edgefademult_id,tod),ind);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y);
	float mdx = 0, mdy = 0, mud = 0;
	/* this reduces texture fetches by half, big difference */
	float3x3 depths;
	int i, j;
	for ( i=-1; i<=1; i++ ) for ( j=-1; j<=1; j++ )
		depths[i+1][j+1] = depthlinear(coord+float2(i,j)*bof);
	for ( i=0; i<=2; i++ ) for ( j=0; j<=2; j++ )
		mdx += GX[i][j]*depths[i][j];
	for ( i=0; i<=2; i++ ) for ( j=0; j<=2; j++ )
		mdy += GY[i][j]*depths[i][j];
	mud = pow(mdx*mdx+mdy*mdy,0.5);
	float fade = 1.0-tex2D(SamplerDepth,coord).x;
	mud *= saturate(pow(fade,edgefadepow)*edgefademult);
	mud = saturate(pow(mud,edgepow)*edgemult);
	if ( edgeview ) return mud;
	return res-mud;
}
/* the pass that happens before everything else */
float4 PS_FirstPass( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( sharpenable ) res.rgb = Sharpen(res.rgb,coord);
	if ( edgeenable ) res.rgb = Edge(res.rgb,coord);
	return res;
}
/* Crappy SSAO */
float3 pseudonormal( float dep, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 ofs1 = float2(0,1.0/bresl.y);
	float2 ofs2 = float2(1.0/bresl.x,0);
	float dep1 = tex2D(SamplerDepth,coord+ofs1).x;
	float dep2 = tex2D(SamplerDepth,coord+ofs2).x;
	float3 p1 = float3(ofs1,dep1-dep);
	float3 p2 = float3(ofs2,dep2-dep);
	float3 normal = cross(p1,p2);
	normal.z = -normal.z;
	return normalize(normal);
}
float4 PS_SSAOPrepass( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	float ssaofadepow = lerp(lerp(ssaofadepow_n,ssaofadepow_d,tod),
		lerp(ssaofadepow_in,ssaofadepow_id,tod),ind);
	float ssaofademult = lerp(lerp(ssaofademult_n,ssaofademult_d,tod),
		lerp(ssaofademult_in,ssaofademult_id,tod),ind);
	if ( !ssaoenable ) return res;
	float depth = tex2D(SamplerDepth,coord).x;
	float ldepth = depthlinear(coord);
	if ( depth >= cutoff*0.000001 )
	{
		res.a = 1.0;
		return res;
	}
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float3 normal = pseudonormal(depth,coord);
	float2 nc = coord*(bresl/256.0);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*ssaoradius;
	float2 nc2 = tex2D(SamplerNoise3,nc+48000.0*Timer.x).xy;
	float3 rnormal = tex2D(SamplerNoise3,nc2).xyz*2.0-1.0;
	rnormal.z = -abs(rnormal.z);
	normal = normalize(normal+rnormal*ssaonoise);
	float occ = 0.0;
	int i;
	float3 sample;
	float sdepth, rangecheck;
	float sclamp = ssaocfact/1000.0;
	int maxsmp;
	if ( ssaohq ) maxsmp = 64;
	else maxsmp = 16;
	for ( i=0; i<maxsmp; i++ )
	{
		if ( ssaohq ) sample = reflect(ssao_hq[i],normal);
		else sample = reflect(ssao_lq[i],normal);
		sdepth = depthlinear(coord+sample.xy*bof);
		if ( ldepth < sdepth ) occ += 1.0;
		else occ += saturate((abs(ldepth-sdepth)-sclamp)/sclamp);
	}
	float uocc = saturate(1.0-occ/float(maxsmp*2));
	float fade = 1.0-depth;
	uocc *= saturate(pow(fade,ssaofadepow)*ssaofademult);
	uocc = saturate(pow(uocc,ssaopow)*ssaomult);
	res.a = saturate(1.0-(uocc*ssaoblend));
	return res;
}
float4 PS_SSAOBlurH( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !ssaoenable ) return res;
	if ( !ssaobenable ) return res;
	float bresl = (fixedx>0)?fixedx:ScreenSize.x;
	float bof = (1.0/bresl)*ssaobradius;
	float isd, sd, ds, sw, tw = 0;
	res.a = 0.0;
	int i;
	isd = tex2D(SamplerDepth,coord).x;
	for ( i=-15; i<=15; i++ )
	{
		sd = tex2D(SamplerDepth,coord+float2(i,0)*bof).x;
		ds = abs(isd-sd)*ssaobfact+0.5;
		sw = 1.0/(ds+1.0);
		sw *= gauss16[abs(i)];
		tw += sw;
		res.a += sw*tex2D(SamplerColor,coord+float2(i,0)*bof).a;
	}
	res.a /= tw;
	return res;
}
float4 PS_SSAOBlurV( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !ssaoenable ) return res;
	if ( !ssaobenable )
	{
		if ( ssaodebug ) return saturate(res.a);
		return res*res.a;
	}
	float bresl = (fixedy>0)?fixedy:(ScreenSize.x*ScreenSize.w);
	float bof = (1.0/bresl)*ssaobradius;
	float isd, sd, ds, sw, tw = 0;
	res.a = 0.0;
	int i;
	isd = tex2D(SamplerDepth,coord).x;
	for ( i=-15; i<=15; i++ )
	{
		sd = tex2D(SamplerDepth,coord+float2(0,i)*bof).x;
		ds = abs(isd-sd)*ssaobfact+0.5;
		sw = 1.0/(ds+1.0);
		sw *= gauss16[abs(i)];
		tw += sw;
		res.a += sw*tex2D(SamplerColor,coord+float2(0,i)*bof).a;
	}
	res.a /= tw;
	if ( ssaodebug ) return saturate(res.a);
	res *= res.a;
	return res;
}
/* Focus */
float4 PS_ReadFocus( VS_OUTPUT_POST IN ) : COLOR
{
	if ( dofdisable ) return 0.0;
	float focusmax = lerp(lerp(focusmax_n,focusmax_d,tod),lerp(focusmax_in,
		focusmax_id,tod),ind);
	float cfocus = min(tex2D(SamplerDepth,0.5).x,focusmax*0.001);
	if ( !focuscircle ) return cfocus;
	float focusradius = lerp(lerp(focusradius_n,focusradius_d,tod),
		lerp(focusradius_in,focusradius_id,tod),ind);
	float focusmix = lerp(lerp(focusmix_n,focusmix_d,tod),lerp(focusmix_in,
		focusmix_id,tod),ind);
	float step = (1.0/3.0);
	float mfocus;
	float2 coord;
	float2 bof = float2(1.0,ScreenSize.w)*focusradius*0.001;
	coord.x = 0.5+sin(0.0)*bof.x;
	coord.y = 0.5+cos(0.0)*bof.y;
	mfocus = step*min(tex2D(SamplerDepth,coord).x,focusmax*0.001);
	coord.x = 0.5+sin(2.0*pi*step)*bof.x;
	coord.y = 0.5+cos(2.0*pi*step)*bof.y;
	mfocus += step*min(tex2D(SamplerDepth,coord).x,focusmax*0.001);
	coord.x = 0.5+sin(4.0*pi*step)*bof.x;
	coord.y = 0.5+cos(4.0*pi*step)*bof.y;
	mfocus += step*min(tex2D(SamplerDepth,coord).x,focusmax*0.001);
	cfocus = (1.0-focusmix)*cfocus+focusmix*mfocus;
	return cfocus;
}
float4 PS_WriteFocus( VS_OUTPUT_POST IN ) : COLOR
{
	if ( dofdisable ) return 0.0;
	return max(lerp(tex2D(SamplerPrev,0.5).x,tex2D(SamplerCurr,0.5).x,
		saturate(FadeFactor)),0.0);
}
/* Depth of Field */
float4 PS_DoFPrepass( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return tex2D(SamplerColor,coord);
	float dofpow = lerp(lerp(dofpow_n,dofpow_d,tod),lerp(dofpow_in,
		dofpow_id,tod),ind);
	float dofmult = lerp(lerp(dofmult_n,dofmult_d,tod),lerp(dofmult_in,
		dofmult_id,tod),ind);
	float doffixedfocuspow = lerp(lerp(doffixedfocuspow_n,
		doffixedfocuspow_d,tod),lerp(doffixedfocuspow_in,
		doffixedfocuspow_id,tod),ind);
	float doffixedfocusmult = lerp(lerp(doffixedfocusmult_n,
		doffixedfocusmult_d,tod),lerp(doffixedfocusmult_in,
		doffixedfocusmult_id,tod),ind);
	float doffixedfocusblend = lerp(lerp(doffixedfocusblend_n,
		doffixedfocusblend_d,tod),lerp(doffixedfocusblend_in,
		doffixedfocusblend_id,tod),ind);
	float doffixedunfocuspow = lerp(lerp(doffixedunfocuspow_n,
		doffixedunfocuspow_d,tod),lerp(doffixedunfocuspow_in,
		doffixedunfocuspow_id,tod),ind);
	float doffixedunfocusmult = lerp(lerp(doffixedunfocusmult_n,
		doffixedunfocusmult_d,tod),lerp(doffixedunfocusmult_in,
		doffixedunfocusmult_id,tod),ind);
	float doffixedunfocusblend = lerp(lerp(doffixedunfocusblend_n,
		doffixedunfocusblend_d,tod),lerp(doffixedunfocusblend_in,
		doffixedunfocusblend_id,tod),ind);
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y);
	float dep = tex2D(SamplerDepth,coord).x;
	float foc = tex2D(SamplerFocus,coord).x;
	float dfc = abs(dep-foc);
	float dff = abs(dep);
	float dfu = dff;
	/*
	   Change power of dof based on field of view. Works only in Skyrim,
	   Boris is just such a fucking assbutt that he doesn't update the
	   FO3/FNV version to be feature-equal to this, inventing pathetic
	   excuses.
	*/
	if ( dofrelfov )
	{
		float relfovfactor = lerp(lerp(relfovfactor_n,relfovfactor_d,
			tod),lerp(relfovfactor_in,relfovfactor_id,tod),ind);
		float relfov = (FieldOfView-fovdefault)/fovdefault;
		dofpow = max(0,dofpow+relfov*relfovfactor);
	}
	dfc = saturate(pow(dfc,dofpow)*dofmult);
	dff = saturate(pow(dff,doffixedfocuspow)*doffixedfocusmult);
	dfu = saturate(pow(dfu,doffixedunfocuspow)*doffixedunfocusmult);
	dfc *= lerp(1.0,dff,doffixedfocusblend);
	dfc += lerp(0.0,dfu,doffixedunfocusblend);
	dfc = saturate(dfc);
	float4 res = tex2D(SamplerColor,coord);
	res.a = dfc;
	return res;
}
float4 PS_DoFBlurH( VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return tex2D(SamplerColor,coord);
	float dfc = tex2D(SamplerColor,coord).a;
	if ( dofdebug ) return dfc;
	float bresl = (fixedx>0)?fixedx:ScreenSize.x;
	float bof = (1.0/bresl)*dofbradius;
	float4 res = float4(0,0,0,0);
	if ( dfc <= 0.0 )
	{
		res = tex2D(SamplerColor,coord);
		res.a = dfc;
		return res;
	}
	int i;
	if ( dofbilateral )
	{
		float isd, sd, ds, sw, tw = 0;
		isd = dfc;
		for ( i=-7; i<=7; i++ )
		{
			sd = tex2D(SamplerColor,coord+float2(i,0)*bof*dfc).a;
			ds = abs(isd-sd)*dofbfact+0.5;
			sw = 1.0/(ds+1.0);
			sw *= gauss8[abs(i)];
			tw += sw;
			res += sw*tex2D(SamplerColor,coord+float2(i,0)*bof
				*dfc);
		}
		res /= tw;
	}
	else
	{
		for ( i=-7; i<=7; i++ )
			res += gauss8[abs(i)]*tex2D(SamplerColor,coord
				+float2(i,0)*bof*dfc);
	}
	res.a = dfc;
	return res;
}
float4 PS_DoFBlurV( VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return tex2D(SamplerColor,coord);
	float dfc = tex2D(SamplerColor,coord).a;
	if ( dofdebug ) return dfc;
	float bresl = (fixedy>0)?fixedy:(ScreenSize.x*ScreenSize.w);
	float bof = (1.0/bresl)*dofbradius;
	float4 res = float4(0,0,0,0);
	if ( dfc <= 0.0 )
	{
		res = tex2D(SamplerColor,coord);
		res.a = dfc;
		return res;
	}
	int i;
	if ( dofbilateral )
	{
		float isd, sd, ds, sw, tw = 0;
		isd = dfc;
		for ( i=-7; i<=7; i++ )
		{
			sd = tex2D(SamplerColor,coord+float2(0,i)*bof*dfc).a;
			ds = abs(isd-sd)*dofbfact+0.5;
			sw = 1.0/(ds+1.0);
			sw *= gauss8[abs(i)];
			tw += sw;
			res += sw*tex2D(SamplerColor,coord+float2(0,i)*bof
				*dfc);
		}
		res /= tw;
	}
	else
	{
		for ( i=-7; i<=7; i++ )
			res += gauss8[abs(i)]*tex2D(SamplerColor,coord
				+float2(0,i)*bof*dfc);
	}
	res.a = 1.0;
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
		PixelShader = compile ps_3_0 PS_FirstPass();
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
		PixelShader = compile ps_3_0 PS_SSAOPrepass();
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
		PixelShader = compile ps_3_0 PS_SSAOBlurH();
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
		PixelShader = compile ps_3_0 PS_SSAOBlurV();
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
technique PostProcess5
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
technique PostProcess6
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_DoFBlurH();
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
technique PostProcess7
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_DoFBlurV();
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
