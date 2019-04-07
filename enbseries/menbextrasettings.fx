/*
	menbextrasettings.fx : MariENB extra user-tweakable variables.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* Border darkening */
bool dkenable
<
	string UIName = "UseDark";
	string UIWidget = "Checkbox";
> = {false};
/* radius of darkening (relative to screen width) */
float dkradius_n
<
	string UIName = "DarkRadiusNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
float dkradius_d
<
	string UIName = "DarkRadiusDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
float dkradius_in
<
	string UIName = "DarkRadiusInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
float dkradius_id
<
	string UIName = "DarkRadiusInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
/* falloff of darkening */
float dkcurve_n
<
	string UIName = "DarkCurveNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dkcurve_d
<
	string UIName = "DarkCurveDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dkcurve_in
<
	string UIName = "DarkCurveInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dkcurve_id
<
	string UIName = "DarkCurveInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* bump of darkening */
float dkbump_n
<
	string UIName = "DarkBumpNight";
	string UIWidget = "Spinner";
> = {-1.0};
float dkbump_d
<
	string UIName = "DarkBumpDay";
	string UIWidget = "Spinner";
> = {-1.0};
float dkbump_in
<
	string UIName = "DarkBumpInteriorNight";
	string UIWidget = "Spinner";
> = {-1.0};
float dkbump_id
<
	string UIName = "DarkBumpInteriorDay";
	string UIWidget = "Spinner";
> = {-1.0};
/* Letterbox */
bool boxenable
<
	string UIName = "UseBox";
	string UIWidget = "Checkbox";
> = {false};
/* vertical factor */
float boxv
<
	string UIName = "BoxVertical";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.80};
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
> = {2500.0};
/* intensity of grain */
float ni
<
	string UIName = "GrainIntensity";
	string UIWidget = "Spinner";
> = {0.05};
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
> = {true};
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
> = {1};
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
> = {2.5};
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
> = {0.05};
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
/* gamma modifier for base color, lower values raise midtones and viceversa */
float bgamma
<
	string UIName = "GammaMod";
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
/* saturation modifier for base color, helps with limited palettes */
float bsaturation
<
	string UIName = "SaturationMod";
	string UIWidget = "Spinner";
> = {1.0};
