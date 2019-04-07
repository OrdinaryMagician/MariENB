/*
	menbeffectinternals.fx : MariENB base internal variables.
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
float4 Timer;
float4 ScreenSize;
float ENightDayFactor;
float EInteriorFactor;
float EBloomAmount;
/* samplers and textures (some unused) */
texture2D texs0;
texture2D texs1;
texture2D texs2;
texture2D texs3;
texture2D texs4;
texture2D texs7;
sampler2D _s0 = sampler_state
{
	Texture = <texs0>;
	MinFilter = POINT;
	MagFilter = POINT;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D _s1 = sampler_state
{
	Texture = <texs1>;
	MinFilter = POINT;
	MagFilter = POINT;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D _s2 = sampler_state
{
	Texture = <texs2>;
	MinFilter = POINT;
	MagFilter = POINT;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D _s3 = sampler_state
{
	Texture = <texs3>;
	MinFilter = POINT;
	MagFilter = POINT;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D _s4 = sampler_state
{
	Texture = <texs4>;
	MinFilter = POINT;
	MagFilter = POINT;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D _s7 = sampler_state
{
	Texture = <texs7>;
	MinFilter = POINT;
	MagFilter = POINT;
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
