/*
	menbeffectsettings.fx : MariENB 3 base user-tweakable variables.
	(C)2015 Marisa Kirisame, UnSX Team.
	Part of MariENB 3, the personal ENB of Marisa for Fallout 4.
	Released under the GNU GPLv3 (or later).
*/
/* film grain */
string str_noise = "Film Grain";
bool ne
<
	string UIName = "Enable Grain";
	string UIWidget = "Checkbox";
> = {false};
/* speed of grain */
float nf
<
	string UIName = "Grain Speed";
	string UIWidget = "Spinner";
> = {2500.0};
/* intensity of grain */
float ni
<
	string UIName = "Grain Intensity";
	string UIWidget = "Spinner";
> = {0.05};
/* saturation of grain */
float ns
<
	string UIName = "Grain Saturation";
	string UIWidget = "Spinner";
> = {0.0};
/* use two-pass grain (double the texture fetches, but looks less uniform) */
bool np
<
	string UIName = "Grain Two-Pass";
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
	string UIName = "Grain Blending Mode";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 3;
> = {1};
/* dark mask blend mode contrast for mask image */
float bnp
<
	string UIName = "Grain Dark Mask Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.5};
/* two-pass distortion factor (0 = look just like one-pass grain) */
float nk
<
	string UIName = "Grain Two-Pass Factor";
	string UIWidget = "Spinner";
> = {0.04};
/* zoom factors for each component of each noise texture */
float nm1
<
	string UIName = "Grain Magnification 1";
	string UIWidget = "Spinner";
> = {13.25};
float nm2
<
	string UIName = "Grain Magnification 2";
	string UIWidget = "Spinner";
> = {19.64};
float nm3
<
	string UIName = "Grain Magnification 3";
	string UIWidget = "Spinner";
> = {17.35};
float nm11
<
	string UIName = "Grain Pass 1 Magnification 1";
	string UIWidget = "Spinner";
> = {2.05};
float nm12
<
	string UIName = "Grain Pass 1 Magnification 2";
	string UIWidget = "Spinner";
> = {3.11};
float nm13
<
	string UIName = "Grain Pass 1 Magnification 3";
	string UIWidget = "Spinner";
> = {2.22};
float nm21
<
	string UIName = "Grain Pass 2 Magnification 1";
	string UIWidget = "Spinner";
> = {4.25};
float nm22
<
	string UIName = "Grain Pass 2 Magnification 2";
	string UIWidget = "Spinner";
> = {0.42};
float nm23
<
	string UIName = "Grain Pass 2 Magnification 3";
	string UIWidget = "Spinner";
> = {6.29};
/* contrast of grain */
float nj
<
	string UIName = "Grain Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
/* tone mapping */
string str_tonemap = "Filmic Tone Mapping";
bool tmapenable
<
	string UIName = "Enable Tonemapping";
	string UIWidget = "Checkbox";
> = {false};
float unA
<
	string UIName = "Tonemap Shoulder Strength";
	string UIWidget = "Spinner";
> = {0.5};
float unB
<
	string UIName = "Tonemap Linear Strengtht";
	string UIWidget = "Spinner";
> = {1.0};
float unC
<
	string UIName = "Tonemap Linear Angle";
	string UIWidget = "Spinner";
> = {0.2};
float unD
<
	string UIName = "Tonemap Toe Strengtht";
	string UIWidget = "Spinner";
> = {0.75};
float unE
<
	string UIName = "Tonemap Toe Numerator";
	string UIWidget = "Spinner";
> = {0.02};
float unF
<
	string UIName = "Tonemap Toe Denominator";
	string UIWidget = "Spinner";
> = {0.30};
float unW
<
	string UIName = "Tonemap Linear Whitet";
	string UIWidget = "Spinner";
> = {10.0};
bool tmapbeforecomp
<
	string UIName = "Tonemap Before Compensate";
	string UIWidget = "Checkbox";
> = {false};
/* overshine/bloom compensation */
string str_comp = "Overbright Compensation";
bool compenable
<
	string UIName = "Enable Compensate";
	string UIWidget = "Checkbox";
> = {false};
/* compensation factor */
float compfactor
<
	string UIName = "Compensate Factor";
	string UIWidget = "Spinner";
> = {0.0};
/* compensation power (contrast) */
float comppow
<
	string UIName = "Compensate Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* compensation saturation (higher values desaturate highlights) */
float compsat
<
	string UIName = "Compensate Saturationt";
	string UIWidget = "Spinner";
> = {1.0};
/* Color grading */
string str_grade = "Color Grading Suite";
bool gradeenable1
<
	string UIName = "Enable RGB Grading";
	string UIWidget = "Checkbox";
> = {false};
/* color component multipliers */
float grademul_r
<
	string UIName = "Grading Intensity Red";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_g
<
	string UIName = "Grading Intensity Green";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_b
<
	string UIName = "Grading Intensity Blue";
	string UIWidget = "Spinner";
> = {1.0};
/* color component contrasts */
float gradepow_r
<
	string UIName = "Grading Contrast Red";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_g
<
	string UIName = "Grading Contrast Green";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_b
<
	string UIName = "Grading Contrast Blue";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* colorization factors */
bool gradeenable2
<
	string UIName = "Enable Vibrance Grading";
	string UIWidget = "Checkbox";
> = {false};
float gradecol_r
<
	string UIName = "Grading Color Red";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_g
<
	string UIName = "Grading Color Green";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_b
<
	string UIName = "Grading Color Blue";
	string UIWidget = "Spinner";
> = {1.0};
/* blend factor for colorization (negative values are quite fancy) */
float gradecolfact
<
	string UIName = "Grading Color Factor";
	string UIWidget = "Spinner";
> = {0.0};
/* HSV grading */
bool gradeenable3
<
	string UIName = "Enable HSV Grading";
	string UIWidget = "Checkbox";
> = {false};
/* saturation multiplier */
float gradesatmul
<
	string UIName = "Grading Saturation Intensity";
	string UIWidget = "Spinner";
> = {1.0};
/* saturation power */
float gradesatpow
<
	string UIName = "Grading Saturation Contrast";
	string UIWidget = "Spinner";
> = {1.0};
/* value multiplier */
float gradevalmul
<
	string UIName = "Grading Value Intensity";
	string UIWidget = "Spinner";
> = {1.0};
/* value power */
float gradevalpow
<
	string UIName = "Grading Value Contrast";
	string UIWidget = "Spinner";
> = {1.0};
bool colorizeafterhsv
<
	string UIName = "Colorize After HSV";
	string UIWidget = "Checkbox";
> = {true};
/* vanilla imagespace support */
string str_vanilla = "Vanilla Processing";
bool vanillaenable
<
	string UIName = "Enable Vanilla Processing";
	string UIWidget = "Checkbox";
> = {true};
float vanillablend
<
	string UIName = "Vanilla Blend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
/* LUT grading */
string str_lut = "RGB Lookup Table Grading";
bool lutenable
<
	string UIName = "Enable LUT Grading";
	string UIWidget = "Checkbox";
> = {false};
float lutblend
<
	string UIName = "LUT Blend";
	string UIWidget = "Spinner";
> = {1.0};
#ifdef LUTMODE_LEGACY
int clut
<
	string UIName = "LUT Preset";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 63;
> = {1};
#endif
string str_dither = "Dithering";
bool dodither
<
	string UIName = "Enable Post Dither";
	string UIWidget = "Checkbox";
> = {true};
int dither
<
	string UIName = "Dither Pattern";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 4;
> = {4};
