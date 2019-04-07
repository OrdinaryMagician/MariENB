/*
	menbprepassinternals.fx : MariENB prepass internal variables.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* mathematical constants */
static const float pi = 3.1415926535898;
/* edge detect factors */
static const float3x3 GX =
{
	-1, 0, 1,
	-2, 0, 2,
	-1, 0, 1
};
static const float3x3 GY =
{
	 1, 2, 1,
	 0, 0, 0,
	-1,-2,-1
};
/* gaussian kernels */
/* radius: 8, std dev: 3 */
static const float gauss8[8] =
{
	0.134598, 0.127325, 0.107778, 0.081638,
	0.055335, 0.033562, 0.018216, 0.008847
};
/* radius: 16, std dev: 6 */
static const float gauss16[16] =
{
	0.067142, 0.066216, 0.063513, 0.059252,
	0.053763, 0.047446, 0.040723, 0.033996,
	0.027603, 0.021798, 0.016742, 0.012507,
	0.009087, 0.006421, 0.004413, 0.002950

};
/* SSAO samples */
static const float3 ssao_samples[64] =
{
	float3( 0.0000,-0.0002, 0.0002),float3(-0.0005, 0.0006, 0.0006),
	float3(-0.0003,-0.0018,-0.0012),float3( 0.0025, 0.0001,-0.0030),
	float3( 0.0032,-0.0031,-0.0042),float3(-0.0075, 0.0032, 0.0034),
	float3(-0.0017, 0.0107, 0.0050),float3(-0.0113,-0.0022,-0.0106),
	float3( 0.0113,-0.0000,-0.0162),float3(-0.0121,-0.0156,-0.0143),
	float3( 0.0145,-0.0099, 0.0238),float3(-0.0041, 0.0258,-0.0236),
	float3( 0.0261,-0.0282,-0.0150),float3(-0.0392, 0.0259, 0.0093),
	float3( 0.0079, 0.0122,-0.0530),float3(-0.0173, 0.0024,-0.0600),
	float3( 0.0164,-0.0483,-0.0487),float3( 0.0253, 0.0749, 0.0030),
	float3( 0.0702,-0.0024, 0.0532),float3(-0.0587, 0.0343,-0.0701),
	float3(-0.0284, 0.0949, 0.0422),float3(-0.0782,-0.0518, 0.0719),
	float3( 0.0891,-0.0295, 0.0887),float3(-0.1176,-0.0770, 0.0034),
	float3( 0.0911, 0.0979,-0.0736),float3(-0.0492,-0.1109,-0.1119),
	float3( 0.0881,-0.1122,-0.1064),float3(-0.0978,-0.0594,-0.1534),
	float3( 0.1226,-0.0478,-0.1577),float3( 0.1713, 0.1376,-0.0033),
	float3(-0.1098, 0.1317,-0.1601),float3( 0.0153, 0.0431,-0.2458),
	float3( 0.0413,-0.2602,-0.0358),float3( 0.1160, 0.2073,-0.1524),
	float3(-0.0891,-0.2844,-0.0254),float3(-0.2356, 0.1856, 0.1007),
	float3(-0.1331,-0.2241,-0.2093),float3(-0.0946,-0.0943, 0.3262),
	float3(-0.2076, 0.2990,-0.0735),float3(-0.3388,-0.1854,-0.0584),
	float3(-0.2950, 0.2562, 0.1256),float3( 0.1245, 0.3253, 0.2533),
	float3(-0.3334, 0.0732, 0.2954),float3(-0.0878,-0.0338, 0.4632),
	float3( 0.3257,-0.1494, 0.3406),float3( 0.1496, 0.4734, 0.1426),
	float3(-0.4816,-0.1498,-0.1911),float3(-0.4407,-0.2691,-0.2231),
	float3(-0.5739,-0.0862,-0.0829),float3(-0.1811,-0.4338, 0.3893),
	float3(-0.4059, 0.2597,-0.4135),float3( 0.5669,-0.1450, 0.3057),
	float3(-0.3459, 0.0907,-0.5852),float3(-0.0378,-0.4889,-0.5161),
	float3(-0.1609,-0.1172, 0.7112),float3(-0.1584, 0.2215,-0.7156),
	float3(-0.0601,-0.6410,-0.4634),float3(-0.1877,-0.4821, 0.6379),
	float3(-0.5357, 0.6528, 0.0957),float3(-0.5073,-0.3124, 0.6462),
	float3(-0.1505, 0.6792,-0.5842),float3( 0.1781,-0.9197, 0.0557),
	float3(-0.5309,-0.3378,-0.7369),float3(-0.7460, 0.2721,-0.6078)
};
/* standard stuff */
float4 ScreenSize;
float ENightDayFactor;
float EInteriorFactor;
float FadeFactor;
float4 Timer;
float FieldOfView;
/* samplers and textures */
texture2D texColor;
texture2D texDepth;
texture2D texNoise3
<
	string ResourceName = "menbnoise2.png";
>;
texture2D texWater
<
	string ResourceName = "menbwater.png";
>;
texture2D texHeat
<
	string ResourceName = "menbheat.png";
>;
texture2D texFocus;
texture2D texCurr;
texture2D texPrev;
sampler2D SamplerColor = sampler_state
{
	Texture = <texColor>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerDepth = sampler_state
{
	Texture = <texDepth>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerNoise3 = sampler_state
{
	Texture = <texNoise3>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Wrap;
	AddressV = Wrap;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerHeat = sampler_state
{
	Texture = <texHeat>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Wrap;
	AddressV = Wrap;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerFocus = sampler_state
{
	Texture = <texFocus>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerCurr = sampler_state
{
	Texture = <texCurr>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerPrev = sampler_state
{
	Texture = <texPrev>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
/* whatever */
struct VS_OUTPUT_POST
{
	float4 vpos : POSITION;
	float2 txcoord : TEXCOORD0;
};
struct VS_INPUT_POST
{
	float3 pos : POSITION;
	float2 txcoord : TEXCOORD0;
};
