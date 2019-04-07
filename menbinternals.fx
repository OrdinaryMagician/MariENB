/*
	menbinternals.fx : MariENB internal variables.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the MIT License.
*/
/* texture sizes */
#define NOISERES 256.0
/* sharpen matrix quadrant */
static const float3x3 shmat =
{
	5.76,-0.5,-0.2,
	-0.5,-0.25,-0.1,
	-0.2,-0.1,-0.04,
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
/* dithering threshold maps */
static const float checkers[4] =
{
	1,0,
	0,1
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
/* palettes */
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
/* standard stuff (not all used) */
float tempF1;
float tempF2;
float tempF3;
float tempF4;
float tempF5;
float tempF6;
float tempF7;
float tempF8;
float tempF9;
float tempF0;
float4 ScreenSize;
float ENightDayFactor;
float EInteriorFactor;
float4 Timer;
float FieldOfView;
/* samplers and textures (some not yet used) */
texture2D texColor;
texture2D texDepth;
texture2D texPalette;
sampler2D SamplerColor = sampler_state
{
	Texture	= <texColor>;
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
sampler2D SamplerPalette = sampler_state
{
	Texture = <texPalette>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
texture2D texNoise1
<
	string ResourceName = "menbnoise1.png";
>;
texture2D texNoise2
<
	string ResourceName = "menbnoise2.png";
>;
texture2D texNoise3
<
	string ResourceName = "menbnoise3.png";
>;
sampler2D SamplerNoise1 = sampler_state
{
	Texture = <texNoise1>;
	MinFilter = LINEAR;
	MagFilter = POINT;
	MipFilter = NONE;
	AddressU = Wrap;
	AddressV = Wrap;
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
