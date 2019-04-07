/*
	enbeffect.fx : MariENB3 base shader.
	(C)2016 Marisa Kirisame, UnSX Team.
	Part of MariENB3, the personal ENB of Marisa for Fallout 4.
	Released under the GNU GPLv3 (or later).
*/
#include "menbglobaldefs.fx"

string str_noise = "Film Grain";
bool ne
<
	string UIName = "Enable Grain";
	string UIWidget = "Checkbox";
> = {false};
/* speed of grain */
float nf
<
	string UIName = "Grain Speed";
	string UIWidget = "Spinner";
> = {2500.0};
/* intensity of grain */
float ni
<
	string UIName = "Grain Intensity";
	string UIWidget = "Spinner";
> = {0.05};
/* saturation of grain */
float ns
<
	string UIName = "Grain Saturation";
	string UIWidget = "Spinner";
> = {0.0};
/* use two-pass grain (double the texture fetches, but looks less uniform) */
bool np
<
	string UIName = "Grain Two-Pass";
	string UIWidget = "Checkbox";
> = {true};
/*
   blending mode for grain:
   0 -> normal
   1 -> add
   2 -> overlay
   3 -> "dark mask", a personal invention
*/
int nb
<
	string UIName = "Grain Blending Mode";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 3;
> = {1};
/* dark mask blend mode contrast for mask image */
float bnp
<
	string UIName = "Grain Dark Mask Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.5};
/* two-pass distortion factor (0 = look just like one-pass grain) */
float nk
<
	string UIName = "Grain Two-Pass Factor";
	string UIWidget = "Spinner";
> = {0.04};
/* zoom factors for each component of each noise texture */
float3 nm
<
	string UIName = "Grain Magnification";
	string UIWidget = "Vector";
> = {13.25,19.64,17.35};
float3 nm1
<
	string UIName = "Grain Pass 1 Magnification";
	string UIWidget = "Vector";
> = {2.05,3.11,2.22};
float3 nm2
<
	string UIName = "Grain Pass 2 Magnification";
	string UIWidget = "Vector";
> = {4.25,0.42,6.29};
/* contrast of grain */
float nj
<
	string UIName = "Grain Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
/* tone mapping */
string str_tonemap = "Filmic Tone Mapping";
bool tmapenable
<
	string UIName = "Enable Tonemapping";
	string UIWidget = "Checkbox";
> = {false};
float unA_n
<
	string UIName = "Tonemap Shoulder Strength Night";
	string UIWidget = "Spinner";
> = {0.5};
float unA_d
<
	string UIName = "Tonemap Shoulder Strength Day";
	string UIWidget = "Spinner";
> = {0.5};
float unA_i
<
	string UIName = "Tonemap Shoulder Strength Interior";
	string UIWidget = "Spinner";
> = {0.5};
float unB_n
<
	string UIName = "Tonemap Linear Strength Night";
	string UIWidget = "Spinner";
> = {1.0};
float unB_d
<
	string UIName = "Tonemap Linear Strength Day";
	string UIWidget = "Spinner";
> = {1.0};
float unB_i
<
	string UIName = "Tonemap Linear Strength Interior";
	string UIWidget = "Spinner";
> = {1.0};
float unC_n
<
	string UIName = "Tonemap Linear Angle Night";
	string UIWidget = "Spinner";
> = {0.2};
float unC_d
<
	string UIName = "Tonemap Linear Angle Day";
	string UIWidget = "Spinner";
> = {0.2};
float unC_i
<
	string UIName = "Tonemap Linear Angle Interior";
	string UIWidget = "Spinner";
> = {0.2};
float unD_n
<
	string UIName = "Tonemap Toe Strength Night";
	string UIWidget = "Spinner";
> = {0.75};
float unD_d
<
	string UIName = "Tonemap Toe Strength Day";
	string UIWidget = "Spinner";
> = {0.75};
float unD_i
<
	string UIName = "Tonemap Toe Strength Interior";
	string UIWidget = "Spinner";
> = {0.75};
float unE_n
<
	string UIName = "Tonemap Toe Numerator Night";
	string UIWidget = "Spinner";
> = {0.02};
float unE_d
<
	string UIName = "Tonemap Toe Numerator Day";
	string UIWidget = "Spinner";
> = {0.02};
float unE_i
<
	string UIName = "Tonemap Toe Numerator Interior";
	string UIWidget = "Spinner";
> = {0.02};
float unF_n
<
	string UIName = "Tonemap Toe Denominator Night";
	string UIWidget = "Spinner";
> = {0.30};
float unF_d
<
	string UIName = "Tonemap Toe Denominator Day";
	string UIWidget = "Spinner";
