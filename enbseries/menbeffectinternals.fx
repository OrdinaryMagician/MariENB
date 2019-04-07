/*
	menbeffectinternals.fx : MariENB 3 base internal variables.
	(C)2015 Marisa Kirisame, UnSX Team.
	Part of MariENB 3, the personal ENB of Marisa for Fallout 4.
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
/* standard stuff */
float4 Timer;
float4 ScreenSize;
float AdaptiveQuality;
float4 Weather;
float4 TimeOfDay1;
float4 TimeOfDay2;
float4 tempF1;
float4 tempF2;
float4 tempF3;
float4 tempInfo1;
float4 Params01[6];
/*
   attempting to figure what each param does:
    0 unused
     x unused
     y unused
     z unused
     w unused
    1 bloom/adaptation related
     x ?
     y ?
     z ?
     w ?
    2 imagespace grading
     x vibrance?
     y unused
     z multiplier 1?
     w multiplier 2?
    3 imagespace tint
     x tint r
     y tint g
     z tint b
     w tint value
    4 coord multipliers for low quality texture sampling, I guess
     x unused
     y unused
     z bloom coord multiplier x
     w bloom coord multiplier y
    5 imagespace fade
     x fade r
     y fade g
     z fade b
     w fade value
*/
/* samplers and textures */
Texture2D TextureColor;
Texture2D TextureBloom;
Texture2D TextureAdaptation;
Texture2D TextureDepth;
Texture2D TextureNoise2
<
	string ResourceName = "menbnoise1.png";
>;
Texture2D TextureNoise3
<
	string ResourceName = "menbnoise2.png";
>;
Texture2D TextureLUT
<
#ifdef LUTMODE_LEGACY
	string ResourceName = "menblutpreset.png";
#endif
#ifdef LUTMODE_16
	string ResourceName = "menblut16.png";
#endif
#ifdef LUTMODE_64
	string ResourceName = "menblut64.png";
#endif
>;
SamplerState Nearest
{
	Filter = MIN_MAG_MIP_POINT;
	AddressU = Clamp;
	AddressV = Clamp;
	MaxLod = 0;
	MipLodBias = 0;
};
SamplerState Linear
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
	MaxLod = 0;
	MipLodBias = 0;
};
SamplerState Noise2
{
	Filter = MIN_LINEAR_MAG_MIP_POINT;
	AddressU = Wrap;
	AddressV = Wrap;
	MaxLod = 0;
	MipLodBias = 0;
};
SamplerState Noise3
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Wrap;
	AddressV = Wrap;
	MaxLod = 0;
	MipLodBias = 0;
};
/* whatever */
struct VS_INPUT_POST
{
	float3 pos : POSITION;
	float2 txcoord0 : TEXCOORD0;
};
struct VS_OUTPUT_POST
{
	float4 pos : SV_POSITION;
	float2 txcoord0 : TEXCOORD0;
};
