/*
	menbextrasettings.fx : MariENB extra user-tweakable variables.
	(C)2013-2016 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
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
float bresx
<
	string UIName = "Emulated Resolution Width";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float bresy
<
	string UIName = "Emulated Resolution Height";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
/* zooming factors (<=0 for stretch) */
float sresx
<
	string UIName = "Zoom Factor X";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float sresy
<
	string UIName = "Zoom Factor Y";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
/*
   palette type:
    -2 : Standard VGA 256-color palette
    -1 : disable
     0 : CGA (320x200 4-color, or 640x200 monochrome)
     1 : EGA (320x200, 16 colors)
     2 : RGB2 (64-color quarter VGA palette, used in AOS)
     3 : RGB323 (8-bit RGB, I don't think this was a real thing)
     4 : VGA (256 colors, standard palette)
     5 : Doom (256 colors, does not cover a lot)
     6 : Quake I (256 colors, covers even less)
     7 : RGB4 (4bpc, I also don't think this was ever used in real hardware)
     8 : RGB565 (ol' 16-bit "true color")
     9 : RGB6 (typical screens incapable of 8bpc)
*/
int paltype
<
	string UIName = "Palette Type";
	string UIWidget = "Spinner";
	int UIMin = -1;
	int UIMax = 9;
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
float maskr
<
	string UIName = "Chroma Key Red";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
float maskg
<
	string UIName = "Chroma Key Green";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float maskb
<
	string UIName = "Chroma Key Blue";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
float maskd
<
	string UIName = "Chroma Key Depth";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};
/* tilting */
float masktiltxcenter
<
	string UIName = "Chroma Key Depth Horizontal Tilt Center";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};
float masktiltycenter
<
	string UIName = "Chroma Key Depth Vertical Tilt Center";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};
float masktiltx
<
	string UIName = "Chroma Key Depth Horizontal Tilt";
	string UIWidget = "Spinner";
> = {0.0};
float masktilty
<
	string UIName = "Chroma Key Depth Vertical Tilt";
	string UIWidget = "Spinner";
> = {0.0};
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
