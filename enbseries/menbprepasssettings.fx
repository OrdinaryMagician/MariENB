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
string str_dist = "Distortion Filters";
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
float heatfactor_i
<
	string UIName = "Heat Factor Interior";
	string UIWidget = "Spinner";
> = {1.0};
string str_focus = "Focusing Parameters";
/*
   focus modes:
   -1 : manual
    0 : center spot
    1 : center + triangle
    2 : 8x8 grid average
    TODO
    3 : 8x8 grid average of 8 closest points
    4 : 8x8 grid average of 8 farthest points
*/
int focuscircle
<
	string UIName = "Focus Mode";
	string UIWidget = "Checkbox";
	int UIMin = -1;
	int UIMax = 2;
> = {1};
bool focusdisplay
<
	string UIName = "Display Focus Points";
	string UIWidget = "Checkbox";
> = {false};
float focusmanualvalue
<
	string UIName = "Manual Focus Depth";
	string UIWidget = "Checkbox";
	float UIMin = 0.0;
	float UIMax = 1000.0;
> = {500.0};
/* center point of focus */
float focuscenter_x
<
	string UIName = "Focus Point Center X";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 100.0;
> = {50.0};
float focuscenter_y
<
	string UIName = "Focus Point Center Y";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 100.0;
> = {50.0};
float focuscircleangle
<
	string UIName = "Focus Triangle Angle";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
/* radius of the focus point triangle */
float focusradius_n
<
	string UIName = "Focus Triangle Radius Night";
	string UIWidget = "Spinner";
> = {20.0};
float focusradius_d
<
	string UIName = "Focus Triangle Radius Day";
	string UIWidget = "Spinner";
> = {20.0};
float focusradius_i
<
	string UIName = "Focus Triangle Radius Interior";
	string UIWidget = "Spinner";
> = {20.0};
/* mix factor with sample at screen center */
float focusmix_n
<
	string UIName = "Focus Triangle Blending Night";
	string UIWidget = "Spinner";
> = {0.5};
float focusmix_d
<
	string UIName = "Focus Triangle Blending Day";
	string UIWidget = "Spinner";
> = {0.5};
float focusmix_i
<
	string UIName = "Focus Triangle Blending Interior";
	string UIWidget = "Spinner";
> = {0.5};
/* maximum focus depth */
float focusmax_n
<
	string UIName = "Focus Maximum Depth Night";
	string UIWidget = "Spinner";
> = {1000.0};
float focusmax_d
<
	string UIName = "Focus Maximum Depth Day";
	string UIWidget = "Spinner";
> = {1000.0};
float focusmax_i
<
	string UIName = "Focus Maximum Depth Interior";
	string UIWidget = "Spinner";
> = {1000.0};
/* dof filter */
string str_dof = "Depth Of Field";
/* dof multiplier (makes unfocused depths more blurry) */
float dofmult_n
<
	string UIName = "DOF Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float dofmult_d
<
	string UIName = "DOF Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float dofmult_i
<
	string UIName = "DOF Intensity Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
/* dof power (the higher it is, the wider the focused area gets) */
float dofpow_n
<
	string UIName = "DOF Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
float dofpow_d
<
	string UIName = "DOF Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
float dofpow_i
<
	string UIName = "DOF Contrast Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
/* dof bump (negative shift increases the area in complete focus) */
float dofbump_n
<
	string UIName = "DOF Shift Night";
	string UIWidget = "Spinner";
> = {0.0};
float dofbump_d
<
	string UIName = "DOF Shift Day";
	string UIWidget = "Spinner";
> = {0.0};
float dofbump_i
<
	string UIName = "DOF Shift Interior";
	string UIWidget = "Spinner";
> = {0.0};
/* fixed focused depth factors */
float doffixedfocusmult_n
<
	string UIName = "DOF Fixed Focus Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocusmult_d
<
	string UIName = "DOF Fixed Focus Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocusmult_i
<
	string UIName = "DOF Fixed Focus Intensity Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocuspow_n
<
	string UIName = "DOF Fixed Focus Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocuspow_d
<
	string UIName = "DOF Fixed Focus Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocuspow_i
<
	string UIName = "DOF Fixed Focus Contrast Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocusbump_n
<
	string UIName = "DOF Fixed Focus Shift Night";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedfocusbump_d
<
	string UIName = "DOF Fixed Focus Shift Day";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedfocusbump_i
<
	string UIName = "DOF Fixed Focus Shift Interior";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedfocusblend_n
<
	string UIName = "DOF Fixed Focus Blend Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedfocusblend_d
<
	string UIName = "DOF Fixed Focus Blend Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedfocusblend_i
<
	string UIName = "DOF Fixed Focus Blend Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedfocusdepth
<
	string UIName = "DOF Fixed Focus Depth";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
float doffixedfocuscap
<
	string UIName = "DOF Fixed Focus Cap";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
/* fixed unfocused depth factors */
float doffixedunfocusmult_n
<
	string UIName = "DOF Fixed Unfocus Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float doffixedunfocusmult_d
<
	string UIName = "DOF Fixed Unfocus Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float doffixedunfocusmult_i
<
	string UIName = "DOF Fixed Unfocus Intensity Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float doffixedunfocuspow_n
