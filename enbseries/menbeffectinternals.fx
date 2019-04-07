/*
	menbeffectinternals.fx : MariENB base internal variables.
	(C)2013-2017 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/*
   dithering threshold maps
   don't touch unless you know what you're doing
*/
static const float checkers[4] =
{
	1.0,0.0,
	0.0,1.0
};
#define d(x) x/4.0
static const float ordered2[4] =
{
	d(0),d(2),
	d(4),d(2)
};
#undef d
#define d(x) x/64.0
static const float ordered8[64] =
{
	d( 0),d(48),d(12),d(60),d( 3),d(51),d(15),d(63),
	d(32),d(16),d(44),d(28),d(35),d(19),d(47),d(31),
	d( 8),d(56),d( 4),d(52),d(11),d(59),d( 7),d(55),
	d(40),d(24),d(36),d(20),d(43),d(27),d(39),d(23),
	d( 2),d(50),d(14),d(62),d( 1),d(49),d(13),d(61),
	d(34),d(18),d(46),d(30),d(33),d(17),d(45),d(29),
	d(10),d(58),d( 6),d(54),d( 9),d(57),d( 5),d(53),
	d(42),d(26),d(38),d(22),d(41),d(25),d(37),d(21)
};
#undef d

/* standard stuff */
float4 ScreenSize;
float4 Timer;
float ENightDayFactor;
float EInteriorFactor;
float EBloomAmount;
float4 WeatherAndTime;
/* samplers and textures */
texture2D texs0;
texture2D texs1;
texture2D texs2;
texture2D texs3;
texture2D texs4;
texture2D texs7;
texture2D texNoise2
<
	string ResourceName = "menbnoise1.png";
>;
texture2D texNoise3
<
	string ResourceName = "menbnoise2.png";
>;
#ifdef LUTMODE_LEGACY
texture2D texLUT
<
	string ResourceName = "menblutpreset.png";
>;
#else
texture2D texLUTN
<
#ifdef LUTMODE_16
	string ResourceName = "menblut16_night.png";
#endif
#ifdef LUTMODE_64
	string ResourceName = "menblut64_night.png";
#endif
>;
texture2D texLUTD
<
#ifdef LUTMODE_16
	string ResourceName = "menblut16_day.png";
#endif
#ifdef LUTMODE_64
	string ResourceName = "menblut64_day.png";
#endif
>;
texture2D texLUTIN
<
#ifdef LUTMODE_16
	string ResourceName = "menblut16_interiornight.png";
#endif
#ifdef LUTMODE_64
	string ResourceName = "menblut64_interiornight.png";
#endif
>;
texture2D texLUTID
<
#ifdef LUTMODE_16
	string ResourceName = "menblut16_interiorday.png";
#endif
#ifdef LUTMODE_64
	string ResourceName = "menblut64_interiorday.png";
#endif
>;
#endif
texture2D texTonemap
<
	string ResourceName = "menbfilmlut.png";
>;
sampler2D _s0 = sampler_state
{
	Texture = <texs0>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
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
	MinFilter = LINEAR;
	MagFilter = LINEAR;
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
	MinFilter = LINEAR;
	MagFilter = LINEAR;
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
	MinFilter = LINEAR;
	MagFilter = LINEAR;
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
	MinFilter = LINEAR;
	MagFilter = LINEAR;
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
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerNoise2 = sampler_state
{
	Texture = <texNoise2>;
	MinFilter = LINEAR;
	MagFilter = POINT;
	MipFilter = NONE;
	AddressU = Wrap;
	AddressV = Wrap;
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
#ifdef LUTMODE_LEGACY
sampler2D SamplerLUT = sampler_state
{
	Texture = <texLUT>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
#else
sampler2D SamplerLUTN = sampler_state
{
	Texture = <texLUTN>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerLUTD = sampler_state
{
	Texture = <texLUTD>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerLUTIN = sampler_state
{
	Texture = <texLUTIN>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerLUTID = sampler_state
{
	Texture = <texLUTID>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
#endif
sampler2D SamplerTonemap = sampler_state
{
	Texture = <texTonemap>;
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
