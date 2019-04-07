/*
	menbbloominternals.fx : MariENB bloom internal variables.
	(C)2013-2016 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* mathematical constants */
static const float pi = 3.1415926535898;
/* gaussian blur matrices */
/* radius: 4, std dev: 1.5 */
/*static const float gauss4[4] =
{
	0.270682, 0.216745, 0.111281, 0.036633
};*/
/* radius: 8, std dev: 3 */
static const float gauss8[8] =
{
	0.134598, 0.127325, 0.107778, 0.081638,
	0.055335, 0.033562, 0.018216, 0.008847
};
/* radius: 40, std dev: 15 */
/*static const float gauss40[40] =
{
	0.026823, 0.026763, 0.026585, 0.026291,
	0.025886, 0.025373, 0.024760, 0.024055,
	0.023267, 0.022404, 0.021478, 0.020499,
	0.019477, 0.018425, 0.017352, 0.016269,
	0.015186, 0.014112, 0.013056, 0.012025,
	0.011027, 0.010067, 0.009149, 0.008279,
	0.007458, 0.006688, 0.005972, 0.005308,
	0.004697, 0.004139, 0.003630, 0.003170,
	0.002756, 0.002385, 0.002055, 0.001763,
	0.001506, 0.001280, 0.001084, 0.000913
};*/
/* radius: 80, std dev: 30 */
static const float gauss80[80] =
{
	0.013406, 0.013398, 0.013376, 0.013339, 0.013287, 0.013221,
	0.013140, 0.013046, 0.012938, 0.012816, 0.012681, 0.012534,
	0.012375, 0.012205, 0.012023, 0.011831, 0.011629, 0.011417,
	0.011198, 0.010970, 0.010735, 0.010493, 0.010245, 0.009992,
	0.009735, 0.009473, 0.009209, 0.008941, 0.008672, 0.008402,
	0.008131, 0.007860, 0.007590, 0.007321, 0.007053, 0.006788,
	0.006525, 0.006266, 0.006010, 0.005759, 0.005511, 0.005269,
	0.005031, 0.004799, 0.004573, 0.004352, 0.004138, 0.003929,
	0.003727, 0.003532, 0.003343, 0.003160, 0.002985, 0.002816,
	0.002653, 0.002497, 0.002348, 0.002205, 0.002068, 0.001938,
	0.001814, 0.001696, 0.001584, 0.001478, 0.001377, 0.001282,
	0.001192, 0.001107, 0.001027, 0.000952, 0.000881, 0.000815,
	0.000753, 0.000694, 0.000640, 0.000589, 0.000542, 0.000497,
	0.000456, 0.000418
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
texture2D texLens
<
#ifdef LENSDIRT_DDS
	string ResourceName = "menblens.dds";
#else
	string ResourceName = "menblens.png";
#endif
>;
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
sampler2D SamplerBloomC1 = sampler_state
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
sampler2D SamplerBloomC2 = sampler_state
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
sampler2D SamplerBloomC3 = sampler_state
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
sampler2D SamplerBloomC4 = sampler_state
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
sampler2D SamplerBloomC5 = sampler_state
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
sampler2D SamplerBloomC6 = sampler_state
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
sampler2D SamplerBloomC7 = sampler_state
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
sampler2D SamplerBloomC8 = sampler_state
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
sampler2D SamplerLens = sampler_state
{
	Texture = <texLens>;
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
