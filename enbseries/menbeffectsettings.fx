/*
	menbeffectsettings.fx : MariENB base user-tweakable variables.
	(C)2013-2016 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
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
float amin_in
<
	string UIName = "Adaptation Min Interior Night";
	string UIWidget = "Spinner";
> = {0.0};
float amin_id
<
	string UIName = "Adaptation Min Interior Day";
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
float amax_in
<
	string UIName = "Adaptation Max Interior Night";
	string UIWidget = "Spinner";
> = {1.0};
float amax_id
<
	string UIName = "Adaptation Max Interior Day";
	string UIWidget = "Spinner";
> = {1.0};
/* tone mapping */
string str_tonemap = "Filmic Tone Mapping";
bool tmapenable
<
	string UIName = "Enable Tonemapping";
	string UIWidget = "Checkbox";
> = {false};
float unA_n
<
	string UIName = "Tonemap Shoulder Strength Night";
	string UIWidget = "Spinner";
> = {0.5};
float unA_d
<
	string UIName = "Tonemap Shoulder Strength Day";
	string UIWidget = "Spinner";
> = {0.5};
float unA_in
<
	string UIName = "Tonemap Shoulder Strength Interior Night";
	string UIWidget = "Spinner";
> = {0.5};
float unA_id
<
	string UIName = "Tonemap Shoulder Strength Interior Day";
	string UIWidget = "Spinner";
> = {0.5};
float unB_n
<
	string UIName = "Tonemap Linear Strength Night";
	string UIWidget = "Spinner";
> = {1.0};
float unB_d
<
	string UIName = "Tonemap Linear Strength Day";
	string UIWidget = "Spinner";
> = {1.0};
float unB_in
<
	string UIName = "Tonemap Linear Strength Interior Night";
	string UIWidget = "Spinner";
> = {1.0};
float unB_id
<
	string UIName = "Tonemap Linear Strength Interior Day";
	string UIWidget = "Spinner";
> = {1.0};
float unC_n
<
	string UIName = "Tonemap Linear Angle Night";
	string UIWidget = "Spinner";
> = {0.2};
float unC_d
<
	string UIName = "Tonemap Linear Angle Day";
	string UIWidget = "Spinner";
> = {0.2};
float unC_in
<
	string UIName = "Tonemap Linear Angle Interior Night";
	string UIWidget = "Spinner";
> = {0.2};
float unC_id
<
	string UIName = "Tonemap Linear Angle Interior Day";
	string UIWidget = "Spinner";
> = {0.2};
float unD_n
<
	string UIName = "Tonemap Toe Strength Night";
	string UIWidget = "Spinner";
> = {0.75};
float unD_d
<
	string UIName = "Tonemap Toe Strength Day";
	string UIWidget = "Spinner";
> = {0.75};
float unD_in
<
	string UIName = "Tonemap Toe Strength Interior Night";
	string UIWidget = "Spinner";
> = {0.75};
float unD_id
<
	string UIName = "Tonemap Toe Strength Interior Day";
	string UIWidget = "Spinner";
> = {0.75};
float unE_n
<
	string UIName = "Tonemap Toe Numerator Night";
	string UIWidget = "Spinner";
> = {0.02};
float unE_d
<
	string UIName = "Tonemap Toe Numerator Day";
	string UIWidget = "Spinner";
> = {0.02};
float unE_in
<
	string UIName = "Tonemap Toe Numerator Interior Night";
	string UIWidget = "Spinner";
> = {0.02};
float unE_id
<
	string UIName = "Tonemap Toe Numerator Interior Day";
	string UIWidget = "Spinner";
> = {0.02};
float unF_n
<
	string UIName = "Tonemap Toe Denominator Night";
	string UIWidget = "Spinner";
> = {0.30};
float unF_d
<
	string UIName = "Tonemap Toe Denominator Day";
	string UIWidget = "Spinner";
> = {0.30};
float unF_in
<
	string UIName = "Tonemap Toe Denominator Interior Night";
	string UIWidget = "Spinner";
