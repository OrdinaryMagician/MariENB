/*
	enbdepthoffield.fx : MariENB3 prepass shaders.
	(C)2016-2017 Marisa Kirisame, UnSX Team.
	Part of MariENB3, the personal ENB of Marisa for Fallout 4.
	Released under the GNU GPLv3 (or later).
*/
#include "menbglobaldefs.fx"

string str_misc = "Miscellaneous";
/* fixed resolution, keeps blur filters at a consistent internal resolution */
int2 fixed
<
	string UIName = "Fixed Resolution";
	string UIWidget = "Vector";
	int2 UIMin = {0,0};
> = {1920,1080};
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
float heatfactor_dw
<
	string UIName = "Heat Factor Dawn";
	string UIWidget = "Spinner";
> = {0.2};
float heatfactor_sr
<
	string UIName = "Heat Factor Sunrise";
	string UIWidget = "Spinner";
> = {0.5};
float heatfactor_dy
<
	string UIName = "Heat Factor Day";
	string UIWidget = "Spinner";
> = {1.0};
float heatfactor_ss
<
	string UIName = "Heat Factor Sunset";
	string UIWidget = "Spinner";
> = {0.7};
float heatfactor_ds
<
	string UIName = "Heat Factor Dusk";
	string UIWidget = "Spinner";
> = {0.1};
float heatfactor_nt
<
	string UIName = "Heat Factor Night";
	string UIWidget = "Spinner";
> = {0.0};
float heatfactor_i
<
	string UIName = "Heat Factor Interior";
	string UIWidget = "Spinner";
> = {0.0};
string str_focus = "Focusing Parameters";
/*
   focus modes:
   -2 : mouse
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
	int UIMin = -2;
	int UIMax = 2;
> = {1};
bool focusdisplay
<
	string UIName = "Display Focus Points";
	string UIWidget = "Checkbox";
> = {false};
bool focusmanual
<
	string UIName = "Enable Manual Focus";
	string UIWidget = "Checkbox";
> = {false};
float focusmanualvalue
<
	string UIName = "Manual Focus Depth";
	string UIWidget = "Checkbox";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};
/* center point of focus */
float2 focuscenter
<
	string UIName = "Focus Point Center";
	string UIWidget = "Vector";
	float2 UIMin = {0.0,0.0};
	float2 UIMax = {1.0,1.0};
> = {0.5,0.5};
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
float focuscenterdiscard
<
	string UIName = "Focus Circle Discard Center Depth";
	string UIWidget = "Spinner";
> = {0.0};
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
/* dof power (falloff, kinda) */
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
/* dof bump (negative values are useful for "widening" the focused area) */
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
	float UIMax = 1.0;
> = {0.0};
float doffixedfocusblend_d
<
	string UIName = "DOF Fixed Focus Blend Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
float doffixedfocusblend_i
<
	string UIName = "DOF Fixed Focus Blend Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
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
	float UIMax = 1.0;
> = {0.0};
float doffixedunfocusblend_d
<
	string UIName = "DOF Fixed Unfocus Blend Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
float doffixedunfocusblend_i
<
	string UIName = "DOF Fixed Unfocus Blend Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
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
bool dofpostblur
<
	string UIName = "Enable DOF Post-Blur";
	string UIWidget = "Checkbox";
> = {true};
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
bool dofhilite
<
	string UIName = "Enable DOF Highlights";
	string UIWidget = "Checkbox";
> = {false};
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
float ssaofadepow_i
<
	string UIName = "SSAO Fade Contrast Interior";
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
float ssaofademult_i
<
	string UIName = "SSAO Fade Intensity Interior";
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
/* depth-based colour grading suite */
string str_grade = "Depth Color Grading Suite";
float dgradedfoc
<
	string UIName = "Depth Grading Center Depth";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
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
float3 dgrademul_n
<
	string UIName = "Grading Intensity Night";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
float3 dgrademul_d
<
	string UIName = "Grading Intensity Day";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
float3 dgrademul_i
<
	string UIName = "Grading Intensity Interior";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
/* color component contrasts */
float3 dgradepow_n
<
	string UIName = "Grading Contrast Night";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
float3 dgradepow_d
<
	string UIName = "Grading Contrast Day";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
float3 dgradepow_i
<
	string UIName = "Grading Contrast Interior";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
/* colorization factors */
bool dgradeenable2
<
	string UIName = "Enable Vibrance Grading";
	string UIWidget = "Checkbox";
> = {false};
float3 dgradecol_n
<
	string UIName = "Grading Color Night";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
float3 dgradecol_d
<
	string UIName = "Grading Color Day";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
float3 dgradecol_i
<
	string UIName = "Grading Color Interior";
	string UIWidget = "Vector";
> = {1.0,1.0,1.0};
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

/* mathematical constants */
static const float pi = 3.1415926535898;

