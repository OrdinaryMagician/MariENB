/*
	enbeffectpostpass.fx : MariENB3 extra shader.
	(C)2016-2017 Marisa Kirisame, UnSX Team.
	Part of MariENB3, the personal ENB of Marisa for Fallout 4.
	Released under the GNU GPLv3 (or later).
*/
#include "menbglobaldefs.fx"

/* BlockGFX filter, I'm proud of it */
string str_block = "BlockGFX Suite";
bool useblock
<
	string UIName = "Enable Block GFX";
	string UIWidget = "Checkbox";
> = {false};
/*
   emulated resolution:
       0 or 1 : real resolution
    <1 and >0 : multiple of real resolution (e.g.: 0.5 is half resolution)
           >1 : this resolution (e.g.: 320x200 is good ol' Mode 13h)
*/
float2 bres
<
	string UIName = "Emulated Resolution";
	string UIWidget = "Vector";
	float2 UIMin = {0.0,0.0};
> = {0.5,0.5};
/* zooming factors (<=0 for stretch) */
float2 sres
<
	string UIName = "Zoom Factor";
	string UIWidget = "Vector";
	float2 UIMin = {0.0,0.0};
> = {0.0,0.0};
/*
   palette type:
    -1 : disable
     0 : CGA (320x200 4-color, or 640x200 monochrome)
     1 : EGA (320x200, 16 colors)
     2 : RGB2 (64-color quarter VGA palette, used in AOS)
     3 : VGA (256 colors)
     4 : RGB565 (ol' 16-bit "true color")
*/
int paltype
<
	string UIName = "Palette Type";
	string UIWidget = "Spinner";
	int UIMin = -1;
	int UIMax = 4;
> = {1};
/*
   CGA palette to use:
    0 : black, white.
    1 : black, cyan, magenta, white. low contrast
    2 : black, cyan, magenta, white. high contrast
    3 : black, green, red, brown. low contrast
    4 : black, green, red, brown. high contrast
    5 : black, cyan, red, white. low contrast
    6 : black, cyan, red, white. high contrast
*/
int cgapal
<
	string UIName = "CGA Palette";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 6;
> = {1};
/*
    EGA palette to use:
     0 : Standard EGA
     1 : AOS EGA (it's designed for text, but looks well on images too)
*/
int egapal
<
	string UIName = "EGA Palette";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 1;
> = {0};
/*
    VGA palette to use:
     0 : Standard VGA
     1 : Amulets & Armor
     2 : Blood
     3 : Doom
     4 : Duke Nukem 3D
     5 : Hacx 2.0
     6 : Heretic
     7 : Hexen
     8 : Hexen 2
     9 : Quake
     10 : Quake 2
     11 : Rise of the Triad
     12 : Shadow Warrior
     13 : Strife
     14 : Wolfenstein 3D
     TODO Project .Blank palette (when the design is finished)
*/
int vgapal
<
	string UIName = "VGA Palette";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 14;
> = {0};
/*
   Dithering mode:
    -1 : No dithering, just raw banding
     0 : 2x2 checkerboard dithering, looks like ass
     1 : 2x2 ordered dithering
     2 : 3x3 ordered dithering
     3 : 4x4 ordered dithering
     4 : 8x8 ordered dithering
*/
int dither
<
	string UIName = "Dithering Pattern";
	string UIWidget = "Spinner";
	int UIMin = -1;
	int UIMax = 4;
> = {4};
/* gamma modifier for base color, lower values raise midtones and viceversa */
float bgamma
<
	string UIName = "Contrast Modifier";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.35};
/* saturation modifier for base color, helps with limited palettes */
float bsaturation
<
	string UIName = "Saturation Modifier";
	string UIWidget = "Spinner";
> = {1.1};
/* base brightness bump for the dither grid */
float bdbump
<
	string UIName = "Dither Offset";
	string UIWidget = "Spinner";
> = {-0.1};
/* range multiplier for the dither grid */
float bdmult
<
	string UIName = "Dither Range";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
