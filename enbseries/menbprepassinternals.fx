/*
	menbprepassinternals.fx : MariENB prepass internal variables.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the WTFPL.
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
/* gaussian blur matrices */
static const float2x2 gauss3 =
{
	0.16,0.12,
	0.12,0.09
};
static const float3x3 gauss5 =
{
	0.0865051903114,0.0692041522491,0.0346020761246,
	0.0692041522491,0.0553633217993,0.0276816609,
	0.0346020761246,0.0276816609,0.01384083045
};
static const float4x4 gauss7 =
{
	0.0632507440209,0.0527089533508,0.0301194019147,0.011294775718,
	0.0527089533508,0.0439241277923,0.0250995015956,0.00941231309835,
	0.0301194019147,0.0250995015956,0.01434257234,0.00537846462763,
	0.011294775718,0.00941231309835,0.00537846462763,0.00201692423536
};
/* SSAO sample sphere */
static const float3 ssao_samples[16] =
{
	float3( 0.5381, 0.1856,-0.4319),float3( 0.1379, 0.2486, 0.4430),
	float3( 0.3371, 0.5679,-0.0057),float3(-0.6999,-0.0451,-0.0019),
	float3( 0.0689,-0.1598,-0.8547),float3( 0.0560, 0.0069,-0.1843),
	float3(-0.0146, 0.1402, 0.0762),float3( 0.0100,-0.1924,-0.0344),
	float3(-0.3577,-0.5301,-0.4358),float3(-0.3169, 0.1063, 0.0158),
	float3( 0.0103,-0.5869, 0.0046),float3(-0.0897,-0.4940, 0.3287),
	float3( 0.7119,-0.0154,-0.0918),float3(-0.0533, 0.0596,-0.5411),
	float3( 0.0352,-0.0631, 0.5460),float3(-0.4776, 0.2847,-0.0271)
};
/* standard stuff */
float4 ScreenSize;
float ENightDayFactor;
float EInteriorFactor;
float FadeFactor;
float4 Timer;
/* samplers and textures */
texture2D texColor;
texture2D texDepth;
texture2D texNoise3
<
	string ResourceName = "menbnoise2.png";
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
	AddressU = Mirror;
	AddressV = Mirror;
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
	MipFilter = LINEAR;
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
