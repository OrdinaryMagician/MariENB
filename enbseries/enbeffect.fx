/*
	enbeffect.fx : MariENB3 base shader.
	(C)2016-2017 Marisa Kirisame, UnSX Team.
	Part of MariENB3, the personal ENB of Marisa for Fallout 4.
	Released under the GNU GPLv3 (or later).
*/
#include "menbglobaldefs.fx"

string str_misc = "Miscellaneous";
/* fixed resolution, keeps blur filters at a consistent internal resolution */
int2 fixed
<
	string UIName = "Fixed Resolution";
	string UIWidget = "Vector";
	int2 UIMin = {0,0};
> = {1920,1080};
string str_dist = "Distortion Filters";
float distcha
<
	string UIName = "Distortion Chromatic Aberration";
	string UIWidget = "Spinner";
> = {10.0};
bool frostenable
<
	string UIName = "Enable Screen Frost";
	string UIWidget = "Checkbox";
> = {false};
float frostpow
<
	string UIName = "Frost Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float froststrength
<
	string UIName = "Frost Strength";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostrpow
<
	string UIName = "Frost Radial Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostrmult
<
	string UIName = "Frost Radial Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostrbump
<
	string UIName = "Frost Radial Offset";
	string UIWidget = "Spinner";
> = {0.0};
float frostblend
<
	string UIName = "Frost Texture Blend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostbpow
<
	string UIName = "Frost Texture Blend Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostsize
<
	string UIName = "Frost Texture Size";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostfactor_dw
<
	string UIName = "Frost Factor Dawn";
	string UIWidget = "Spinner";
> = {0.1};
float frostfactor_sr
<
	string UIName = "Frost Factor Sunrise";
	string UIWidget = "Spinner";
> = {0.0};
float frostfactor_dy
<
	string UIName = "Frost Factor Day";
	string UIWidget = "Spinner";
> = {0.0};
float frostfactor_ss
<
	string UIName = "Frost Factor Sunset";
	string UIWidget = "Spinner";
> = {0.0};
float frostfactor_ds
<
	string UIName = "Frost Factor Dusk";
	string UIWidget = "Spinner";
> = {0.1};
float frostfactor_nt
<
	string UIName = "Frost Factor Night";
	string UIWidget = "Spinner";
> = {0.25};
float frostfactor_i
<
	string UIName = "Frost Factor Interior";
	string UIWidget = "Spinner";
> = {0.0};
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
bool nbt
<
	string UIName = "Apply Grain Before Tone Mapping";
	string UIWidget = "Checkbox";
> = {true};
/* old dirt filter */
string str_dirt = "Screen Dirt";
bool dirtenable
<
	string UIName = "Enable Dirt";
	string UIWidget = "Checkbox";
> = {false};
float dirtcfactor
<
	string UIName = "Dirt Coord Factor";
	string UIWidget = "Spinner";
> = {0.1};
float dirtlfactor
<
	string UIName = "Dirt Luminance Factor";
	string UIWidget = "Spinner";
> = {0.0};
float dirtmc
<
	string UIName = "Dirt Coord Zoom";
	string UIWidget = "Spinner";
> = {3.0};
float dirtml
<
	string UIName = "Dirt Luminance Zoom";
	string UIWidget = "Spinner";
> = {1.0};
/* eye adaptation */
string str_adaptation = "Eye Adaptation";
bool aenable
<
	string UIName = "Enable Adaptation";
	string UIWidget = "Checkbox";
> = {false};
/* tone mapping */
string str_tonemap = "Tone Mapping";
/*
   algorithms:
    -1 : Disabled
     0 : Vanilla
     1 : Linear
     2 : Reinhard
     3 : Uncharted 2
     4 : Hejl Dawson
     5 : Haarm-Peter Duiker
*/
int tmapenable
<
	string UIName = "Tonemapping Method";
	string UIWidget = "Spinner";
	int UIMin = -1;
	int UIMax = 5;
> = {3};
float tmapexposure_n
<
	string UIName = "Tonemap Exposure Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float tmapexposure_d