/* ASCII art filter */
string str_ascii = "Luma ASCII Art Filter";
bool asciienable
<
	string UIName = "Enable ASCII";
	string UIWidget = "Checkbox";
> = {false};
bool asciimono
<
	string UIName = "ASCII Monochrome";
	string UIWidget = "Checkbox";
> = {true};
float asciiblend
<
	string UIName = "ASCII Blend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
string str_mask = "Depth Chroma Key";
bool maskenable
<
	string UIName = "Enable Chroma Key";
	string UIWidget = "Checkbox";
> = {false};
float3 mask
<
	string UIName = "Chroma Key Red";
	string UIWidget = "Color";
> = {0.0,1.0,0.0};
float maskd
<
	string UIName = "Chroma Key Depth";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};
string str_dot = "RGBI Dot Matrix";
bool dotenable
<
	string UIName = "Enable Dot Matrix";
	string UIWidget = "Checkbox";
> = {false};
int dotsize
<
	string UIName = "Dot Size";
	string UIWidget = "Spinner";
	int UIMin = 1;
> = {1};
float dotblend
<
	string UIName = "Dot Blend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.4};
float dotmult
<
	string UIName = "Dot Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dotpow
<
	string UIName = "Dot Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
string str_curve = "Lens Curvature";
bool curveenable
<
	string UIName = "Enable Curvature";
	string UIWidget = "Checkbox";
> = {false};
float chromaab
<
	string UIName = "Curve Chromatic Aberration";
	string UIWidget = "Spinner";
> = {0.0};
float lenszoom
<
	string UIName = "Curve Zooming";
	string UIWidget = "Spinner";
> = {50.0};
float lensdist
<
	string UIName = "Curve Distortion";
	string UIWidget = "Spinner";
> = {0.0};
float curvesoft
<
	string UIName = "Curve Sampling Soften";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
/* BlurSharpShift, some people are obsessed with this nonsense */
string str_bss = "BlurSharpShift";
bool bssblurenable
<
	string UIName = "Enable Blur";
	string UIWidget = "Checkbox";
> = {false};
float bssblurradius
<
	string UIName = "Blur Sampling Range";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
bool bsssharpenable
<
	string UIName = "Enable Sharp";
	string UIWidget = "Checkbox";
> = {false};
float bsssharpradius
<
	string UIName = "Sharp Sampling Range";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bsssharpamount
<
	string UIName = "Sharpening Amount";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {6.0};
bool bssshiftenable
<
	string UIName = "Enable Shift";
	string UIWidget = "Checkbox";
> = {false};
float bssshiftradius
<
	string UIName = "Shift Sampling Range";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.75};
/* luma sharpen because of reasons */
string str_lsharp = "Luma Sharpen";
bool lsharpenable
<
	string UIName = "Luma Sharpen Enable";
	string UIWidget = "Checkbox";
> = {false};
float lsharpradius
<
	string UIName = "Luma Sharpen Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.8};
float lsharpclamp
<
	string UIName = "Luma Sharpen Clamp";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.02};
float lsharpblend
<
	string UIName = "Luma Sharpen Blending";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.2};

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
/* gauss stuff */
float gauss3[3] =
{
	0.444814, 0.239936, 0.037657
};

float4 ScreenSize;
Texture2D TextureOriginal;
Texture2D TextureColor;
Texture2D TextureDepth;
Texture2D TextureFont
<
	string ResourceName = "menbvgaluma.png";
>;
Texture2D TextureDots
<
	string ResourceName = "menbdots.png";
>;
Texture2D TextureCGA
<
	string ResourceName = "menbcgalut.png";
>;
Texture2D TextureEGA
<
	string ResourceName = "menbegalut.png";
>;
Texture2D TextureVGA
<
	string ResourceName = "menbvgalut.png";
>;

SamplerState Sampler
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
};
SamplerState SamplerB
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Border;
	AddressV = Border;
};
SamplerState SamplerFont
{
	Filter = MIN_LINEAR_MAG_MIP_POINT;
	AddressU = Wrap;
	AddressV = Wrap;
	MaxLOD = 0;
	MinLOD = 0;
};
SamplerState SamplerDots
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Wrap;
	AddressV = Wrap;
	MaxLOD = 0;
	MinLOD = 0;
};
SamplerState SamplerLUT
{
	Filter = MIN_MAG_MIP_POINT;
	AddressU = Clamp;
	AddressV = Clamp;
	MaxLOD = 0;
	MinLOD = 0;
};

