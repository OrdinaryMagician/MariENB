/*
	menbeffectsettings.fx : MariENB base user-tweakable variables.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the WTFPL.
*/
/* fixed resolution, keeps blur filters at a consistent internal resolution */
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
/* Border darkening */
/* radius of darkening (relative to screen width) */
float dkradius_n
<
	string UIName = "DarkRadiusNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.40};
float dkradius_d
<
	string UIName = "DarkRadiusDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.29};
float dkradius_in
<
	string UIName = "DarkRadiusInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.50};
float dkradius_id
<
	string UIName = "DarkRadiusInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.39};
/* falloff of darkening */
float dkcurve_n
<
	string UIName = "DarkCurveNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.70};
float dkcurve_d
<
	string UIName = "DarkCurveDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.30};
float dkcurve_in
<
	string UIName = "DarkCurveInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.35};
float dkcurve_id
<
	string UIName = "DarkCurveInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.67};
/* bump of darkening */
float dkbump_n
<
	string UIName = "DarkBumpNight";
	string UIWidget = "Spinner";
> = {0.74};
float dkbump_d
<
	string UIName = "DarkBumpDay";
	string UIWidget = "Spinner";
> = {0.33};
float dkbump_in
<
	string UIName = "DarkBumpInteriorNight";
	string UIWidget = "Spinner";
> = {0.82};
float dkbump_id
<
	string UIName = "DarkBumpInteriorDay";
	string UIWidget = "Spinner";
> = {0.61};
/* "adaptation" factors */
float amin_n
<
	string UIName = "AdaptationMinNight";
	string UIWidget = "Spinner";
> = {0.20};
float amin_d
<
	string UIName = "AdaptationMinDay";
	string UIWidget = "Spinner";
> = {0.09};
float amin_in
<
	string UIName = "AdaptationMinInteriorNight";
	string UIWidget = "Spinner";
> = {0.17};
float amin_id
<
	string UIName = "AdaptationMinInteriorDay";
	string UIWidget = "Spinner";
> = {0.10};
float amax_n
<
	string UIName = "AdaptationMaxNight";
	string UIWidget = "Spinner";
> = {1.21};
float amax_d
<
	string UIName = "AdaptationMaxDay";
	string UIWidget = "Spinner";
> = {0.94};
float amax_in
<
	string UIName = "AdaptationMaxInteriorNight";
	string UIWidget = "Spinner";
> = {1.26};
float amax_id
<
	string UIName = "AdaptationMaxInteriorDay";
	string UIWidget = "Spinner";
> = {0.91};
/* overshine/bloom compensation */
/* compensation factor */
float compfactor_n
<
	string UIName = "CompensateFactorNight";
	string UIWidget = "Spinner";
> = {0.23};
float compfactor_d
<
	string UIName = "CompensateFactorDay";
	string UIWidget = "Spinner";
> = {0.46};
float compfactor_in
<
	string UIName = "CompensateFactorInteriorNight";
	string UIWidget = "Spinner";
> = {0.30};
float compfactor_id
<
	string UIName = "CompensateFactorInteriorDay";
	string UIWidget = "Spinner";
> = {0.39};
/* compensation power (contrast) */
float comppow_n
<
	string UIName = "CompensatePowerNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.08};
float comppow_d
<
	string UIName = "CompensatePowerDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.11};
float comppow_in
<
	string UIName = "CompensatePowerInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.05};
float comppow_id
<
	string UIName = "CompensatePowerInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.14};
/* compensation saturation (higher values desaturate highlights) */
float compsat_n
<
	string UIName = "CompensateSaturationNight";
	string UIWidget = "Spinner";
> = {0.97};
float compsat_d
<
	string UIName = "CompensateSaturationDay";
	string UIWidget = "Spinner";
> = {0.85};
float compsat_in
<
	string UIName = "CompensateSaturationInteriorNight";
	string UIWidget = "Spinner";
> = {0.89};
float compsat_id
<
	string UIName = "CompensateSaturationInteriorDay";
	string UIWidget = "Spinner";
> = {0.74};
/* Color grading */
/* color component multipliers */
float grademul_r_n
<
	string UIName = "GradingMulRNight";
	string UIWidget = "Spinner";
> = {1.04};
float grademul_g_n
<
	string UIName = "GradingMulGNight";
	string UIWidget = "Spinner";
> = {1.08};
float grademul_b_n
<
	string UIName = "GradingMulBNight";
	string UIWidget = "Spinner";
> = {1.15};
float grademul_r_d
<
	string UIName = "GradingMulRDay";
	string UIWidget = "Spinner";
> = {1.66};
float grademul_g_d
<
	string UIName = "GradingMulGDay";
	string UIWidget = "Spinner";