<
	string UIName = "Tonemap Exposure Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float tmapexposure_i
<
	string UIName = "Tonemap Exposure Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float tmapblend_n
<
	string UIName = "Tonemap Blend Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float tmapblend_d
<
	string UIName = "Tonemap Blend Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float tmapblend_i
<
	string UIName = "Tonemap Blend Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float unA_n
<
	string UIName = "Uncharted2 Shoulder Strength Night";
	string UIWidget = "Spinner";
> = {0.5};
float unA_d
<
	string UIName = "Uncharted2 Shoulder Strength Day";
	string UIWidget = "Spinner";
> = {0.5};
float unA_i
<
	string UIName = "Uncharted2 Shoulder Strength Interior";
	string UIWidget = "Spinner";
> = {0.5};
float unB_n
<
	string UIName = "Uncharted2 Linear Strength Night";
	string UIWidget = "Spinner";
> = {1.0};
float unB_d
<
	string UIName = "Uncharted2 Linear Strength Day";
	string UIWidget = "Spinner";
> = {1.0};
float unB_i
<
	string UIName = "Uncharted2 Linear Strength Interior";
	string UIWidget = "Spinner";
> = {1.0};
float unC_n
<
	string UIName = "Uncharted2 Linear Angle Night";
	string UIWidget = "Spinner";
> = {0.2};
float unC_d
<
	string UIName = "Uncharted2 Linear Angle Day";
	string UIWidget = "Spinner";
> = {0.2};
float unC_i
<
	string UIName = "Uncharted2 Linear Angle Interior";
	string UIWidget = "Spinner";
> = {0.2};
float unD_n
<
	string UIName = "Uncharted2 Toe Strength Night";
	string UIWidget = "Spinner";
> = {0.75};
float unD_d
<
	string UIName = "Uncharted2 Toe Strength Day";
	string UIWidget = "Spinner";
> = {0.75};
float unD_i
<
	string UIName = "Uncharted2 Toe Strength Interior";
	string UIWidget = "Spinner";
> = {0.75};
float unE_n
<
	string UIName = "Uncharted2 Toe Numerator Night";
	string UIWidget = "Spinner";
> = {0.02};
float unE_d
<
	string UIName = "Uncharted2 Toe Numerator Day";
	string UIWidget = "Spinner";
> = {0.02};
float unE_i
<
	string UIName = "Uncharted2 Toe Numerator Interior";
	string UIWidget = "Spinner";
> = {0.02};
float unF_n
<
	string UIName = "Uncharted2 Toe Denominator Night";
	string UIWidget = "Spinner";
> = {0.30};
float unF_d
<
	string UIName = "Uncharted2 Toe Denominator Day";
	string UIWidget = "Spinner";
> = {0.30};
float unF_i
<
	string UIName = "Uncharted2 Toe Denominator Interior";
	string UIWidget = "Spinner";
> = {0.30};
float unW_n
<
	string UIName = "Uncharted2 Linear White Night";
	string UIWidget = "Spinner";
> = {10.0};
float unW_d
<
	string UIName = "Uncharted2 Linear White Day";
	string UIWidget = "Spinner";
> = {10.0};
float unW_i
<
	string UIName = "Uncharted2 Linear White Interior";
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
> = {true};
/* LUT grading */
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
/* technicolor shader */
string str_tech = "Technicolor";
bool techenable
<
	string UIName = "Enable Technicolor";
	string UIWidget = "Checkbox";
> = {false};
float techblend
<
	string UIName = "Technicolor Blend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
/* vanilla */
string str_vanilla = "Vanilla Processing";
bool vgradeenable
<
	string UIName = "Enable Vanilla Imagespace";
	string UIWidget = "Checkbox";
> = {true};
float vtintpow
<
	string UIName = "Vanilla Tint Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float vtintmul
<
	string UIName = "Vanilla Tint Strength";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float vtintblend
<
	string UIName = "Vanilla Tint Blend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float vsatpow
