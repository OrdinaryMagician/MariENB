/*
	menbprepasssettings.fx : MariENB prepass user-tweakable variables.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the WTFPL.
*/
/* fixed resolution */
int fixedx
<
	string UIName = "_FixedResolutionX";
	string UIWidget = "Spinner";
	int UIMin = 0;
> = {0};
int fixedy
<
	string UIName = "_FixedResolutionY";
	string UIWidget = "Spinner";
	int UIMin = 0;
> = {0};
/* circle average focus */
bool focuscircle
<
	string UIName = "FocusCircleEnable";
	string UIWidget = "Checkbox";
> = {false};
/* radius of the outmost circle */
float focusradius_n
<
	string UIName = "FocusCircleRadiusNight";
	string UIWidget = "Spinner";
> = {12.5};
float focusradius_d
<
	string UIName = "FocusCircleRadiusDay";
	string UIWidget = "Spinner";
> = {12.5};
float focusradius_in
<
	string UIName = "FocusCircleRadiusInteriorNight";
	string UIWidget = "Spinner";
> = {12.5};
float focusradius_id
<
	string UIName = "FocusCircleRadiusInteriorDay";
	string UIWidget = "Spinner";
> = {12.5};
/* mix factor with sample at screen center */
float focusmix_n
<
	string UIName = "FocusCircleMixNight";
	string UIWidget = "Spinner";
> = {0.25};
float focusmix_d
<
	string UIName = "FocusCircleMixDay";
	string UIWidget = "Spinner";
> = {0.25};
float focusmix_in
<
	string UIName = "FocusCircleMixInteriorNight";
	string UIWidget = "Spinner";
> = {0.25};
float focusmix_id
<
	string UIName = "FocusCircleMixInteriorDay";
	string UIWidget = "Spinner";
> = {0.25};
/* maximum focus depth */
float focusmax_n
<
	string UIName = "FocusMaxNight";
	string UIWidget = "Spinner";
> = {1.0};
float focusmax_d
<
	string UIName = "FocusMaxDay";
	string UIWidget = "Spinner";
> = {1.0};
float focusmax_in
<
	string UIName = "FocusMaxInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float focusmax_id
<
	string UIName = "FocusMaxInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* dof filter */
/* depth multiplier */
float dofmult_n
<
	string UIName = "DoFMultNight";
	string UIWidget = "Spinner";
> = {1.0};
float dofmult_d
<
	string UIName = "DoFMultDay";
	string UIWidget = "Spinner";
> = {1.0};
float dofmult_in
<
	string UIName = "DoFMultInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float dofmult_id
<
	string UIName = "DoFMultInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* depth power */
float dofpow_n
<
	string UIName = "DoFPowNight";
	string UIWidget = "Spinner";
> = {1.0};
float dofpow_d
<
	string UIName = "DoFPowDay";
	string UIWidget = "Spinner";
> = {1.0};
float dofpow_in
<
	string UIName = "DoFPowInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float dofpow_id
<
	string UIName = "DoFPowInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* fixed depth multiplier */
float doffixedfocusmult_n
<
	string UIName = "DoFFixedFocusedMultNight";
	string UIWidget = "Spinner";
> = {1.0};
float doffixedfocusmult_d
<
	string UIName = "DoFFixedFocusedMultDay";
	string UIWidget = "Spinner";
> = {1.0};
float doffixedfocusmult_in
<
	string UIName = "DoFFixedFocusedMultInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float doffixedfocusmult_id
<
	string UIName = "DoFFixedFocusedMultInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* fixed depth power */
float doffixedfocuspow_n
<
	string UIName = "DoFFixedFocusedPowNight";
	string UIWidget = "Spinner";
> = {1.0};
float doffixedfocuspow_d
<
	string UIName = "DoFFixedFocusedPowDay";
	string UIWidget = "Spinner";
> = {1.0};
float doffixedfocuspow_in
<
	string UIName = "DoFFixedFocusedPowInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float doffixedfocuspow_id
<
	string UIName = "DoFFixedFocusedPowInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* fixed depth blending */
float doffixedfocusblend_n
<
	string UIName = "DoFFixedFocusedBlendNight";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedfocusblend_d
<
	string UIName = "DoFFixedFocusedBlendDay";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedfocusblend_in
<
	string UIName = "DoFFixedFocusedBlendInteriorNight";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedfocusblend_id
<
	string UIName = "DoFFixedFocusedBlendInteriorDay";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedunfocusmult_n
<
	string UIName = "DoFFixedUnfocusedMultNight";
	string UIWidget = "Spinner";
> = {1.0};
float doffixedunfocusmult_d
<
	string UIName = "DoFFixedUnfocusedMultDay";
	string UIWidget = "Spinner";
