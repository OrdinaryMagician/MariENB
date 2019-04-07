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
/* The standard tonemap from sweetfx */
float3 TonemapSFX( float3 res )
{
	float Gamma = tod_ind(sfxgamma);
	float Exposure = tod_ind(sfxexposure);
	float Saturation = tod_ind(sfxsaturation);
	float Bleach = tod_ind(sfxbleach);
	float Defog = tod_ind(sfxdefog);
	float3 FogColor = float3(tod_ind(sfxfogcolor_r),tod_ind(sfxfogcolor_g),
		tod_ind(sfxfogcolor_b));
	float3 tcol = res;
	tcol = saturate(tcol-Defog*FogColor*2.55);
	tcol *= pow(2.0,Exposure);
	tcol = pow(tcol,Gamma);
	float lum = luminance(tcol);
	float L = saturate(1.0*(lum-0.45));
	float3 A2 = Bleach*tcol;
	float3 res1 = 2.0*tcol*lum;
	float3 res2 = 1.0-2.0*(1.0-lum)*(1.0-tcol);
	float3 newc = lerp(res1,res2,L);
	float3 mixrgb = A2*newc;
	tcol += (1.0-A2)*mixrgb;
	float3 gray = dot(tcol,1.0/3.0);
	float3 diff = tcol-gray;
	return (tcol+diff*Saturation)/(1+(diff*Saturation));
}
float3 Tonemap( float3 res )
{
	float3 tcol = pow(max(res,0.0),1.0/2.2);
	if ( tmapenable == -1 ) return tcol;
	res *= tod_ind(tmapexposure);
	float tblend = tod_ind(tmapblend);
	float3 mapped;
	if ( tmapenable == 5 ) mapped = TonemapSFX(res);
	else if ( tmapenable == 4 ) mapped = TonemapHaarmPeterDuiker(res);
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
	/*
	   Skyrim method depends explicitly on vanilla eye adaptation which is
	   ass as I still CANNOT EVEN UNDERSTAND how the hell it's calculated
	   just from a mess of disassembled code.
	*/
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
#ifdef FALLOUT
	float oft = _r3.y;
#else
	/* TODO figure the offset thingy for Skyrim someday */
	float oft = 0.0;
#endif
	tcol = max(0,(tcol*_r3.w-oft)*_r3.z+oft);
	tcol = lerp(res,tcol,vconblend);
	return tcol;
}
/*
	vanilla imagespace rough interpretation, just in case you don't believe
	me when I say I cannot understand

	c6 -> 0 0 0 0
	c7 -> 0.2125 0.7154 0.0721 1
	c6 is used in a cmp instruction
	c7 xyz is in a dot product, so we can assume it's a
	  luminance calculation
	c7 w is used in some mad instructions as the "add"
	  component, I wonder why
	s0 is diffuse
	s1 is bloom
	s2 is adaptation
	
	code
	
	rcp r0.x,c2.y
	  r0.x now contains 1.0/c2.y (this is one of the bloom params)
	texld r1, v0, s2
	  r1 contains the adaptation texture now
	mul r0.yz, r1.xxyw, c1.y
	  r0.yz for some reason contains adaptation's xxyw (wat)
	  multiplied by adapt min
	rcp r0.w, r0.y
	  r0.w is now 1.0/r0.y (again, I don't know what's going on)
	mul r0.z, r0.w, r0.z
	  r0.z *= r0.w, really don't know where this is going since
	  I SERIOUSLY have no idea what all the adaptation texture
	  channels do
	
	this is where adaptation ends and bloom stuff starts
	
	results:
	  r0.x is 1.0/c2.y
	  r0.y is ... I don't even know anymore, what the heck
	  r0.z is ... I'm at a loss here too
	  r0.w is 1.0/r0.y and I don't even know what r0.y is anyway
	  r1 still contains the adaptation texture
	
	texld r1, v0, s1
	  oh, here the bloom texture is loaded to r1
	mul r1.xyz,r1,c1.y
	  multiplies bloom rgb by adaptation min
	dp3 r0.w, c7, r1
	  r0.w contains the luminance of bloom
	mul r1.w, r0.w, r0.z
	  multiplies the luminance by whatever was calculated from
	  all the adaptation stuff
	mad r0.z, r0.z, r0.w, c7.w
	  r0.z now contains r0.z multiplied by the original luminance
	  plus one
	rcp r0.z, r0.z
	  r0.z is now 1.0/r0.z
	mad r0.x, r1.w, r0.x, c7.w
	  r0.x is now r1.w * r0.x + 1
	  r0.x previously contained 1.0/c2.y, so this would be
	  r1.w*(1.0/c2.y)+1 (no idea)
	mul r0.x,r0.x,r1.w
	  r0.x changes again by multiplying it by r1.w (luminance?)
	mul r0.x,r0.z,r0.x
	  here it gets multiplied by r0.z, which I HAVE NO IDEA what
	  it is
	cmp r0.x,-r0.w,c6.x,r0.x
	  r0.x contains c6.x if -r0.w >= 0, otherwise it's unchanged
	  I'm only getting more confused at this point
	rcp r0.z,r0.w
	  great, now we get the inverse of luminance to r0.z
	mul r0.z,r0.z,r0.x
	  r0.z is multiplied by r0.x
	add_sat r0.x,-r0.x,c2.x
	  r0.x now contains c2.x-r0.x, all of this is saturated
	  I seriously don't know where this is going
	
	now it finally loads the diffuse
	
	results:
	  r0.x is some sort of brightness modifier (?)
	  r0.y never changed, and I still have no clue what it does
	  r0.z is the inverse of bloom texture luminance
	  r0.w is the bloom luminance
	  r1 contains the bloom texture and something luminance-related
	  on the alpha channel
	
	texld r2, v0, s0
	  loads diffuse onto r2
	mul r2.xyz, r2, c1.y
	  adjusts diffuse by adaptation min
	mul r2.xyz, r0.x, r2
	  adjusts the brightness again from the bloom "section"
	mad r1.xyz, r1, r0.z, r2
	  adds the bloom into diffuse using r0.z as the opacity,
	  r1 now contains the blend, goodbye adaptation texture
	dp3 r0.x, r1, c7
	  calculates the luminance of the diffuse+bloom, put in r0.x
	mov r1.w, c7.w
	  r1.w is set to one
	lrp r2, c3.x, r1, r0.x
	  r2 contains lerp(r0.x,r1,c3.x)
	  c3.x is a vibrance/saturation factor
	  OK this is at least very simple
	mad r1, r0.x, c4, -r2
	  r1 is r0.x*c4-r2
	  first instruction of tint filter
	mad r1, c4.w, r1, r2
	  r1 is now c4.w*r1+r2
	  second instruction of tint filter
	  combining the two, we get
	  r1 = c4.w*(r0.x*c4-r2)+r2
	  I thought tinting was a simple lerp, but nope
	mad r1, c3.w, r1, -r0.y
	  r1 is c3.w*r1-r0.y
	  this is one of the contrast instructions, and it's where the
	  whole adaptation mess comes from, since I have NO IDEA
	  what r0.y contains
	mad r0, c3.z, r1, r0.y
	  r0 is now c3.z*r1+r0.y
	  the second contrast instruction, really at a loss here
	  whole thing would be
	  r0 = c3.z*(c3.w*r1-r0.y)+r0.y
	add r1, -r0, c5
	  r1 contains c5-r0
	  c5 is the fade parameters
	mad oC0, c5.w, r1, r0
	  the final output color is c5.w*r1+r0
	  so... oC0 = c5.w*(c5-r0)+r0
	  I'm confused, this is also not a simple lerp, oh well?
	
	verdict: I HAVE NO IDEA WHAT r0.y CONTAINS, DAMN IT
*/
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
#ifdef LUTMODE_LEGACY
	float3 tcol = clamp(res,0.08,0.92);
	tcol.rg = tcol.rg*0.5+0.25;
	float2 lc1 = float2(tcol.r/16.0+floor(tcol.b*16.0)/16.0,tcol.g/64.0);
	float2 lc2 = float2(tcol.r/16.0+ceil(tcol.b*16.0)/16.0,tcol.g/64.0);
	float dec = (ceil(tcol.b*16.0)==16.0)?(0.0):frac(tcol.b*16.0);
	/* night samples */
	float3 tcl1_n = tex2D(SamplerLUT,lc1+float2(0,clut_n/64.0));
	float3 tcl2_n = tex2D(SamplerLUT,lc2+float2(0,clut_n/64.0));
	/* day samples */
	float3 tcl1_d = tex2D(SamplerLUT,lc1+float2(0,clut_d/64.0));
	float3 tcl2_d = tex2D(SamplerLUT,lc2+float2(0,clut_d/64.0));
	/* interior night samples */
	float3 tcl1_in = tex2D(SamplerLUT,lc1+float2(0,clut_in/64.0));
	float3 tcl2_in = tex2D(SamplerLUT,lc2+float2(0,clut_in/64.0));
	/* interior day samples */
	float3 tcl1_id = tex2D(SamplerLUT,lc1+float2(0,clut_id/64.0));
	float3 tcl2_id = tex2D(SamplerLUT,lc2+float2(0,clut_id/64.0));