> = {0.30};
float unF_id
<
	string UIName = "Tonemap Toe Denominator Interior Day";
	string UIWidget = "Spinner";
> = {0.30};
float unW_n
<
	string UIName = "Tonemap Linear White Night";
	string UIWidget = "Spinner";
> = {10.0};
float unW_d
<
	string UIName = "Tonemap Linear White Day";
	string UIWidget = "Spinner";
> = {10.0};
float unW_in
<
	string UIName = "Tonemap Linear White Interior Night";
	string UIWidget = "Spinner";
> = {10.0};
float unW_id
<
	string UIName = "Tonemap Linear White Interior Day";
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
float grademul_r_in
<
	string UIName = "Grading Intensity Interior Night Red";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_g_in
<
	string UIName = "Grading Intensity Interior Night Green";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_b_in
<
	string UIName = "Grading Intensity Interior Night Blue";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_r_id
<
	string UIName = "Grading Intensity Interior Day Red";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_g_id
<
	string UIName = "Grading Intensity Interior Day Green";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_b_id
<
	string UIName = "Grading Intensity Interior Day Blue";
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
float gradepow_r_in
<
	string UIName = "Grading Contrast Interior Night Red";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_g_in
<
	string UIName = "Grading Contrast Interior Night Green";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_b_in
<
	string UIName = "Grading Contrast Interior Night Blue";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_r_id
<
	string UIName = "Grading Contrast Interior Day Red";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_g_id
<
	string UIName = "Grading Contrast Interior Day Green";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_b_id
<
	string UIName = "Grading Contrast Interior Day Blue";
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
float gradecol_r_in
<
	string UIName = "Grading Color Interior Night Red";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_g_in
<
	string UIName = "Grading Color Interior Night Green";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_b_in
<
	string UIName = "Grading Color Interior Night Blue";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_r_id
<
	string UIName = "Grading Color Interior Day Red";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_g_id
<
	string UIName = "Grading Color Interior Day Green";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_b_id
<
	string UIName = "Grading Color Interior Day Blue";
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
float gradecolfact_in
<
	string UIName = "Grading Color Factor Interior Night";
	string UIWidget = "Spinner";
> = {0.0};
float gradecolfact_id
<
	string UIName = "Grading Color Factor Interior Day";
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
float gradesatmul_in
<
	string UIName = "Grading Saturation Intensity Interior Night";
	string UIWidget = "Spinner";
> = {1.0};
float gradesatmul_id
<
	string UIName = "Grading Saturation Intensity Interior Day";
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
float gradesatpow_in
<
	string UIName = "Grading Saturation Contrast Interior Night";
	string UIWidget = "Spinner";
> = {1.0};
float gradesatpow_id
<
	string UIName = "Grading Saturation Contrast Interior Day";
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
float gradevalmul_in
<
	string UIName = "Grading Value Intensity Interior Night";
	string UIWidget = "Spinner";
> = {1.0};
float gradevalmul_id
<
	string UIName = "Grading Value Intensity Interior Day";
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
float gradevalpow_in
<
	string UIName = "Grading Value Contrast Interior Night";
	string UIWidget = "Spinner";
> = {1.0};
float gradevalpow_id
<
	string UIName = "Grading Value Contrast Interior Day";
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
float lutblend_in
<
	string UIName = "LUT Blend Interior Night";
	string UIWidget = "Spinner";
> = {1.0};
float lutblend_id
<
	string UIName = "LUT Blend Interior Day";
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
/* not using ENB's own variables, sorry */
string str_enbpal = "ENB Palette";
bool palenable
<
	string UIName = "Enable ENB Palette";
	string UIWidget = "Checkbox";
> = {false};
float palblend
<
	string UIName = "Palette Blend";
	string UIWidget = "Spinner";
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
	int UIMax = 4;
> = {4};
string str_debug = "Debugging";
bool bloomdebug
<
	string UIName = "Display Bloom";
	string UIWidget = "Checkbox";
> = {false};
