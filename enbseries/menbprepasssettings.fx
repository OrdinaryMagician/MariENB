/*
	menbprepasssettings.fx : MariENB prepass user-tweakable variables.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* fixed resolution, keeps blur filters at a consistent internal resolution */
int fixedx
<
	string UIName = "_FixedResolutionX";
	string UIWidget = "Spinner";
	int UIMin = 0;
> = {1920};
int fixedy
<
	string UIName = "_FixedResolutionY";
	string UIWidget = "Spinner";
	int UIMin = 0;
> = {1080};
float cutoff
<
	string UIName = "DepthCutoff";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1000000.0;
> = {999949.0};
float distcha
<
	string UIName = "DistortionChromaticAberration";
	string UIWidget = "Spinner";
> = {10.0};
bool waterenable
<
	string UIName = "UnderwaterEnable";
	string UIWidget = "Checkbox";
> = {false};
float uwm1
<
	string UIName = "UnderwaterMult1";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.4};
float uwm2
<
	string UIName = "UnderwaterMult2";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.6};
float uwm3
<
	string UIName = "UnderwaterMult3";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.4};
float uwf1
<
	string UIName = "UnderwaterFreq1";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {10.0};
float uwf2
<
	string UIName = "UnderwaterFreq2";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {8.0};
float uwf3
<
	string UIName = "UnderwaterFreq3";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {16.0};
float uws1
<
	string UIName = "UnderwaterStr1";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.3};
float uws2
<
	string UIName = "UnderwaterStr2";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float uws3
<
	string UIName = "UnderwaterStr3";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.8};
float uwz
<
	string UIName = "UnderwaterZoom";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.5};
bool heatenable
<
	string UIName = "HeatEnable";
	string UIWidget = "Checkbox";
> = {false};
float heatsize
<
	string UIName = "HeatSize";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {3.5};
float heatspeed
<
	string UIName = "HeatSpeed";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.5};
float heatfadepow
<
	string UIName = "HeatFadePower";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {200.0};
float heatfademul
<
	string UIName = "HeatFadeMultiplier";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float heatfadebump
<
	string UIName = "HeatFadeBump";
	string UIWidget = "Spinner";
> = {0.0};
float heatstrength
<
	string UIName = "HeatStrength";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
float heatpow
<
	string UIName = "HeatPower";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.2};
float heattodpow
<
	string UIName = "HeatTODPower";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.2};
bool heatalways
<
	string UIName = "HeatAlways";
	string UIWidget = "Checkbox";
> = {false};
/* circle (triangle, actually) average focus */
bool focuscircle
<
	string UIName = "FocusCircleEnable";
	string UIWidget = "Checkbox";
> = {true};
bool focusdisplay
<
	string UIName = "FocusPointDisplay";
	string UIWidget = "Checkbox";
> = {false};
bool focusmanual
<
	string UIName = "FocusManual";
	string UIWidget = "Checkbox";
> = {false};
float focusmanualvalue
<
	string UIName = "FocusManualValue";
	string UIWidget = "Checkbox";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};
/* center point of focus */
float focuscenter_x
<
	string UIName = "FocusCenterX";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};
float focuscenter_y
<
	string UIName = "FocusCenterY";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};
float focuscircleangle
<
	string UIName = "FocusCircleAngle";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
/* radius of the focus point triangle */
float focusradius_n
<
	string UIName = "FocusCircleRadiusNight";
	string UIWidget = "Spinner";
> = {20.0};
float focusradius_d
<
	string UIName = "FocusCircleRadiusDay";
	string UIWidget = "Spinner";
> = {20.0};
float focusradius_in
<
	string UIName = "FocusCircleRadiusInteriorNight";
	string UIWidget = "Spinner";
> = {20.0};
float focusradius_id
<
	string UIName = "FocusCircleRadiusInteriorDay";
	string UIWidget = "Spinner";
> = {20.0};
/* mix factor with sample at screen center */
float focusmix_n
<
	string UIName = "FocusCircleMixNight";
	string UIWidget = "Spinner";
> = {0.5};
float focusmix_d
<
	string UIName = "FocusCircleMixDay";
	string UIWidget = "Spinner";
> = {0.5};
float focusmix_in
<
	string UIName = "FocusCircleMixInteriorNight";
	string UIWidget = "Spinner";
> = {0.5};
float focusmix_id
<
	string UIName = "FocusCircleMixInteriorDay";
	string UIWidget = "Spinner";
> = {0.5};
/* maximum focus depth */
float focusmax_n
<
	string UIName = "FocusMaxNight";
	string UIWidget = "Spinner";
> = {1000.0};
float focusmax_d
<
	string UIName = "FocusMaxDay";
	string UIWidget = "Spinner";
