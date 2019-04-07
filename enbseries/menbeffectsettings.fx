/*
	menbeffectsettings.fx : MariENB base user-tweakable variables.
	(C)2013-2017 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
string str_misc = "Miscellaneous";
/* fixed resolution, keeps blur filters at a consistent internal resolution */
int fixedx
<
	string UIName = "Fixed Resolution Width";
	string UIWidget = "Spinner";
	int UIMin = 0;
> = {1920};
int fixedy
<
	string UIName = "Fixed Resolution Height";
	string UIWidget = "Spinner";
	int UIMin = 0;
> = {1080};
string str_dist = "Frost Overlay";
float distcha
<
	string UIName = "Distortion Chromatic Aberration";
	string UIWidget = "Spinner";
> = {10.0};
bool frostenable
<
	string UIName = "Enable Screen Frost";
	string UIWidget = "Checkbox";
> = {false};
float frostpow
<
	string UIName = "Frost Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float froststrength
<
	string UIName = "Frost Strength";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostrpow
<
	string UIName = "Frost Radial Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostrmult
<
	string UIName = "Frost Radial Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostrbump
<
	string UIName = "Frost Radial Offset";
	string UIWidget = "Spinner";
> = {0.0};
float frostblend
<
	string UIName = "Frost Texture Blend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostbpow
<
	string UIName = "Frost Texture Blend Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostsize
<
	string UIName = "Frost Texture Size";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostfactor_n
<
	string UIName = "Frost Factor Night";
	string UIWidget = "Spinner";
> = {1.0};
float frostfactor_d
<
	string UIName = "Frost Factor Day";
	string UIWidget = "Spinner";
> = {1.0};
float frostfactor_i
<
	string UIName = "Frost Factor Interior";
	string UIWidget = "Spinner";
> = {1.0};
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
bool nbt
<
	string UIName = "Apply Grain Before Tone Mapping";
	string UIWidget = "Checkbox";
> = {true};
/* old dirt filter */
string str_dirt = "Screen Dirt";
bool dirtenable
<
	string UIName = "Enable Dirt";
	string UIWidget = "Checkbox";
> = {false};
float dirtcfactor
<
	string UIName = "Dirt Coord Factor";
	string UIWidget = "Spinner";
> = {0.1};
float dirtlfactor
<
	string UIName = "Dirt Luminance Factor";
	string UIWidget = "Spinner";
> = {0.0};
float dirtmc
<
	string UIName = "Dirt Coord Zoom";
	string UIWidget = "Spinner";
> = {3.0};
float dirtml
<
	string UIName = "Dirt Luminance Zoom";
	string UIWidget = "Spinner";
> = {1.0};
/* "adaptation" factors */
string str_adaptation = "Eye Adaptation";
bool aenable
<
	string UIName = "Enable Adaptation";
	string UIWidget = "Checkbox";
> = {false};
float amin_n
<
	string UIName = "Adaptation Min Night";
	string UIWidget = "Spinner";
> = {0.0};
float amin_d
<
	string UIName = "Adaptation Min Day";
	string UIWidget = "Spinner";
> = {0.0};
float amin_i
<
	string UIName = "Adaptation Min Interior";
	string UIWidget = "Spinner";
> = {0.0};
float amax_n
<
	string UIName = "Adaptation Max Night";
	string UIWidget = "Spinner";
> = {1.0};
float amax_d
<
	string UIName = "Adaptation Max Day";
	string UIWidget = "Spinner";
> = {1.0};
float amax_i
<
	string UIName = "Adaptation Max Interior";
	string UIWidget = "Spinner";
> = {1.0};
/* tone mapping */
string str_tonemap = "Tone Mapping";
/*
   algorithms:
    -1 : Disabled
     0 : Linear
     1 : Reinhard
     2 : Uncharted 2
     3 : Hejl Dawson
     4 : Haarm-Peter Duiker
*/
int tmapenable
<
	string UIName = "Tonemapping Method";
	string UIWidget = "Spinner";
	int UIMin = -1;
	int UIMax = 4;
> = {2};
float tmapexposure_n
<
	string UIName = "Tonemap Exposure Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float tmapexposure_d
<
	string UIName = "Tonemap Exposure Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float tmapexposure_i
<
	string UIName = "Tonemap Exposure Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float tmapblend_n
<
	string UIName = "Tonemap Blend Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float tmapblend_d
<
	string UIName = "Tonemap Blend Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float tmapblend_i
<
	string UIName = "Tonemap Blend Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float unA_n
<
	string UIName = "Uncharted2 Shoulder Strength Night";
	string UIWidget = "Spinner";
> = {0.5};
float unA_d
<
	string UIName = "Uncharted2 Shoulder Strength Day";
	string UIWidget = "Spinner";