/* edge detect factors */
static const float3x3 GX =
{
	-1, 0, 1,
	-2, 0, 2,
	-1, 0, 1
};
static const float3x3 GY =
{
	 1, 2, 1,
	 0, 0, 0,
	-1,-2,-1
};
/* radius: 8, std dev: 3 */
static const float gauss8[8] =
{
	0.134598, 0.127325, 0.107778, 0.081638,
	0.055335, 0.033562, 0.018216, 0.008847
};
/* radius: 16, std dev: 13 */
static const float gauss16[16] =
{
	0.040012, 0.039893, 0.039541, 0.038960,
	0.038162, 0.037159, 0.035969, 0.034612,
	0.033109, 0.031485, 0.029764, 0.027971,
	0.026131, 0.024268, 0.022405, 0.020563
};
/* SSAO samples */
static const float3 ssao_samples[64] = 
{
	float3(-0.0051, 0.0021, 0.0146),float3(-0.0197,-0.0213,-0.0116),
	float3( 0.0005,-0.0432,-0.0182),float3(-0.0011,-0.0586,-0.0217),
	float3(-0.0549, 0.0461, 0.0309),float3(-0.0448,-0.0764,-0.0306),
	float3(-0.0366, 0.0758,-0.0699),float3(-0.0770,-0.0707,-0.0686),
	float3( 0.1181,-0.0340,-0.0683),float3(-0.0647, 0.0356, 0.1377),
	float3(-0.1167, 0.1262, 0.0024),float3(-0.1353,-0.0861, 0.0971),
	float3(-0.0096, 0.0936, 0.1800),float3( 0.1311,-0.1013,-0.1429),
	float3(-0.1186,-0.0653, 0.1913),float3( 0.1641, 0.0260, 0.1868),
	float3(-0.1225,-0.2319, 0.0424),float3( 0.1036,-0.2000, 0.1684),
	float3( 0.1656, 0.2022,-0.1408),float3(-0.1809,-0.1673, 0.1922),
	float3(-0.2485,-0.1236, 0.1750),float3( 0.1030,-0.0550, 0.3233),
	float3(-0.0405, 0.3068, 0.1827),float3(-0.0576, 0.1632, 0.3327),
	float3( 0.0392, 0.3583,-0.1505),float3( 0.0082, 0.2865, 0.2879),
	float3( 0.0055,-0.2835, 0.3124),float3(-0.2733, 0.1991,-0.2776),
	float3( 0.2667, 0.1127,-0.3486),float3(-0.3326, 0.2740,-0.1844),
	float3( 0.2887,-0.3838, 0.0630),float3( 0.1088, 0.1546, 0.4629),
	float3( 0.0977,-0.3565, 0.3595),float3(-0.4204, 0.0855, 0.3133),
	float3(-0.2237,-0.4932, 0.0759),float3( 0.4245, 0.3169,-0.1891),
	float3( 0.0084,-0.5682, 0.1062),float3(-0.1489,-0.5296,-0.2235),
	float3( 0.0014,-0.4153,-0.4460),float3( 0.0300,-0.4392, 0.4437),
	float3( 0.2627, 0.4518, 0.3704),float3(-0.4945, 0.3659, 0.2285),
	float3(-0.2550,-0.5311, 0.3230),float3(-0.4477, 0.0828,-0.5151),
	float3( 0.4682, 0.4531,-0.2644),float3(-0.1235,-0.0366, 0.7071),
	float3( 0.3545, 0.4559, 0.4536),float3(-0.1037,-0.2199,-0.7095),
	float3( 0.4269, 0.5299,-0.3510),float3( 0.7051,-0.1468,-0.3027),
	float3( 0.4590,-0.5669,-0.3208),float3( 0.2330, 0.1264, 0.7680),
	float3(-0.3954, 0.5619,-0.4622),float3( 0.5977,-0.5110, 0.3059),
	float3(-0.5800,-0.6306, 0.0672),float3(-0.2211,-0.0332,-0.8460),
	float3(-0.3808,-0.2238,-0.7734),float3(-0.5616, 0.6858,-0.1887),
	float3(-0.2995, 0.5165,-0.7024),float3( 0.5042,-0.0537, 0.7885),
	float3(-0.6477,-0.3691, 0.5938),float3(-0.3969, 0.8815, 0.0620),
	float3(-0.4300,-0.8814,-0.0852),float3(-0.1683, 0.9379, 0.3033)
};
/* For low quality DOF */
static const float2 poisson32[32] =
{
	float2( 0.7284430,-0.1927130),float2( 0.4051600,-0.2312710),
	float2( 0.9535280, 0.0669683),float2( 0.6544140,-0.4439470),
	float2( 0.6029910, 0.1058970),float2( 0.2637500,-0.7163810),
	float2( 0.9105380,-0.3889810),float2( 0.5942730,-0.7400740),
	float2( 0.8215680, 0.3162520),float2( 0.3577550, 0.4884250),
	float2( 0.6935990, 0.7070140),float2( 0.0470570, 0.1961800),
	float2(-0.0977021, 0.6241300),float2( 0.2110300, 0.8778350),
	float2(-0.3743440, 0.2494580),float2( 0.0144776,-0.0766484),
	float2(-0.3377660,-0.1255100),float2( 0.3136420, 0.1077710),
	float2(-0.5204340, 0.8369860),float2(-0.1182680, 0.9801750),
	float2(-0.6969480,-0.3869330),float2(-0.6156080, 0.0307209),
	float2(-0.3806790,-0.6055360),float2(-0.1909570,-0.3861330),
	float2(-0.2449080,-0.8655030),float2( 0.0822108,-0.4975580),
	float2(-0.5649250, 0.5756740),float2(-0.8741830,-0.1685750),
	float2( 0.0761715,-0.9631760),float2(-0.9218270, 0.2121210),
	float2(-0.6378530, 0.3053550),float2(-0.8425180, 0.4753000)
};

float4 Timer;
float4 ScreenSize;
float4 Weather;
float ENightDayFactor;
float EInteriorFactor;
float4 TimeOfDay1;
float4 TimeOfDay2;
float4 DofParameters;
float4 tempInfo2;

Texture2D TextureCurrent;
Texture2D TexturePrevious;
Texture2D TextureOriginal;
Texture2D TextureColor;
Texture2D TextureDepth;
Texture2D TextureFocus;

Texture2D RenderTargetR16F; /* for SSAO */
Texture2D RenderTargetR32F; /* for DOF */

Texture2D TextureNoise3
<
	string ResourceName = "menbnoise3.png";
>;
Texture2D TextureHeat
<
#ifdef HEAT_DDS
	string ResourceName = "menbheat.dds";
#else
	string ResourceName = "menbheat.png";
#endif
>;

SamplerState Sampler0
{
	Filter = MIN_MAG_MIP_POINT;
	AddressU = Clamp;
	AddressV = Clamp;
};
SamplerState Sampler1
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
};
SamplerState Sampler2
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Wrap;
	AddressV = Wrap;
};

