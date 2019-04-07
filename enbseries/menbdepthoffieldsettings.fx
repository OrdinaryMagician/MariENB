/*
	menbdepthoffieldsettings.fx : MariENB dof variables.
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
/* fixed dof for foggy weathers */
bool doffogenable
<
	string UIName = "Enable DOF Fog";
	string UIWidget = "Checkbox";
> = {true};
float doffogmult_n
<
	string UIName = "DOF Fog Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float doffogmult_d
<
	string UIName = "DOF Fog Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float doffogmult_in
<
	string UIName = "DOF Fog Intensity Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float doffogmult_id
<
	string UIName = "DOF Fog Intensity Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float doffogpow_n
<
	string UIName = "DOF Fog Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float doffogpow_d
<
	string UIName = "DOF Fog Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float doffogpow_in
<
	string UIName = "DOF Fog Contrast Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float doffogpow_id
<
	string UIName = "DOF Fog Contrast Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float doffogbump_n
<
	string UIName = "DOF Fog Shift Night";
	string UIWidget = "Spinner";
> = {0.0};
float doffogbump_d
<
	string UIName = "DOF Fog Shift Day";
	string UIWidget = "Spinner";
> = {0.0};
float doffogbump_in
<
	string UIName = "DOF Fog Shift Interior Night";
	string UIWidget = "Spinner";
> = {0.0};
float doffogbump_id
<
	string UIName = "DOF Fog Shift Interior Day";
	string UIWidget = "Spinner";
> = {0.0};
float doffogblend_n
<
	string UIName = "DOF Fog Blend Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffogblend_d
<
	string UIName = "DOF Fog Blend Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffogblend_in
<
	string UIName = "DOF Fog Blend Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffogblend_id
<
	string UIName = "DOF Fog Blend Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffogdepth
<
	string UIName = "DOF Fog Depth";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
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
