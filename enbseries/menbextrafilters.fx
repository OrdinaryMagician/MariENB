/*
	menbextrafilters.fx : MariENB extra shader routines.
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
/* helpers */
/* photometric */
#define luminance(x) dot(x,float3(0.2126,0.7152,0.0722))
/* CCIR601 */
//#define luminance(x) dot(x,float3(0.299,0.587,0.114))
float3 rgb2hsv( float3 c )
{
	float4 K = float4(0.0,-1.0/3.0,2.0/3.0,-1.0);
	float4 p = (c.g<c.b)?float4(c.bg,K.wz):float4(c.gb,K.xy);
	float4 q = (c.r<p.x)?float4(p.xyw,c.r):float4(c.r,p.yzx);
	float d = q.x-min(q.w,q.y);
	float e = 1.0e-10;
	return float3(abs(q.z+(q.w-q.y)/(6.0*d+e)),d/(q.x+e),q.x);
}
float3 hsv2rgb( float3 c )
{
	float4 K = float4(1.0,2.0/3.0,1.0/3.0,3.0);
	float3 p = abs(frac(c.x+K.xyz)*6.0-K.w);
	return c.z*lerp(K.x,saturate(p-K.x),c.y);
}
float4 PS_ChromaKey( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !maskenable ) return res;
	float dep = tex2D(SamplerDepth,coord).x;
	float msd = maskd;
	msd = maskd+0.01*masktiltx*(masktiltxcenter-coord.x)
		+0.01*masktilty*(masktiltycenter-coord.y);
	if ( dep > msd )
		return float4(maskr,maskg,maskb,1.0);
	return res;
}
/* that's right, CRT curvature */
float4 PS_Curvature( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !curveenable ) return res;
	float3 eta = float3(1+chromaab*0.009,1+chromaab*0.006,1+chromaab
		*0.003);
	float2 center = float2(coord.x-0.5,coord.y-0.5);
	float zfact = 100.0/lenszoom;
	float r2 = center.x*center.x+center.y*center.y;
	float f = 1+r2*lensdist*0.01;
	float x = f*zfact*center.x+0.5;
	float y = f*zfact*center.y+0.5;
	float2 rcoord = (f*eta.r)*zfact*(center.xy*0.5)+0.5;
	float2 gcoord = (f*eta.g)*zfact*(center.xy*0.5)+0.5;
	float2 bcoord = (f*eta.b)*zfact*(center.xy*0.5)+0.5;
	int i,j;
	float3 idist = float3(tex2D(SamplerColorb,rcoord).r,
		tex2D(SamplerColorb,gcoord).g,
		tex2D(SamplerColorb,bcoord).b);
	res.rgb = idist.rgb;
	return res;
}
/* Why am I doing this */
float4 PS_Blur( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !bssblurenable ) return res;
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
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*bssblurradius;
	int i;
	[unroll] for ( i=0; i<16; i++ )
		res += tex2D(SamplerColor,coord+ofs[i]*bof);
	res /= 17.0;
	res.a = 1.0;
	return res;
}
float4 PS_Sharp( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !bsssharpenable ) return res;
	float2 ofs[8] =
	{
		float2(1.0,1.0), float2(-1.0,-1.0),
		float2(-1.0,1.0), float2(1.0,-1.0),
		
		float2(1.41,1.41), float2(-1.41,-1.41),
		float2(-1.41,1.41), float2(1.41,-1.41)
	};
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*bsssharpradius;
	float4 tcol = res;
	int i;
	[unroll] for ( i=0; i<8; i++ )
		tcol += tex2D(SamplerColor,coord+ofs[i]*bof);
	tcol /= 9.0;
	float4 orig = res;
	res = orig*(1.0+dot(orig.rgb-tcol.rgb,0.333333)*bsssharpamount);
	float rg = clamp(pow(orig.b,3.0),0.0,1.0);
	res = lerp(res,orig,rg);
	res.a = 1.0;
	return res;
}
float4 PS_Shift( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !bssshiftenable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*bssshiftradius;
	res.g = tex2D(SamplerColor,coord).g;
	res.r = tex2D(SamplerColor,coord+float2(0,-bof.y)).r;
	res.b = tex2D(SamplerColor,coord+float2(0,bof.y)).b;
	res.a = 1.0;
	return res;
}
/* vignette filtering */
float4 PS_Vignette( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	float4 vigdata = float4(0,0,0,0);
	if ( vigshape == 0 )
	{
		/* circular vignette */
		float2 uv = ((coord-0.5)*float2(1.0,ScreenSize.w))*2.0;
		vigdata.a = dot(uv,uv);
		vigdata.a = clamp(pow(vigdata.a,vigpow)*vigmul+vigbump,
			0.0,1.0);
		vigdata.rgb = float3(vigcolor_r,vigcolor_g,vigcolor_b);
	}
	else if ( vigshape == 1 )
	{	
		/* box vignette */
		float2 uv = coord.xy*(1.0-coord.yx)*4.0;
		vigdata.a = 1.0-(uv.x*uv.y);
		vigdata.a = clamp(pow(max(vigdata.a,0.0),vigpow)*vigmul
			+vigbump,0.0,1.0);
		vigdata.rgb = float3(vigcolor_r,vigcolor_g,vigcolor_b);
	}
	else
	{
		/* textured vignette (rgb = color, alpha = blend) */
		vigdata = tex2D(SamplerVignette,coord);
	}
	/* apply blur */
	if ( bblurenable )
	{
		float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
		float bfact = clamp(pow(max(vigdata.a,0.0),bblurpow)*bblurmul
			+bblurbump,0.0,1.0);
		float2 bof = (1.0/bresl)*bblurradius*bfact;
		res.rgb *= 0;
		int i,j;
		[unroll] for ( i=-3; i<4; i++ ) [unroll] for ( j=-3; j<4; j++ )
			res.rgb += gauss4[abs(i)]*gauss4[abs(j)]
				*tex2D(SamplerColor,coord+float2(i,j)*bof).rgb;
	}
	/* apply color */
	if ( vigenable )
	{
		float3 outcol;
		if ( vigmode == 0 )
			outcol = vigdata.rgb;
		else if ( vigmode == 1 )
			outcol = res.rgb+vigdata.rgb;
		else if ( vigmode == 2 )
			outcol = res.rgb*vigdata.rgb;
		res.rgb = lerp(res.rgb,outcol,vigdata.a);
	}
	return clamp(res,0.0,1.0);
}
/* paint filter */
float4 PS_Kuwahara( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !oilenable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = 1.0/bresl;
	float n = 16.0;
	float3 m[4] =
	{
		float3(0,0,0),float3(0,0,0),float3(0,0,0),float3(0,0,0)
	}, s[4] =
	{
		float3(0,0,0),float3(0,0,0),float3(0,0,0),float3(0,0,0)
	}, c;
	int i, j;
	[loop] for ( i=-3; i<=0; i++ ) [loop] for ( j=-3; j<=0; j++ )
	{
		c = tex2D(SamplerColor,coord+float2(i,j)*bof).rgb;
		m[0] += c;
		s[0] += c*c;
	}
	[loop] for ( i=-3; i<=0; i++ ) [loop] for ( j=0; j<=3; j++ )
	{
		c = tex2D(SamplerColor,coord+float2(i,j)*bof).rgb;
		m[1] += c;
		s[1] += c*c;
	}
	[loop] for ( i=0; i<=3; i++ ) [loop] for ( j=-3; j<=0; j++ )
	{
		c = tex2D(SamplerColor,coord+float2(i,j)*bof).rgb;
		m[2] += c;
		s[2] += c*c;
	}
	[loop] for ( i=0; i<=3; i++ ) [loop] for ( j=0; j<=3; j++ )
	{
		c = tex2D(SamplerColor,coord+float2(i,j)*bof).rgb;
		m[3] += c;
		s[3] += c*c;
	}
	float min_sigma2 = 1e+2, sigma2;
	[unroll] for ( i=0; i<4; i++ )
	{
		m[i] /= n;
		s[i] = abs(s[i]/n-m[i]*m[i]);
		sigma2 = s[i].r+s[i].g+s[i].b;
		if ( sigma2 >= min_sigma2 ) continue;
		min_sigma2 = sigma2;
		res.rgb = m[i];
	}
	return res;
}
/* remove speckles from kuwahara filter */
float4 PS_MedianSmooth( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !oilenable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = 1.0/bresl;
	float3 m1, m2, m3;
	float3 a, b, c;
	a = tex2D(SamplerColor,coord+float2(-1,-1)*bof).rgb;
	b = tex2D(SamplerColor,coord+float2( 0,-1)*bof).rgb;
	c = tex2D(SamplerColor,coord+float2( 1,-1)*bof).rgb;
	m1 = (luminance(a)<luminance(b))?((luminance(b)<luminance(c))?b
		:max(a,c)):((luminance(a)<luminance(c))?a:max(b,c));
	a = tex2D(SamplerColor,coord+float2(-1, 0)*bof).rgb;
	b = tex2D(SamplerColor,coord+float2( 0, 0)*bof).rgb;
	c = tex2D(SamplerColor,coord+float2( 1, 0)*bof).rgb;
	m2 = (luminance(a)<luminance(b))?((luminance(b)<luminance(c))?b
		:max(a,c)):((luminance(a)<luminance(c))?a:max(b,c));
	a = tex2D(SamplerColor,coord+float2(-1, 1)*bof).rgb;
	b = tex2D(SamplerColor,coord+float2( 0, 1)*bof).rgb;
	c = tex2D(SamplerColor,coord+float2( 1, 1)*bof).rgb;
	m3 = (luminance(a)<luminance(b))?((luminance(b)<luminance(c))?b
		:max(a,c)):((luminance(a)<luminance(c))?a:max(b,c));
	res.rgb = (luminance(m1)<luminance(m2))?((luminance(m2)<luminance(m3))
		?m2:max(m1,m3)):((luminance(m1)<luminance(m3))?m1:max(m2,m3));
	return res;
}
/* ultimate super-cinematic immersive black bars */
float4 PS_Cinematic( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !boxenable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float sar = bresl.x/bresl.y;
	float tar = boxh/boxv;
	float2 box = (sar<tar)?float2(0.0,(bresl.y-(bresl.x/tar))*0.5)
		:float2((bresl.x-(bresl.y*tar))*0.5,0.0);
	box /= bresl;
	/* this is some kind of advanced black magic I can't understand */
	float2 test = saturate((coord*coord-coord)-(box*box-box));
	if ( -test.x != test.y ) res *= 0.0;
	return res;
}
/* Legacy MariENB FXAA, useful for further smoothing the paint filter */
float4 PS_FXAA( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = float2(IN.txcoord.x,IN.txcoord.y);
	float4 res = tex2D(SamplerColor,coord);
	if ( !fxaaenable ) return res;
	float fxaareducemul_ = 1.0/max(abs(fxaareducemul),1.0);
	float fxaareducemin_ = 1.0/max(abs(fxaareducemin),1.0);
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y);
	float3 rgbNW = tex2D(SamplerColor,coord+float2(-1,-1)*bof).rgb;
	float3 rgbNE = tex2D(SamplerColor,coord+float2(1,-1)*bof).rgb;
	float3 rgbSW = tex2D(SamplerColor,coord+float2(-1,1)*bof).rgb;
	float3 rgbSE = tex2D(SamplerColor,coord+float2(1,1)*bof).rgb;
	float3 rgbM = tex2D(SamplerColor,coord).rgb;
	float3 luma = float3(0.299,0.587,0.114);
	float lumaNW = dot(rgbNW,luma);
	float lumaNE = dot(rgbNE,luma);
	float lumaSW = dot(rgbSW,luma);
	float lumaSE = dot(rgbSE,luma);
	float lumaM = dot(rgbM,luma);
	float lumaMin = min(lumaM,min(min(lumaNW,lumaNE),min(lumaSW,lumaSE)));
	float lumaMax = max(lumaM,max(max(lumaNW,lumaNE),max(lumaSW,lumaSE)));
	float2 dir = float2(-((lumaNW+lumaNE)-(lumaSW+lumaSE)),((lumaNW+lumaSW)
		-(lumaNE+lumaSE)));
	float dirReduce = max((lumaNW+lumaNE+lumaSW+lumaSE)*(0.25
		*fxaareducemul_),fxaareducemin_);
	float rcpDirMin = 1.0/(min(abs(dir.x),abs(dir.y))+dirReduce);
	dir = min(float2(fxaaspanmax,fxaaspanmax),max(float2(-fxaaspanmax,
		-fxaaspanmax),dir*rcpDirMin))/bresl;
	float3 rgbA = (1.0/2.0)*(tex2D(SamplerColor,coord+dir*(1.0/3.0-0.5))
		.rgb+tex2D(SamplerColor,coord+dir*(2.0/3.0-0.5)).rgb);
	float3 rgbB = rgbA*(1.0/2.0)+(1.0/4.0)*(tex2D(SamplerColor,coord+dir
		*(0.0/3.0-0.5)).rgb+tex2D(SamplerColor,coord+dir*(3.0/3.0-0.5))
		.rgb);
	float lumaB = dot(rgbB,luma);
	if ( (lumaB < lumaMin) || (lumaB > lumaMax) ) res.rgb = rgbA;
	else res.rgb = rgbB;
	res.a = 1.0;
	return res;
}
/* Colour matrix */
float3 ColorMatrix( float3 res )
{
	float3x3 cmat = float3x3(cmat_rr,cmat_rg,cmat_rb,
		cmat_gr,cmat_gg,cmat_gb,
		cmat_br,cmat_bg,cmat_bb);
	res = mul(res,cmat);
	if ( cmatnormalize )
	{
		float cmscale = (cmat._11+cmat._12+cmat._13+cmat._21
			+cmat._22+cmat._23+cmat._31+cmat._32+cmat._33)/3.0;
		res /= cmscale;
	}
	return res;
}
/* Hue-Saturation filter from GIMP */
float hs_hue_overlap( float hue_p, float hue_s, float res )
{
	float v = hue_p+hue_s;
	res += (hshue_a+v)/2.0;
	return res%1.0;
}
float hs_hue( float hue, float res )
{
	res += (hshue_a+hue)/2.0;
	return res%1.0;
}
float hs_sat( float sat, float res )
{
	float v = hssat_a+sat;
	res *= v+1.0;
	return clamp(res,0.0,1.0);
}
float hs_val( float val, float res )
{
	float v = (hsval_a+val)/2.0;
	if ( v < 0.0 ) return res*(v+1.0);
	return res+(v*(1.0-res));
}
float3 HueSaturation( float3 res )
{
	float3 hsv = rgb2hsv(res);
	float ch = hsv.x*6.0;
	int ph = 0, sh = 0;
	float pv = 0.0, sv = 0.0;
	bool usesh = false;
	float hues[6] = {hshue_r,hshue_y,hshue_g,hshue_c,hshue_b,hshue_m};
	float sats[6] = {hssat_r,hssat_y,hssat_g,hssat_c,hssat_b,hssat_m};
	float vals[6] = {hsval_r,hsval_y,hsval_g,hsval_c,hsval_b,hsval_m};
	float v;
	[loop] for ( float h=0.0; h<7.0; h+=1.0 )
	{
		float ht = h+0.5;
		if ( ch < ht+hsover )
		{
			ph = floor(h);
			if ( (hsover > 0.0) && (ch > ht-hsover) )
			{
				usesh = true;
				sh = ph+1;
				sv = (ch-ht+hsover)/(2.0*hsover);
				pv = 1.0-sv;
			}
			else usesh = false;
			break;
		}
	}
	if ( ph >= 6 )
	{
		ph = 0;
		usesh = false;
	}
	if ( sh >= 6 ) sh = 0;
	if ( usesh )
	{
		hsv.x = hs_hue_overlap(hues[ph]*pv,hues[sh]*sv,hsv.x);
		hsv.y = hs_sat(sats[ph],hsv.y)*pv+hs_sat(sats[sh],hsv.y)*sv;
		hsv.z = hs_val(vals[ph],hsv.z)*pv+hs_val(vals[sh],hsv.z)*sv;
	}
	else
	{
		hsv.x = hs_hue(hues[ph],hsv.x);
		hsv.y = hs_sat(sats[ph],hsv.y);
		hsv.z = hs_val(vals[ph],hsv.z);
	}
	return hsv2rgb(hsv);
}
/* Colour Balance filter from GIMP */
/* Additional filters that don't fit in enbeffect */
float4 PS_Append( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( cmatenable ) res.rgb = ColorMatrix(res.rgb);
	if ( hsenable ) res.rgb = HueSaturation(res.rgb);
	res.rgb = max(res.rgb,0.0);
	res.a = 1.0;
	return res;
}
technique PostProcess
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Append();
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
		PixelShader = compile ps_3_0 PS_Kuwahara();
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
		PixelShader = compile ps_3_0 PS_MedianSmooth();
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
		PixelShader = compile ps_3_0 PS_FXAA();
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
		PixelShader = compile ps_3_0 PS_Blur();
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
		PixelShader = compile ps_3_0 PS_Sharp();
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
		PixelShader = compile ps_3_0 PS_Shift();
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
technique PostProcess8
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_ChromaKey();
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
technique PostProcess9
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Vignette();
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
technique PostProcess10
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Curvature();
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
technique PostProcess11
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Cinematic();
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