struct VS_INPUT_POST
{
	float3 pos : POSITION;
	float2 txcoord : TEXCOORD0;
};
struct VS_OUTPUT_POST
{
	float4 pos : SV_POSITION;
	float2 txcoord : TEXCOORD0;
};

VS_OUTPUT_POST VS_Quad( VS_INPUT_POST IN )
{
	VS_OUTPUT_POST OUT;
	OUT.pos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord.xy = IN.txcoord.xy;
	return OUT;
}

/* helper functions */
/* photometric */
#define luminance(x) dot(x,float3(0.2126,0.7152,0.0722))
/* CCIR601 */
//#define luminance(x) dot(x,float3(0.299,0.587,0.114))
float3 rgb2hsv( float3 c )
{
	float4 K = float4(0.0,-1.0/3.0,2.0/3.0,-1.0);
	float4 p = (c.g<c.b)?float4(c.bg,K.wz):float4(c.gb,K.xy);
	float4 q = (c.r<p.x)?float4(p.xyw,c.r):float4(c.r,p.yzx);
	float d = q.x-min(q.w,q.y);
	float e = 1.0e-10;
	return float3(abs(q.z+(q.w-q.y)/(6.0*d+e)),d/(q.x+e),q.x);
}
float3 hsv2rgb( float3 c )
{
	float4 K = float4(1.0,2.0/3.0,1.0/3.0,3.0);
	float3 p = abs(frac(c.x+K.xyz)*6.0-K.w);
	return c.z*lerp(K.x,saturate(p-K.x),c.y);
}
float depthlinear( float2 coord )
{
	float z = TextureDepth.SampleLevel(Sampler1,coord,0).x;
	return (2*zNear)/(zFar+zNear-z*(zFar-zNear));
}

/*
   Thank you Boris for not providing access to a normal buffer. Guesswork using
   the depth buffer results in imprecise normals that aren't smoothed. Plus
   there is no way to get the normal data from textures either. Also, three
   texture fetches are needed instead of one (great!)
*/
float3 pseudonormal( float dep, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 ofs1 = float2(0,1.0/bresl.y);
	float2 ofs2 = float2(1.0/bresl.x,0);
	float dep1 = TextureDepth.SampleLevel(Sampler1,coord+ofs1,0).x;
	float dep2 = TextureDepth.SampleLevel(Sampler1,coord+ofs2,0).x;
	float3 p1 = float3(ofs1,dep1-dep);
	float3 p2 = float3(ofs2,dep2-dep);
	float3 normal = cross(p1,p2);
	normal.z = -normal.z;
	return normalize(normal);
}

/* SSAO Prepass */
float4 PS_SSAOPre( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	/* get occlusion using single-step Ray Marching with 64 samples */
	float ssaofadepow = tod_ind(ssaofadepow);
	float ssaofademult = tod_ind(ssaofademult);
	if ( !ssaoenable ) return 0.0;
	float depth = TextureDepth.Sample(Sampler1,coord).x;
	float ldepth = depthlinear(coord);
	if ( depth >= cutoff*0.000001 ) return 1.0;
	float2 bresl;
	if ( (fixed.x > 0) && (fixed.y > 0) ) bresl = fixed;
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float3 normal = pseudonormal(depth,coord);
	float2 nc = coord*(bresl/256.0);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*ssaoradius;
	float2 nc2 = TextureNoise3.SampleLevel(Sampler2,nc+48000.0*Timer.x
		*ssaonoise,0).xy;
	float3 rnormal = TextureNoise3.SampleLevel(Sampler2,nc2,0).xyz*2.0-1.0;
	rnormal = normalize(rnormal);
	float occ = 0.0;
	int i;
	float3 sample;
	float sdepth, so, delta;
	float sclamp = ssaoclamp/100000.0;
	float sclampmin = ssaoclampmin/100000.0;
	[unroll] for ( i=0; i<64; i++ )
	{
		sample = reflect(ssao_samples[i],rnormal);
		sample *= sign(dot(normal,sample));
		so = ldepth-sample.z*bof.x;
		sdepth = depthlinear(coord+bof*sample.xy/ldepth);
		delta = saturate(so-sdepth);
		delta *= 1.0-smoothstep(0.0,sclamp,delta);
		if ( (delta > sclampmin) && (delta < sclamp) )
			occ += 1.0-delta;
	}
	float uocc = saturate(occ/64.0);
	float fade = 1.0-depth;
	uocc *= saturate(pow(max(0,fade),ssaofadepow)*ssaofademult);
	uocc = saturate(pow(max(0,uocc),ssaopow)*ssaomult+ssaobump);
	return saturate(1.0-(uocc*ssaoblend));
}
/*
   The blur pass uses bilateral filtering to mostly preserve borders.
   An additional factor using difference of normals was tested, but the
   performance decrease was too much, so it's gone forever.
*/
float4 PS_SSAOBlur( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler1,coord);
	float mud = RenderTargetR16F.Sample(Sampler1,coord).x;
	if ( !ssaoenable ) return res;
	if ( !ssaobenable )
	{
		if ( ssaodebug ) return saturate(mud);
		return res*mud;
	}
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*ssaobradius;
	float isd, sd, ds, sw, tw = 0;
	mud = 0.0;
	int i, j;
	isd = TextureDepth.Sample(Sampler1,coord).x;
	[unroll] for ( j=-7; j<=7; j++ ) [unroll] for ( i=-7; i<=7; i++ )
	{
		sd = TextureDepth.Sample(Sampler1,coord+float2(i,j)*bof).x;
		ds = 1.0/pow(1.0+abs(isd-sd),ssaobfact);
		sw = ds;
		sw *= gauss8[abs(i)]*gauss8[abs(j)];
		tw += sw;
		mud += sw*RenderTargetR16F.Sample(Sampler1,coord+float2(i,j)
			*bof).x;
	}
	mud /= tw;
	if ( ssaodebug ) return saturate(mud);
	return res*mud;
}