> = {0.30};
float unF_i
<
	string UIName = "Tonemap Toe Denominator Interior";
	string UIWidget = "Spinner";
> = {0.30};
float unW_n
<
	string UIName = "Tonemap Linear White Night";
	string UIWidget = "Spinner";
> = {10.0};
float unW_d
<
	string UIName = "Tonemap Linear White Day";
	string UIWidget = "Spinner";
> = {10.0};
float unW_i
<
	string UIName = "Tonemap Linear White Interior";
	string UIWidget = "Spinner";
> = {10.0};
/* Color grading */
string str_grade = "Color Grading Suite";
bool gradeenable1
<
	string UIName = "Enable RGB Grading";
	string UIWidget = "Checkbox";
> = {false};
/* color component multipliers */
float3 grademul_n
<
	string UIName = "Grading Intensity Night";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
float3 grademul_d
<
	string UIName = "Grading Intensity Day";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
float3 grademul_i
<
	string UIName = "Grading Intensity Interior";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
/* color component contrasts */
float3 gradepow_n
<
	string UIName = "Grading Contrast Night";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
float3 gradepow_d
<
	string UIName = "Grading Contrast Day";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
float3 gradepow_i
<
	string UIName = "Grading Contrast Interior";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
/* colorization factors */
bool gradeenable2
<
	string UIName = "Enable Vibrance Grading";
	string UIWidget = "Checkbox";
> = {false};
float3 gradecol_n
<
	string UIName = "Grading Color Night";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
float3 gradecol_d
<
	string UIName = "Grading Color Day";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
float3 gradecol_i
<
	string UIName = "Grading Color Interior";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
/* blend factor for colorization (negative values are quite fancy) */
float gradecolfact_n
<
	string UIName = "Grading Color Factor Night";
	string UIWidget = "Spinner";
> = {0.0};
float gradecolfact_d
<
	string UIName = "Grading Color Factor Day";
	string UIWidget = "Spinner";
> = {0.0};
float gradecolfact_i
<
	string UIName = "Grading Color Factor Interior";
	string UIWidget = "Spinner";
> = {0.0};
/* HSV grading */
bool gradeenable3
<
	string UIName = "Enable HSV Grading";
	string UIWidget = "Checkbox";
> = {false};
/* saturation multiplier */
float gradesatmul_n
<
	string UIName = "Grading Saturation Intensity Night";
	string UIWidget = "Spinner";
> = {1.0};
float gradesatmul_d
<
	string UIName = "Grading Saturation Intensity Day";
	string UIWidget = "Spinner";
> = {1.0};
float gradesatmul_i
<
	string UIName = "Grading Saturation Intensity Interior";
	string UIWidget = "Spinner";
> = {1.0};
/* saturation power */
float gradesatpow_n
<
	string UIName = "Grading Saturation Contrast Night";
	string UIWidget = "Spinner";
> = {1.0};
float gradesatpow_d
<
	string UIName = "Grading Saturation Contrast Day";
	string UIWidget = "Spinner";
> = {1.0};
float gradesatpow_i
<
	string UIName = "Grading Saturation Contrast Interior";
	string UIWidget = "Spinner";
> = {1.0};
/* value multiplier */
float gradevalmul_n
<
	string UIName = "Grading Value Intensity Night";
	string UIWidget = "Spinner";
> = {1.0};
float gradevalmul_d
<
	string UIName = "Grading Value Intensity Day";
	string UIWidget = "Spinner";
> = {1.0};
float gradevalmul_i
<
	string UIName = "Grading Value Intensity Interior";
	string UIWidget = "Spinner";
> = {1.0};
/* value power */
float gradevalpow_n
<
	string UIName = "Grading Value Contrast Night";
	string UIWidget = "Spinner";
> = {1.0};
float gradevalpow_d
<
	string UIName = "Grading Value Contrast Day";
	string UIWidget = "Spinner";
> = {1.0};
float gradevalpow_i
<
	string UIName = "Grading Value Contrast Interior";
	string UIWidget = "Spinner";
> = {1.0};
bool colorizeafterhsv
<
	string UIName = "Colorize After HSV";
	string UIWidget = "Checkbox";
> = {true};/* LUT grading */
string str_lut = "RGB Lookup Table Grading";
bool lutenable
<
	string UIName = "Enable LUT Grading";
	string UIWidget = "Checkbox";
> = {false};
float lutblend_n
<
	string UIName = "LUT Blend Night";
	string UIWidget = "Spinner";
> = {1.0};
float lutblend_d
<
	string UIName = "LUT Blend Day";
	string UIWidget = "Spinner";