struct VS_INPUT_POST
{
	float3 pos : POSITION;
	float2 txcoord : TEXCOORD0;
};
struct VS_OUTPUT_POST
{
	float4 pos : SV_POSITION;
	float2 txcoord : TEXCOORD0;
};

VS_OUTPUT_POST VS_PostProcess(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;
	OUT.pos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord.xy = IN.txcoord.xy;
	return OUT;
}

/* helpers */
/* photometric */
#define luminance(x) dot(x,float3(0.2126,0.7152,0.0722))
/* CCIR601 */
//#define luminance(x) dot(x,float3(0.299,0.587,0.114))
float3 rgb2hsv( float3 c )
{
	float4 K = float4(0.0,-1.0/3.0,2.0/3.0,-1.0);
	float4 p = (c.g<c.b)?float4(c.bg,K.wz):float4(c.gb,K.xy);
	float4 q = (c.r<p.x)?float4(p.xyw,c.r):float4(c.r,p.yzx);
	float d = q.x-min(q.w,q.y);
	float e = 1.0e-10;
	return float3(abs(q.z+(q.w-q.y)/(6.0*d+e)),d/(q.x+e),q.x);
}
float3 hsv2rgb( float3 c )
{
	float4 K = float4(1.0,2.0/3.0,1.0/3.0,3.0);
	float3 p = abs(frac(c.x+K.xyz)*6.0-K.w);
	return c.z*lerp(K.x,saturate(p-K.x),c.y);
}

/* prepass */
float4 ReducePrepass( in float4 col, in float2 coord )
{
	float3 hsv = rgb2hsv(col.rgb);
	hsv.y = clamp(hsv.y*bsaturation,0.0,1.0);
	hsv.z = pow(max(0,hsv.z),bgamma);
	col.rgb = hsv2rgb(saturate(hsv));
	if ( dither == 0 )
		col += bdbump+checkers[int(coord.x%2)+2*int(coord.y%2)]*bdmult;
	else if ( dither == 1 )
		col += bdbump+ordered2[int(coord.x%2)+2*int(coord.y%2)]*bdmult;
	else if ( dither == 2 )
		col += bdbump+ordered3[int(coord.x%3)+3*int(coord.y%3)]*bdmult;
	else if ( dither == 3 )
		col += bdbump+ordered4[int(coord.x%4)+4*int(coord.y%4)]*bdmult;
	else if ( dither == 4 )
		col += bdbump+ordered8[int(coord.x%8)+8*int(coord.y%8)]*bdmult;
	col = saturate(col);
	return col;
}
/*
   CGA had seven graphic modes (320x200 modes have low/high contrast versions):
    - 640x200 monochrome, which doesn't really need a palette here, as it can
	  be done procedurally with minimum effort.
	- 320x200 black/cyan/magenta/white
	- 320x200 black/green/red/brown
	- 320x200 black/cyan/red/white
*/
float4 ReduceCGA( in float4 color, in float2 coord )
{
	float4 dac = clamp(ReducePrepass(color,coord)+0.005,0.005,0.995);
	float2 lc = float2((dac.r+cgapal)/7.0,
		dac.g/64.0+floor(dac.b*64.0)/64.0);
	return TextureCGA.Sample(SamplerLUT,lc);
}
/*
   EGA technically only had the 320x200 16-colour graphic mode, but when VGA
   came out, it was possible to tweak the DAC, allowing for custom palettes.
   AOS EGA is a palette based on my terminal colour scheme on Linux, which I
   also use for AliceOS.
*/
float4 ReduceEGA( in float4 color, in float2 coord )
{
	float4 dac = clamp(ReducePrepass(color,coord)+0.005,0.005,0.995);
	float2 lc = float2((dac.r+egapal)/2.0,
		dac.g/64.0+floor(dac.b*64.0)/64.0);
	return TextureEGA.Sample(SamplerLUT,lc);
}
/* A two bits per channel mode that can usually fit VGA mode 13h and mode x */
float4 ReduceRGB2( in float4 color, in float2 coord )
{
	float4 dac = ReducePrepass(color,coord);
	color.rgb = trunc(dac.rgb*4.0)/4.0;
	return color;
}
/*
   The classic 16-bit colour mode everyone from my generation would remember,
   especially that subtle green tint and the banding due to lack of dithering
   in most games and GPUs at that time.
*/
float4 ReduceRGB565( in float4 color, in float2 coord )
{
	float4 dac = ReducePrepass(color,coord);
	color.rgb = trunc(dac.rgb*float3(32.0,64.0,32.0))
		/float3(32.0,64.0,32.0);
	return color;
}
/* Various VGA 256-colour palettes */
float4 ReduceVGA( in float4 color, in float2 coord )
{
	float4 dac = clamp(ReducePrepass(color,coord)+0.005,0.005,0.995);
	float2 lc = float2((dac.r+vgapal)/15.0,
		dac.g/64.0+floor(dac.b*64.0)/64.0);
	return TextureVGA.Sample(SamplerLUT,lc);
}