/* precalculate DOF factors */
float4 PS_DoFPrepass( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return 0.0;
	float dofpow = tod_ind(dofpow);
	float dofmult = tod_ind(dofmult);
	float dofbump = tod_ind(dofbump);
	float doffixedfocuspow = tod_ind(doffixedfocuspow);
	float doffixedfocusmult = tod_ind(doffixedfocusmult);
	float doffixedfocusbump = tod_ind(doffixedfocusbump);
	float doffixedfocusblend = tod_ind(doffixedfocusblend);
	float doffixedunfocuspow = tod_ind(doffixedunfocuspow);
	float doffixedunfocusmult = tod_ind(doffixedunfocusmult);
	float doffixedunfocusbump = tod_ind(doffixedunfocusbump);
	float doffixedunfocusblend = tod_ind(doffixedunfocusblend);
	float dep = TextureDepth.Sample(Sampler1,coord).x;
	float foc = TextureFocus.Sample(Sampler1,coord).x;
	/* cheap tilt */
	foc = foc+0.01*doftiltx*(doftiltxcenter-coord.x)
		+0.01*doftilty*(doftiltycenter-coord.y);
	float dff = abs((dep-doffixedfocusdepth)*1.0/doffixedfocuscap);
	dff = clamp(pow(dff,doffixedfocuspow)*doffixedfocusmult
		+doffixedfocusbump,0.0,1.0);
	if ( dep > doffixedfocuscap ) dff = 1.0;
	float dfu = abs(dep-doffixedunfocusdepth);
	dfu = clamp(pow(dfu,doffixedunfocuspow)*doffixedunfocusmult
		+doffixedunfocusbump,0.0,1.0);
	if ( doffixedcut && (dep >= cutoff*0.000001) ) dfu *= 0;
	float dfc = abs(dep-foc);
	dfc = clamp(pow(dfc,dofpow)*dofmult+dofbump,0.0,1.0);
	if ( doffixedonly ) dfc *= 0;
	dfc += lerp(0.0,dfu,doffixedunfocusblend);
	dfc *= lerp(1.0,dff,doffixedfocusblend);
	return clamp(dfc,0.0,1.0);
}

/* old Edgevision mode */
float3 EdgeView( float3 res, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	if ( fixed.x>0 && fixed.y>0 ) bresl = fixed;
	float edgevfadepow = tod_ind(edgevfadepow);
	float edgevfademult = tod_ind(edgevfademult);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*edgevradius;
	float mdx = 0, mdy = 0, mud = 0;
	/* this reduces texture fetches by half, big difference */
	float3x3 depths;
	depths[0][0] = depthlinear(coord+float2(-1,-1)*bof);
	depths[0][1] = depthlinear(coord+float2( 0,-1)*bof);
	depths[0][2] = depthlinear(coord+float2( 1,-1)*bof);
	depths[1][0] = depthlinear(coord+float2(-1, 0)*bof);
	depths[1][1] = depthlinear(coord+float2( 0, 0)*bof);
	depths[1][2] = depthlinear(coord+float2( 1, 0)*bof);
	depths[2][0] = depthlinear(coord+float2(-1, 1)*bof);
	depths[2][1] = depthlinear(coord+float2( 0, 1)*bof);
	depths[2][2] = depthlinear(coord+float2( 1, 1)*bof);
	mdx += GX[0][0]*depths[0][0];
	mdx += GX[0][1]*depths[0][1];
	mdx += GX[0][2]*depths[0][2];
	mdx += GX[1][0]*depths[1][0];
	mdx += GX[1][1]*depths[1][1];
	mdx += GX[1][2]*depths[1][2];
	mdx += GX[2][0]*depths[2][0];
	mdx += GX[2][1]*depths[2][1];
	mdx += GX[2][2]*depths[2][2];
	mdy += GY[0][0]*depths[0][0];
	mdy += GY[0][1]*depths[0][1];
	mdy += GY[0][2]*depths[0][2];
	mdy += GY[1][0]*depths[1][0];
	mdy += GY[1][1]*depths[1][1];
	mdy += GY[1][2]*depths[1][2];
	mdy += GY[2][0]*depths[2][0];
	mdy += GY[2][1]*depths[2][1];
	mdy += GY[2][2]*depths[2][2];
	mud = pow(mdx*mdx+mdy*mdy,0.5);
	float fade = 1.0-TextureDepth.Sample(Sampler1,coord).x;
	mud *= clamp(pow(max(0,fade),edgevfadepow)*edgevfademult,0.0,1.0);
	mud = clamp(pow(max(0,mud),edgevpow)*edgevmult,0.0,1.0);
	if ( edgevblend ) return res-(edgevinv?1.0-mud:mud);
	return edgevinv?1.0-mud:mud;
}

