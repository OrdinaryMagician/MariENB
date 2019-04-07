/*
	menbextrasettings.fx : MariENB extra user-tweakable variables.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* BlockGFX filter, I'm proud of it */
bool useblock
<
	string UIName = "UseBlockGFX";
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
	string UIName = "EmulatedResX";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float bresy
<
	string UIName = "EmulatedResY";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
/* zooming factors (<=0 for stretch) */
float sresx
<
	string UIName = "ZoomedResX";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float sresy
<
	string UIName = "ZoomedResY";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
/*
   palette type:
    -1 : disable
     0 : CGA (320x200 4-color, or 640x200 monochrome)
     1 : EGA (320x200, 16 colors)
     2 : RGB2 (64-color quarter VGA palette, used in AOS)
     3 : RGB323 (8-bit RGB, I don't think this was a real thing)
     4 : RGB4 (4bpc, I also don't think this was ever used in real hardware)
     5 : RGB565 (ol' 16-bit "true color")
     6 : RGB6 (typical screens incapable of 8bpc)
*/
int paltype
<
	string UIName = "PaletteType";
	string UIWidget = "Spinner";
	int UIMin = -1;
	int UIMax = 6;
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
	string UIName = "CGAPalette";
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
	string UIName = "EGAPalette";
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
	string UIName = "DitherMode";
	string UIWidget = "Spinner";
	int UIMin = -1;
	int UIMax = 4;
> = {4};
/* gamma modifier for base color, lower values raise midtones and viceversa */
float bgamma
<
	string UIName = "GammaMod";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.35};
/* base brightness bump for the dither grid */
float bdbump
<
	string UIName = "DitherBump";
	string UIWidget = "Spinner";
> = {-0.1};
/* range multiplier for the dither grid */
float bdmult
<
	string UIName = "DitherMultiplier";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
/* saturation modifier for base color, helps with limited palettes */
float bsaturation
<
	string UIName = "SaturationMod";
	string UIWidget = "Spinner";
> = {1.1};
/* Painting filter, mixes Kuwahara with median for a smooth result */
bool paintenable
<
	string UIName = "EnablePainting";
	string UIWidget = "Checkbox";
> = {false};
float paintradius
<
	string UIName = "PaintingRadius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float paintmradius
<
	string UIName = "PaintingMedianRadius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* ASCII art filter */
bool asciienable
<
	string UIName = "EnableASCII";
	string UIWidget = "Checkbox";
> = {false};
bool asciimono
<
	string UIName = "ASCIIMonochrome";
	string UIWidget = "Checkbox";
> = {true};
float asciiblend
<
	string UIName = "ASCIIBlend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
bool maskenable
<
	string UIName = "EnableChromaKey";
	string UIWidget = "Checkbox";
> = {false};
float maskr
<
	string UIName = "ChromaKeyRed";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
float maskg
<
	string UIName = "ChromaKeyGreen";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float maskb
<
	string UIName = "ChromaKeyBlue";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
float maskd
<
	string UIName = "ChromaKeyDepth";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};