/* Retro rockets */
float4 PS_Retro( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !useblock ) return res;
	float2 rresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float4 tcol;
	float2 bresl = rresl;
	if ( bres.x <= 0 || bres.y <= 0 ) bresl = rresl;
	else
	{
		if ( bres.x <= 1.0 ) bresl.x = rresl.x*bres.x;
		else bresl.x = bres.x;
		if ( bres.y <= 1.0 ) bresl.y = rresl.y*bres.y;
		else bresl.y = bres.y;
	}
	float2 sresl = sres;
	if ( sres.x <= 0 ) sresl.x = rresl.x/bresl.x;
	if ( sres.y <= 0 ) sresl.y = rresl.y/bresl.y;
	float2 ncoord = coord*(rresl/bresl);
	ncoord = (-0.5/sresl)*(rresl/bresl)+ncoord/sresl+0.5;
	ncoord = floor(ncoord*bresl)/bresl;
	if ( bres.x <= 0 || bres.y <= 0 ) ncoord = coord;
	tcol = TextureOriginal.Sample(Sampler,ncoord);
	if ( paltype == 0 ) res = ReduceCGA(tcol,(coord*rresl)/sresl);
	else if ( paltype == 1 ) res = ReduceEGA(tcol,(coord*rresl)/sresl);
	else if ( paltype == 2 ) res = ReduceRGB2(tcol,(coord*rresl)/sresl);
	else if ( paltype == 3 ) res = ReduceVGA(tcol,(coord*rresl)/sresl);
	else if ( paltype == 4 ) res = ReduceRGB565(tcol,(coord*rresl)/sresl);
	else res = tcol;
	if ( ncoord.x < 0 || ncoord.x >= 1 || ncoord.y < 0 || ncoord.y >= 1 )
		res *= 0;
	res.a = 1.0;
	return res;
}

/* ASCII art (more like CP437 art) */
float4 PS_ASCII( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !asciienable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 fresl = float2(FONT_WIDTH,FONT_HEIGHT);
	float2 cresl = float2(GLYPH_WIDTH,GLYPH_HEIGHT);
	float2 bscl = floor(bresl/cresl);
	/*
	   Here I use the "cheap" method, based on the overall luminance of each
	   glyph, rather than attempt to search for the best fitting glyph for
	   each cell. If you want to know why, take a look at the ASCII filter
	   bundled with the Dolphin emulator, and be prepared for the resulting
	   seconds per frame it runs at. The calculations needed for such a filter
	   are completely insane even for the highest-end GPUs.
	*/
	float3 col = TextureOriginal.Sample(Sampler,floor(bscl*coord)/bscl).rgb;
	int lum = clamp(luminance(col)*FONT_LEVELS,0,FONT_LEVELS);
	float2 itx = floor(coord*bresl);
	float2 blk = floor(itx/cresl)*cresl;
	float2 ofs = itx-blk;
	ofs.y += lum*cresl.y;
	ofs /= fresl;
	float gch = TextureFont.Sample(SamplerFont,ofs).x;
	if ( gch < 0.5 ) res.rgb = res.rgb*asciiblend;
	else
	{
		if ( asciimono ) res.rgb = 1.0;
		else res.rgb = col;
	}
	return res;
}