> = {1.45};
float grademul_b_d
<
	string UIName = "GradingMulBDay";
	string UIWidget = "Spinner";
> = {1.29};
float grademul_r_in
<
	string UIName = "GradingMulRInteriorNight";
	string UIWidget = "Spinner";
> = {1.35};
float grademul_g_in
<
	string UIName = "GradingMulGInteriorNight";
	string UIWidget = "Spinner";
> = {1.18};
float grademul_b_in
<
	string UIName = "GradingMulBInteriorNight";
	string UIWidget = "Spinner";
> = {1.22};
float grademul_r_id
<
	string UIName = "GradingMulRInteriorDay";
	string UIWidget = "Spinner";
> = {1.71};
float grademul_g_id
<
	string UIName = "GradingMulGInteriorDay";
	string UIWidget = "Spinner";
> = {1.60};
float grademul_b_id
<
	string UIName = "GradingMulBInteriorDay";
	string UIWidget = "Spinner";
> = {1.41};
/* color component contrasts */
float gradepow_r_n
<
	string UIName = "GradingPowRNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.02};
float gradepow_g_n
<
	string UIName = "GradingPowGNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.06};
float gradepow_b_n
<
	string UIName = "GradingPowBNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.03};
float gradepow_r_d
<
	string UIName = "GradingPowRDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.09};
float gradepow_g_d
<
	string UIName = "GradingPowGDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.08};
float gradepow_b_d
<
	string UIName = "GradingPowBDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.05};
float gradepow_r_in
<
	string UIName = "GradingPowRInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.08};
float gradepow_g_in
<
	string UIName = "GradingPowGInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.11};
float gradepow_b_in
<
	string UIName = "GradingPowBInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.06};
float gradepow_r_id
<
	string UIName = "GradingPowRInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.05};
float gradepow_g_id
<
	string UIName = "GradingPowGInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.04};
float gradepow_b_id
<
	string UIName = "GradingPowBInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.04};
/* colorization factors */
float gradecol_r_n
<
	string UIName = "GradingColRNight";
	string UIWidget = "Spinner";
> = {-0.59};
float gradecol_g_n
<
	string UIName = "GradingColGNight";
	string UIWidget = "Spinner";
> = {-0.26};
float gradecol_b_n
<
	string UIName = "GradingColBNight";
	string UIWidget = "Spinner";
> = {-0.73};
float gradecol_r_d
<
	string UIName = "GradingColRDay";
	string UIWidget = "Spinner";
> = {-0.62};
float gradecol_g_d
<
	string UIName = "GradingColGDay";
	string UIWidget = "Spinner";
> = {-0.10};
float gradecol_b_d
<
	string UIName = "GradingColBDay";
	string UIWidget = "Spinner";
> = {-0.81};
float gradecol_r_in
<
	string UIName = "GradingColRInteriorNight";
	string UIWidget = "Spinner";
> = {-0.41};
float gradecol_g_in
<
	string UIName = "GradingColGInteriorNight";
	string UIWidget = "Spinner";
> = {-0.18};
float gradecol_b_in
<
	string UIName = "GradingColBInteriorNight";
	string UIWidget = "Spinner";
> = {-1.69};
float gradecol_r_id
<
	string UIName = "GradingColRInteriorDay";
	string UIWidget = "Spinner";
> = {-0.60};
float gradecol_g_id
<
	string UIName = "GradingColGInteriorDay";
	string UIWidget = "Spinner";
> = {-0.45};
float gradecol_b_id
<
	string UIName = "GradingColBInteriorDay";
	string UIWidget = "Spinner";
> = {-0.85};
/* blend factor for colorization (negative values are quite fancy) */
float gradecolfact_n
<
	string UIName = "GradingColFactorNight";
	string UIWidget = "Spinner";
> = {-0.11};
float gradecolfact_d
<
	string UIName = "GradingColFactorDay";
	string UIWidget = "Spinner";
> = {-0.14};
float gradecolfact_in
<
	string UIName = "GradingColFactorInteriorNight";
	string UIWidget = "Spinner";
> = {-0.14};
float gradecolfact_id
<
	string UIName = "GradingColFactorInteriorDay";
	string UIWidget = "Spinner";
> = {-0.20};
/* Letterbox */
/* vertical factor */
float boxv
<
	string UIName = "BoxVertical";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.90};
/* softening (0 = disable) */
float boxb
<
	string UIName = "BoxSoften";
	string UIWidget = "Spinner";
> = {0.01};
/* box alpha */
float boxa
<
	string UIName = "BoxAlpha";
	string UIWidget = "Spinner";
> = {12.00};
/* soften bloom texture (remove blocky artifacts from downscaled bloom) */
bool softbloom
<
	string UIName = "BloomSoften";
	string UIWidget = "Checkbox";
> = {false};
