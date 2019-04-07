/*
	menbeffectfilters.fx : MariENB base shader routines.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* If defined, this is for Fallout 3 and New Vegas */
//#define FALLOUT
VS_OUTPUT_POST VS_Pass( VS_INPUT_POST IN )
{
	VS_OUTPUT_POST OUT;
	OUT.vpos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord0.xy = IN.txcoord0.xy;
	return OUT;
}
#ifdef FALLOUT
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
#else
float4 _c1 : register(c1);
float4 _c2 : register(c2);
float4 _c3 : register(c3);
float4 _c4 : register(c4);
float4 _c5 : register(c5);
#define _r1 _c1
#define _r2 _c2
#define _r3 _c3
#define _r4 _c4
#define _r5 _c5
/*
   SKYRIM REGISTERS

   r1 (c1):         r2 (c2):              r3 (c3):
    x -> adapt max   x -> bloom bump (?)   x -> vibrance
    y -> adapt min   y -> bloom mult (?)   y -> unused
    z -> unused      z -> unused           z -> multiplier 1
    w -> unused      w -> unused           w -> multiplier 2

   r4 (c4):          r5 (c5):
    x -> tint red     x -> fade red
    y -> tint green   y -> fade green
    z -> tint blue    z -> fade blue
    w -> tint value   w -> fade value
*/
#endif
#define tod ENightDayFactor
#define ind EInteriorFactor
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
	amin = lerp(lerp(amin_n,amin_d,tod),lerp(amin_in,amin_id,tod),ind);
	amax = lerp(lerp(amax_n,amax_d,tod),lerp(amax_in,amax_id,tod),ind);
	return res/(adapts*amax+amin);
}
/* "uncharted 2" filmic tone mapping */
float3 Uch( float3 res )
{
	float A = lerp(lerp(unA_n,unA_d,tod),lerp(unA_in,unA_id,tod),ind);
	float B = lerp(lerp(unB_n,unB_d,tod),lerp(unB_in,unB_id,tod),ind);
	float C = lerp(lerp(unC_n,unC_d,tod),lerp(unC_in,unC_id,tod),ind);
	float D = lerp(lerp(unD_n,unD_d,tod),lerp(unD_in,unD_id,tod),ind);
	float E = lerp(lerp(unE_n,unE_d,tod),lerp(unE_in,unE_id,tod),ind);
	float F = lerp(lerp(unF_n,unF_d,tod),lerp(unF_in,unF_id,tod),ind);
	return ((res*(A*res+C*B)+D*E)/(res*(A*res+B)+D*F))-E/F;
}
float3 Tonemap( float3 res )
{
	float W = lerp(lerp(unW_n,unW_d,tod),lerp(unW_in,unW_id,tod),ind);
	float3 ucol = Uch(res);
	float3 uwhite = Uch(W);
	return ucol/uwhite;
}
/* overbright compensation pre-pass, kinda pointless now that I have tonemap */
float3 Compensate( float3 res )
{
	float comppow = lerp(lerp(comppow_n,comppow_d,tod),lerp(comppow_in,
		comppow_id,tod),ind);
	float compsat = lerp(lerp(compsat_n,compsat_d,tod),lerp(compsat_in,
		compsat_id,tod),ind);
	float compfactor = lerp(lerp(compfactor_n,compfactor_d,tod),
		lerp(compfactor_in,compfactor_id,tod),ind);
	float3 ovr = pow(res,comppow);
	float ovrs = luminance(ovr);
	ovr = ovr*compsat+ovrs*(1.0-compsat);
	return res-ovr*compfactor;
}
/* colour grading passes */
float3 GradingRGB( float3 res )
{
	float grademul_r = lerp(lerp(grademul_r_n,grademul_r_d,tod),
		lerp(grademul_r_in,grademul_r_id,tod),ind);
	float grademul_g = lerp(lerp(grademul_g_n,grademul_g_d,tod),
		lerp(grademul_g_in,grademul_g_id,tod),ind);
	float grademul_b = lerp(lerp(grademul_b_n,grademul_b_d,tod),
		lerp(grademul_b_in,grademul_b_id,tod),ind);
	float gradepow_r = lerp(lerp(gradepow_r_n,gradepow_r_d,tod),
		lerp(gradepow_r_in,gradepow_r_id,tod),ind);
	float gradepow_g = lerp(lerp(gradepow_g_n,gradepow_g_d,tod),
		lerp(gradepow_g_in,gradepow_g_id,tod),ind);
	float gradepow_b = lerp(lerp(gradepow_b_n,gradepow_b_d,tod),
		lerp(gradepow_b_in,gradepow_b_id,tod),ind);
	float3 grademul = float3(grademul_r,grademul_g,grademul_b);
	float3 gradepow = float3(gradepow_r,gradepow_g,gradepow_b);
	return pow(res,gradepow)*grademul;
}
float3 GradingColorize( float3 res )
{
	float gradecol_r = lerp(lerp(gradecol_r_n,gradecol_r_d,tod),
		lerp(gradecol_r_in,gradecol_r_id,tod),ind);
	float gradecol_g = lerp(lerp(gradecol_g_n,gradecol_g_d,tod),
		lerp(gradecol_g_in,gradecol_g_id,tod),ind);
	float gradecol_b = lerp(lerp(gradecol_b_n,gradecol_b_d,tod),
		lerp(gradecol_b_in,gradecol_b_id,tod),ind);
	float gradecolfact = lerp(lerp(gradecolfact_n,gradecolfact_d,
		tod),lerp(gradecolfact_in,gradecolfact_id,tod),ind);
	float3 gradecol = float3(gradecol_r,gradecol_g,gradecol_b);
	float tonev = luminance(res);
	float3 tonecolor = gradecol*tonev;
	return res*(1.0-gradecolfact)+tonecolor*gradecolfact;
}
float3 GradingHSV( float3 res )
{
	float gradesatmul = lerp(lerp(gradesatmul_n,gradesatmul_d,tod),
		lerp(gradesatmul_in,gradesatmul_id,tod),ind);
	float gradesatpow = lerp(lerp(gradesatpow_n,gradesatpow_d,tod),
		lerp(gradesatpow_in,gradesatpow_id,tod),ind);
	float gradevalmul = lerp(lerp(gradevalmul_n,gradevalmul_d,tod),
		lerp(gradevalmul_in,gradevalmul_id,tod),ind);
	float gradevalpow = lerp(lerp(gradevalpow_n,gradevalpow_d,tod),
		lerp(gradevalpow_in,gradevalpow_id,tod),ind);
	float3 hsv = rgb2hsv(res);
	hsv.y = clamp(pow(hsv.y,gradesatpow)*gradesatmul,0.0,1.0);
	hsv.z = pow(hsv.z,gradevalpow)*gradevalmul;
	return hsv2rgb(hsv);
}
/* game screen tinting filters */
float3 Tint( float3 res )
{
	float3 tgray = luminance(res);
	float3 tintc = _r4.rgb*tgray;
	float3 tcol = tintc*_r4.a + res*(1.0-_r4.a);
	return lerp(res,tcol,tintblend);
}
/* game grading filters */
float3 GradingGame( float3 res )
{
	/*
	   Skyrim method is slightly different, but it depends explicitly on
	   vanilla eye adaptation which is ass.
	*/
	float3 tgray = luminance(res);
	float3 tcol = res*_r3.x + tgray*(1.0-_r3.x);
	tcol = max(0,(tcol*_r3.w-_r3.y)*_r3.z+_r3.y);
	return lerp(res,tcol,vgradeblend);
}
/* LUT colour grading */
float3 GradingLUT( float3 res )
{
	/*
	   gross hacks were needed to "fix" the way direct3d interpolates on
	   sampling, and to manually interpolate on the blue channel
	   
	   this could be alleviated if I could have all the LUTs as 64 separate
	   volume maps, but PS 3.0 has a limit of 16 samplers and I think ENB
	   can't load volume maps anyway.
	*/
	float3 tcol = clamp(res,0.0,1.0);
	tcol.rg = tcol.rg*0.5+0.25;
	float2 lc1 = float2(tcol.r/16.0+floor(tcol.b*16.0)/16.0,tcol.g/64.0
		+clut/64.0);
	float2 lc2 = float2(tcol.r/16.0+ceil(tcol.b*16.0)/16.0,tcol.g/64.0
		+clut/64.0);
	float dec = frac(tcol.b*16.0);
	float3 tcl1 = tex2D(SamplerLUT,lc1);
	float3 tcl2 = tex2D(SamplerLUT,lc2);
	tcol = lerp(tcl1,tcl2,dec);
	float lutblend = lerp(lerp(lutblend_n,lutblend_d,tod),lerp(lutblend_in,
		lutblend_id,tod),ind);
	return lerp(res,tcol,lutblend);
}
/* classic ENB palette colour grading, seems to kill dark and light values */
float3 GradingPal( float3 res )
{
	float4 adapt = tex2D(_s4,0.5);
	adapt = adapt/(adapt+1.0);
	float adapts = max(adapt.r,max(adapt.g,adapt.b));
	float3 palt;
	float2 coord;
	coord.y = adapts;
	coord.x = res.r;
	palt.r = tex2D(_s7,coord).r;
	coord.x = res.g;
	palt.g = tex2D(_s7,coord).g;
	coord.x = res.b;
	palt.b = tex2D(_s7,coord).b;
	return lerp(res,palt,palblend);
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
		col += ordered3[int(rcoord.x%3)+3*int(rcoord.y%3)]*dml-0.5*dml;
	else if ( dither == 3 )
		col += ordered4[int(rcoord.x%4)+4*int(rcoord.y%4)]*dml-0.5*dml;
	else if ( dither == 4 )
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
	   1. two-pass algorithm that produces a particular fuzz complete with a
	       soft horizontal tear, reminiscent of old TV static.
	   2. simple version that has very noticeable tiling and visible scrolling
	      at low speeds
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
	if ( nb == 1 ) return res+nt*ni;
	if ( nb == 2 ) return overlay(res,(nt*ni));
	if ( nb == 3 )
	{
		float bn = 1.0-saturate((res.r+res.g+res.b)/3.0);
		bn = pow(bn,bnp);
		float3 nn = saturate(nt*bn);
		return darkmask(res,(nn*ni));
	}
	return lerp(res,nt,ni);
}
/* MariENB shader */
float4 PS_Mari( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord0.xy;
	float4 res = tex2D(_s0,coord);
	if ( aenable ) res.rgb = Adaptation(res.rgb);
	if ( tmapenable && tmapbeforecomp ) res.rgb = Tonemap(res.rgb);
	if ( compenable ) res.rgb = Compensate(res.rgb);
	if ( tmapenable && !tmapbeforecomp ) res.rgb = Tonemap(res.rgb);
	if ( bloomdebug	) res.rgb *= 0;
	res.rgb += tex2D(_s3,coord).rgb*EBloomAmount;
	if ( vgradeenable ) res.rgb = GradingGame(res.rgb);
	if ( tintbeforegrade && tintenable ) res.rgb = Tint(res.rgb);
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
	if ( palenable ) res.rgb = GradingPal(res.rgb);
	if ( !tintbeforegrade && tintenable ) res.rgb = Tint(res.rgb);
	if ( fadebeforefilm ) res.rgb = _r5.rgb*_r5.a + res.rgb*(1.0-_r5.a);
	if ( ne ) res.rgb = FilmGrain(res.rgb,coord);
	if ( !fadebeforefilm ) res.rgb = _r5.rgb*_r5.a + res.rgb*(1.0-_r5.a);
	if ( dodither ) res.rgb = Dither(res.rgb,coord);
	res.rgb = max(0,res.rgb);
	res.a = 1.0;
	return res;
}
/*
   So... let me get this straight... rather than simply switching techniques,
   Boris just compiles the program twice with and without this macro, then
   toggling "UseEffect" switches between each variation? What the fuck?
*/
#ifndef ENB_FLIPTECHNIQUE
#ifdef FALLOUT
technique Shader_C1DAE3F7
#else
technique Shader_D6EC7DD1
#endif
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
#ifdef FALLOUT
technique Shader_C1DAE3F7
#else
technique Shader_D6EC7DD1
#endif
#endif
{
	pass p0
	{
#ifdef FALLOUT
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
#else
		VertexShader = compile vs_3_0 VS_Pass();
#endif
		/*
		   >inline assembly
		   Have to keep this part intact, sadly
		   Boris what the fuck have you done
		*/
		PixelShader = asm
		{
#ifdef FALLOUT
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
#else
			ps_3_0
			def c6,0,0,0,0
			def c7,0.212500006,0.715399981,0.0720999986,1
			dcl_texcoord v0.xy
			dcl_2d s0
			dcl_2d s1
			dcl_2d s2
			rcp r0.x,c2.y
			texld r1,v0,s2
			mul r0.yz,r1.xxyw,c1.y
			rcp r0.w,r0.y
			mul r0.z,r0.w,r0.z
			texld r1,v0,s1
			mul r1.xyz,r1,c1.y
			dp3 r0.w,c7,r1
			mul r1.w,r0.w,r0.z
			mad r0.z,r0.z,r0.w,c7.w
			rcp r0.z,r0.z
			mad r0.x,r1.w,r0.x,c7.w
			mul r0.x,r0.x,r1.w
			mul r0.x,r0.z,r0.x
			cmp r0.x,-r0.w,c6.x,r0.x
			rcp r0.z,r0.w
			mul r0.z,r0.z,r0.x
			add_sat r0.x,-r0.x,c2.x
			texld r2,v0,s0
			mul r2.xyz,r2,c1.y
			mul r2.xyz,r0.x,r2
			mad r1.xyz,r1,r0.z,r2
			dp3 r0.x,r1,c7
			mov r1.w,c7.w
			lrp r2,c3.x,r1,r0.x
			mad r1,r0.x,c4,-r2
			mad r1,c4.w,r1,r2
			mad r1,c3.w,r1,-r0.y
			mad r0,c3.z,r1,r0.y
			add r1,-r0,c5
			mad oC0,c5.w,r1,r0
#endif
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
