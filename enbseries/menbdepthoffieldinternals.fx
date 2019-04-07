/*
	menbdepthoffieldinternals.fx : MariENB dof internal variables.
	(C)2013-2017 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* mathematical constants */
static const float pi = 3.1415926535898;
/* For basic DOF */
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
/* samplers and textures */
texture2D texColor;
texture2D texDepth;
texture2D texNoise3
<
	string ResourceName = "menbnoise3.png";
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