> = {1.0};
float doffixedunfocusmult_in
<
	string UIName = "DoFFixedUnfocusedMultInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float doffixedunfocusmult_id
<
	string UIName = "DoFFixedUnfocusedMultInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* fixed depth power */
float doffixedunfocuspow_n
<
	string UIName = "DoFFixedUnfocusedPowNight";
	string UIWidget = "Spinner";
> = {1.0};
float doffixedunfocuspow_d
<
	string UIName = "DoFFixedUnfocusedPowDay";
	string UIWidget = "Spinner";
> = {1.0};
float doffixedunfocuspow_in
<
	string UIName = "DoFFixedUnfocusedPowInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float doffixedunfocuspow_id
<
	string UIName = "DoFFixedUnfocusedPowInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* fixed depth blending */
float doffixedunfocusblend_n
<
	string UIName = "DoFFixedUnfocusedBlendNight";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedunfocusblend_d
<
	string UIName = "DoFFixedUnfocusedBlendDay";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedunfocusblend_in
<
	string UIName = "DoFFixedUnfocusedBlendInteriorNight";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedunfocusblend_id
<
	string UIName = "DoFFixedUnfocusedBlendInteriorDay";
	string UIWidget = "Spinner";
> = {0.0};
/* display dof factors per pixel */
bool dofdebug
<
	string UIName = "DoFDebug";
	string UIWidget = "Checkbox";
> = {false};
/* two-pass blur, makes you shortsighted */
bool doftwopass
<
	string UIName = "DoFTwoPass";
	string UIWidget = "Checkbox";
> = {false};
/* disable depth of field, in case you want just the contour filter */
bool dofdisable
<
	string UIName = "DoFDisable";
	string UIWidget = "Checkbox";
> = {false};
/* enable depth of field smoothing (3x3 gaussian blur, slight fps loss) */
bool dofsmooth
<
	string UIName = "DoFSmoothing";
	string UIWidget = "Checkbox";
> = {true};
/* enable depth of field sky cutoff (keeps sky sharp, but may look awful) */
bool dofcutoff
<
	string UIName = "DoFCutoff";
	string UIWidget = "Checkbox";
> = {false};
/* disable edge detect filters */
bool noedge
<
	string UIName = "EdgeDisable";
	string UIWidget = "Checkbox";
> = {true};
/* use "edge vision" instead of contour filter (just because it looks fancy) */
bool edgeview
<
	string UIName = "EdgeView";
	string UIWidget = "Checkbox";
> = {false};
/* factors */
float edgefadepow
<
	string UIName = "EdgeFadePower";
	string UIWidget = "Spinner";
> = {1.6};
float edgefademult
<
	string UIName = "EdgeFadeMultiplier";
	string UIWidget = "Spinner";
> = {16.0};
float edgepow
<
	string UIName = "EdgePower";
	string UIWidget = "Spinner";
> = {1.5};
float edgemult
<
	string UIName = "EdgeMultiplier";
	string UIWidget = "Spinner";
> = {32.0};
/* ssao filter */
bool ssaoenable
<
	string UIName = "SSAOEnable";
	string UIWidget = "Checkbox";
> = {false};
int ssaodebug
<
	string UIName = "SSAODebug";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 2;
> = 0;
float ssaonoff1
<
	string UIName = "SSAONormalOffset1";
	string UIWidget = "Spinner";
> = {0.0};
float ssaonoff2
<
	string UIName = "SSAONormalOffset2";
	string UIWidget = "Spinner";
> = {0.1};
float ssaonoff3
<
	string UIName = "SSAONormalOffset3";
	string UIWidget = "Spinner";
> = {0.1};
float ssaonoff4
<
	string UIName = "SSAONormalOffset4";
	string UIWidget = "Spinner";
> = {0.0};
float ssaoradius
<
	string UIName = "SSAORadius";
	string UIWidget = "Spinner";
> = {1.0};
float ssaonoise
<
	string UIName = "SSAONoise";
	string UIWidget = "Spinner";
> = {0.5};
float ssaofadepow
<
	string UIName = "SSAOFadePower";
	string UIWidget = "Spinner";
> = {1.5};
float ssaofademult
<
	string UIName = "SSAOFadeMultiplier";
	string UIWidget = "Spinner";
> = {15.0};
float ssaomult
<
	string UIName = "SSAOMultiplier";
	string UIWidget = "Spinner";
> = {1.0};
float ssaopow
<
	string UIName = "SSAOPower";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float ssaoblend
<
	string UIName = "SSAOBlend";
	string UIWidget = "Spinner";
> = {1.0};
bool ssaobenable
<
	string UIName = "SSAOBlurEnable";
	string UIWidget = "Spinner";
> = {true};