<
	string UIName = "Vanilla Vibrance Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float vsatmul
<
	string UIName = "Vanilla Vibrance Strength";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float vsatblend
<
	string UIName = "Vanilla Vibrance Blend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float vconblend
<
	string UIName = "Vanilla Contrast Blend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
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

Texture2D TextureNoise1
<
	string ResourceName = "menbnoise1.png";
>;
Texture2D TextureNoise2
<
	string ResourceName = "menbnoise2.png";
>;
Texture2D TextureNoise3
<
	string ResourceName = "menbnoise3.png";
>;
Texture3D TextureLUTN
<
	string ResourceName = "menblut_night.dds";
>;
Texture3D TextureLUTD
<
	string ResourceName = "menblut_day.dds";
>;
Texture3D TextureLUTI
<
	string ResourceName = "menblut_interior.dds";
>;
Texture2D TextureTonemap
<
	string ResourceName = "menbfilmlut.png";
>;
Texture2D TextureFrost
<
#ifdef FROST_DDS
	string ResourceName = "menbfrost.dds";
#else
	string ResourceName = "menbfrost.png";
#endif
>;

SamplerState Sampler0
{
	Filter = MIN_MAG_MIP_POINT;
	AddressU = Clamp;
	AddressV = Clamp;
	MaxLOD = 0;
};
SamplerState Sampler1
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
	MaxLOD = 0;
};
SamplerState Sampler2
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Wrap;
	AddressV = Wrap;
	MaxLOD = 0;
};
SamplerState SamplerLUT
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
	AddressW = Clamp;
	MaxLOD = 0;
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
/* Vanilla tonemap is weird */
float3 TonemapGame( float3 res )
{
#ifdef SKYRIMSE
	return pow(max(res,0.0),1.0/2.2);
#else
	float3 wat = res*2.0;
	float3 huh = res*0.3+0.05;
	float2 weh = float2(0.2,3.333333)*Params01[1].w;
	huh = wat*huh+weh.x;
	float3 ehh = wat*0.3+0.5;
	ehh = ehh*0.3+0.5;
	ehh = wat*ehh+0.06;
	ehh = huh/ehh;
	ehh = -Params01[1].w*3.333333+ehh;
	wat.x = Params01[1].w*0.2+19.376;
	wat.x = wat.x*0.0408564-weh.y;
	return pow(max(ehh/wat.x,0.0),1.0/2.2);
#endif
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
	retColor.r = TextureTonemap.Sample(Sampler1,float2(lerp(Padding,1-Padding,LogColor.r),.5)).x;
	retColor.g = TextureTonemap.Sample(Sampler1,float2(lerp(Padding,1-Padding,LogColor.g),.5)).x;
	retColor.b = TextureTonemap.Sample(Sampler1,float2(lerp(Padding,1-Padding,LogColor.b),.5)).x;
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
	if ( tmapenable == 5 ) mapped = TonemapHaarmPeterDuiker(res);
	else if ( tmapenable == 4 ) mapped = TonemapHejlDawson(res);
	else if ( tmapenable == 3 ) mapped = TonemapUC2(res);
	else if ( tmapenable == 2 ) mapped = TonemapReinhard(res);
	else if ( tmapenable == 1 ) mapped = TonemapLinear(res);
	else if ( tmapenable == 0 ) mapped = TonemapGame(res);
	return lerp(tcol,mapped,tblend);
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
	/* night sample */
	float3 tcl_n = TextureLUTN.Sample(SamplerLUT,res).rgb;
	/* day sample */
	float3 tcl_d = TextureLUTD.Sample(SamplerLUT,res).rgb;
	/* interior sample */
	float3 tcl_i = TextureLUTI.Sample(SamplerLUT,res).rgb;
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
		n1 = TextureNoise2.Sample(Sampler2,s1*nm1.x*nr).r;
		n2 = TextureNoise2.Sample(Sampler2,s2*nm1.y*nr).g;
		n3 = TextureNoise2.Sample(Sampler2,s3*nm1.z*nr).b;
		s1 = tcs+float2(ts+n1*nk,n2*nk);
		s2 = tcs+float2(n2,ts+n3*nk);
		s3 = tcs+float2(ts+n3*nk,ts+n1*nk);
		n1 = TextureNoise2.Sample(Sampler2,s1*nm2.x*nr).r;
		n2 = TextureNoise2.Sample(Sampler2,s2*nm2.y*nr).g;
		n3 = TextureNoise2.Sample(Sampler2,s3*nm2.z*nr).b;
	}
	else
	{
		n1 = TextureNoise3.Sample(Sampler2,s1*nm.x*nr).r;
		n2 = TextureNoise3.Sample(Sampler2,s2*nm.y*nr).g;
		n3 = TextureNoise3.Sample(Sampler2,s3*nm.z*nr).b;
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

/* identical between games, the only difference is parameter indices */
float3 GradingGame( float3 res, float adapt )
{
	float satv, tintv, conv, brtv;
	float3 tintc;
#ifdef SKYRIMSE
	satv = Params01[3].x;
	tintc = Params01[4].xyz;
	tintv = Params01[4].w;
	conv = Params01[3].w;
	brtv = Params01[3].z;
#else
	satv = Params01[2].x;
	tintc = Params01[3].xyz;
	tintv = Params01[3].w;
	conv = Params01[2].w;
	brtv = Params01[2].z;
#endif
	float val = luminance(res);
	float3 tcol = res-val;
	satv = (satv<0.0)?(-pow(abs(satv),vsatpow)*vsatmul)
		:(pow(max(satv,0.0),vsatpow)*vsatmul);
	tcol = satv*tcol+val;
	tcol = lerp(res,tcol,vsatblend);
	float3 tint = tintc*val-tcol;
	tintv = (tintv<0.0)?(-pow(abs(tintv),vtintpow)*vtintmul)
		:(pow(max(tintv,0.0),vtintpow)*vtintmul);
	tcol = tintv*tint+tcol;
	tcol = lerp(res,tcol,vtintblend);
	tcol = conv*tcol-adapt;
	tcol = brtv*tcol+adapt;
	return lerp(res,tcol,vconblend);
}
/* Skyrim SE version is blatantly incomplete and will glitch out */
float2 Adaptation( float2 coord )
{
#ifdef SKYRIMSE
	float adapt = TextureAdaptation.Sample(Sampler1,coord).x;
	return float2(adapt);
#else
	float adapt = TextureAdaptation.Sample(Sampler0,coord).x;
	float adapt_v1 = Params01[1].z/(0.001+adapt);
	float adapt_v2 = adapt_v1<Params01[1].y;
	adapt_v1 = adapt_v2?Params01[1].y:adapt_v1;
	adapt_v2 = Params01[1].x<adapt_v1;
	adapt_v1 = adapt_v2?Params01[1].x:adapt_v1;
	return float2(adapt_v1,adapt);
#endif
}

/* Screen frost shader. Not very realistic either, but looks fine too. */
float2 ScreenFrost( float2 coord )
{
	float2 bresl;
	if ( (fixed.x > 0) && (fixed.y > 0) ) bresl = fixed;
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 nc = coord*(bresl/FROSTSIZE)*frostsize;
	float2 ofs = TextureFrost.Sample(Sampler2,nc).xy;
	ofs = (ofs-0.5)*2.0;
	ofs *= pow(length(ofs),frostpow)*froststrength;
	float todpow = max(0.0,todx_ind(frostfactor));
	ofs *= todpow;
	/*ofs *= max(0.0,coldfactor-warmfactor);*/
	float dist = distance(coord,float2(0.5,0.5))*2.0;
	ofs *= clamp(pow(dist,frostrpow)*frostrmult+frostrbump,0.0,1.0);
	return coord+ofs;
}

/* Old MariENB 0.x screen dirt filter, updated */
float3 ScreenDirt( float3 res, float2 coord )
{
	float2 nr = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w)/256.0;
	float3 ncolc = TextureNoise1.Sample(Sampler2,coord*dirtmc*nr).rgb;
	float2 ds = float2(res.r+res.g,res.g+res.b)/2.0;
	float3 ncoll = TextureNoise1.Sample(Sampler2,ds*dirtml).rgb;
	res = lerp(res,(ncolc.r+1.0)*res,dirtcfactor
		*saturate(1.0-(ds.x+ds.y)*0.25));
	res = lerp(res,(ncoll.r+1.0)*res,dirtlfactor
		*saturate(1.0-(ds.x+ds.y)*0.25));
	return res;
}

