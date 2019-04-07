/*
	menbeffectfilters.fx : MariENB base shader routines.
	(C)2013-2017 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
VS_OUTPUT_POST VS_Pass( VS_INPUT_POST IN )
{
	VS_OUTPUT_POST OUT;
	OUT.vpos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord0.xy = IN.txcoord0.xy;
	return OUT;
}
float4 _c1 : register(c1);
float4 _c2 : register(c2);
float4 _c19 : register(c19);
float4 _c20 : register(c20);
float4 _c22 : register(c22);
#define _r1 _c1
#define _r2 _c2
#define _r3 _c19
#define _r4 _c20
#define _r5 _c22
/*
   FALLOUT REGISTERS

   r1 (c1):         r2 (c2):         r3 (c19):
    x -> adapt max   x -> unused      x -> vibrance
    y -> unused      y -> unused      y -> balancer
    z -> unused      z -> bloom mix   z -> multiplier 1
    w -> unused      w -> unused      w -> multiplier 2

   r4 (c20):         r5 (c22):
    x -> tint red     x -> fade red
    y -> tint green   y -> fade green
    z -> tint blue    z -> fade blue
    w -> tint value   w -> fade value
*/
/* helper functions */
/* photometric */
#define luminance(x) dot(x,float3(0.2126,0.7152,0.0722))
/* CCIR601 */
//#define luminance(x) dot(x,float3(0.299,0.587,0.114))
/* overlay blend */
#define overlay(a,b) (a<0.5)?(2.0*a*b):(1.0-(2.0*(1.0-a)*(1.0-b)))
/* "dark mask" blending is something I came up with and can't really explain */
#define darkmask(a,b) (a>0.5)?(2.0*a*(0.5+b)):(1.0-2.0*(1.0-a)*(1.0-((0.5+b))))
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
/* "eye adaptation" */
float3 Adaptation( float3 res )
{
	float4 adapt = tex2D(_s4,0.5);
	float adapts, amin, amax;
	adapts = clamp(luminance(adapt.rgb),0.0,50.0);
	amin = tod_ind(amin);
	amax = tod_ind(amax);
	return res/(adapts*amax+amin);
}
/* Uncharted 2 tone mapping */
float3 Uch( float3 res )
{
	float A = tod_ind(unA);
	float B = tod_ind(unB);
	float C = tod_ind(unC);
	float D = tod_ind(unD);
	float E = tod_ind(unE);
	float F = tod_ind(unF);
	return ((res*(A*res+C*B)+D*E)/(res*(A*res+B)+D*F))-E/F;
}
float3 TonemapUC2( float3 res )
{
	float W = tod_ind(unW);
	float3 ucol = Uch(res);
	float3 uwhite = Uch(W);
	return pow(max(ucol/uwhite,0.0),1.0/2.2);
}
/* Ugly old Reinhard tone mapping */
float3 TonemapReinhard( float3 res )
{
	float3 tcol = res/(1+res);
	return pow(max(tcol,0.0),1.0/2.2);
}
/* That thing used in watch_dogs */
float3 TonemapHaarmPeterDuiker( float3 res )
{
	float3 ld = 0.002;
	float linReference = 0.18;
	float logReference = 444;
	float logGamma = 0.45;
	float3 LogColor;
	LogColor.rgb = (log10(0.4*res/linReference)/ld*logGamma+logReference)/1023.f;
	LogColor.rgb = saturate(LogColor.rgb);
	float FilmLutWidth = 256;
	float Padding = .5/FilmLutWidth;
	float3 retColor;
	retColor.r = tex2D(SamplerTonemap,float2(lerp(Padding,1-Padding,LogColor.r),.5)).x;
	retColor.g = tex2D(SamplerTonemap,float2(lerp(Padding,1-Padding,LogColor.g),.5)).x;
	retColor.b = tex2D(SamplerTonemap,float2(lerp(Padding,1-Padding,LogColor.b),.5)).x;
	return retColor;
}
/* Practically nothing */
float3 TonemapLinear( float3 res )
{
	return pow(max(res,0.0),1.0/2.2);
}
/* People somehow call this one realistic */
float3 TonemapHejlDawson( float3 res )
{
	float3 x = max(0.0,res-0.004);
	return (x*(6.2*x+.5))/(x*(6.2*x+1.7)+0.06);
}
float3 Tonemap( float3 res )
{
	float3 tcol = pow(max(res,0.0),1.0/2.2);
	if ( tmapenable == -1 ) return tcol;
	res *= tod_ind(tmapexposure);
	float tblend = tod_ind(tmapblend);
	float3 mapped;
	if ( tmapenable == 4 ) mapped = TonemapHaarmPeterDuiker(res);
	else if ( tmapenable == 3 ) mapped = TonemapHejlDawson(res);
	else if ( tmapenable == 2 ) mapped = TonemapUC2(res);
	else if ( tmapenable == 1 ) mapped = TonemapReinhard(res);
	else if ( tmapenable == 0 ) mapped = TonemapLinear(res);
	return lerp(tcol,mapped,tblend);
}
/* colour grading passes */
float3 GradingRGB( float3 res )
{
	float grademul_r = tod_ind(grademul_r);
	float grademul_g = tod_ind(grademul_g);
	float grademul_b = tod_ind(grademul_b);
	float gradepow_r = tod_ind(gradepow_r);
	float gradepow_g = tod_ind(gradepow_g);
	float gradepow_b = tod_ind(gradepow_b);
	float3 grademul = float3(grademul_r,grademul_g,grademul_b);
	float3 gradepow = float3(gradepow_r,gradepow_g,gradepow_b);
	return pow(max(0,res),gradepow)*grademul;
}
float3 GradingColorize( float3 res )
{
	float gradecol_r = tod_ind(gradecol_r);
	float gradecol_g = tod_ind(gradecol_g);
	float gradecol_b = tod_ind(gradecol_b);
	float gradecolfact = tod_ind(gradecolfact);
	float3 gradecol = float3(gradecol_r,gradecol_g,gradecol_b);
	float tonev = luminance(res);
	float3 tonecolor = gradecol*tonev;
	return res*(1.0-gradecolfact)+tonecolor*gradecolfact;
}
float3 GradingHSV( float3 res )
{
	float gradesatmul = tod_ind(gradesatmul);
	float gradesatpow = tod_ind(gradesatpow);
	float gradevalmul = tod_ind(gradevalmul);
	float gradevalpow = tod_ind(gradevalpow);
	float3 hsv = rgb2hsv(res);
	hsv.y = clamp(pow(max(0,hsv.y),gradesatpow)*gradesatmul,0.0,1.0);
	hsv.z = pow(max(0,hsv.z),gradevalpow)*gradevalmul;
	return hsv2rgb(hsv);
}
/* game grading filters */
float3 GradingGame( float3 res )
{
	float3 tgray = luminance(res);
	/* saturation */
	float satv = (_r3.x<0.0)?(-pow(abs(_r3.x),vsatpow)*vsatmul)
		:(pow(max(_r3.x,0.0),vsatpow)*vsatmul);
	float3 tcol = res*satv + tgray*(1.0-satv);
	tcol = lerp(res,tcol,vsatblend);
	/* tint */
	float tintv = (_r4.w<0.0)?(-pow(abs(_r4.w),vtintpow)*vtintmul)
		:(pow(max(_r4.w,0.0),vtintpow)*vtintmul);
	tcol = tintv*(tgray*_r4.rgb-tcol)+tcol;
	tcol = lerp(res,tcol,vtintblend);
	/* contrast(?) stuff */
	float oft = _r3.y;
	tcol = max(0,(tcol*_r3.w-oft)*_r3.z+oft);
	tcol = lerp(res,tcol,vconblend);
	return tcol;
}
/* LUT colour grading */
float3 GradingLUT( float3 res )
{
	/*
	   Volume maps are SO MUCH BETTER on the shader side, no ugly
	   interpolation hacks are needed to work around sampling quirks,
	   and the code is EXTREMELY simplified as a result.
	   
	   Seriously, it's just as simple as using the screen rgb values
	   as xyz coordinates, nothing more, it maps exactly 1:1. Additionally,
	   the LUTs can have any arbitrary width, height and depth.
	   
	   It's also possible to use RGBA32F color on the LUT side, but that's
	   a bit more complicated to set up for the user. GIMP doesn't support
	   that format yet, dunno about Photoshop.
	*/
	float3 tcl_n = tex3D(SamplerLUTN,res).rgb;
	float3 tcl_d = tex3D(SamplerLUTD,res).rgb;
	float3 tcl_i = tex3D(SamplerLUTI,res).rgb;
	float3 tcol = tod_ind(tcl);
	float lutblend = tod_ind(lutblend);
	return lerp(res,tcol,lutblend);
}
/* I think this Technicolor implementation is correct... maybe */
float3 Technicolor( float3 res )
{
	res = clamp(res,0.0,1.0);
	float red = 1.0-(res.r-(res.g+res.b)*0.5);
	float green = 1.0-(res.g-(res.r+res.b)*0.5);
	float blue = 1.0-(res.b-(res.r+res.g)*0.5);
	float3 tint = float3(green*blue,red*blue,red*green)*res;
	return lerp(res,res+0.5*(tint-res),techblend);
}
/* post-pass dithering, something apparently only my ENB does */
float3 Dither( float3 res, float2 coord )
{
	float2 rcoord = coord*float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float3 col = res;
	float dml = (1.0/256.0);
	if ( dither == 1 )
		col += ordered2[int(rcoord.x%2)+2*int(rcoord.y%2)]*dml-0.5*dml;
	else if ( dither == 2 )
		col += ordered8[int(rcoord.x%8)+8*int(rcoord.y%8)]*dml-0.5*dml;
	else col += checkers[int(rcoord.x%2)+2*int(rcoord.y%2)]*dml-0.5*dml;
	col = (trunc(col*256.0)/256.0);
	return col;
}
/* Fuzzy */
float3 FilmGrain( float3 res, float2 coord )
{
	float ts = Timer.x*nf;
	float2 tcs = coord.xy;
	float2 s1 = tcs+float2(0,ts);
	float2 s2 = tcs+float2(ts,0);
	float2 s3 = tcs+float2(ts,ts);
	float n1, n2, n3;
	float2 nr = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w)/256.0;
	/*
	   There are two methods of making noise here:
	   1. two-pass algorithm that produces a particular fuzz complete with
	       a soft horizontal tear, reminiscent of old TV static.
	   2. simple version that has very noticeable tiling and visible
	      scrolling at low speeds
	*/
	if ( np )
	{
		n1 = tex2D(SamplerNoise2,s1*nm11*nr).r;
		n2 = tex2D(SamplerNoise2,s2*nm12*nr).g;
		n3 = tex2D(SamplerNoise2,s3*nm13*nr).b;
		s1 = tcs+float2(ts+n1*nk,n2*nk);
		s2 = tcs+float2(n2,ts+n3*nk);
		s3 = tcs+float2(ts+n3*nk,ts+n1*nk);
		n1 = tex2D(SamplerNoise2,s1*nm21*nr).r;
		n2 = tex2D(SamplerNoise2,s2*nm22*nr).g;
		n3 = tex2D(SamplerNoise2,s3*nm23*nr).b;
	}
	else
	{
		n1 = tex2D(SamplerNoise3,s1*nm1*nr).r;
		n2 = tex2D(SamplerNoise3,s2*nm2*nr).g;
		n3 = tex2D(SamplerNoise3,s3*nm3*nr).b;
	}
	float n4 = (n1+n2+n3)/3;
	float3 ng = float3(n4,n4,n4);
	float3 nc = float3(n1,n2,n3);
	float3 nt = pow(clamp(lerp(ng,nc,ns),0.0,1.0),nj);
	if ( nb == 1 ) return res+nt*ni*0.01;
	if ( nb == 2 ) return overlay(res,(nt*ni*0.01));
	if ( nb == 3 )
	{
		float bn = 1.0-saturate((res.r+res.g+res.b)/3.0);
		bn = pow(bn,bnp);
		float3 nn = saturate(nt*bn);
		return darkmask(res,(nn*ni*0.01));
	}
	return lerp(res,nt,ni*0.01);
}
/* Screen frost distortion */
float2 ScreenFrost( float2 coord )
{
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 nc = coord*(bresl/FROSTSIZE)*frostsize;
	float2 ofs = tex2D(SamplerFrost,nc).xy;
	ofs = (ofs-0.5)*2.0;
	ofs *= pow(length(ofs),frostpow)*froststrength;
	ofs *= max(0.0,tod_ind(frostfactor));
	float dist = distance(coord,float2(0.5,0.5))*2.0;
	ofs *= clamp(pow(dist,frostrpow)*frostrmult+frostrbump,0.0,1.0);
	return coord+ofs;
}
/* Old MariENB 0.x screen dirt filter, updated */
float3 ScreenDirt( float3 res, float2 coord )
{
	float2 nr = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w)/256.0;
	float3 ncolc = tex2D(SamplerNoise1,coord*dirtmc*nr).rgb;
	float2 ds = float2(res.r+res.g,res.g+res.b)/2.0;
	float3 ncoll = tex2D(SamplerNoise1,ds*dirtml).rgb;
	res = lerp(res,(ncolc.r+1.0)*res,dirtcfactor
		*saturate(1.0-(ds.x+ds.y)*0.25));
	res = lerp(res,(ncoll.r+1.0)*res,dirtlfactor
		*saturate(1.0-(ds.x+ds.y)*0.25));
	return res;
}
/* MariENB shader */
float4 PS_Mari( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord0.xy;
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float4 res;
	float3 bcol;
	if ( frostenable )
	{
		float2 ofs = ScreenFrost(coord);
		ofs -= coord;
		if ( (distcha != 0.0) && (length(ofs) != 0.0) )
		{
			float2 ofr, ofg, ofb;
			ofr = ofs*(1.0-distcha*0.01);
			ofg = ofs;
			ofb = ofs*(1.0+distcha*0.01);
			res = float4(tex2D(_s0,coord+ofr).r,
				tex2D(_s0,coord+ofg).g,
				tex2D(_s0,coord+ofb).b,1.0);
			bcol = float3(tex2D(_s3,coord+ofr).r,
				tex2D(_s3,coord+ofg).g,
				tex2D(_s3,coord+ofb).b)*EBloomAmount;
		}
		else
		{
			res = tex2D(_s0,coord+ofs);
			bcol = tex2D(_s3,coord+ofs).rgb*EBloomAmount;
		}
		float2 nc = coord*(bresl/FROSTSIZE)*frostsize;
		float bmp = pow(max(0,tex2D(SamplerFrost,nc).z),frostbpow);
		float dist = distance(coord,float2(0.5,0.5))*2.0;
		dist = clamp(pow(dist,frostrpow)*frostrmult+frostrbump,0.0,
			1.0)*frostblend;
		dist *= max(0.0,tod_ind(frostfactor));
		res.rgb *= 1.0+bmp*dist;
	}
	else
	{
		res = tex2D(_s0,coord);
		bcol = tex2D(_s3,coord).rgb*EBloomAmount;
	}
	res.rgb = pow(max(res.rgb,0.0),2.2);
	if ( bloomdebug	) res.rgb *= 0;
	res.rgb += bcol;
	if ( aenable ) res.rgb = Adaptation(res.rgb);
	if ( nbt && ne ) res.rgb = FilmGrain(res.rgb,coord);
	if ( dirtenable ) res.rgb = ScreenDirt(res.rgb,coord);
	res.rgb = Tonemap(res.rgb);
	if ( vgradeenable ) res.rgb = GradingGame(res.rgb);
	if ( gradeenable1 ) res.rgb = GradingRGB(res.rgb);
	if ( colorizeafterhsv )
	{
		if ( gradeenable3 ) res.rgb = GradingHSV(res.rgb);
		if ( gradeenable2 ) res.rgb = GradingColorize(res.rgb);
	}
	else
	{
		if ( gradeenable2 ) res.rgb = GradingColorize(res.rgb);
		if ( gradeenable3 ) res.rgb = GradingHSV(res.rgb);
	}
	if ( lutenable ) res.rgb = GradingLUT(res.rgb);
	if ( techenable ) res.rgb = Technicolor(res.rgb);
	if ( !nbt && ne ) res.rgb = FilmGrain(res.rgb,coord);
	res.rgb = _r5.rgb*_r5.a + res.rgb*(1.0-_r5.a);
	if ( dodither ) res.rgb = Dither(res.rgb,coord);
	res.rgb = max(0,res.rgb);
	res.a = 1.0;
	return res;
}
/*
   So... let me get this straight... rather than simply switching techniques,
   Boris just compiles the program twice with and without this macro, then
   toggling "UseEffect" switches between each variation? Wat?
*/
#ifndef ENB_FLIPTECHNIQUE
technique Shader_C1DAE3F7
#else
technique Shader_ORIGINALPOSTPROCESS
#endif
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Mari();
		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		ZEnable = FALSE;
		ZWriteEnable = FALSE;
		CullMode = NONE;
		AlphaTestEnable = FALSE;
		AlphaBlendEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