> = {1000.0};
float focusmax_in
<
	string UIName = "FocusMaxInteriorNight";
	string UIWidget = "Spinner";
> = {1000.0};
float focusmax_id
<
	string UIName = "FocusMaxInteriorDay";
	string UIWidget = "Spinner";
> = {1000.0};
/* dof filter */
/* dof multiplier (makes unfocused depths more blurry) */
float dofmult_n
<
	string UIName = "DoFMultNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float dofmult_d
<
	string UIName = "DoFMultDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float dofmult_in
<
	string UIName = "DoFMultInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float dofmult_id
<
	string UIName = "DoFMultInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
/* dof power (falloff, kinda) */
float dofpow_n
<
	string UIName = "DoFPowNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
float dofpow_d
<
	string UIName = "DoFPowDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
float dofpow_in
<
	string UIName = "DoFPowInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
float dofpow_id
<
	string UIName = "DoFPowInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
/* dof bump (to emulate tilt shift I guess, I brought it back) */
float dofbump_n
<
	string UIName = "DoFBumpNight";
	string UIWidget = "Spinner";
> = {0.0};
float dofbump_d
<
	string UIName = "DoFBumpDay";
	string UIWidget = "Spinner";
> = {0.0};
float dofbump_in
<
	string UIName = "DoFBumpInteriorNight";
	string UIWidget = "Spinner";
> = {0.0};
float dofbump_id
<
	string UIName = "DoFBumpInteriorDay";
	string UIWidget = "Spinner";
> = {0.0};
/* fixed focused depth factors */
float doffixedfocusmult_n
<
	string UIName = "DoFFixedFocusedMultNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocusmult_d
<
	string UIName = "DoFFixedFocusedMultDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocusmult_in
<
	string UIName = "DoFFixedFocusedMultInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocusmult_id
<
	string UIName = "DoFFixedFocusedMultInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocuspow_n
<
	string UIName = "DoFFixedFocusedPowNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocuspow_d
<
	string UIName = "DoFFixedFocusedPowDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocuspow_in
<
	string UIName = "DoFFixedFocusedPowInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocuspow_id
<
	string UIName = "DoFFixedFocusedPowInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocusbump_n
<
	string UIName = "DoFFixedFocusedBumpNight";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedfocusbump_d
<
	string UIName = "DoFFixedFocusedBumpDay";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedfocusbump_in
<
	string UIName = "DoFFixedFocusedBumpInteriorNight";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedfocusbump_id
<
	string UIName = "DoFFixedFocusedBumpInteriorDay";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedfocusblend_n
<
	string UIName = "DoFFixedFocusedBlendNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedfocusblend_d
<
	string UIName = "DoFFixedFocusedBlendDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedfocusblend_in
<
	string UIName = "DoFFixedFocusedBlendInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedfocusblend_id
<
	string UIName = "DoFFixedFocusedBlendInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
/* fixed unfocused depth factors */
float doffixedunfocusmult_n
<
	string UIName = "DoFFixedUnfocusedMultNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float doffixedunfocusmult_d
<
	string UIName = "DoFFixedUnfocusedMultDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float doffixedunfocusmult_in
<
	string UIName = "DoFFixedUnfocusedMultInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float doffixedunfocusmult_id
<
	string UIName = "DoFFixedUnfocusedMultInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float doffixedunfocuspow_n
<
	string UIName = "DoFFixedUnfocusedPowNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float doffixedunfocuspow_d
<
	string UIName = "DoFFixedUnfocusedPowDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float doffixedunfocuspow_in
<
	string UIName = "DoFFixedUnfocusedPowInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float doffixedunfocuspow_id
<
	string UIName = "DoFFixedUnfocusedPowInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float doffixedunfocusbump_n
<
	string UIName = "DoFFixedUnfocusedBumpNight";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedunfocusbump_d
<
	string UIName = "DoFFixedUnfocusedBumpDay";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedunfocusbump_in
<
	string UIName = "DoFFixedUnfocusedBumpInteriorNight";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedunfocusbump_id
<
	string UIName = "DoFFixedUnfocusedBumpInteriorDay";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedunfocusblend_n
<
	string UIName = "DoFFixedUnfocusedBlendNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedunfocusblend_d
<
	string UIName = "DoFFixedUnfocusedBlendDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedunfocusblend_in
<
	string UIName = "DoFFixedUnfocusedBlendInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedunfocusblend_id
<
	string UIName = "DoFFixedUnfocusedBlendInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
/* disable depth of field */
bool dofdisable
<
	string UIName = "DoFDisable";
	string UIWidget = "Checkbox";
> = {false};
/* use bilateral filtering for sharper dof blurring */
bool dofbilateral
<
	string UIName = "DoFBilateral";
	string UIWidget = "Checkbox";
