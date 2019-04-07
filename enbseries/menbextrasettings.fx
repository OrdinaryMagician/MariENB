/*
	menbextrasettings.fx : MariENB extra user-tweakable variables.
	(C)2013-2017 Marisa Kirisame, UnSX Team.
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
     2 : 8x8 ordered dithering
*/
int dither
<
	string UIName = "Dithering Pattern";
	string UIWidget = "Spinner";
	int UIMin = -1;
	int UIMax = 2;
> = {2};
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
/*
   Paint filters:
   -1 : Disabled
    0 : Oil painting filter, mixes Kuwahara with median for a smooth result
    1 : "Van Gogh" filter, ported from https://www.shadertoy.com/view/MdGSDG
        with some small changes
    2 : "Watercolor" filter, ported from https://www.shadertoy.com/view/ltyGRV
        also with some small changes
    
*/
string str_paint = "Painting Filters";
bool oilenable
<
	string UIName = "Enable Oil Filter";
	string UIWidget = "Checkbox";
> = {false};
/* legacy FXAA filter */
string str_fxaa = "FXAA";
bool fxaaenable
<
	string UIName = "Enable FXAA";
	string UIWidget = "Checkbox";
> = {false};
float fxaaspanmax
<
	string UIName = "FXAA Span Max";
	string UIWidget = "Checkbox";
> = {4.0};
float fxaareducemul
<
	string UIName = "FXAA Reduce Mul";
	string UIWidget = "Checkbox";
> = {16.0};
float fxaareducemin
<
	string UIName = "FXAA Reduce Min";
	string UIWidget = "Checkbox";
> = {128.0};
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
/* Depth-cutting chroma key */
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
/* cheap dot matrix */
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
/* lens curve with chromatic aberration */
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
/* very cinematic black bars */
string str_box = "Black Bars";
bool boxenable
<
	string UIName = "Enable Black Bars";
	string UIWidget = "Checkbox";
> = {false};
float boxh
<
	string UIName = "Box Horizontal Ratio";
	string UIWidget = "Spinner";
	float UIMin = 1.0;
> = {2.39};
float boxv
<
	string UIName = "Box Vertical Ratio";
	string UIWidget = "Spinner";
	float UIMin = 1.0;
> = {1.0};
/* vignette */
string str_vignette = "Vignette with border blur";
bool vigenable
<
	string UIName = "Enable Vignette";
	string UIWidget = "Checkbox";
> = {false};
bool bblurenable
<
	string UIName = "Enable Border Blur";
	string UIWidget = "Checkbox";
> = {false};
/* 0 = circle, 1 = box, 2 = texture */
int vigshape
<
	string UIName = "Vignette Shape";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 2;
> = {0};
/* 0 = overwrite, 1 = add, 2 = multiply */
int vigmode
<
	string UIName = "Vignette Blending Mode";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 2;
> = {0};
float vigpow
<
	string UIName = "Vignette Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float vigmul
<
	string UIName = "Vignette Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float vigbump
<
	string UIName = "Vignette Shift";
	string UIWidget = "Spinner";
> = {0.0};
float vigcolor_r
<
	string UIName = "Vignette Color Red";
	string UIWidget = "Spinner";
> = {0.0};
float vigcolor_g
<
	string UIName = "Vignette Color Green";
	string UIWidget = "Spinner";
> = {0.0};
float vigcolor_b
<
	string UIName = "Vignette Color Blue";
	string UIWidget = "Spinner";
> = {0.0};
float bblurpow
<
	string UIName = "Border Blur Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bblurmul
<
	string UIName = "Border Blur Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bblurbump
<
	string UIName = "Border Blur Shift";
	string UIWidget = "Spinner";
> = {0.0};
float bblurradius
<
	string UIName = "Border Blur Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