float4 PS_ChromaKey( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !maskenable ) return res;
	if ( TextureDepth.Sample(Sampler,coord).x > maskd )
		return float4(mask.r,mask.g,mask.b,1.0);
	return res;
}

/* 2x2 RGBI dot matrix, not even close to anything that exists IRL but meh */
float4 PS_DotMatrix( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !dotenable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	bresl.xy *= 1.0/(dotsize*2.0);
	float4 dac = float4(res.r*0.5,res.g*0.5,res.b*0.5,
		(res.r+res.g+res.b)/6.0);
	/*
	   There are two types of CRTs: aperture grille and shadow mask.
	   The former is blurry and has scanlines (rather big ones, even), but
	   is cheap to emulate; while the latter is the one most known for its
	   crisp, square pixels with minimal distortion. Most individuals into
	   this whole "retro graphics" stuff prefer aperture grille, which
	   looks like shit, then again, that's the sort of visual quality they
	   want. The main issue with shadow mask CRTs is that it's impossible
	   to accurately emulate them unless done on a screen with a HUGE
	   resolution. After all, the subpixels need to be clearly visible, and
	   if on top of it you add curvature distortion, you need to reduce
	   moire patterns that will inevitably show up at low resolutions.
	   
	   It would be more desirable to eventually have flat panels that can
	   display arbitrary resolutions using a form of scaling that preserves
	   square pixels with unnoticeable distortion (typically, with nearest
	   neighbour you'd get some pixels that are bigger/smaller than others
	   if the upscale resolution isn't an integer multiple of the real
	   resolution.
	   
	   This 2x2 RGBI thing is a rather naïve filter I made many years ago,
	   it looks unlike any real CRT, but scales well. Its only problem is
	   moire patterns when using the default size of 2x2.
	*/
	float4 dots = TextureDots.Sample(SamplerDots,coord*bresl)*dac;
	float3 tcol = pow(max(0,dots.rgb+dots.a),dotpow)*dotmult;
	res.rgb = res.rgb*(1-dotblend)+tcol*dotblend;
	return res;
}
/* that's right, CRT curvature */
float4 PS_Curvature( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !curveenable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*curvesoft;
	float3 eta = float3(1+chromaab*0.009,1+chromaab*0.006,1+chromaab
		*0.003);
	float2 center = float2(coord.x-0.5,coord.y-0.5);
	float zfact = 100.0/lenszoom;
	float r2 = center.x*center.x+center.y*center.y;
	float f = 1+r2*lensdist*0.01;
	float x = f*zfact*center.x+0.5;
	float y = f*zfact*center.y+0.5;
	float2 rcoord = (f*eta.r)*zfact*(center.xy*0.5)+0.5;
	float2 gcoord = (f*eta.g)*zfact*(center.xy*0.5)+0.5;
	float2 bcoord = (f*eta.b)*zfact*(center.xy*0.5)+0.5;
	int i,j;
	float4 idist = float4(0,0,0,0);
	/*
	   sticking a 5x5 gaussian blur with a tweakable radius in here to
	   attempt to reduce moire patterns in some cases. Supersampling would
	   be more useful for that, but ENB sucks ass through a crazy straw in
	   that aspect, so it would be more desirable to use GeDoSaTo (I sure
	   hope I can port all my stuff to it one day, at least the damn thing
	   is FOSS).
	*/
	[unroll] for ( i=-2; i<=2; i++ ) [unroll] for ( j=-2; j<=2; j++ )
	{
		idist += gauss3[abs(i)]*gauss3[abs(j)]
			*float4(TextureColor.Sample(Sampler,rcoord+bof
			*float2(i,j)).r,TextureColor.Sample(SamplerB,gcoord+bof
			*float2(i,j)).g,TextureColor.Sample(SamplerB,bcoord+bof
			*float2(i,j)).b,TextureColor.Sample(SamplerB,float2(x,
			y)+bof*float2(i,j)).a);
	}
	res.rgb = idist.rgb;
	return res;
}