#else
#ifdef LUTMODE_16
	float3 tcol = clamp(res,0.08,0.92);
	tcol.rg = tcol.rg*0.5+0.25;
	float2 lc1 = float2(tcol.r,tcol.g/16.0+floor(tcol.b*16.0)/16.0);
	float2 lc2 = float2(tcol.r,tcol.g/16.0+ceil(tcol.b*16.0)/16.0);
	float dec = (ceil(tcol.b*16.0)==16.0)?(0.0):frac(tcol.b*16.0);
#endif
#ifdef LUTMODE_64
	float3 tcol = clamp(res,0.02,0.98);
	tcol.rg = tcol.rg*0.5+0.25;
	float2 lc1 = float2(tcol.r,tcol.g/64.0+floor(tcol.b*64.0)/64.0);
	float2 lc2 = float2(tcol.r,tcol.g/64.0+ceil(tcol.b*64.0)/64.0);
	float dec = (ceil(tcol.b*64.0)==64.0)?(0.0):frac(tcol.b*64.0);
#endif
	/* night samples */
	float3 tcl1_n = tex2D(SamplerLUTN,lc1);
	float3 tcl2_n = tex2D(SamplerLUTN,lc2);
	/* day samples */
	float3 tcl1_d = tex2D(SamplerLUTD,lc1);
	float3 tcl2_d = tex2D(SamplerLUTD,lc2);
	/* interior night samples */
	float3 tcl1_in = tex2D(SamplerLUTIN,lc1);
	float3 tcl2_in = tex2D(SamplerLUTIN,lc2);
	/* interior day samples */
	float3 tcl1_id = tex2D(SamplerLUTID,lc1);
	float3 tcl2_id = tex2D(SamplerLUTID,lc2);
#endif
	float3 tcl1 = tod_ind(tcl1);
	float3 tcl2 = tod_ind(tcl2);
	tcol = lerp(tcl1,tcl2,dec);
	float lutblend = tod_ind(lutblend);
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
/* MariENB shader */
float4 PS_Mari( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord0.xy;
	float4 res = tex2D(_s0,coord);
	res.rgb = pow(max(res.rgb,0.0),2.2);
	float3 bcol = tex2D(_s3,coord).rgb*EBloomAmount;
	if ( bloomdebug	) res.rgb *= 0;
	res.rgb += bcol;
	if ( aenable ) res.rgb = Adaptation(res.rgb);
	if ( nbt && ne ) res.rgb = FilmGrain(res.rgb,coord);
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
	if ( palenable ) res.rgb = GradingPal(res.rgb);
	if ( techenable ) res.rgb = Technicolor(res.rgb);
	if ( !nbt && ne ) res.rgb = FilmGrain(res.rgb,coord);
#ifdef FALLOUT
	res.rgb = _r5.rgb*_r5.a + res.rgb*(1.0-_r5.a);
#else
	res.rgb = _r5.w*(_r5.rgb-res.rgb)+res.rgb;
#endif
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
		/* >inline assembly */
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