/* luminance edge detection */
float3 EdgeDetect( float3 res, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	if ( fixed.x>0 && fixed.y>0 ) bresl = fixed;
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*comradius;
	float mdx = 0, mdy = 0, mud = 0;
	float3x3 lums;
	float3 col;
	col = TextureOriginal.Sample(Sampler1,coord+float2(-1,-1)*bof).rgb;
	lums[0][0] = luminance(col);
	col = TextureOriginal.Sample(Sampler1,coord+float2(0,-1)*bof).rgb;
	lums[0][1] = luminance(col);
	col = TextureOriginal.Sample(Sampler1,coord+float2(1,-1)*bof).rgb;
	lums[0][2] = luminance(col);
	col = TextureOriginal.Sample(Sampler1,coord+float2(-1,0)*bof).rgb;
	lums[1][0] = luminance(col);
	col = TextureOriginal.Sample(Sampler1,coord+float2(0,0)*bof).rgb;
	lums[1][1] = luminance(col);
	col = TextureOriginal.Sample(Sampler1,coord+float2(1,0)*bof).rgb;
	lums[1][2] = luminance(col);
	col = TextureOriginal.Sample(Sampler1,coord+float2(-1,1)*bof).rgb;
	lums[2][0] = luminance(col);
	col = TextureOriginal.Sample(Sampler1,coord+float2(0,1)*bof).rgb;
	lums[2][1] = luminance(col);
	col = TextureOriginal.Sample(Sampler1,coord+float2(1,1)*bof).rgb;
	lums[2][2] = luminance(col);
	mdx += GX[0][0]*lums[0][0];
	mdx += GX[0][1]*lums[0][1];
	mdx += GX[0][2]*lums[0][2];
	mdx += GX[1][0]*lums[1][0];
	mdx += GX[1][1]*lums[1][1];
	mdx += GX[1][2]*lums[1][2];
	mdx += GX[2][0]*lums[2][0];
	mdx += GX[2][1]*lums[2][1];
	mdx += GX[2][2]*lums[2][2];
	mdy += GY[0][0]*lums[0][0];
	mdy += GY[0][1]*lums[0][1];
	mdy += GY[0][2]*lums[0][2];
	mdy += GY[1][0]*lums[1][0];
	mdy += GY[1][1]*lums[1][1];
	mdy += GY[1][2]*lums[1][2];
	mdy += GY[2][0]*lums[2][0];
	mdy += GY[2][1]*lums[2][1];
	mdy += GY[2][2]*lums[2][2];
	mud = pow(max(mdx*mdx+mdy*mdy,0.0),0.5);
	mud = clamp(pow(max(mud,0.0),compow)*commult,0.0,1.0);
	if ( comblend ) return res-(cominv?1.0-mud:mud);
	return cominv?1.0-mud:mud;
}

/* linevision filter */
float3 LineView( float3 res, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	if ( fixed.x>0 && fixed.y>0 ) bresl = fixed;
	float contfadepow = tod_ind(contfadepow);
	float contfademult = tod_ind(contfademult);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*contradius;
	float dep = depthlinear(coord);
	float cont = depthlinear(coord+float2(-1,-1)*bof);
	cont += depthlinear(coord+float2(0,-1)*bof);
	cont += depthlinear(coord+float2(1,-1)*bof);
	cont += depthlinear(coord+float2(-1,0)*bof);
	cont += depthlinear(coord+float2(1,0)*bof);
	cont += depthlinear(coord+float2(-1,1)*bof);
	cont += depthlinear(coord+float2(0,1)*bof);
	cont += depthlinear(coord+float2(1,1)*bof);
	cont /= 8.0;
	float mud = 0.0;
	if ( abs(cont-dep) > (contthreshold*0.00001) ) mud = 1.0;
	float fade = 1.0-TextureDepth.Sample(Sampler1,coord).x;
	mud *= clamp(pow(max(0.0,fade),contfadepow)*contfademult,0.0,1.0);
	mud = clamp(pow(max(0.0,mud),contpow)*contmult,0.0,1.0);
	if ( contblend ) return res-(continv?1.0-mud:mud);
	return continv?1.0-mud:mud;
}

/* fog filter */
float3 Limbo( float3 res, float2 coord )
{
	float mud = clamp(pow(max(0.0,depthlinear(coord)),fogpow)*fogmult
		+fogbump,0.0,1.0);
	if ( foglimbo ) return fogcolor*mud;
	return lerp(res,fogcolor,mud);
}

/* Colour grading based on depth */
float3 DepthGradeRGB( float3 res, float dfc )
{
	float3 dgrademul = tod_ind(dgrademul);
	float3 dgradepow = tod_ind(dgradepow);
	return lerp(res,pow(max(0,res),dgradepow)*dgrademul,dfc);
}
float3 DepthGradeColor( float3 res, float dfc )
{
	float dgradecolfact = tod_ind(dgradecolfact);
	float3 dgradecol = tod_ind(dgradecol);
	float tonev = luminance(res);
	float3 tonecolor = dgradecol*tonev;
	return lerp(res,res*(1.0-dgradecolfact)+tonecolor*dgradecolfact,dfc);
}
float3 DepthGradeHSV( float3 res, float dfc )
{
	float dgradesatmul = tod_ind(dgradesatmul);
	float dgradesatpow = tod_ind(dgradesatpow);
	float dgradevalmul = tod_ind(dgradevalmul);
	float dgradevalpow = tod_ind(dgradevalpow);
	float3 hsv = rgb2hsv(res);
	hsv.y = clamp(pow(max(0,hsv.y),dgradesatpow)*dgradesatmul,0.0,1.0);
	hsv.z = pow(max(0,hsv.z),dgradevalpow)*dgradevalmul;
	return lerp(res,hsv2rgb(hsv),dfc);
}
float3 DepthGrade( float3 res, float2 coord )
{
	float dep = TextureDepth.Sample(Sampler1,coord).x;
	float dfc = abs(dep-dgradedfoc);
	float dgradedpow = tod_ind(dgradedpow);
	float dgradedmul = tod_ind(dgradedmul);
	float dgradedbump = tod_ind(dgradedbump);
	float dgradedblend = tod_ind(dgradedblend);
	dfc = clamp(pow(dfc,dgradedpow)*dgradedmul+dgradedbump,0.0,1.0)
		*dgradedblend;
	if ( dgradeenable1 ) res = DepthGradeRGB(res,dfc);
	if ( dcolorizeafterhsv )
	{
		if ( dgradeenable3 ) res = DepthGradeHSV(res,dfc);
		if ( dgradeenable2 ) res = DepthGradeColor(res,dfc);
	}
	else
	{
		if ( dgradeenable2 ) res = DepthGradeColor(res,dfc);
		if ( dgradeenable3 ) res = DepthGradeHSV(res,dfc);
	}
	return res;
}

