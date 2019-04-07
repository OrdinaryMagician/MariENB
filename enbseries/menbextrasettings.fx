/*
	menbextrasettings.fx : MariENB extra user-tweakable variables.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the WTFPL.
*/
/* film grain */
bool ne
<
	string UIName = "UseGrain";
	string UIWidget = "Checkbox";
> = {false};
/* speed of grain */
float nf
<
	string UIName = "GrainFrequency";
	string UIWidget = "Spinner";
> = {0.25};
/* intensity of grain */
float ni
<
	string UIName = "GrainIntensity";
	string UIWidget = "Spinner";
> = {0.15};
/* saturation of grain */
float ns
<
	string UIName = "GrainSaturation";
	string UIWidget = "Spinner";
> = {0.0};
/* use two-pass grain (double the texture fetches, but looks less uniform) */
bool np
<
	string UIName = "GrainTwoPass";
	string UIWidget = "Checkbox";
> = {false};
/*
   blending mode for grain:
   0 -> normal
   1 -> add
   2 -> overlay
   3 -> "dark mask", a personal invention
*/
int nb
<
	string UIName = "GrainBlend";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 3;
> = {0};
/* dark mask blend mode contrast for mask image */
float bnp
<
	string UIName = "GrainDarkMaskPower";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* two-pass distortion factor (0 = look just like one-pass grain) */
float nk
<
	string UIName = "GrainTwoPassFactor";
	string UIWidget = "Spinner";
> = {0.04};
/* zoom factors for each component of each noise texture */
float nm1
<
	string UIName = "GrainMagnification1";
	string UIWidget = "Spinner";
> = {13.25};
float nm2
<
	string UIName = "GrainMagnification2";
	string UIWidget = "Spinner";
> = {19.64};
float nm3
<
	string UIName = "GrainMagnification3";
	string UIWidget = "Spinner";
> = {17.35};
float nm11
<
	string UIName = "GrainPass1Magnification1";
	string UIWidget = "Spinner";
> = {2.05};
float nm12
<
	string UIName = "GrainPass1Magnification2";
	string UIWidget = "Spinner";
> = {3.11};
float nm13
<
	string UIName = "GrainPass1Magnification3";
	string UIWidget = "Spinner";
> = {2.22};
float nm21
<
	string UIName = "GrainPass2Magnification1";
	string UIWidget = "Spinner";
> = {4.25};
float nm22
<
	string UIName = "GrainPass2Magnification2";
	string UIWidget = "Spinner";
> = {0.42};
float nm23
<
	string UIName = "GrainPass2Magnification3";
	string UIWidget = "Spinner";
> = {6.29};
/* contrast of grain */
float nj
<
	string UIName = "GrainPower";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.33};
/* use curvature + chromatic aberration filter */
bool usecurve
<
	string UIName = "UseCurve";
	string UIWidget = "Checkbox";
> = {false};
/* this is a stupid filter and you should feel bad for using it */
float chromaab
<
	string UIName = "CurveChromaAberration";
	string UIWidget = "Spinner";
> = {0.07};
/* zoom factor for curve lens (50.0 = no zoom) */
float lenszoom
<
	string UIName = "CurveLensZoom";
	string UIWidget = "Spinner";
> = {50.25};
/* distortion factors for lens */
float lensdist
<
	string UIName = "CurveLensDistortion";
	string UIWidget = "Spinner";
> = {0.0};
float lensdistc
<
	string UIName = "CurveLensDistortionCubic";
	string UIWidget = "Spinner";
> = {0.0};
/* clamp borders of lens with black */
bool lensclamp
<
	string UIName = "CurveLensClamp";
	string UIWidget = "Checkbox";
> = {true};
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
> = {2};
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
/* gamma modifiers for base color, lower values raise midtones and viceversa */
float bgammar
<
	string UIName = "GammaModR";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.65};
float bgammag
<
	string UIName = "GammaModG";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.65};
float bgammab
<
	string UIName = "GammaModB";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.65};
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
> = {0.3};
/* saturation modifiers for base color, helps with limited palettes */
float bsaturationr
<
	string UIName = "SaturationModR";
	string UIWidget = "Spinner";
> = {1.0};
float bsaturationg
<
	string UIName = "SaturationModG";
	string UIWidget = "Spinner";
> = {1.0};
float bsaturationb
<
	string UIName = "SaturationModB";
	string UIWidget = "Spinner";
> = {1.0};
