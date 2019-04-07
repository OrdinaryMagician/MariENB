/*
	menbprepasssettings.fx : MariENB prepass user-tweakable variables.
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
float cutoff
<
	string UIName = "Depth Cutoff";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1000000.0;
> = {999949.0};
float zNear
<
	string UIName = "Near Z";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.05};
float zFar
<
	string UIName = "Far Z";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {3098.0};
string str_dist = "Heat Distortion";
float distcha
<
	string UIName = "Distortion Chromatic Aberration";
	string UIWidget = "Spinner";
> = {10.0};
bool heatenable
<
	string UIName = "Enable Hot Air Refraction";
	string UIWidget = "Checkbox";
> = {false};
float heatsize
<
	string UIName = "Heat Texture Size";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {3.5};
float heatspeed
<
	string UIName = "Heat Speed";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.5};
float heatfadepow
<
	string UIName = "Heat Fade Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {200.0};
float heatfademul
<
	string UIName = "Heat Fade Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float heatfadebump
<
	string UIName = "Heat Fade Offset";
	string UIWidget = "Spinner";
> = {0.0};
float heatstrength
<
	string UIName = "Heat Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
float heatpow
<
	string UIName = "Heat Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.2};
float heatfactor_n
<
	string UIName = "Heat Factor Night";
	string UIWidget = "Spinner";
> = {1.0};
float heatfactor_d
<
	string UIName = "Heat Factor Day";
	string UIWidget = "Spinner";
> = {1.0};
float heatfactor_in
<
	string UIName = "Heat Factor Interior Night";
	string UIWidget = "Spinner";
> = {1.0};
float heatfactor_id
<
	string UIName = "Heat Factor Interior Day";
	string UIWidget = "Spinner";
> = {1.0};
bool heatalways
<
	string UIName = "Heat Always Enable";
	string UIWidget = "Checkbox";
> = {false};
/* use "edge vision" filter */
string str_view = "Edgevision";
bool edgevenable
<
	string UIName = "Enable Edgevision";
	string UIWidget = "Checkbox";
> = {false};
/* factors */
float edgevfadepow_n
<
	string UIName = "Edgevision Fade Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float edgevfadepow_d
<
	string UIName = "Edgevision Fade Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float edgevfadepow_in
<
	string UIName = "Edgevision Fade Contrast Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float edgevfadepow_id
<
	string UIName = "Edgevision Fade Contrast Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float edgevfademult_n
<
	string UIName = "Edgevision Fade Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float edgevfademult_d
<
	string UIName = "Edgevision Fade Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float edgevfademult_in
<
	string UIName = "Edgevision Fade Intensity Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float edgevfademult_id
<
	string UIName = "Edgevision Fade Intensity Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float edgevpow
<
	string UIName = "Edgevision Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
float edgevmult
<
	string UIName = "Edgevision Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
float edgevradius
<
	string UIName = "Edgevision Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
bool edgevinv
<
	string UIName = "Invert Edgevision";
	string UIWidget = "Checkbox";
> = {false};
bool edgevblend
<
	string UIName = "Blend Edgevision";
	string UIWidget = "Checkbox";
> = {false};
/* use luma edge detection filter */
string str_com = "Edge Detect";
bool comenable
<
	string UIName = "Enable Edge Detect";
	string UIWidget = "Checkbox";
> = {false};
float compow
<
	string UIName = "Edge Detect Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float commult
<
	string UIName = "Edge Detect Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float comradius
<
	string UIName = "Edge Detect Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
bool cominv
<
	string UIName = "Invert Edge Detect";
	string UIWidget = "Checkbox";
> = {false};
bool comblend
<
	string UIName = "Blend Edge Detect";
	string UIWidget = "Checkbox";
> = {false};
/* use edge threshold filter aka "linevision" */
string str_cont = "Linevision";
bool contenable
<
	string UIName = "Enable Linevision";
	string UIWidget = "Checkbox";
> = {false};
/* factors */
float contfadepow_n
<
	string UIName = "Linevision Fade Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float contfadepow_d
<
	string UIName = "Linevision Fade Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float contfadepow_in
<
	string UIName = "Linevision Fade Contrast Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float contfadepow_id
<
	string UIName = "Linevision Fade Contrast Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float contfademult_n
<
	string UIName = "Linevision Fade Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float contfademult_d
<
	string UIName = "Linevision Fade Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float contfademult_in
<
	string UIName = "Linevision Fade Intensity Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float contfademult_id