float4 PS_DepthGrade( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler1,coord);
	res.rgb = DepthGrade(res.rgb,coord);
	res.rgb = max(res.rgb,0.0);
	return res;
}

float4 PS_PreFilters( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler1,coord);
	if ( edgevenable ) res.rgb = EdgeView(res.rgb,coord);
	if ( comenable ) res.rgb = EdgeDetect(res.rgb,coord);
	if ( contenable ) res.rgb = LineView(res.rgb,coord);
	if ( fogenable ) res.rgb = Limbo(res.rgb,coord);
	res.rgb = max(res.rgb,0.0);
	return res;
}

/* Distant hot air refraction. Not very realistic, but does the job. */
float2 DistantHeat( float2 coord )
{
	float2 bresl;
	float dep, odep;
	dep = TextureDepth.Sample(Sampler1,coord).x;
	float distfade = clamp(pow(max(0,dep),heatfadepow)*heatfademul
		+heatfadebump,0.0,1.0);
	if ( distfade <= 0.0 ) return coord;
	float todpow = max(0.0,todx_ind(heatfactor));
	if ( todpow <= 0.0 ) return coord;
	if ( (fixed.x > 0) && (fixed.y > 0) ) bresl = fixed;
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 nc = coord*(bresl/HEATSIZE)*heatsize;
	float2 ts = float2(0.01,1.0)*Timer.x*10000.0*heatspeed;
	float2 ofs = TextureHeat.SampleLevel(Sampler2,nc+ts,0).xy;
	ofs = (ofs-0.5)*2.0;
	ofs *= pow(length(ofs),heatpow);
	ofs *= todpow;
	/*ofs *= max(0.0,warmfactor-coldfactor);*/
	odep = TextureDepth.SampleLevel(Sampler1,coord+ofs*heatstrength
		*distfade*0.01,0).x;
	float odistfade = clamp(pow(max(0,odep),heatfadepow)*heatfademul
		+heatfadebump,0.0,1.0);
	if ( odistfade <= 0.0 ) return coord;
	return coord+ofs*heatstrength*distfade*0.01;
}

/* Screen distortion filters */
float4 PS_Distortion( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float2 bresl;
	if ( (fixed.x > 0) && (fixed.y > 0) ) bresl = fixed;
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 ofs = coord;
	if ( heatenable ) ofs = DistantHeat(ofs);
	ofs -= coord;
	float4 res;
	if ( (distcha == 0.0) || (length(ofs) == 0.0) )
		return TextureColor.Sample(Sampler1,coord+ofs);
	float2 ofr, ofg, ofb;
	ofr = ofs*(1.0-distcha*0.01);
	ofg = ofs;
	ofb = ofs*(1.0+distcha*0.01);
	res = float4(TextureColor.Sample(Sampler1,coord+ofr).r,
		TextureColor.Sample(Sampler1,coord+ofg).g,
		TextureColor.Sample(Sampler1,coord+ofb).b,
		TextureColor.Sample(Sampler1,coord+ofs).a);
	return res;
}

/* This will do absolutely nothing */
float4 PS_Aperture( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	return float4(0,0,0,1);
}

/* Focus */
float4 PS_ReadFocus( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	if ( dofdisable ) return 0.0;
	if ( focuscircle == -2 )
		return TextureDepth.Sample(Sampler1,tempInfo2.zw).x;
	if ( focuscircle < 0 ) return focusmanualvalue;
	float focusmax = tod_ind(focusmax);
	float cfocus = min(TextureDepth.Sample(Sampler1,focuscenter).x,
		focusmax*0.001);
	if ( focuscircle == 0 ) return cfocus;
	if ( focuscircle == 2 )
	{
		int i, j;
		float mfocus = 0.0;
		float2 px;
		[unroll] for( j=0; j<8; j++ ) [unroll] for( i=0; i<8; i++ )
		{
			px = float2((i+0.5)/8.0,(j+0.5)/8.0);
			mfocus += min(TextureDepth.Sample(Sampler1,px).x,
				focusmax*0.001);
		}
		return mfocus/64.0;
	}
	/* using polygons inscribed into a circle, in this case a triangle */
	float focusradius = tod_ind(focusradius);
	float focusmix = tod_ind(focusmix);
	float cstep = (1.0/3.0);
	float sfocus, mfocus[4];
	float2 coord;
	float2 bof = float2(1.0,1.0/ScreenSize.w)*focusradius*0.01;
	float fan = focuscircleangle*2.0*pi;
	coord.x = focuscenter.x+sin(fan)*bof.x;
	coord.y = focuscenter.y+cos(fan)*bof.y;
	mfocus[0] = min(TextureDepth.Sample(Sampler1,coord).x,
		focusmax*0.001);
	coord.x = focuscenter.x+sin(fan+2.0*pi*cstep)*bof.x;
	coord.y = focuscenter.y+cos(fan+2.0*pi*cstep)*bof.y;
	mfocus[1] = min(TextureDepth.Sample(Sampler1,coord).x,
		focusmax*0.001);
	coord.x = focuscenter.x+sin(fan+4.0*pi*cstep)*bof.x;
	coord.y = focuscenter.y+cos(fan+4.0*pi*cstep)*bof.y;
	mfocus[2] = min(TextureDepth.Sample(Sampler1,coord).x,
		focusmax*0.001);
	if ( (mfocus[0] <= focuscenterdiscard)
		&& (mfocus[1] <= focuscenterdiscard)
		&& (mfocus[2] <= focuscenterdiscard) )
		mfocus[3] = focuscenterdiscard;
	else if ( mfocus[0] <= focuscenterdiscard )
	{
		if ( mfocus[1] <= focuscenterdiscard ) mfocus[3] = mfocus[2];
		else mfocus[3] = 0.5*(mfocus[1]+mfocus[2]);
	}
	else if ( mfocus[1] <= focuscenterdiscard )
	{
		if ( mfocus[2] <= focuscenterdiscard ) mfocus[3] = mfocus[0];
		else mfocus[3] = 0.5*(mfocus[0]+mfocus[2]);
	}
	else if ( mfocus[2] <= focuscenterdiscard )
		mfocus[3] = 0.5*(mfocus[0]+mfocus[1]);
	else mfocus[3] = cstep*(mfocus[0]+mfocus[1]+mfocus[2]);
	if ( cfocus <= focuscenterdiscard ) cfocus = mfocus[3];
	else if ( (mfocus[3] > focuscenterdiscard) )
		cfocus = (1.0-focusmix)*cfocus+focusmix*mfocus[3];
	return cfocus;
}

