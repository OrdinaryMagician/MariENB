/*
	menbeffectsettings.fx : MariENB base user-tweakable variables.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* "adaptation" factors */
bool aenable
<
	string UIName = "UseAdaptation";
	string UIWidget = "Checkbox";
> = {false};
float amin_n
<
	string UIName = "AdaptationMinNight";
	string UIWidget = "Spinner";
> = {0.0};
float amin_d
<
	string UIName = "AdaptationMinDay";
	string UIWidget = "Spinner";
> = {0.0};
float amin_in
<
	string UIName = "AdaptationMinInteriorNight";
	string UIWidget = "Spinner";
> = {0.0};
float amin_id
<
	string UIName = "AdaptationMinInteriorDay";
	string UIWidget = "Spinner";
> = {0.0};
float amax_n
<
	string UIName = "AdaptationMaxNight";
	string UIWidget = "Spinner";
> = {1.0};
float amax_d
<
	string UIName = "AdaptationMaxDay";
	string UIWidget = "Spinner";
> = {1.0};
float amax_in
<
	string UIName = "AdaptationMaxInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float amax_id
<
	string UIName = "AdaptationMaxInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* overshine/bloom compensation */
bool compenable
<
	string UIName = "UseCompensate";
	string UIWidget = "Checkbox";
> = {false};
/* compensation factor */
float compfactor_n
<
	string UIName = "CompensateFactorNight";
	string UIWidget = "Spinner";
> = {0.0};
float compfactor_d
<
	string UIName = "CompensateFactorDay";
	string UIWidget = "Spinner";
> = {0.0};
float compfactor_in
<
	string UIName = "CompensateFactorInteriorNight";
	string UIWidget = "Spinner";
> = {0.0};
float compfactor_id
<
	string UIName = "CompensateFactorInteriorDay";
	string UIWidget = "Spinner";
> = {0.0};
/* compensation power (contrast) */
float comppow_n
<
	string UIName = "CompensatePowerNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float comppow_d
<
	string UIName = "CompensatePowerDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float comppow_in
<
	string UIName = "CompensatePowerInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float comppow_id
<
	string UIName = "CompensatePowerInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* compensation saturation (higher values desaturate highlights) */
float compsat_n
<
	string UIName = "CompensateSaturationNight";
	string UIWidget = "Spinner";
> = {1.0};
float compsat_d
<
	string UIName = "CompensateSaturationDay";
	string UIWidget = "Spinner";
> = {1.0};
float compsat_in
<
	string UIName = "CompensateSaturationInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float compsat_id
<
	string UIName = "CompensateSaturationInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* Color grading */
bool gradeenable1
<
	string UIName = "UseRGBGrading";
	string UIWidget = "Checkbox";
> = {false};
/* color component multipliers */
float grademul_r_n
<
	string UIName = "GradingMulRNight";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_g_n
<
	string UIName = "GradingMulGNight";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_b_n
<
	string UIName = "GradingMulBNight";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_r_d
<
	string UIName = "GradingMulRDay";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_g_d
<
	string UIName = "GradingMulGDay";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_b_d
<
	string UIName = "GradingMulBDay";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_r_in
<
	string UIName = "GradingMulRInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_g_in
<
	string UIName = "GradingMulGInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_b_in
<
	string UIName = "GradingMulBInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_r_id
<
	string UIName = "GradingMulRInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_g_id
<
	string UIName = "GradingMulGInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
float grademul_b_id
<
	string UIName = "GradingMulBInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* color component contrasts */
float gradepow_r_n
<
	string UIName = "GradingPowRNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_g_n
<
	string UIName = "GradingPowGNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_b_n
<
	string UIName = "GradingPowBNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_r_d
<
	string UIName = "GradingPowRDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_g_d
<
	string UIName = "GradingPowGDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_b_d
<
	string UIName = "GradingPowBDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_r_in
<
	string UIName = "GradingPowRInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_g_in
<
	string UIName = "GradingPowGInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_b_in
<
	string UIName = "GradingPowBInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_r_id
<
	string UIName = "GradingPowRInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_g_id
<
	string UIName = "GradingPowGInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float gradepow_b_id
<
	string UIName = "GradingPowBInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* colorization factors */
