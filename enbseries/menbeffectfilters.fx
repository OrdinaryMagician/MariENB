/*
	menbeffectfilters.fx : MariENB 3 base shader routines.
	(C)2015 Marisa Kirisame, UnSX Team.
	Part of MariENB 3, the personal ENB of Marisa for Fallout 4.
	Released under the GNU GPLv3 (or later).
*/
VS_OUTPUT_POST VS_Pass( VS_INPUT_POST IN )
{
	VS_OUTPUT_POST OUT;
	OUT.pos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord0.xy = IN.txcoord0.xy;
	return OUT;
}
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
/* "uncharted 2" filmic tone mapping */
float3 Uch( float3 res )
{
	float A = tod(unA);
	float B = tod(unB);
	float C = tod(unC);
	float D = tod(unD);
	float E = tod(unE);
	float F = tod(unF);
	return ((res*(A*res+C*B)+D*E)/(res*(A*res+B)+D*F))-E/F;
}
float3 Tonemap( float3 res )
{
	float W = tod(unW);
	float3 ucol = Uch(res);
	float3 uwhite = Uch(W);
	return ucol/uwhite;
}
/* overbright compensation pre-pass, kinda pointless now that I have tonemap */
float3 Compensate( float3 res )
{
	/*float comppow = tod(comppow);
	float compsat = tod(compsat);
	float compfactor = tod(compfactor);*/
	float3 ovr = pow(res,comppow);
	float ovrs = luminance(ovr);
	ovr = ovr*compsat+ovrs*(1.0-compsat);
	return res-ovr*compfactor;
}
/* colour grading passes */
float3 GradingRGB( float3 res )
{
	/*float grademul_r = tod(grademul_r);
	float grademul_g = tod(grademul_g);
	float grademul_b = tod(grademul_b);
	float gradepow_r = tod(gradepow_r);
	float gradepow_g = tod(gradepow_g);
	float gradepow_b = tod(gradepow_b);*/
	float3 grademul = float3(grademul_r,grademul_g,grademul_b);
	float3 gradepow = float3(gradepow_r,gradepow_g,gradepow_b);
	return pow(res,gradepow)*grademul;
}
float3 GradingColorize( float3 res )
{
	/*float gradecol_r = tod(gradecol_r);
	float gradecol_g = tod(gradecol_g);
	float gradecol_b = tod(gradecol_b);
	float gradecolfact = tod(gradecolfact);*/
	float3 gradecol = float3(gradecol_r,gradecol_g,gradecol_b);
	float tonev = luminance(res);
	float3 tonecolor = gradecol*tonev;
	return res*(1.0-gradecolfact)+tonecolor*gradecolfact;
}
float3 GradingHSV( float3 res )
{
	/*float gradesatmul = tod(gradesatmul);
	float gradesatpow = tod(gradesatpow);
	float gradevalmul = tod(gradevalmul);
	float gradevalpow = tod(gradevalpow);*/
	float3 hsv = rgb2hsv(res);
	hsv.y = clamp(pow(hsv.y,gradesatpow)*gradesatmul,0.0,1.0);
	hsv.z = pow(hsv.z,gradevalpow)*gradevalmul;
	return hsv2rgb(hsv);
}
/* vanilla game stuff */
float3 GameProcessing( float3 res, float2 coord )
{
	float3 tcol = res;
	float4 r0,r1,r2,r3;
	r0.xyz = tcol;
	r1.xy = Params01[4].zw*coord;
	r1.xyz = TextureBloom.Sample(Linear,r1.xy).xyz;
	r0.w = TextureAdaptation.Sample(Nearest,coord).x;
	r1.w = Params01[1].z/(0.001+r0.w);
	r2.x = r1.w<Params01[1].y;
	r1.w = r2.x?Params01[1].y:r1.w;
	r2.x = Params01[1].x<r1.w;
	r1.w = r2.x?Params01[1].x:r1.w;
	r0.xyz = r1.xyz+r0.xyz;
	r0.xyz = r0.xyz*r1.w;
	r1.xyz = r0.xyz+r0.xyz;
	r2.xyz = r0.xyz*0.3+0.05;
	r3.xy = float2(0.2,3.333333)*Params01[1].w;
	r2.xyz = r1.xyz*r2.xyz+r3.x;
	r0.xyz = r0.xyz*0.3+0.5;
	r0.xyz = r1.xyz*r0.xyz+0.06;
	r0.xyz = r2.xyz/r0.xyz;
	r0.xyz = -Params01[1].w*3.333333+r0.xyz;
	r1.x = Params01[1].w*0.2+19.376;
	r1.x = r1.x*0.0408564-r3.y;
	r1.xyz = r0.xyz/r1.x;
	r0.x = dot(r1.xyz,float3(0.2125,0.7154,0.0721));
	r1.xyz = r1.xyz-r0.x;
	r1.xyz = Params01[2].x*r1.xyz+r0.x;
	r2.xyz = r0.x * Params01[3].xyz-r1.xyz;
	r1.xyz = Params01[3].w*r2.xyz+r1.xyz;
	r1.xyz = Params01[2].w*r1.xyz-r0.w;
	r0.xyz = Params01[2].z*r1.xyz+r0.w;
	tcol.xyz = lerp(r0.xyz,Params01[5].xyz,Params01[5].w);
	tcol.xyz = pow(tcol.xyz,1.0/2.2);
	return lerp(res,tcol,vanillablend);
}
/* LUT colour grading */
float3 GradingLUT( float3 res )
{
	float3 tcol = clamp(res,0.0001,0.9999);
	tcol.rg = tcol.rg*0.5+0.25;
#ifdef LUTMODE_LEGACY
	float2 lc1 = float2(tcol.r/16.0+floor(tcol.b*16.0)/16.0,tcol.g/64.0
		+clut/64.0);
	float2 lc2 = float2(tcol.r/16.0+ceil(tcol.b*16.0)/16.0,tcol.g/64.0
		+clut/64.0);
	float dec = (ceil(tcol.b*16.0)==16.0)?(0.0):frac(tcol.b*16.0);
#endif
#ifdef LUTMODE_16
	float2 lc1 = float2(tcol.r,tcol.g/16.0+floor(tcol.b*16.0)/16.0);
	float2 lc2 = float2(tcol.r,tcol.g/16.0+ceil(tcol.b*16.0)/16.0);
	float dec = (ceil(tcol.b*16.0)==16.0)?(0.0):frac(tcol.b*16.0);
#endif
#ifdef LUTMODE_64
	float2 lc1 = float2(tcol.r,tcol.g/64.0+floor(tcol.b*64.0)/64.0);
	float2 lc2 = float2(tcol.r,tcol.g/64.0+ceil(tcol.b*64.0)/64.0);
	float dec = (ceil(tcol.b*64.0)==64.0)?(0.0):frac(tcol.b*64.0);
#endif
	float3 tcl1 = TextureLUT.Sample(Linear,lc1).rgb;
	float3 tcl2 = TextureLUT.Sample(Linear,lc2).rgb;
	tcol = lerp(tcl1,tcl2,dec);
	/*float lutblend = tod(lutblend);*/
	return lerp(res,tcol,lutblend);
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
	   1. two-pass algorithm that produces a particular fuzz complete with
	       a soft horizontal tear, reminiscent of old TV static.
	   2. simple version that has very noticeable tiling and visible
	      scrolling at low speeds
	*/
	if ( np )
	{
		n1 = TextureNoise2.Sample(Noise2,s1*nm11*nr).r;
		n2 = TextureNoise2.Sample(Noise2,s2*nm12*nr).g;
		n3 = TextureNoise2.Sample(Noise2,s3*nm13*nr).b;
		s1 = tcs+float2(ts+n1*nk,n2*nk);
		s2 = tcs+float2(n2,ts+n3*nk);
		s3 = tcs+float2(ts+n3*nk,ts+n1*nk);
		n1 = TextureNoise2.Sample(Noise2,s1*nm21*nr).r;
		n2 = TextureNoise2.Sample(Noise2,s2*nm22*nr).g;
		n3 = TextureNoise2.Sample(Noise2,s3*nm23*nr).b;
	}
	else
	{
		n1 = TextureNoise3.Sample(Noise3,s1*nm1*nr).r;
		n2 = TextureNoise3.Sample(Noise3,s2*nm2*nr).g;
		n3 = TextureNoise3.Sample(Noise3,s3*nm3*nr).b;
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
float4 PS_MariENB( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord0.xy;
	float4 res = TextureColor.Sample(Nearest,coord);
	if ( tmapenable && tmapbeforecomp ) res.rgb = Tonemap(res.rgb);
	if ( compenable ) res.rgb = Compensate(res.rgb);
	if ( tmapenable && !tmapbeforecomp ) res.rgb = Tonemap(res.rgb);
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
	if ( ne ) res.rgb = FilmGrain(res.rgb,coord);
	if ( vanillaenable ) res.rgb = GameProcessing(res.rgb,coord);
	if ( dodither ) res.rgb = Dither(res.rgb,coord);
	res.a = 1.0;
	return res;
}
/* Vanilla shader */
float4 PS_Vanilla( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float4 res;
	float4 color;
	color = TextureColor.Sample(Nearest,IN.txcoord0.xy);
	float4 r0,r1,r2,r3;
	r0.xyz = color.xyz;
	r1.xy = Params01[4].zw*IN.txcoord0.xy;
	r1.xyz = TextureBloom.Sample(Linear,r1.xy).xyz;
	r0.w = TextureAdaptation.Sample(Nearest,IN.txcoord0.xy).x;
	r1.w = Params01[1].z/(0.001+r0.w);
	r2.x = r1.w<Params01[1].y;
	r1.w = r2.x?Params01[1].y:r1.w;
	r2.x = Params01[1].x<r1.w;
	r1.w = r2.x?Params01[1].x:r1.w;
	r0.xyz = r1.xyz+r0.xyz;
	r0.xyz = r0.xyz*r1.w;
	r1.xyz = r0.xyz+r0.xyz;
	r2.xyz = r0.xyz*0.3+0.05;
	r3.xy = float2(0.2,3.333333)*Params01[1].w;
	r2.xyz = r1.xyz*r2.xyz+r3.x;
	r0.xyz = r0.xyz*0.3+0.5;
	r0.xyz = r1.xyz*r0.xyz+0.06;
	r0.xyz = r2.xyz/r0.xyz;
	r0.xyz = -Params01[1].w*3.333333+r0.xyz;
	r1.x = Params01[1].w*0.2+19.376;
	r1.x = r1.x*0.0408564-r3.y;
	r1.xyz = r0.xyz/r1.x;
	r0.x = dot(r1.xyz,float3(0.2125,0.7154,0.0721));
	r1.xyz = r1.xyz-r0.x;
	r1.xyz = Params01[2].x*r1.xyz+r0.x;
	r2.xyz = r0.x * Params01[3].xyz-r1.xyz;
	r1.xyz = Params01[3].w*r2.xyz+r1.xyz;
	r1.xyz = Params01[2].w*r1.xyz-r0.w;
	r0.xyz = Params01[2].z*r1.xyz+r0.w;
	res.xyz = lerp(r0.xyz,Params01[5].xyz,Params01[5].w);
	res.xyz = pow(res.xyz,1.0/2.2);
	res.w = 1.0;
	return res;
}
/* This seems to make a bit more sense now */
technique11 Draw <string UIName="MariENB";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Pass()));
		SetPixelShader(CompileShader(ps_5_0,PS_MariENB()));
	}
}
/* cool, no more inline assembly */
technique11 ORIGINALPOSTPROCESS <string UIName="Vanilla";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Pass()));
		SetPixelShader(CompileShader(ps_5_0,PS_Vanilla()));
	}
}