> = {true};
float dofbfact
<
	string UIName = "DoFBilateralFactor";
	string UIWidget = "Spinner";
> = {20.0};
float dofbradius
<
	string UIName = "DoFBlurRadius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
bool dofrelfov
<
	string UIName = "DoFRelativeToFoV";
	string UIWidget = "Checkbox";
> = {true};
float fovdefault
<
	string UIName = "DoFRelativeDefaultFOV";
	string UIWidget = "Spinner";
	float UIMin = 1.0;
	float UIMax = 180.0;
> = {75.0};
float relfovfactor_n
<
	string UIName = "DoFRelativeFactorNight";
	string UIWidget = "Spinner";
> = {2.0};
float relfovfactor_d
<
	string UIName = "DoFRelativeFactorDay";
	string UIWidget = "Spinner";
> = {2.0};
float relfovfactor_in
<
	string UIName = "DoFRelativeFactorInteriorNight";
	string UIWidget = "Spinner";
> = {2.0};
float relfovfactor_id
<
	string UIName = "DoFRelativeFactorInteriorDay";
	string UIWidget = "Spinner";
> = {2.0};
bool dofdebug
<
	string UIName = "DebugDepth";
	string UIWidget = "Checkbox";
> = {false};
/* enable edge detect filters */
bool edgeenable
<
	string UIName = "EdgeEnable";
	string UIWidget = "Checkbox";
> = {false};
/* use "edge vision" instead of contour filter (just because it looks fancy) */
bool edgeview
<
	string UIName = "EdgeView";
	string UIWidget = "Checkbox";
> = {true};
/* factors */
float edgefadepow_n
<
	string UIName = "EdgeFadePowerNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float edgefadepow_d
<
	string UIName = "EdgeFadePowerDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float edgefadepow_in
<
	string UIName = "EdgeFadePowerInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float edgefadepow_id
<
	string UIName = "EdgeFadePowerInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float edgefademult_n
<
	string UIName = "EdgeFadeMultiplierNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float edgefademult_d
<
	string UIName = "EdgeFadeMultiplierDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float edgefademult_in
<
	string UIName = "EdgeFadeMultiplierInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float edgefademult_id
<
	string UIName = "EdgeFadeMultiplierInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float edgepow
<
	string UIName = "EdgePower";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float edgemult
<
	string UIName = "EdgeMultiplier";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {128.0};
float edgeradius
<
	string UIName = "EdgeRadius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* ssao filter */
bool ssaoenable
<
	string UIName = "SSAOEnable";
	string UIWidget = "Checkbox";
> = {false};
float ssaoradius
<
	string UIName = "SSAORadius";
	string UIWidget = "Spinner";
> = {1.0};
int ssaonoise
<
	string UIName = "SSAONoise";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 1;
> = {1};
float ssaofadepow_n
<
	string UIName = "SSAOFadePowerNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.05};
float ssaofadepow_d
<
	string UIName = "SSAOFadePowerDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.05};
float ssaofadepow_in
<
	string UIName = "SSAOFadePowerInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.05};
float ssaofadepow_id
<
	string UIName = "SSAOFadePowerInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.05};
float ssaofademult_n
<
	string UIName = "SSAOFadeMultiplierNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float ssaofademult_d
<
	string UIName = "SSAOFadeMultiplierDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float ssaofademult_in
<
	string UIName = "SSAOFadeMultiplierInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float ssaofademult_id
<
	string UIName = "SSAOFadeMultiplierInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float ssaomult
<
	string UIName = "SSAOMultiplier";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float ssaopow
<
	string UIName = "SSAOPower";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.5};
float ssaoblend
<
	string UIName = "SSAOBlend";
	string UIWidget = "Spinner";
> = {1.0};
bool ssaobenable
<
	string UIName = "SSAOBlurEnable";
	string UIWidget = "Checkbox";
> = {true};
float ssaobfact
<
	string UIName = "SSAOBilateralFactor";
	string UIWidget = "Spinner";
> = {10000.0};
float ssaoclamp
<
	string UIName = "SSAOClamp";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float ssaobradius
<
	string UIName = "SSAOBlurRadius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
bool ssaodebug
<
	string UIName = "DebugSSAO";
	string UIWidget = "Checkbox";
> = {false};
/* luma sharpen because of reasons */
bool sharpenable
<
	string UIName = "SharpenEnable";
	string UIWidget = "Checkbox";
> = {false};
float sharpradius
<
	string UIName = "SharpenRadius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.8};
float sharpclamp
<
	string UIName = "SharpenClamp";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.02};
float sharpblend
<
	string UIName = "SharpenBlending";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.2};