/* Why am I doing this */
float4 PS_Blur( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !bssblurenable ) return res;
	float2 ofs[16] =
	{
		float2(1.0,1.0), float2(-1.0,-1.0),
		float2(-1.0,1.0), float2(1.0,-1.0),
		
		float2(1.0,0.0), float2(-1.0,0.0),
		float2(0.0,1.0), float2(0.0,-1.0),
		
		float2(1.41,0.0), float2(-1.41,0.0),
		float2(0.0,1.41), float2(0.0,-1.41),
		
		float2(1.41,1.41), float2(-1.41,-1.41),
		float2(-1.41,1.41), float2(1.41,-1.41)
	};
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*bssblurradius;
	int i;
	[unroll] for ( i=0; i<16; i++ )
		res += TextureColor.Sample(Sampler,coord+ofs[i]*bof);
	res /= 17.0;
	res.a = 1.0;
	return res;
}
float4 PS_Sharp( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !bsssharpenable ) return res;
	float2 ofs[8] =
	{
		float2(1.0,1.0), float2(-1.0,-1.0),
		float2(-1.0,1.0), float2(1.0,-1.0),
		
		float2(1.41,1.41), float2(-1.41,-1.41),
		float2(-1.41,1.41), float2(1.41,-1.41)
	};
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*bsssharpradius;
	float4 tcol = res;
	int i;
	[unroll] for ( i=0; i<8; i++ )
		tcol += TextureColor.Sample(Sampler,coord+ofs[i]*bof);
	tcol /= 9.0;
	float4 orig = res;
	res = orig*(1.0+dot(orig.rgb-tcol.rgb,0.333333)*bsssharpamount);
	float rg = clamp(pow(orig.b,3.0),0.0,1.0);
	res = lerp(res,orig,rg);
	res.a = 1.0;
	return res;
}
float4 PS_Shift( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !bssshiftenable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*bssshiftradius;
	res.g = TextureColor.Sample(Sampler,coord).g;
	res.r = TextureColor.Sample(Sampler,coord+float2(0,-bof.y)).r;
	res.b = TextureColor.Sample(Sampler,coord+float2(0,bof.y)).b;
	res.a = 1.0;
	return res;
}

/* That "luma sharpen" thingy, added just because someone might want it */
float4 PS_LumaSharp( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !lsharpenable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*lsharpradius;
	float4 crawling = TextureColor.Sample(Sampler,coord+float2(0,-1)*bof);
	crawling += TextureColor.Sample(Sampler,coord+float2(-1,0)*bof);
	crawling += TextureColor.Sample(Sampler,coord+float2(1,0)*bof);
	crawling += TextureColor.Sample(Sampler,coord+float2(0,1)*bof);
	crawling *= 0.25;
	float4 inmyskin = res-crawling;
	float thesewounds = luminance(inmyskin.rgb);
	thesewounds = clamp(thesewounds,-lsharpclamp*0.01,lsharpclamp*0.01);
	float4 theywillnotheal = res+thesewounds*lsharpblend;
	return theywillnotheal;
}

technique11 ExtraFilters <string UIName="MariENB";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_LumaSharp()));
	}
}
technique11 ExtraFilters1
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_Blur()));
	}
}
technique11 ExtraFilters2
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_Sharp()));
	}
}
technique11 ExtraFilters3
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_Shift()));
	}
}
technique11 ExtraFilters4
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_ChromaKey()));
	}
}
technique11 ExtraFilters5
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_Retro()));
	}
}
technique11 ExtraFilters6
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_ASCII()));
	}
}
technique11 ExtraFilters7
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_DotMatrix()));
	}
}
technique11 ExtraFilters8
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_Curvature()));
	}
}