float4 PS_Draw( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord0.xy;
	float2 bresl;
	if ( (fixed.x > 0) && (fixed.y > 0) ) bresl = fixed;
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float4 res, mud;
	if ( frostenable )
	{
		float2 ofs = ScreenFrost(coord);
		ofs -= coord;
		float2 ofr, ofg, ofb;
		ofr = ofs*(1.0-distcha*0.01);
		ofg = ofs;
		ofb = ofs*(1.0+distcha*0.01);
		res = float4(TextureColor.Sample(Sampler0,coord+ofr).r,
			TextureColor.Sample(Sampler0,coord+ofg).g,
			TextureColor.Sample(Sampler0,coord+ofb).b,1.0);
#ifdef SKYRIMSE
		mud = float4(TextureBloom.Sample(Sampler1,coord+ofr).r,
			TextureBloom.Sample(Sampler1,coord+ofg).g,
			TextureBloom.Sample(Sampler1,coord+ofb).b,1.0);
#else
		mud = float4(TextureBloom.Sample(Sampler1,
			Params01[4].zw*(coord+ofr)).r,
			TextureBloom.Sample(Sampler1,Params01[4].zw
			*(coord+ofg)).g,TextureBloom.Sample(Sampler1,
			Params01[4].zw*(coord+ofb)).b,1.0);
#endif
		float2 nc = coord*(bresl/FROSTSIZE)*frostsize;
		float bmp = pow(max(0,TextureFrost.SampleLevel(Sampler2,nc,
			0).z),frostbpow);
		float dist = distance(coord,float2(0.5,0.5))*2.0;
		dist = clamp(pow(dist,frostrpow)*frostrmult+frostrbump,0.0,
			1.0)*frostblend;
		float todpow = max(0.0,todx_ind(frostfactor));
		dist *= todpow;
		/* Weathers not implemented in FO4 ENB as of 0.291 */
		/*dist *= max(0.0,coldfactor-warmfactor);*/
		res.rgb *= 1.0+bmp*dist;
	}
	else
	{
		res = TextureColor.Sample(Sampler0,coord);
#ifdef SKYRIMSE
		mud = TextureBloom.Sample(Sampler1,coord);
#else
		mud = TextureBloom.Sample(Sampler1,Params01[4].zw*coord);
#endif
	}
	/* Insert MariENB filters here */
	float2 adapt = Adaptation(coord);
	if ( bloomdebug ) res.rgb *= 0;
	float3 bcol = mud.rgb*ENBParams01.x;
	res.rgb += bcol;
	if ( aenable ) res.rgb *= adapt.x;
	if ( nbt && ne ) res.rgb = FilmGrain(res.rgb,coord);
	if ( dirtenable ) res.rgb = ScreenDirt(res.rgb,coord);
	res.rgb = Tonemap(res.rgb);
	if ( vgradeenable ) res.rgb = GradingGame(res.rgb,adapt.y);
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
	if ( techenable ) res.rgb = Technicolor(res.rgb);
	if ( lutenable ) res.rgb = GradingLUT(res.rgb);
	if ( !nbt && ne ) res.rgb = FilmGrain(res.rgb,coord);
	/* fade has same index on both games */
	res.rgb = Params01[5].rgb*Params01[5].a+res.rgb*(1.0-Params01[5].a);
	if ( adaptdebug	) res.rgb = TextureAdaptation.Sample(Sampler1,coord).x;
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
