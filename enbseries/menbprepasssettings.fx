/*
	menbprepasssettings.fx : MariENB prepass user-tweakable variables.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
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
string str_dist = "Distortion Filters";
float distcha
<
	string UIName = "Distortion Chromatic Aberration";
	string UIWidget = "Spinner";
> = {10.0};
bool waterenable
<
	string UIName = "Enable Underwater";
	string UIWidget = "Checkbox";
> = {false};
float uwm1
<
	string UIName = "Underwater Frequency 1";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.4};
float uwm2
<
	string UIName = "Underwater Frequency 2";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.6};
float uwm3
<
	string UIName = "Underwater Frequency 3";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.4};
float uwf1
<
	string UIName = "Underwater Speed 1";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {10.0};
float uwf2
<
	string UIName = "Underwater Speed 2";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {8.0};
float uwf3
<
	string UIName = "Underwater Speed 3";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {16.0};
float uws1
<
	string UIName = "Underwater Amplitude 1";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.3};
float uws2
<
	string UIName = "Underwater Amplitude 2";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float uws3
<
	string UIName = "Underwater Amplitude 3";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.8};
float uwz
<
	string UIName = "Underwater Zoom";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.5};
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
float heattodpow
<
	string UIName = "Heat Time-of-day Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.2};
bool heatalways
<
	string UIName = "Heat Always Enable";
	string UIWidget = "Checkbox";
> = {false};
string str_focus = "Focusing Parameters";
/* circle (triangle, actually) average focus */
bool focuscircle
<
	string UIName = "Enable Focus Triangle";
	string UIWidget = "Checkbox";
> = {true};
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
float focuscenter_x
<
	string UIName = "Focus Point Center X";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};
float focuscenter_y
<
	string UIName = "Focus Point Center Y";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};
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
float focusradius_in
<
	string UIName = "Focus Triangle Radius Interior Night";
	string UIWidget = "Spinner";
> = {20.0};
float focusradius_id
<
	string UIName = "Focus Triangle Radius Interior Day";
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
float focusmix_in
<
	string UIName = "Focus Triangle Blending Interior Night";
	string UIWidget = "Spinner";
> = {0.5};
float focusmix_id
<
	string UIName = "Focus Triangle Blending Interior Day";
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
float focusmax_in
<
	string UIName = "Focus Maximum Depth Interior Night";
	string UIWidget = "Spinner";
> = {1000.0};
float focusmax_id
<
	string UIName = "Focus Maximum Depth Interior Day";
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
float dofmult_in
<
	string UIName = "DOF Intensity Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float dofmult_id
<
	string UIName = "DOF Intensity Interior Day";
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
float dofpow_in
<
	string UIName = "DOF Contrast Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
float dofpow_id
<
	string UIName = "DOF Contrast Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
/* dof bump (to emulate tilt shift I guess, I brought it back) */
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
float dofbump_in
<
	string UIName = "DOF Shift Interior Night";
	string UIWidget = "Spinner";
> = {0.0};
float dofbump_id
<
	string UIName = "DOF Shift Interior Day";
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
float doffixedfocusmult_in
<
	string UIName = "DOF Fixed Focus Intensity Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocusmult_id
<
	string UIName = "DOF Fixed Focus Intensity Interior Day";
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
float doffixedfocuspow_in
<
	string UIName = "DOF Fixed Focus Contrast Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocuspow_id
<
	string UIName = "DOF Fixed Focus Contrast Interior Day";
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
float doffixedfocusbump_in
<
	string UIName = "DOF Fixed Focus Shift Interior Night";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedfocusbump_id
<
	string UIName = "DOF Fixed Focus Shift Interior Day";
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
float doffixedfocusblend_in
<
	string UIName = "DOF Fixed Focus Blend Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedfocusblend_id
<
	string UIName = "DOF Fixed Focus Blend Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
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
float doffixedunfocusmult_in
<
	string UIName = "DOF Fixed Unfocus Intensity Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float doffixedunfocusmult_id