<
	string UIName = "Linevision Fade Intensity Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float contpow
<
	string UIName = "Linevision Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float contmult
<
	string UIName = "Linevision Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float contradius
<
	string UIName = "Linevision Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float contthreshold
<
	string UIName = "Linevision Threshold";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.05};
bool continv
<
	string UIName = "Invert Linevision";
	string UIWidget = "Checkbox";
> = {false};
bool contblend
<
	string UIName = "Blend Linevision";
	string UIWidget = "Checkbox";
> = {false};
/* fog filter */
string str_fog = "Custom Fog Filter";
bool fogenable
<
	string UIName = "Enable Custom Fog";
	string UIWidget = "Checkbox";
> = {false};
float fogpow
<
	string UIName = "Fog Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fogmult
<
	string UIName = "Fog Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fogbump
<
	string UIName = "Fog Shift";
	string UIWidget = "Spinner";
> = {0.0};
float3 fogcolor
<
	string UIName = "Fog Color";
	string UIWidget = "Spinner";
> = {1.0,1.0,1.0};
bool foglimbo
<
	string UIName = "Limbo Mode";
	string UIWidget = "Checkbox";
> = {false};
/* ssao filter */
string str_ssao = "Ray Marching SSAO";
bool ssaoenable
<
	string UIName = "Enable SSAO";
	string UIWidget = "Checkbox";
> = {false};
float ssaoradius
<
	string UIName = "SSAO Radius";
	string UIWidget = "Spinner";
> = {1.0};
int ssaonoise
<
	string UIName = "SSAO Noise";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 1;
> = {1};
float ssaofadepow_n
<
	string UIName = "SSAO Fade Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.05};
float ssaofadepow_d
<
	string UIName = "SSAO Fade Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.05};
float ssaofadepow_in
<
	string UIName = "SSAO Fade Contrast Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.05};
float ssaofadepow_id
<
	string UIName = "SSAO Fade Contrast Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.05};
float ssaofademult_n
<
	string UIName = "SSAO Fade Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float ssaofademult_d
<
	string UIName = "SSAO Fade Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float ssaofademult_in
<
	string UIName = "SSAO Fade Intensity Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float ssaofademult_id
<
	string UIName = "SSAO Fade Intensity Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float ssaomult
<
	string UIName = "SSAO Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float ssaopow
<
	string UIName = "SSAO Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.5};
float ssaobump
<
	string UIName = "SSAO Shift";
	string UIWidget = "Spinner";
> = {0.0};
float ssaoblend
<
	string UIName = "SSAO Blending";
	string UIWidget = "Spinner";
> = {1.0};
bool ssaobenable
<
	string UIName = "SSAO Blur";
	string UIWidget = "Checkbox";
> = {true};
float ssaobfact
<
	string UIName = "SSAO Bilateral Factor";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float ssaoclamp
<
	string UIName = "SSAO Range";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float ssaoclampmin
<
	string UIName = "SSAO Range Min";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float ssaobradius
<
	string UIName = "SSAO Blur Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
bool ssaodebug
<
	string UIName = "Debug SSAO";
	string UIWidget = "Checkbox";
> = {false};
/* luma sharpen because of reasons */
string str_sharp = "Luma Sharpen";
bool sharpenable
<
	string UIName = "Sharpen Enable";
	string UIWidget = "Checkbox";
> = {false};
float sharpradius
<
	string UIName = "Sharpen Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.8};
float sharpclamp
<
	string UIName = "Sharpen Clamp";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.02};
float sharpblend
<
	string UIName = "Sharpen Blending";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.2};
/* depth-based colour grading suite */
string str_grade = "Depth Color Grading Suite";
float dgradedfoc
<
	string UIName = "Depth Grading Center Depth";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1000.0;
> = {500.0};
float dgradedpow_n
<
	string UIName = "Depth Grading Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradedpow_d
<
	string UIName = "Depth Grading Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradedpow_in
<
	string UIName = "Depth Grading Contrast Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradedpow_id
<
	string UIName = "Depth Grading Contrast Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradedmul_n
<
	string UIName = "Depth Grading Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradedmul_d
<
	string UIName = "Depth Grading Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradedmul_in
<
	string UIName = "Depth Grading Intensity Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradedmul_id
<
	string UIName = "Depth Grading Intensity Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradedbump_n
<
	string UIName = "Depth Grading Shift Night";
	string UIWidget = "Spinner";