float4 PS_Focus( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	if ( dofdisable ) return 0.0;
	return max(lerp(TexturePrevious.Sample(Sampler0,0.5).x,
		TextureCurrent.Sample(Sampler0,0.5).x,
		saturate(DofParameters.w)),0.0);
}
/* helper code for simplifying these */
#define gcircle(x) float2(cos(x),sin(x))
float4 dofsample( float2 coord, float2 bsz, float blur, bool bDoHighlight,
	out float4 deps, out float4 dfcs )
{
	float4 res;
	float cstep = 2.0*pi*(1.0/3.0);
	float ang = 0.5*pi;
	res.r = TextureColor.SampleLevel(Sampler1,coord
		+gcircle(ang)*bsz*dofpcha*0.1,0,0).r;
	deps.r = TextureDepth.SampleLevel(Sampler1,coord
		+gcircle(ang)*bsz*dofpcha*0.1,0,0).x;
	dfcs.r = RenderTargetR32F.SampleLevel(Sampler1,coord
		+gcircle(ang)*bsz*dofpcha*0.1,0,0).x;
	ang += cstep;
	res.g = TextureColor.SampleLevel(Sampler1,coord
		+gcircle(ang)*bsz*dofpcha*0.1,0,0).g;
	deps.g = TextureDepth.SampleLevel(Sampler1,coord
		+gcircle(ang)*bsz*dofpcha*0.1,0,0).x;
	dfcs.g = RenderTargetR32F.SampleLevel(Sampler1,coord
		+gcircle(ang)*bsz*dofpcha*0.1,0,0).x;
	ang += cstep;
	res.b = TextureColor.SampleLevel(Sampler1,coord
		+gcircle(ang)*bsz*dofpcha*0.1,0,0).b;
	deps.b = TextureDepth.SampleLevel(Sampler1,coord
		+gcircle(ang)*bsz*dofpcha*0.1,0,0).x;
	dfcs.b = RenderTargetR32F.SampleLevel(Sampler1,coord
		+gcircle(ang)*bsz*dofpcha*0.1,0,0).x;
	if ( bDoHighlight )
	{
		float l = luminance(res.rgb);
		float threshold = max((l-dofbthreshold)*dofbgain,0.0);
		res += lerp(0,res,threshold*blur);
	}
	res.a = TextureColor.SampleLevel(Sampler1,coord,0,0).a;
	deps.a = TextureDepth.SampleLevel(Sampler1,coord,0,0).x;
	dfcs.a = RenderTargetR32F.SampleLevel(Sampler1,coord,0,0).x;
	return res;
}
/* gather blur pass */
float4 PS_DoFBlur( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return TextureColor.Sample(Sampler1,coord);
	float dfc = RenderTargetR32F.Sample(Sampler1,coord).x;
	if ( dofdebug ) return TextureDepth.Sample(Sampler1,coord).x;
	if ( dfcdebug ) return dfc;
	float2 bresl;
	if ( (fixed.x > 0) && (fixed.y > 0) ) bresl = fixed;
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = 1.0/bresl;
	if ( dfc <= dofminblur ) return TextureColor.Sample(Sampler1,coord);
	float4 res = float4(0,0,0,0);
	float dep = TextureDepth.Sample(Sampler1,coord).x;
	float2 bsz = bof*dofpradius*dfc;
	float4 sc, ds, sd, sw, tw = float4(0,0,0,0);
	float cstep = 2.0*pi*(1.0/3.0);
	float ang = 0.5*pi;
	[unroll] for ( int i=0; i<32; i++ )
	{
		sc = dofsample(coord+poisson32[i]*bsz,bsz,dfc,dofhilite,ds,sd);
		sw.r = (ds.r>dep)?1.0:sd.r;
		sw.g = (ds.g>dep)?1.0:sd.g;
		sw.b = (ds.b>dep)?1.0:sd.b;
		sw.a = (ds.a>dep)?1.0:sd.a;
		tw += sw;
		res += sc*sw;
	}
	res /= tw;
	return res;
}