<
	string UIName = "DOF Fixed Unfocus Intensity Interior Day";
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
float doffixedunfocuspow_in
<
	string UIName = "DOF Fixed Unfocus Contrast Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float doffixedunfocuspow_id
<
	string UIName = "DOF Fixed Unfocus Contrast Interior Day";
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
float doffixedunfocusbump_in
<
	string UIName = "DOF Fixed Unfocus Shift Interior Night";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedunfocusbump_id
<
	string UIName = "DOF Fixed Unfocus Shift Interior Day";
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
float doffixedunfocusblend_in
<
	string UIName = "DOF Fixed Unfocus Blend Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedunfocusblend_id
<
	string UIName = "DOF Fixed Unfocus Blend Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
/* disable depth of field */
bool dofdisable
<
	string UIName = "Disable DOF";
	string UIWidget = "Checkbox";
> = {false};
/* use bilateral filtering for sharper dof blurring */
bool dofbilateral
<
	string UIName = "DOF Bilateral Blur";
	string UIWidget = "Checkbox";
> = {true};
float dofbfact
<
	string UIName = "DOF Bilateral Factor";
	string UIWidget = "Spinner";
> = {20.0};
float dofbradius
<
	string UIName = "DOF Blur Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
bool dofrelfov
<
	string UIName = "DOF Relative to FOV";
	string UIWidget = "Checkbox";
> = {true};
float fovdefault
<
	string UIName = "Default FOV";
	string UIWidget = "Spinner";
	float UIMin = 1.0;
	float UIMax = 180.0;
> = {75.0};
float relfovfactor_n
<
	string UIName = "DOF Relative Factor Night";
	string UIWidget = "Spinner";
> = {2.0};
float relfovfactor_d
<
	string UIName = "DOF Relative Factor Day";
	string UIWidget = "Spinner";
> = {2.0};
float relfovfactor_in
<
	string UIName = "DOF Relative Factor Interior Night";
	string UIWidget = "Spinner";
> = {2.0};
float relfovfactor_id
<
	string UIName = "DOF Relative Factor Interior Day";
	string UIWidget = "Spinner";
> = {2.0};
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
/* enable edge detect filters */
string str_edge = "Depth Edge Detection";
bool edgeenable
<
	string UIName = "Enable Depth Edge Detect";
	string UIWidget = "Checkbox";
> = {false};
/* factors */
float edgefadepow_n
<
	string UIName = "Edge Fade Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float edgefadepow_d
<
	string UIName = "Edge Fade Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float edgefadepow_in
<
	string UIName = "Edge Fade Contrast Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float edgefadepow_id
<
	string UIName = "Edge Fade Contrast Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float edgefademult_n
<
	string UIName = "Edge Fade Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float edgefademult_d
<
	string UIName = "Edge Fade Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float edgefademult_in
<
	string UIName = "Edge Fade Intensity Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float edgefademult_id
<
	string UIName = "Edge Fade Intensity Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float edgepow
<
	string UIName = "Edge Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.5};
float edgemult
<
	string UIName = "Edge Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float edgeradius
<
	string UIName = "Edge Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.01};
float edgethreshold
<
	string UIName = "Edge Threshold";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.01};
bool edgedebug
<
	string UIName = "Debug Edge";
	string UIWidget = "Checkbox";
> = {false};
/* use luma edge detection filter */
string str_cel = "Luma Edge Detection";
bool celenable
<
	string UIName = "Enable Luma Edge Detect";
	string UIWidget = "Checkbox";
> = {false};
float celradius
<
	string UIName = "Cel Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float celmult
<
	string UIName = "Cel Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
float celpow
<
	string UIName = "Cel Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
bool celdebug
<
	string UIName = "Debug Cel";
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
> = {10000.0};
float ssaoclamp
<
	string UIName = "SSAO Range";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
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