> = {0.5};
float unA_i
<
	string UIName = "Uncharted2 Shoulder Strength Interior";
	string UIWidget = "Spinner";
> = {0.5};
float unB_n
<
	string UIName = "Uncharted2 Linear Strength Night";
	string UIWidget = "Spinner";
> = {1.0};
float unB_d
<
	string UIName = "Uncharted2 Linear Strength Day";
	string UIWidget = "Spinner";
> = {1.0};
float unB_i
<
	string UIName = "Uncharted2 Linear Strength Interior";
	string UIWidget = "Spinner";
> = {1.0};
float unC_n
<
	string UIName = "Uncharted2 Linear Angle Night";
	string UIWidget = "Spinner";
> = {0.2};
float unC_d
<
	string UIName = "Uncharted2 Linear Angle Day";
	string UIWidget = "Spinner";
> = {0.2};
float unC_i
<
	string UIName = "Uncharted2 Linear Angle Interior";
	string UIWidget = "Spinner";
> = {0.2};
float unD_n
<
	string UIName = "Uncharted2 Toe Strength Night";
	string UIWidget = "Spinner";
> = {0.75};
float unD_d
<
	string UIName = "Uncharted2 Toe Strength Day";
	string UIWidget = "Spinner";
> = {0.75};
float unD_i
<
	string UIName = "Uncharted2 Toe Strength Interior";
	string UIWidget = "Spinner";
> = {0.75};
float unE_n
<
	string UIName = "Uncharted2 Toe Numerator Night";
	string UIWidget = "Spinner";
> = {0.02};
float unE_d
<
	string UIName = "Uncharted2 Toe Numerator Day";
	string UIWidget = "Spinner";
> = {0.02};
float unE_i
<
	string UIName = "Uncharted2 Toe Numerator Interior";
	string UIWidget = "Spinner";
> = {0.02};
float unF_n
<
	string UIName = "Uncharted2 Toe Denominator Night";
	string UIWidget = "Spinner";
> = {0.30};
float unF_d
<
	string UIName = "Uncharted2 Toe Denominator Day";
	string UIWidget = "Spinner";
> = {0.30};
float unF_i
<
	string UIName = "Uncharted2 Toe Denominator Interior";
	string UIWidget = "Spinner";
> = {0.30};
float unW_n
<
	string UIName = "Uncharted2 Linear White Night";
	string UIWidget = "Spinner";
> = {10.0};
float unW_d
<
	string UIName = "Uncharted2 Linear White Day";
	string UIWidget = "Spinner";
> = {10.0};
float unW_i
<
	string UIName = "Uncharted2 Linear White Interior";
	string UIWidget = "Spinner";
> = {10.0};
/* Color grading */
string str_grade = "Color Grading Suite";
bool gradeenable1
<
	string UIName = "Enable RGB Grading";
	string UIWidget = "Checkbox";
> = {false};
/* color component multipliers */
float grademul_r_n
<
	string UIName = "Grading Intensity Night Red";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_g_n
<
	string UIName = "Grading Intensity Night Green";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_b_n
<
	string UIName = "Grading Intensity Night Blue";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_r_d
<
	string UIName = "Grading Intensity Day Red";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_g_d
<
	string UIName = "Grading Intensity Day Green";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_b_d
<
	string UIName = "Grading Intensity Day Blue";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_r_i
<
	string UIName = "Grading Intensity Interior Red";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_g_i
<
	string UIName = "Grading Intensity Interior Green";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_b_i
<
	string UIName = "Grading Intensity Interior Blue";
	string UIWidget = "Spinner";
> = {1.0};
/* color component contrasts */
float gradepow_r_n
<
	string UIName = "Grading Contrast Night Red";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_g_n
<
	string UIName = "Grading Contrast Night Green";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_b_n
<
	string UIName = "Grading Contrast Night Blue";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_r_d
<
	string UIName = "Grading Contrast Day Red";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_g_d
<
	string UIName = "Grading Contrast Day Green";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_b_d
<
	string UIName = "Grading Contrast Day Blue";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_r_i
<
	string UIName = "Grading Contrast Interior Red";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_g_i
<
	string UIName = "Grading Contrast Interior Green";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_b_i
<
	string UIName = "Grading Contrast Interior Blue";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* colorization factors */
bool gradeenable2
<
	string UIName = "Enable Vibrance Grading";
	string UIWidget = "Checkbox";
> = {false};
float gradecol_r_n
<
	string UIName = "Grading Color Night Red";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_g_n
<
	string UIName = "Grading Color Night Green";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_b_n
<
	string UIName = "Grading Color Night Blue";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_r_d
<
	string UIName = "Grading Color Day Red";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_g_d