/* "bokeh" blur pass */
float4 PS_DoFBorkeh( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return TextureColor.Sample(Sampler1,coord);
	float dfc = RenderTargetR32F.Sample(Sampler1,coord).x;
	if ( dofdebug ) return TextureDepth.Sample(Sampler1,coord).x;
	if ( dfcdebug ) return dfc;
	float2 bresl;
	if ( (fixed.x > 0) && (fixed.y > 0) ) bresl = fixed;
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = 1.0/bresl;
	float4 res = TextureColor.Sample(Sampler1,coord);
	/*
	   Skip blurring areas that are perfectly in focus. The performance
	   gain is negligible in most cases, though.
	*/
	if ( dfc <= dofminblur ) return res;
	float dep = TextureDepth.Sample(Sampler1,coord).x;
	float2 sf = bof+(TextureNoise3.SampleLevel(Sampler2,coord
		*(bresl/256.0),0,0).xy*2.0-1.0)*dofbnoise*0.001;
	float2 sr = sf*dofbradius*dfc;
	int rsamples;
	float bstep, bw;
	float4 sc, ds, sd, sw, tw = float4(1,1,1,1);
	float2 rcoord;
	#define dofbrings 7
	#define dofbsamples 3
	[unroll] for ( int i=1; i<=dofbrings; i++ )
	{
		rsamples = i*dofbsamples;
		[unroll] for ( int j=0; j<rsamples; j++ )
		{
			bstep = pi*2.0/(float)rsamples;
			rcoord = gcircle(j*bstep)*i;
			bw = lerp(1.0,(float)i/(float)dofbrings,dofbbias);
			sc = dofsample(coord+rcoord*sr,sr*i,dfc,dofhilite,ds,sd);
			sw.r = (ds.r>dep)?1.0:sd.r;
			sw.g = (ds.g>dep)?1.0:sd.g;
			sw.b = (ds.b>dep)?1.0:sd.b;
			sw.a = (ds.a>dep)?1.0:sd.a;
			res += sc*sw*bw;
			tw += sw*bw;
		}
	}
	res /= tw;
	return res;
}
float4 PS_DoFPostBlur( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return TextureColor.Sample(Sampler1,coord);
	float dfc = RenderTargetR32F.Sample(Sampler1,coord).x;
	if ( dofdebug ) return TextureDepth.Sample(Sampler1,coord).x;
	if ( dfcdebug ) return dfc;
	float2 bresl;
	if ( (fixed.x > 0) && (fixed.y > 0) ) bresl = fixed;
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*dofpbradius;
	float2 ofs[16] =
	{
		float2(1.0,1.0), float2(-1.0,-1.0),
		float2(-1.0,1.0), float2(1.0,-1.0),
		
		float2(1.0,0.0), float2(-1.0,0.0),
		float2(0.0,1.0), float2(0.0,-1.0),
		
		float2(1.41,0.0), float2(-1.41,0.0),
		float2(0.0,1.41), float2(0.0,-1.41),
		
		float2(1.41,1.41), float2(-1.41,-1.41),
		float2(-1.41,1.41), float2(1.41,-1.41)
	};
	float4 res = TextureColor.Sample(Sampler1,coord);
	if ( !dofpostblur ) return res;
	int i;
	[unroll] for ( i=0; i<16; i++ )
		res += TextureColor.Sample(Sampler1,coord+ofs[i]*bof*dfc);
	res /= 17.0;
	return res;
}

/* screen frost overlay */
float4 PS_DebugFocus( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler1,coord);
	if ( !focusdisplay || (focuscircle == -1) ) return res;
	if ( focuscircle == -2 )
	{
		if ( distance(coord,tempInfo2.zw) < 0.01 )
			res.rgb = float3(1,0,0);
		return res;
	}
	if ( focuscircle == 2 )
	{
		int i, j;
		float2 px;
		[unroll] for( j=0; j<8; j++ ) [unroll] for( i=0; i<8; i++ )
		{
			px = float2((i+0.5)/8.0,(j+0.5)/8.0);
			if ( distance(coord,px) < 0.005 )
				res.rgb = float3(1,0,0);
		}
		return res;
	}
	if ( distance(coord,focuscenter) < 0.01 ) res.rgb = float3(1,0,0);
	if ( focuscircle == 0 ) return res;
	float cstep = (1.0/3.0);
	float2 tcoord;
	float focusradius = tod_ind(focusradius);
	float2 bof = float2(1.0,1.0/ScreenSize.w)*focusradius*0.01;
	float fan = focuscircleangle*2.0*pi;
	tcoord.x = focuscenter.x+sin(fan)*bof.x;
	tcoord.y = focuscenter.y+cos(fan)*bof.y;
	if ( distance(coord,tcoord) < 0.01 ) res.rgb = float3(1,0,0);
	tcoord.x = focuscenter.x+sin(fan+2.0*pi*cstep)*bof.x;
	tcoord.y = focuscenter.y+cos(fan+2.0*pi*cstep)*bof.y;
	if ( distance(coord,tcoord) < 0.01 ) res.rgb = float3(1,0,0);
	tcoord.x = focuscenter.x+sin(fan+4.0*pi*cstep)*bof.x;
	tcoord.y = focuscenter.y+cos(fan+4.0*pi*cstep)*bof.y;
	if ( distance(coord,tcoord) < 0.01 ) res.rgb = float3(1,0,0);
	return res;
}

technique11 Aperture
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Aperture()));
	}
}

technique11 ReadFocus
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_ReadFocus()));
	}
}

technique11 Focus
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Focus()));
	}
}

technique11 Prepass <string UIName="MariENB";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_PreFilters()));
	}
}
technique11 Prepass1
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_DepthGrade()));
	}
}
technique11 Prepass2 <string RenderTarget="RenderTargetR16F";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_SSAOPre()));
	}
}
technique11 Prepass3
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Distortion()));
	}
}
technique11 Prepass4
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_SSAOBlur()));
	}
}
technique11 Prepass5 <string RenderTarget="RenderTargetR32F";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_DoFPrepass()));
	}
}
technique11 Prepass6
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_DoFBlur()));
	}
}
technique11 Prepass7
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_DoFPostBlur()));
	}
}
technique11 Prepass8
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_DebugFocus()));
	}
}

technique11 PrepassB <string UIName="MariENB (HQ Bokeh)";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_PreFilters()));
	}
}
technique11 PrepassB1
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_DepthGrade()));
	}
}
technique11 PrepassB2 <string RenderTarget="RenderTargetR16F";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_SSAOPre()));
	}
}
technique11 PrepassB3
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Distortion()));
	}
}
technique11 PrepassB4
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_SSAOBlur()));
	}
}
technique11 PrepassB5 <string RenderTarget="RenderTargetR32F";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_DoFPrepass()));
	}
}
technique11 PrepassB6
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_DoFBorkeh()));
	}
}
technique11 PrepassB7
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_DoFPostBlur()));
	}
}
technique11 PrepassB8
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_DebugFocus()));
	}
}