bool gradeenable2
<
	string UIName = "UseColorizeGrading";
	string UIWidget = "Checkbox";
> = {false};
float gradecol_r_n
<
	string UIName = "GradingColRNight";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_g_n
<
	string UIName = "GradingColGNight";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_b_n
<
	string UIName = "GradingColBNight";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_r_d
<
	string UIName = "GradingColRDay";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_g_d
<
	string UIName = "GradingColGDay";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_b_d
<
	string UIName = "GradingColBDay";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_r_in
<
	string UIName = "GradingColRInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_g_in
<
	string UIName = "GradingColGInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_b_in
<
	string UIName = "GradingColBInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_r_id
<
	string UIName = "GradingColRInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_g_id
<
	string UIName = "GradingColGInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
float gradecol_b_id
<
	string UIName = "GradingColBInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* blend factor for colorization (negative values are quite fancy) */
float gradecolfact_n
<
	string UIName = "GradingColFactorNight";
	string UIWidget = "Spinner";
> = {0.0};
float gradecolfact_d
<
	string UIName = "GradingColFactorDay";
	string UIWidget = "Spinner";
> = {0.0};
float gradecolfact_in
<
	string UIName = "GradingColFactorInteriorNight";
	string UIWidget = "Spinner";
> = {0.0};
float gradecolfact_id
<
	string UIName = "GradingColFactorInteriorDay";
	string UIWidget = "Spinner";
> = {0.0};
/* HSV grading */
bool gradeenable3
<
	string UIName = "UseHSVGrading";
	string UIWidget = "Checkbox";
> = {false};
/* saturation multiplier */
float gradesatmul_n
<
	string UIName = "GradingSatMulNight";
	string UIWidget = "Spinner";
> = {1.0};
float gradesatmul_d
<
	string UIName = "GradingSatMulDay";
	string UIWidget = "Spinner";
> = {1.0};
float gradesatmul_in
<
	string UIName = "GradingSatMulInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float gradesatmul_id
<
	string UIName = "GradingSatMulInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* saturation power */
float gradesatpow_n
<
	string UIName = "GradingSatPowNight";
	string UIWidget = "Spinner";
> = {1.0};
float gradesatpow_d
<
	string UIName = "GradingSatPowDay";
	string UIWidget = "Spinner";
> = {1.0};
float gradesatpow_in
<
	string UIName = "GradingSatPowInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float gradesatpow_id
<
	string UIName = "GradingSatPowInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* value multiplier */
float gradevalmul_n
<
	string UIName = "GradingValMulNight";
	string UIWidget = "Spinner";
> = {1.0};
float gradevalmul_d
<
	string UIName = "GradingValMulDay";
	string UIWidget = "Spinner";
> = {1.0};
float gradevalmul_in
<
	string UIName = "GradingValMulInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float gradevalmul_id
<
	string UIName = "GradingValMulInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* value power */
float gradevalpow_n
<
	string UIName = "GradingValPowNight";
	string UIWidget = "Spinner";
> = {1.0};
float gradevalpow_d
<
	string UIName = "GradingValPowDay";
	string UIWidget = "Spinner";
> = {1.0};
float gradevalpow_in
<
	string UIName = "GradingValPowInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float gradevalpow_id
<
	string UIName = "GradingValPowInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
bool colorizeafterhsv
<
	string UIName = "ColorizeAfterHSV";
	string UIWidget = "Checkbox";
> = {false};
/* game tinting support */
bool tintenable
<
	string UIName = "UseTint";
	string UIWidget = "Checkbox";
> = {true};
float tintblend
<
	string UIName = "TintingBlend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
bool tintbeforegrade
<
	string UIName = "TintingBeforeGrading";
	string UIWidget = "Checkbox";
> = {false};
/* vanilla grading */
bool vgradeenable
<
	string UIName = "EnableVanillaGrading";
	string UIWidget = "Checkbox";
> = {true};
float vgradeblend
<
	string UIName = "VanillaGradingBlend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
/* debug vanilla shader registers */
bool regdebug
<
	string UIName = "DebugRegisters";
	string UIWidget = "Checkbox";
> = {false};
/* scale of register bars */
float regdebugscale
<
	string UIName = "DebugRegistersScale";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};