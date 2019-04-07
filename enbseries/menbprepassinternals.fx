/*
	menbprepassinternals.fx : MariENB prepass internal variables.
	(C)2013-2016 Marisa Kirisame, UnSX Team.
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
static const float3 ssao_samples_lq[16] = 
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
static const float3 ssao_samples_hq[64] =
{
	float3( 0.0000,-0.0000,-0.0000),float3( 0.0000, 0.0000,-0.0000),
	float3( 0.0001,-0.0000,-0.0000),float3( 0.0002, 0.0001,-0.0001),
	float3(-0.0000,-0.0005, 0.0000),float3( 0.0004,-0.0004,-0.0006),
	float3( 0.0005,-0.0011,-0.0004),float3(-0.0000, 0.0013,-0.0014),
	float3( 0.0024, 0.0006, 0.0013),float3(-0.0017,-0.0017, 0.0030),
	float3(-0.0037, 0.0033,-0.0011),float3( 0.0010, 0.0018,-0.0063),
	float3( 0.0059, 0.0056,-0.0020),float3(-0.0009, 0.0083,-0.0063),
	float3(-0.0110, 0.0065,-0.0016),float3( 0.0089, 0.0070,-0.0108),
	float3(-0.0115,-0.0134,-0.0062),float3(-0.0121,-0.0172, 0.0071),
	float3(-0.0066, 0.0246,-0.0060),float3( 0.0057,-0.0279, 0.0109),
	float3(-0.0269,-0.0160,-0.0164),float3( 0.0402, 0.0045, 0.0034),
	float3( 0.0248,-0.0045, 0.0390),float3( 0.0110,-0.0491,-0.0159),
	float3(-0.0193,-0.0431, 0.0363),float3( 0.0441, 0.0271,-0.0426),
	float3( 0.0385,-0.0428,-0.0482),float3(-0.0623,-0.0501, 0.0249),
	float3( 0.0683,-0.0000, 0.0631),float3( 0.1008, 0.0180,-0.0114),
	float3(-0.0156,-0.0713, 0.0871),float3(-0.0561,-0.0757, 0.0822),
	float3( 0.0714, 0.0850,-0.0805),float3(-0.1320,-0.0042, 0.0711),
	float3( 0.1553, 0.0486,-0.0167),float3(-0.1164,-0.0125,-0.1341),
	float3( 0.1380,-0.1230,-0.0562),float3( 0.0868,-0.1897,-0.0175),
	float3( 0.0749, 0.1495, 0.1525),float3(-0.2038,-0.1324,-0.0235),
	float3( 0.0205, 0.1920, 0.1784),float3( 0.1637,-0.0964,-0.2092),
	float3( 0.2875, 0.0966,-0.0020),float3( 0.0572,-0.0180,-0.3194),
	float3(-0.3329, 0.0981,-0.0189),float3( 0.2627, 0.2092,-0.1585),
	float3( 0.1783,-0.3359,-0.1108),float3( 0.2675, 0.2056,-0.2533),
	float3(-0.1852, 0.3017,-0.2759),float3(-0.0944, 0.3532, 0.3061),
	float3(-0.0022,-0.3744, 0.3404),float3(-0.0600,-0.4031,-0.3487),
	float3(-0.2663, 0.4915, 0.1004),float3(-0.2442, 0.4253, 0.3468),
	float3( 0.2583, 0.1321,-0.5645),float3(-0.0219, 0.4516, 0.4943),
	float3(-0.5503, 0.2597,-0.3590),float3( 0.2239,-0.5571,-0.4398),
	float3(-0.7210,-0.1982, 0.2339),float3( 0.7948,-0.1848, 0.1145),
	float3(-0.7190, 0.1767, 0.4489),float3(-0.5617, 0.5845,-0.4116),
	float3(-0.8919,-0.0384, 0.3360),float3(-0.0144, 0.9775,-0.2105)
};
/* For high quality DOF */
static const float2 poisson32[32] =
{
	float2( 0.7284430,-0.1927130),float2( 0.4051600,-0.2312710),
	float2( 0.9535280, 0.0669683),float2( 0.6544140,-0.4439470),
	float2( 0.6029910, 0.1058970),float2( 0.2637500,-0.7163810),
	float2( 0.9105380,-0.3889810),float2( 0.5942730,-0.7400740),
	float2( 0.8215680, 0.3162520),float2( 0.3577550, 0.4884250),
	float2( 0.6935990, 0.7070140),float2( 0.0470570, 0.1961800),
	float2(-0.0977021, 0.6241300),float2( 0.2110300, 0.8778350),
	float2(-0.3743440, 0.2494580),float2( 0.0144776,-0.0766484),
	float2(-0.3377660,-0.1255100),float2( 0.3136420, 0.1077710),
	float2(-0.5204340, 0.8369860),float2(-0.1182680, 0.9801750),
	float2(-0.6969480,-0.3869330),float2(-0.6156080, 0.0307209),
	float2(-0.3806790,-0.6055360),float2(-0.1909570,-0.3861330),
	float2(-0.2449080,-0.8655030),float2( 0.0822108,-0.4975580),
	float2(-0.5649250, 0.5756740),float2(-0.8741830,-0.1685750),
	float2( 0.0761715,-0.9631760),float2(-0.9218270, 0.2121210),
	float2(-0.6378530, 0.3053550),float2(-0.8425180, 0.4753000)
};
/* standard stuff */
float4 ScreenSize;
float ENightDayFactor;
float EInteriorFactor;
float FadeFactor;
float4 Timer;
float FieldOfView;
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
texture2D texFrost
<
#ifdef FROST_DDS
	string ResourceName = "menbfrost.dds";
#else
	string ResourceName = "menbfrost.png";
#endif
>;
texture2D texFrostBump
<
#ifdef FROSTBUMP_DDS
	string ResourceName = "menbfrostbump.dds";
#else
	string ResourceName = "menbfrostbump.png";
#endif
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
sampler2D SamplerFrost = sampler_state
{
	Texture = <texFrost>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Wrap;
	AddressV = Wrap;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerFrostBump = sampler_state
{
	Texture = <texFrostBump>;
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