<
	string UIName = "Grading Color Day Green";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_b_d
<
	string UIName = "Grading Color Day Blue";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_r_i
<
	string UIName = "Grading Color Interior Red";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_g_i
<
	string UIName = "Grading Color Interior Green";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_b_i
<
	string UIName = "Grading Color Interior Blue";
	string UIWidget = "Spinner";
> = {1.0};
/* blend factor for colorization (negative values are quite fancy) */
float gradecolfact_n
<
	string UIName = "Grading Color Factor Night";
	string UIWidget = "Spinner";
> = {0.0};
float gradecolfact_d
<
	string UIName = "Grading Color Factor Day";
	string UIWidget = "Spinner";
> = {0.0};
float gradecolfact_i
<
	string UIName = "Grading Color Factor Interior";
	string UIWidget = "Spinner";
> = {0.0};
/* HSV grading */
bool gradeenable3
<
	string UIName = "Enable HSV Grading";
	string UIWidget = "Checkbox";
> = {false};
/* saturation multiplier */
float gradesatmul_n
<
	string UIName = "Grading Saturation Intensity Night";
	string UIWidget = "Spinner";
> = {1.0};
float gradesatmul_d
<
	string UIName = "Grading Saturation Intensity Day";
	string UIWidget = "Spinner";
> = {1.0};
float gradesatmul_i
<
	string UIName = "Grading Saturation Intensity Interior";
	string UIWidget = "Spinner";
> = {1.0};
/* saturation power */
float gradesatpow_n
<
	string UIName = "Grading Saturation Contrast Night";
	string UIWidget = "Spinner";
> = {1.0};
float gradesatpow_d
<
	string UIName = "Grading Saturation Contrast Day";
	string UIWidget = "Spinner";
> = {1.0};
float gradesatpow_i
<
	string UIName = "Grading Saturation Contrast Interior";
	string UIWidget = "Spinner";
> = {1.0};
/* value multiplier */
float gradevalmul_n
<
	string UIName = "Grading Value Intensity Night";
	string UIWidget = "Spinner";
> = {1.0};
float gradevalmul_d
<
	string UIName = "Grading Value Intensity Day";
	string UIWidget = "Spinner";
> = {1.0};
float gradevalmul_i
<
	string UIName = "Grading Value Intensity Interior";
	string UIWidget = "Spinner";
> = {1.0};
/* value power */
float gradevalpow_n
<
	string UIName = "Grading Value Contrast Night";
	string UIWidget = "Spinner";
> = {1.0};
float gradevalpow_d
<
	string UIName = "Grading Value Contrast Day";
	string UIWidget = "Spinner";
> = {1.0};
float gradevalpow_i
<
	string UIName = "Grading Value Contrast Interior";
	string UIWidget = "Spinner";
> = {1.0};
bool colorizeafterhsv
<
	string UIName = "Colorize After HSV";
	string UIWidget = "Checkbox";
> = {true};
/* game imagespace support */
string str_vanilla = "Vanilla Imagespace Tint/Grading/Fade";
/* vanilla grading */
bool vgradeenable
<
	string UIName = "Enable Vanilla Imagespace";
	string UIWidget = "Checkbox";
> = {true};
float vtintblend
<
	string UIName = "Vanilla Tint Blend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float vsatblend
<
	string UIName = "Vanilla Vibrance Blend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float vconblend
<
	string UIName = "Vanilla Contrast Blend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float vtintpow
<
	string UIName = "Vanilla Tint Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float vtintmul
<
	string UIName = "Vanilla Tint Strength";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float vsatpow
<
	string UIName = "Vanilla Vibrance Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float vsatmul
<
	string UIName = "Vanilla Vibrance Strength";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* LUT grading */
string str_lut = "RGB Lookup Table Grading";
bool lutenable
<
	string UIName = "Enable LUT Grading";
	string UIWidget = "Checkbox";
> = {false};
float lutblend_n
<
	string UIName = "LUT Blend Night";
	string UIWidget = "Spinner";
> = {1.0};
float lutblend_d
<
	string UIName = "LUT Blend Day";
	string UIWidget = "Spinner";
> = {1.0};
float lutblend_i
<
	string UIName = "LUT Blend Interior";
	string UIWidget = "Spinner";
> = {1.0};
/* technicolor shader */
string str_tech = "Technicolor";
bool techenable
<
	string UIName = "Enable Technicolor";
	string UIWidget = "Checkbox";
> = {false};
float techblend
<
	string UIName = "Technicolor Blend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
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
	int UIMax = 2;
> = {2};
string str_debug = "Debugging";
bool bloomdebug
<
	string UIName = "Display Bloom";
	string UIWidget = "Checkbox";
> = {false};
