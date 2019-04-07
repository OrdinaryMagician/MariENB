/*
	menbprepassinternals.fx : MariENB prepass internal variables.
	(C)2013-2017 Marisa Kirisame, UnSX Team.
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
/* radius: 8, std dev: 6 */
static const float gauss8[8] =
{
	0.084247, 0.083085, 0.079694, 0.074348,
	0.067460, 0.059533, 0.051099, 0.042657
};
/* radius: 16, std dev: 13 */
static const float gauss16[16] =
{
	0.040012, 0.039893, 0.039541, 0.038960,
	0.038162, 0.037159, 0.035969, 0.034612,
	0.033109, 0.031485, 0.029764, 0.027971,
	0.026131, 0.024268, 0.022405, 0.020563
};
/* SSAO samples */
static const float3 ssao_samples[16] = 
{
	float3( 0.0000,-0.0002, 0.0000),float3(-0.0004, 0.0013, 0.0014),
	float3(-0.0030, 0.0048,-0.0034),float3( 0.0147, 0.0046,-0.0026),
	float3(-0.0097, 0.0275,-0.0092),float3(-0.0178,-0.0072, 0.0491),
	float3( 0.0227,-0.0431,-0.0681),float3( 0.1052, 0.0332,-0.0588),
	float3( 0.0997, 0.0056, 0.1473),float3(-0.1252, 0.2019, 0.0564),
	float3(-0.1054,-0.2072, 0.2271),float3(-0.0542, 0.3096, 0.2814),
	float3( 0.0072,-0.3534, 0.4035),float3(-0.0024,-0.2385, 0.6260),
	float3(-0.1940, 0.5722,-0.5602),float3(-0.0910,-0.7548,-0.6497)
};
/* standard stuff */
float4 ScreenSize;
float ENightDayFactor;
float EInteriorFactor;
float4 Timer;
float4 WeatherAndTime;
/* this still doesn't do anything */
extern float fWaterLevel;
/* samplers and textures */
texture2D texColor;
texture2D texDepth;
texture2D texNoise3
<
	string ResourceName = "menbnoise2.png";
>;
texture2D texHeat
<
#ifdef HEAT_DDS
	string ResourceName = "menbheat.dds";
#else
	string ResourceName = "menbheat.png";
#endif
>;
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