> = {0.0};
float dgradedbump_d
<
	string UIName = "Depth Grading Shift Day";
	string UIWidget = "Spinner";
> = {0.0};
float dgradedbump_in
<
	string UIName = "Depth Grading Shift Interior Night";
	string UIWidget = "Spinner";
> = {0.0};
float dgradedbump_id
<
	string UIName = "Depth Grading Shift Interior Day";
	string UIWidget = "Spinner";
> = {0.0};
float dgradedblend_n
<
	string UIName = "Depth Grading Blend Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float dgradedblend_d
<
	string UIName = "Depth Grading Blend Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float dgradedblend_in
<
	string UIName = "Depth Grading Blend Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float dgradedblend_id
<
	string UIName = "Depth Grading Blend Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
bool dgradeenable1
<
	string UIName = "Enable RGB Grading";
	string UIWidget = "Checkbox";
> = {false};
/* color component multipliers */
float dgrademul_r_n
<
	string UIName = "Grading Intensity Night Red";
	string UIWidget = "Spinner";
> = {1.0};
float dgrademul_g_n
<
	string UIName = "Grading Intensity Night Green";
	string UIWidget = "Spinner";
> = {1.0};
float dgrademul_b_n
<
	string UIName = "Grading Intensity Night Blue";
	string UIWidget = "Spinner";
> = {1.0};
float dgrademul_r_d
<
	string UIName = "Grading Intensity Day Red";
	string UIWidget = "Spinner";
> = {1.0};
float dgrademul_g_d
<
	string UIName = "Grading Intensity Day Green";
	string UIWidget = "Spinner";
> = {1.0};
float dgrademul_b_d
<
	string UIName = "Grading Intensity Day Blue";
	string UIWidget = "Spinner";
> = {1.0};
float dgrademul_r_in
<
	string UIName = "Grading Intensity Interior Night Red";
	string UIWidget = "Spinner";
> = {1.0};
float dgrademul_g_in
<
	string UIName = "Grading Intensity Interior Night Green";
	string UIWidget = "Spinner";
> = {1.0};
float dgrademul_b_in
<
	string UIName = "Grading Intensity Interior Night Blue";
	string UIWidget = "Spinner";
> = {1.0};
float dgrademul_r_id
<
	string UIName = "Grading Intensity Interior Day Red";
	string UIWidget = "Spinner";
> = {1.0};
float dgrademul_g_id
<
	string UIName = "Grading Intensity Interior Day Green";
	string UIWidget = "Spinner";
> = {1.0};
float dgrademul_b_id
<
	string UIName = "Grading Intensity Interior Day Blue";
	string UIWidget = "Spinner";
> = {1.0};
/* color component contrasts */
float dgradepow_r_n
<
	string UIName = "Grading Contrast Night Red";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradepow_g_n
<
	string UIName = "Grading Contrast Night Green";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradepow_b_n
<
	string UIName = "Grading Contrast Night Blue";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradepow_r_d
<
	string UIName = "Grading Contrast Day Red";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradepow_g_d
<
	string UIName = "Grading Contrast Day Green";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradepow_b_d
<
	string UIName = "Grading Contrast Day Blue";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradepow_r_in
<
	string UIName = "Grading Contrast Interior Night Red";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradepow_g_in
<
	string UIName = "Grading Contrast Interior Night Green";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradepow_b_in
<
	string UIName = "Grading Contrast Interior Night Blue";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradepow_r_id
<
	string UIName = "Grading Contrast Interior Day Red";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradepow_g_id
<
	string UIName = "Grading Contrast Interior Day Green";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradepow_b_id
<
	string UIName = "Grading Contrast Interior Day Blue";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* colorization factors */
bool dgradeenable2
<
	string UIName = "Enable Vibrance Grading";
	string UIWidget = "Checkbox";
> = {false};
float dgradecol_r_n
<
	string UIName = "Grading Color Night Red";
	string UIWidget = "Spinner";
> = {1.0};
float dgradecol_g_n
<
	string UIName = "Grading Color Night Green";
	string UIWidget = "Spinner";
> = {1.0};
float dgradecol_b_n
<
	string UIName = "Grading Color Night Blue";
	string UIWidget = "Spinner";
> = {1.0};
float dgradecol_r_d
<
	string UIName = "Grading Color Day Red";
	string UIWidget = "Spinner";
> = {1.0};
float dgradecol_g_d
<
	string UIName = "Grading Color Day Green";
	string UIWidget = "Spinner";