> = {1.0};
float lutblend_i
<
	string UIName = "LUT Blend Interior";
	string UIWidget = "Spinner";
> = {1.0};
#ifdef LUTMODE_LEGACY
int clut
<
	string UIName = "LUT Preset";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 63;
> = {1};
#endif
string str_dither = "Dithering";
bool dodither
<
	string UIName = "Enable Post Dither";
	string UIWidget = "Checkbox";
> = {true};
int dither
<
	string UIName = "Dither Pattern";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 4;
> = {4};
string str_debug = "Debugging";
bool bloomdebug
<
	string UIName = "Display Bloom";
	string UIWidget = "Checkbox";
> = {false};
bool adaptdebug
<
	string UIName = "Display Adaptation";
	string UIWidget = "Checkbox";
> = {false};

/*
   dithering threshold maps
   don't touch unless you know what you're doing
*/
static const float checkers[4] =
{
	1.0,0.0,
	0.0,1.0
};
#define d(x) x/4.0
static const float ordered2[4] =
{
	d(0),d(2),
	d(4),d(2)
};
#undef d
#define d(x) x/9.0
static const float ordered3[9] =
{
	d(2),d(6),d(3),
	d(5),d(0),d(8),
	d(1),d(7),d(4)
};
#undef d
#define d(x) x/16.0
static const float ordered4[16] =
{
	d( 0),d( 8),d( 2),d(10),
	d(12),d( 4),d(14),d( 6),
	d( 3),d(11),d( 1),d( 9),
	d(15),d( 7),d(13),d( 5)
};
#undef d
#define d(x) x/64.0
static const float ordered8[64] =
{
	d( 0),d(48),d(12),d(60),d( 3),d(51),d(15),d(63),
	d(32),d(16),d(44),d(28),d(35),d(19),d(47),d(31),
	d( 8),d(56),d( 4),d(52),d(11),d(59),d( 7),d(55),
	d(40),d(24),d(36),d(20),d(43),d(27),d(39),d(23),
	d( 2),d(50),d(14),d(62),d( 1),d(49),d(13),d(61),
	d(34),d(18),d(46),d(30),d(33),d(17),d(45),d(29),
	d(10),d(58),d( 6),d(54),d( 9),d(57),d( 5),d(53),
	d(42),d(26),d(38),d(22),d(41),d(25),d(37),d(21)
};
#undef d

float4 Timer;
float4 ScreenSize;
float ENightDayFactor;
float EInteriorFactor;
float4 TimeOfDay1;
float4 TimeOfDay2;

#ifdef SKYRIMSE
float4 Params01[7];
#else
float4 Params01[6];
#endif
float4 ENBParams01;
Texture2D TextureColor;
Texture2D TextureBloom;
Texture2D TextureAdaptation;

Texture2D TextureNoise2
<
	string ResourceName = "menbnoise1.png";
>;
Texture2D TextureNoise3
<
	string ResourceName = "menbnoise2.png";
>;
Texture2D TextureLUT
<
#ifdef LUTMODE_LEGACY
	string ResourceName = "menblutpreset.png";
#endif
#ifdef LUTMODE_16
	string ResourceName = "menblut16.png";
#endif
#ifdef LUTMODE_64
	string ResourceName = "menblut64.png";
#endif
>;

SamplerState Sampler0
{
	Filter = MIN_MAG_MIP_POINT;
	AddressU = Clamp;
	AddressV = Clamp;
};
SamplerState Sampler1
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
};
SamplerState SamplerLUT
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Wrap;
	AddressV = Wrap;
	MaxLOD = 0;
	MinLOD = 0;
};
SamplerState SamplerNoise2
{
	Filter = MIN_LINEAR_MAG_MIP_POINT;
	AddressU = Wrap;
	AddressV = Wrap;
	MaxLOD = 0;
	MinLOD = 0;
};
SamplerState SamplerNoise3
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Wrap;
	AddressV = Wrap;
	MaxLOD = 0;
	MinLOD = 0;
};

struct VS_INPUT_POST
{
	float3 pos : POSITION;
	float2 txcoord : TEXCOORD0;
};
struct VS_OUTPUT_POST
{
	float4 pos : SV_POSITION;
	float2 txcoord0 : TEXCOORD0;
};

