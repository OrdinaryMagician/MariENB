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
/* radius: 8, std dev: 3 */
static const float gauss8[8] =
{
	0.134598, 0.127325, 0.107778, 0.081638,
	0.055335, 0.033562, 0.018216, 0.008847
};
/* SSAO samples */
static const float3 ssao_samples[64] = 
{
	float3(-0.0051, 0.0021, 0.0146),float3(-0.0197,-0.0213,-0.0116),
	float3( 0.0005,-0.0432,-0.0182),float3(-0.0011,-0.0586,-0.0217),
	float3(-0.0549, 0.0461, 0.0309),float3(-0.0448,-0.0764,-0.0306),
	float3(-0.0366, 0.0758,-0.0699),float3(-0.0770,-0.0707,-0.0686),
	float3( 0.1181,-0.0340,-0.0683),float3(-0.0647, 0.0356, 0.1377),
	float3(-0.1167, 0.1262, 0.0024),float3(-0.1353,-0.0861, 0.0971),
	float3(-0.0096, 0.0936, 0.1800),float3( 0.1311,-0.1013,-0.1429),
	float3(-0.1186,-0.0653, 0.1913),float3( 0.1641, 0.0260, 0.1868),
	float3(-0.1225,-0.2319, 0.0424),float3( 0.1036,-0.2000, 0.1684),
	float3( 0.1656, 0.2022,-0.1408),float3(-0.1809,-0.1673, 0.1922),
	float3(-0.2485,-0.1236, 0.1750),float3( 0.1030,-0.0550, 0.3233),
	float3(-0.0405, 0.3068, 0.1827),float3(-0.0576, 0.1632, 0.3327),
	float3( 0.0392, 0.3583,-0.1505),float3( 0.0082, 0.2865, 0.2879),
	float3( 0.0055,-0.2835, 0.3124),float3(-0.2733, 0.1991,-0.2776),
	float3( 0.2667, 0.1127,-0.3486),float3(-0.3326, 0.2740,-0.1844),
	float3( 0.2887,-0.3838, 0.0630),float3( 0.1088, 0.1546, 0.4629),
	float3( 0.0977,-0.3565, 0.3595),float3(-0.4204, 0.0855, 0.3133),
	float3(-0.2237,-0.4932, 0.0759),float3( 0.4245, 0.3169,-0.1891),
	float3( 0.0084,-0.5682, 0.1062),float3(-0.1489,-0.5296,-0.2235),
	float3( 0.0014,-0.4153,-0.4460),float3( 0.0300,-0.4392, 0.4437),
	float3( 0.2627, 0.4518, 0.3704),float3(-0.4945, 0.3659, 0.2285),
	float3(-0.2550,-0.5311, 0.3230),float3(-0.4477, 0.0828,-0.5151),
	float3( 0.4682, 0.4531,-0.2644),float3(-0.1235,-0.0366, 0.7071),
	float3( 0.3545, 0.4559, 0.4536),float3(-0.1037,-0.2199,-0.7095),
	float3( 0.4269, 0.5299,-0.3510),float3( 0.7051,-0.1468,-0.3027),
	float3( 0.4590,-0.5669,-0.3208),float3( 0.2330, 0.1264, 0.7680),
	float3(-0.3954, 0.5619,-0.4622),float3( 0.5977,-0.5110, 0.3059),
	float3(-0.5800,-0.6306, 0.0672),float3(-0.2211,-0.0332,-0.8460),
	float3(-0.3808,-0.2238,-0.7734),float3(-0.5616, 0.6858,-0.1887),
	float3(-0.2995, 0.5165,-0.7024),float3( 0.5042,-0.0537, 0.7885),
	float3(-0.6477,-0.3691, 0.5938),float3(-0.3969, 0.8815, 0.0620),
	float3(-0.4300,-0.8814,-0.0852),float3(-0.1683, 0.9379, 0.3033)
};
/* standard stuff */
float4 ScreenSize;
float ENightDayFactor;
float EInteriorFactor;
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
	string ResourceName = "menbnoise3.png";
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