> = {1.0};
float dgradecol_b_d
<
	string UIName = "Grading Color Day Blue";
	string UIWidget = "Spinner";
> = {1.0};
float dgradecol_r_in
<
	string UIName = "Grading Color Interior Night Red";
	string UIWidget = "Spinner";
> = {1.0};
float dgradecol_g_in
<
	string UIName = "Grading Color Interior Night Green";
	string UIWidget = "Spinner";
> = {1.0};
float dgradecol_b_in
<
	string UIName = "Grading Color Interior Night Blue";
	string UIWidget = "Spinner";
> = {1.0};
float dgradecol_r_id
<
	string UIName = "Grading Color Interior Day Red";
	string UIWidget = "Spinner";
> = {1.0};
float dgradecol_g_id
<
	string UIName = "Grading Color Interior Day Green";
	string UIWidget = "Spinner";
> = {1.0};
float dgradecol_b_id
<
	string UIName = "Grading Color Interior Day Blue";
	string UIWidget = "Spinner";
> = {1.0};
/* blend factor for colorization (negative values are quite fancy) */
float dgradecolfact_n
<
	string UIName = "Grading Color Factor Night";
	string UIWidget = "Spinner";
> = {0.0};
float dgradecolfact_d
<
	string UIName = "Grading Color Factor Day";
	string UIWidget = "Spinner";
> = {0.0};
float dgradecolfact_in
<
	string UIName = "Grading Color Factor Interior Night";
	string UIWidget = "Spinner";
> = {0.0};
float dgradecolfact_id
<
	string UIName = "Grading Color Factor Interior Day";
	string UIWidget = "Spinner";
> = {0.0};
/* HSV grading */
bool dgradeenable3
<
	string UIName = "Enable HSV Grading";
	string UIWidget = "Checkbox";
> = {false};
/* saturation multiplier */
float dgradesatmul_n
<
	string UIName = "Grading Saturation Intensity Night";
	string UIWidget = "Spinner";
> = {1.0};
float dgradesatmul_d
<
	string UIName = "Grading Saturation Intensity Day";
	string UIWidget = "Spinner";
> = {1.0};
float dgradesatmul_in
<
	string UIName = "Grading Saturation Intensity Interior Night";
	string UIWidget = "Spinner";
> = {1.0};
float dgradesatmul_id
<
	string UIName = "Grading Saturation Intensity Interior Day";
	string UIWidget = "Spinner";
> = {1.0};
/* saturation power */
float dgradesatpow_n
<
	string UIName = "Grading Saturation Contrast Night";
	string UIWidget = "Spinner";
> = {1.0};
float dgradesatpow_d
<
	string UIName = "Grading Saturation Contrast Day";
	string UIWidget = "Spinner";
> = {1.0};
float dgradesatpow_in
<
	string UIName = "Grading Saturation Contrast Interior Night";
	string UIWidget = "Spinner";
> = {1.0};
float dgradesatpow_id
<
	string UIName = "Grading Saturation Contrast Interior Day";
	string UIWidget = "Spinner";
> = {1.0};
/* value multiplier */
float dgradevalmul_n
<
	string UIName = "Grading Value Intensity Night";
	string UIWidget = "Spinner";
> = {1.0};
float dgradevalmul_d
<
	string UIName = "Grading Value Intensity Day";
	string UIWidget = "Spinner";
> = {1.0};
float dgradevalmul_in
<
	string UIName = "Grading Value Intensity Interior Night";
	string UIWidget = "Spinner";
> = {1.0};
float dgradevalmul_id
<
	string UIName = "Grading Value Intensity Interior Day";
	string UIWidget = "Spinner";
> = {1.0};
/* value power */
float dgradevalpow_n
<
	string UIName = "Grading Value Contrast Night";
	string UIWidget = "Spinner";
> = {1.0};
float dgradevalpow_d
<
	string UIName = "Grading Value Contrast Day";
	string UIWidget = "Spinner";
> = {1.0};
float dgradevalpow_in
<
	string UIName = "Grading Value Contrast Interior Night";
	string UIWidget = "Spinner";
> = {1.0};
float dgradevalpow_id
<
	string UIName = "Grading Value Contrast Interior Day";
	string UIWidget = "Spinner";
> = {1.0};
bool dcolorizeafterhsv
<
	string UIName = "Colorize After HSV";
	string UIWidget = "Checkbox";
> = {true};
