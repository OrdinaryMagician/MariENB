/*
	menbbloominternals.fx : MariENB bloom internal variables.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the MIT License.
*/
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
/* standard stuff (not all used) */
float4 tempF1;
float4 tempF2;
float4 tempF3;
float4 ScreenSize;
float4 Timer;
float4 TempParameters;
float4 LenzParameters;
float4 BloomParameters;
float ENightDayFactor;
float EInteriorFactor;
/* samplers and textures (some left unused) */
texture2D texBloom1;
texture2D texBloom2;
texture2D texBloom3;
texture2D texBloom4;
texture2D texBloom5;
texture2D texBloom6;
texture2D texBloom7;
texture2D texBloom8;
sampler2D SamplerBloom1 = sampler_state
{
	Texture = <texBloom1>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerBloom2 = sampler_state
{
	Texture = <texBloom2>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerBloom3 = sampler_state
{
	Texture = <texBloom3>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerBloom4 = sampler_state
{
	Texture = <texBloom4>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerBloom5 = sampler_state
{
	Texture = <texBloom5>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerBloom6 = sampler_state
{
	Texture = <texBloom6>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerBloom7 = sampler_state
{
	Texture = <texBloom7>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerBloom8 = sampler_state
{
	Texture = <texBloom8>;
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
	float2 txcoord0 : TEXCOORD0;
};
struct VS_INPUT_POST
{
	float3 pos : POSITION;
	float2 txcoord0 : TEXCOORD0;
};