#ifndef ENB_FLIPTECHNIQUE
technique Shader_ORIGINALPOSTPROCESS
#else
technique Shader_C1DAE3F7
#endif
{
	pass p0
	{
		VertexShader = asm
		{
			vs_1_1
			def c3,2,-2,0,0
			dcl_position v0
			dcl_texcoord v1
			mov r0.xy,c0
			mad oPos.xy,r0,-c3,v0
			add oT0.xy,v1,c1
			add oT1.xy,v1,c2
			mov oPos.zw,v0
		};
		/* >inline assembly */
		PixelShader = asm
		{
			ps_2_x
			def c0,0.5,0,0,0
			def c3,0.298999995,0.587000012,0.114,0
			dcl t0.xy
			dcl t1.xy
			dcl_2d s0
			dcl_2d s1
			texld r0,t1,s1
			texld r1,t0,s0
			max r0.w,r1.w,c1.x
			rcp r0.w,r0.w
			mul r1.w,r0.w,c0.x
			mul r0.w,r0.w,c1.x
			mul r1.xyz,r1,r1.w
			max r2.xyz,r1,c0.y
			mad r0.xyz,r0.w,r0,r2
			dp3 r0.w,r0,c3
			lrp r1.xyz,c19.x,r0,r0.w
			mad r0.xyz,r0.w,c20,-r1
			mad r0.xyz,c20.w,r0,r1
			mad r0.xyz,c19.w,r0,-c19.y
			mad r0.xyz,c19.z,r0,c19.y
			lrp r1.xyz,c22.w,c22,r0
			mov r1.w,c2.z
			mov oC0,r1
		};
		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		ZEnable = FALSE;
		ZWriteEnable = FALSE;
		CullMode = NONE;
		AlphaTestEnable = FALSE;
		AlphaBlendEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