VS_OUTPUT_POST VS_Draw( VS_INPUT_POST IN )
{
	VS_OUTPUT_POST OUT;
	OUT.pos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord0.xy = IN.txcoord.xy;
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
	float A = tod_ind(unA);
	float B = tod_ind(unB);
	float C = tod_ind(unC);
	float D = tod_ind(unD);
	float E = tod_ind(unE);
	float F = tod_ind(unF);
	return ((res*(A*res+C*B)+D*E)/(res*(A*res+B)+D*F))-E/F;
}
float3 Tonemap( float3 res )
{
	float W = tod_ind(unW);
	float3 ucol = Uch(res);
	float3 uwhite = Uch(W);
	return max(ucol/uwhite,0.0);
}
/* colour grading passes */
float3 GradingRGB( float3 res )
{
	float3 grademul = tod_ind(grademul);
	float3 gradepow = tod_ind(gradepow);
	return pow(max(0,res),gradepow)*grademul;
}
float3 GradingColorize( float3 res )
{
	float gradecolfact = tod_ind(gradecolfact);
	float3 gradecol = tod_ind(gradecol);
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
/* LUT colour grading */
float3 GradingLUT( float3 res )
{
	/*
	   gross hacks were needed to "fix" the way direct3d interpolates on
	   sampling, and to manually interpolate on the blue channel
	   
	   this could be alleviated if I could have all the LUTs as volume
	   maps, but I think ENB can't load them.
	*/
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
	float3 tcl1 = TextureLUT.Sample(SamplerLUT,lc1).rgb;
	float3 tcl2 = TextureLUT.Sample(SamplerLUT,lc2).rgb;
	tcol = lerp(tcl1,tcl2,dec);
	float lutblend = tod_ind(lutblend);
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
		n1 = TextureNoise2.Sample(SamplerNoise2,s1*nm1.x*nr).r;
		n2 = TextureNoise2.Sample(SamplerNoise2,s2*nm1.y*nr).g;
		n3 = TextureNoise2.Sample(SamplerNoise2,s3*nm1.z*nr).b;
		s1 = tcs+float2(ts+n1*nk,n2*nk);
		s2 = tcs+float2(n2,ts+n3*nk);
		s3 = tcs+float2(ts+n3*nk,ts+n1*nk);
		n1 = TextureNoise2.Sample(SamplerNoise2,s1*nm2.x*nr).r;
		n2 = TextureNoise2.Sample(SamplerNoise2,s2*nm2.y*nr).g;
		n3 = TextureNoise2.Sample(SamplerNoise2,s3*nm2.z*nr).b;
	}
	else
	{
		n1 = TextureNoise3.Sample(SamplerNoise3,s1*nm.x*nr).r;
		n2 = TextureNoise3.Sample(SamplerNoise3,s2*nm.y*nr).g;
		n3 = TextureNoise3.Sample(SamplerNoise3,s3*nm.z*nr).b;
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

float4 PS_Draw( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord0.xy;
	float4 res;
#ifdef SKYRIMSE
	res = TextureColor.Sample(Sampler0,coord)
		+TextureBloom.Sample(Sampler1,coord)*ENBParams01.x;
	/* Luckily I could sort of interpret some of the vanilla grading */
	float val = luminance(res.rgb);
	float adapt = TextureAdaptation.Sample(Sampler1,coord).x;
	float4 tint;
	res -= val;
	res = Params01[3].x*res+val;
	tint = Params01[4]*val-res;
	res = Params01[4].w*tint+res;
	res = Params01[3].w*res-adapt;
	res = Params01[3].z*res+adapt;
	if ( bloomdebug	) res = TextureBloom.Sample(Sampler1,coord)
		*ENBParams01.x;
#else
	float4 color;
	color = TextureColor.Sample(Sampler0,IN.txcoord0.xy);
	float4 r0, r1, r2, r3;
	r0.xyz = color.xyz;
	r1.xy = Params01[4].zw*IN.txcoord0.xy;
	r1.xyz = TextureBloom.Sample(Sampler1,r1.xy).xyz*ENBParams01.x;
	r0.w = TextureAdaptation.Sample(Sampler0,IN.txcoord0.xy).x;
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
	r1.xyz = Params01[2].x * r1.xyz+r0.x;
	r2.xyz = r0.x*Params01[3].xyz-r1.xyz;
	r1.xyz = Params01[3].w*r2.xyz+r1.xyz;
	r1.xyz = Params01[2].w*r1.xyz-r0.w;
	r0.xyz = Params01[2].z*r1.xyz+r0.w;
	color.xyz = lerp(r0.xyz,Params01[5].xyz,Params01[5].w);
	color.xyz = saturate(color.xyz);
	color.xyz = pow(color.xyz,1.0/2.2);
	res.xyz = max(0,color.xyz);
	res.w = 1.0;
	if ( bloomdebug	) res = TextureBloom.Sample(Sampler1,Params01[4].zw
		*coord)*ENBParams01.x;
#endif
	/* Insert MariENB filters here */
	if ( tmapenable ) res.rgb = Tonemap(res.rgb);
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
	if ( adaptdebug	) res.rgb = TextureAdaptation.Sample(Sampler1,coord).x;
	if ( dodither ) res.rgb = Dither(res.rgb,coord);
	res.rgb = max(0,res.rgb);
	res.a = 1.0;
	return res;
}

float4 PS_DrawOriginal( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float4 res;
	float4 color;
	color = TextureColor.Sample(Sampler0,IN.txcoord0.xy);
	float4 r0, r1, r2, r3;
#ifdef SKYRIMSE
	/*
	   You won't believe how HARD Boris has mangled this code.
	   After fixing the horrid code style and the unnecessary scientific
	   notation on floats, it's still unreadable.
	   It's also completely broken and results in a black screen.
	*/
	float2 scaleduv=Params01[6].xy*IN.txcoord0.xy;
	scaleduv = max(scaleduv, 0.0);
	scaleduv = min(scaleduv, Params01[6].zy);
	r1.xy = scaleduv;
	r0.xyz = color.xyz;
	if ( Params01[0].x > 0.5 ) r1.xy = IN.txcoord0.xy;
	r1.xyz = TextureBloom.Sample(Sampler1,r1.xy).xyz;
	r2.xy = TextureAdaptation.Sample(Sampler1,IN.txcoord0.xy).xy;
	r0.w = dot(float3(0.2125,0.7154,0.0721),r0.xyz);
	r0.w = max(r0.w,0.00001);
	r1.w = r2.y/r2.x;
	r2.y = r0.w*r1.w;
	if ( Params01[2].z >= 0.5 ) r2.z = 0xffffffff;
	else r2.z = 0;
	r3.xy = r1.w*r0.w+float2(-0.004,1.0);
	r1.w = max(r3.x, 0.0);
	r3.xz = r1.w*6.2+float2(0.5,1.7);
	r2.w = r1.w*r3.x;
	r1.w = r1.w*r3.z+0.06;
	r1.w = r2.w/r1.w;
	r1.w = pow(r1.w,2.2);
	r1.w = r1.w*Params01[2].y;
	r2.w = r2.y*Params01[2].y+1.0;
	r2.y = r2.w*r2.y;
	r2.y = r2.y/r3.y;
	if (r2.z == 0) r1.w = r2.y;
	else r1.w = r1.w;
	r0.w = r1.w/r0.w;
	r1.w = saturate(Params01[2].x-r1.w);
	r1.xyz = r1*r1.w;
	r0.xyz = r0*r0.w+r1;
	r1.x = dot(r0.xyz,float3(0.2125,0.7154,0.0721));
	r0.w = 1.0;
	r0 = r0-r1.x;
	r0 = Params01[3].x*r0+r1.x;
	r1 = Params01[4]*r1.x-r0;
	r0 = Params01[4].w*r1+r0;
	r0 = Params01[3].w*r0-r2.x;
	r0 = Params01[3].z*r0+r2.x;
	r0.xyz = saturate(r0);
	r1.xyz = pow(r1.xyz,Params01[6].w);
	r1 = Params01[5]-r0;
	res = Params01[5].w*r1+r0;
#else
	r0.xyz = color.xyz;
	r1.xy = Params01[4].zw*IN.txcoord0.xy;
	r1.xyz = TextureBloom.Sample(Sampler1,r1.xy).xyz;
	r0.w = TextureAdaptation.Sample(Sampler0,IN.txcoord0.xy).x;
	r1.w = Params01[1].z/(0.001+r0.w);
	r2.x = r1.w<Params01[1].y;
	r1.w = r2.x?Params01[1].y:r1.w;
	r2.x = Params01[1].x < r1.w;
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
	r2.xyz = r0.x*Params01[3].xyz-r1.xyz;
	r1.xyz = Params01[3].w*r2.xyz+r1.xyz;
	r1.xyz = Params01[2].w*r1.xyz-r0.w;
	r0.xyz = Params01[2].z*r1.xyz+r0.w;
	res.xyz = lerp(r0.xyz,Params01[5].xyz,Params01[5].w);
	res.xyz = pow(max(0,res.xyz),1.0/2.2);
#endif
	res.w = 1.0;
	return res;
}

technique11 Draw <string UIName="MariENB";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Draw()));
		SetPixelShader(CompileShader(ps_5_0, PS_Draw()));
	}
}

technique11 ORIGINALPOSTPROCESS <string UIName="Vanilla";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Draw()));
		SetPixelShader(CompileShader(ps_5_0, PS_DrawOriginal()));
	}
}