<
	string UIName = "DOF Fixed Unfocus Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float doffixedunfocuspow_d
<
	string UIName = "DOF Fixed Unfocus Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float doffixedunfocuspow_i
<
	string UIName = "DOF Fixed Unfocus Contrast Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float doffixedunfocusbump_n
<
	string UIName = "DOF Fixed Unfocus Shift Night";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedunfocusbump_d
<
	string UIName = "DOF Fixed Unfocus Shift Day";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedunfocusbump_i
<
	string UIName = "DOF Fixed Unfocus Shift Interior";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedunfocusblend_n
<
	string UIName = "DOF Fixed Unfocus Blend Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedunfocusblend_d
<
	string UIName = "DOF Fixed Unfocus Blend Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedunfocusblend_i
<
	string UIName = "DOF Fixed Unfocus Blend Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedunfocusdepth
<
	string UIName = "DOF Fixed Unfocus Depth";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
/* prevents fixed dof from blurring the skybox */
bool doffixedcut
<
	string UIName = "DOF Fixed Use Cutoff";
	string UIWidget = "Checkbox";
> = {true};
/* disable depth of field */
bool dofdisable
<
	string UIName = "Disable DOF";
	string UIWidget = "Checkbox";
> = {false};
bool doffixedonly
<
	string UIName = "Use Only Fixed DOF";
	string UIWidget = "Checkbox";
> = {false};
float dofpradius
<
	string UIName = "DOF Gather Blur Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {6.0};
float dofpbradius
<
	string UIName = "DOF Post-Blur Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dofpcha
<
	string UIName = "DOF Blur Chromatic Aberration";
	string UIWidget = "Spinner";
> = {0.0};
float dofbthreshold
<
	string UIName = "DOF Highlight Threshold";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float dofbgain
<
	string UIName = "DOF Highlight Gain";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float dofbradius
<
	string UIName = "DOF Bokeh Blur Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dofbbias
<
	string UIName = "DOF Bokeh Edge Bias";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float dofbnoise
<
	string UIName = "DOF Bokeh Fuzz";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.01};
/* tilting */
float doftiltxcenter
<
	string UIName = "Focus Plane Horizontal Tilt Center";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};
float doftiltycenter
<
	string UIName = "Focus Plane Vertical Tilt Center";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};
float doftiltx
<
	string UIName = "Focus Plane Horizontal Tilt";
	string UIWidget = "Spinner";
> = {0.0};
float doftilty
<
	string UIName = "Focus Plane Vertical Tilt";
	string UIWidget = "Spinner";
> = {0.0};
/* cheap performance option */
float dofminblur
<
	string UIName = "DOF Minimum Blur";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
bool dofdebug
<
	string UIName = "Debug Depth";
	string UIWidget = "Checkbox";
> = {false};
bool dfcdebug
<
	string UIName = "Debug Focus";
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
float edgevfadepow_i
<
	string UIName = "Edgevision Fade Contrast Interior";
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
float edgevfademult_i
<
	string UIName = "Edgevision Fade Intensity Interior";
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
float contfadepow_i
<
	string UIName = "Linevision Fade Contrast Interior";
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
float contfademult_i
<
	string UIName = "Linevision Fade Intensity Interior";
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
float dgradedpow_i
<
	string UIName = "Depth Grading Contrast Interior";
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
float dgradedmul_i
<
	string UIName = "Depth Grading Intensity Interior";
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
float dgradedbump_i
<
	string UIName = "Depth Grading Shift Interior";
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
float dgradedblend_i
<
	string UIName = "Depth Grading Blend Interior";
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
float dgrademul_r_i
<
	string UIName = "Grading Intensity Interior Red";
	string UIWidget = "Spinner";
> = {1.0};
float dgrademul_g_i
<
	string UIName = "Grading Intensity Interior Green";
	string UIWidget = "Spinner";
> = {1.0};
float dgrademul_b_i
<
	string UIName = "Grading Intensity Interior Blue";
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
float dgradepow_r_i
<
	string UIName = "Grading Contrast Interior Red";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradepow_g_i
<
	string UIName = "Grading Contrast Interior Green";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dgradepow_b_i
<
	string UIName = "Grading Contrast Interior Blue";
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
float dgradecol_r_i
<
	string UIName = "Grading Color Interior Red";
	string UIWidget = "Spinner";
> = {1.0};
float dgradecol_g_i
<
	string UIName = "Grading Color Interior Green";
	string UIWidget = "Spinner";
> = {1.0};
float dgradecol_b_i
<
	string UIName = "Grading Color Interior Blue";
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
float dgradecolfact_i
<
	string UIName = "Grading Color Factor Interior";
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
float dgradesatmul_i
<
	string UIName = "Grading Saturation Intensity Interior";
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
float dgradesatpow_i
<
	string UIName = "Grading Saturation Contrast Interior";
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
float dgradevalmul_i
<
	string UIName = "Grading Value Intensity Interior";
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
float dgradevalpow_i
<
	string UIName = "Grading Value Contrast Interior";
	string UIWidget = "Spinner";
> = {1.0};
bool dcolorizeafterhsv
<
	string UIName = "Colorize After HSV";
	string UIWidget = "Checkbox";
> = {true};