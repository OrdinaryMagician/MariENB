/*
	menbextrainternals.fx : MariENB extra internal variables.
	(C)2013-2016 Marisa Kirisame, UnSX Team.
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
#define d(x) x/9.0
static const float ordered3[9] =
{
	d(2),d(6),d(3),
	d(5),d(0),d(8),
	d(1),d(7),d(4)
};
#undef d
#define d(x) x/16.0
static const float ordered4[16] =
{
	d( 0),d( 8),d( 2),d(10),
	d(12),d( 4),d(14),d( 6),
	d( 3),d(11),d( 1),d( 9),
	d(15),d( 7),d(13),d( 5)
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
/*
   palettes
   don't touch unless you know what you're doing
*/
#define d(x) x/3.0
static const float3 cga1l[4] =
{
	float3(d(0),d(0),d(0)),
	float3(d(0),d(2),d(2)),
	float3(d(2),d(0),d(2)),
	float3(d(2),d(2),d(2))
};
static const float3 cga1h[4] =
{
	float3(d(0),d(0),d(0)),
	float3(d(1),d(3),d(3)),
	float3(d(3),d(1),d(3)),
	float3(d(3),d(3),d(3))
};
static const float3 cga2l[4] =
{
	float3(d(0),d(0),d(0)),
	float3(d(0),d(2),d(0)),
	float3(d(2),d(0),d(0)),
	float3(d(2),d(1),d(0))
};
static const float3 cga2h[4] =
{
	float3(d(0),d(0),d(0)),
	float3(d(1),d(3),d(1)),
	float3(d(3),d(1),d(1)),
	float3(d(3),d(2),d(1))
};
static const float3 cga3l[4] =
{
	float3(d(0),d(0),d(0)),
	float3(d(0),d(2),d(2)),
	float3(d(2),d(0),d(0)),
	float3(d(2),d(2),d(2))
};
static const float3 cga3h[4] =
{
	float3(d(0),d(0),d(0)),
	float3(d(1),d(3),d(3)),
	float3(d(3),d(1),d(1)),
	float3(d(3),d(3),d(3))
};
static const float3 stdega[16] =
{
	float3(d(0),d(0),d(0)),
	float3(d(2),d(0),d(0)),
	float3(d(0),d(2),d(0)),
	float3(d(2),d(1),d(0)),
	float3(d(0),d(0),d(2)),
	float3(d(2),d(0),d(2)),
	float3(d(0),d(2),d(2)),
	float3(d(2),d(2),d(2)),
	float3(d(1),d(1),d(1)),
	float3(d(3),d(1),d(1)),
	float3(d(1),d(3),d(1)),
	float3(d(3),d(3),d(1)),
	float3(d(1),d(1),d(3)),
	float3(d(3),d(1),d(3)),
	float3(d(1),d(3),d(3)),
	float3(d(3),d(3),d(3))
};
#undef d
#define d(x) x/256.0
static const float3 aosega[16] =
{
	float3(d(  0),d(  0),d(  0)),
	float3(d(128),d(  0),d(  0)),
	float3(d( 32),d(128),d(  0)),
	float3(d(160),d( 64),d( 32)),
	float3(d(  0),d( 32),d( 88)),
	float3(d( 60),d(  0),d( 88)),
	float3(d( 16),d(160),d(208)),
	float3(d( 88),d( 88),d( 88)),
	float3(d( 32),d( 32),d( 32)),
	float3(d(256),d( 64),d( 64)),
	float3(d( 72),d(256),d( 64)),
	float3(d(256),d(224),d( 60)),
	float3(d( 48),d(128),d(256)),
	float3(d(192),d( 48),d(256)),
	float3(d( 72),d(224),d(256)),
	float3(d(256),d(256),d(256)),
};
#undef d
/* gauss stuff */
float gauss3[3] =
{
	0.444814, 0.239936, 0.037657
};
/* standard stuff */
float4 ScreenSize;
float ENightDayFactor;
float EInteriorFactor;
/* samplers and textures */
texture2D texColor;
texture2D texDepth;
texture2D texFont
<
	string ResourceName = "menbvgaluma.png";
>;
texture2D texDots
<
	string ResourceName = "menbdots.png";
>;
texture2D texDoom
<
	string ResourceName = "menbdoomlut.png";
>;
texture2D texQuake
<
	string ResourceName = "menbquakelut.png";
>;
texture2D texVGA
<
	string ResourceName = "menbvgalut.png";
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
sampler2D SamplerColorb = sampler_state
{
	Texture = <texColor>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Border;
	AddressV = Border;
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
sampler2D SamplerFont = sampler_state
{
	Texture = <texFont>;
	MinFilter = LINEAR;
	MagFilter = POINT;
	MipFilter = NONE;
	AddressU = Wrap;
	AddressV = Wrap;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerDots = sampler_state
{
	Texture = <texDots>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Wrap;
	AddressV = Wrap;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerDoom = sampler_state
{
	Texture = <texDoom>;
	MinFilter = POINT;
	MagFilter = POINT;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerQuake = sampler_state
{
	Texture = <texQuake>;
	MinFilter = POINT;
	MagFilter = POINT;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
sampler2D SamplerVGA = sampler_state
{
	Texture = <texVGA>;
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
	float2 txcoord : TEXCOORD0;
};
struct VS_INPUT_POST
{
	float3 pos : POSITION;
	float2 txcoord : TEXCOORD0;
};
