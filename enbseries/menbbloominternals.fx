/*
	menbbloominternals.fx : MariENB bloom internal variables.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* gaussian blur matrices */
/* radius: 3, std dev: 0.7014 */
static const float gauss3[3] = {0.568780, 0.205851, 0.009759};
/* radius: 36, std dev: 32 */
static const float gauss36[36] =
{
	0.017014, 0.017006, 0.016981, 0.016939, 0.016881, 0.016807,
	0.016717, 0.016612, 0.016490, 0.016354, 0.016203, 0.016038,
	0.015859, 0.015666, 0.015461, 0.015244, 0.015015, 0.014775,
	0.014524, 0.014264, 0.013995, 0.013718, 0.013433, 0.013141,
	0.012843, 0.012539, 0.012231, 0.011918, 0.011602, 0.011284,
	0.010964, 0.010642, 0.010319, 0.009997, 0.009675, 0.009355
};
/* standard stuff */
float4 ScreenSize;
float4 TempParameters;
float4 BloomParameters;
float ENightDayFactor;
float EInteriorFactor;
/* samplers and textures */
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
	AddressU = Border;
	AddressV = Border;
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
	AddressU = Border;
	AddressV = Border;
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
	AddressU = Border;
	AddressV = Border;
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
	AddressU = Border;
	AddressV = Border;
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
	AddressU = Border;
	AddressV = Border;
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
	AddressU = Border;
	AddressV = Border;
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
	AddressU = Border;
	AddressV = Border;
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
	AddressU = Border;
	AddressV = Border;
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
