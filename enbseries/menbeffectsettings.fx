/*
	menbeffectsettings.fx : MariENB base user-tweakable variables.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* Border darkening */
bool dkenable
<
	string UIName = "UseDark";
	string UIWidget = "Checkbox";
> = {false};
/* radius of darkening (relative to screen width) */
float dkradius_n
<
	string UIName = "DarkRadiusNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
float dkradius_d
<
	string UIName = "DarkRadiusDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
float dkradius_in
<
	string UIName = "DarkRadiusInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
float dkradius_id
<
	string UIName = "DarkRadiusInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
/* falloff of darkening */
float dkcurve_n
<
	string UIName = "DarkCurveNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.2};
float dkcurve_d
<
	string UIName = "DarkCurveDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.2};
float dkcurve_in
<
	string UIName = "DarkCurveInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.2};
float dkcurve_id
<
	string UIName = "DarkCurveInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.2};
/* bump of darkening */
float dkbump_n
<
	string UIName = "DarkBumpNight";
	string UIWidget = "Spinner";
> = {-0.75};
float dkbump_d
<
	string UIName = "DarkBumpDay";
	string UIWidget = "Spinner";
> = {-0.75};
float dkbump_in
<
	string UIName = "DarkBumpInteriorNight";
	string UIWidget = "Spinner";
> = {-0.75};
float dkbump_id
<
	string UIName = "DarkBumpInteriorDay";
	string UIWidget = "Spinner";
> = {-0.75};
/* Letterbox */
bool boxenable
<
	string UIName = "UseBox";
	string UIWidget = "Checkbox";
> = {false};
/* vertical factor */
float boxv
<
	string UIName = "BoxVertical";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.8};
/* film grain */
bool ne
<
	string UIName = "UseGrain";
	string UIWidget = "Checkbox";
> = {false};
/* speed of grain */
float nf
<
	string UIName = "GrainFrequency";
	string UIWidget = "Spinner";
> = {2500.0};
/* intensity of grain */
float ni
<
	string UIName = "GrainIntensity";
	string UIWidget = "Spinner";
> = {0.05};
/* saturation of grain */
float ns
<
	string UIName = "GrainSaturation";
	string UIWidget = "Spinner";
> = {0.0};
/* use two-pass grain (double the texture fetches, but looks less uniform) */
bool np
<
	string UIName = "GrainTwoPass";
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
	string UIName = "GrainBlend";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 3;
> = {1};
/* dark mask blend mode contrast for mask image */
float bnp
<
	string UIName = "GrainDarkMaskPower";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.5};
/* two-pass distortion factor (0 = look just like one-pass grain) */
float nk
<
	string UIName = "GrainTwoPassFactor";
	string UIWidget = "Spinner";
> = {0.04};
/* zoom factors for each component of each noise texture */
float nm1
<
	string UIName = "GrainMagnification1";
	string UIWidget = "Spinner";
> = {13.25};
float nm2
<
	string UIName = "GrainMagnification2";
	string UIWidget = "Spinner";
> = {19.64};
float nm3
<
	string UIName = "GrainMagnification3";
	string UIWidget = "Spinner";
> = {17.35};
float nm11
<
	string UIName = "GrainPass1Magnification1";
	string UIWidget = "Spinner";
> = {2.05};
float nm12
<
	string UIName = "GrainPass1Magnification2";
	string UIWidget = "Spinner";
> = {3.11};
float nm13
<
	string UIName = "GrainPass1Magnification3";
	string UIWidget = "Spinner";
> = {2.22};
float nm21
<
	string UIName = "GrainPass2Magnification1";
	string UIWidget = "Spinner";
> = {4.25};
float nm22
<
	string UIName = "GrainPass2Magnification2";
	string UIWidget = "Spinner";
> = {0.42};
float nm23
<
	string UIName = "GrainPass2Magnification3";
	string UIWidget = "Spinner";
> = {6.29};
/* contrast of grain */
float nj
<
	string UIName = "GrainPower";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
/* use curvature + chromatic aberration filter */
bool usecurve
<
	string UIName = "UseCurve";
	string UIWidget = "Checkbox";
> = {false};
/* this is a stupid filter and you should feel bad for using it */
float chromaab
<
	string UIName = "CurveChromaAberration";
	string UIWidget = "Spinner";
> = {0.05};
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
/* tone mapping */
bool tmapenable
<
	string UIName = "UseTonemapping";
	string UIWidget = "Checkbox";
> = {false};
float unA_n
<
	string UIName = "TonemapHighlightStrengthNight";
	string UIWidget = "Spinner";
> = {0.5};
float unA_d
<
	string UIName = "TonemapHighlightStrengthDay";
	string UIWidget = "Spinner";
> = {0.5};
float unA_in
<
	string UIName = "TonemapHighlightStrengthInteriorNight";
	string UIWidget = "Spinner";
> = {0.5};
float unA_id
<
	string UIName = "TonemapHighlightStrengthInteriorDay";
	string UIWidget = "Spinner";
> = {0.5};
float unB_n
<
	string UIName = "TonemapHighlightGammaNight";
	string UIWidget = "Spinner";
> = {1.0};
float unB_d
<
	string UIName = "TonemapHighlightGammaDay";
	string UIWidget = "Spinner";
> = {1.0};
float unB_in
<
	string UIName = "TonemapHighlightGammaInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float unB_id
<
	string UIName = "TonemapHighlightGammaInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
float unC_n
<
	string UIName = "TonemapMidtoneStrengthNight";
	string UIWidget = "Spinner";
> = {0.2};
float unC_d
<
	string UIName = "TonemapMidtoneStrengthDay";
	string UIWidget = "Spinner";
> = {0.2};
float unC_in
<
	string UIName = "TonemapMidtoneStrengthInteriorNight";
	string UIWidget = "Spinner";
> = {0.2};
float unC_id
<
	string UIName = "TonemapMidtoneStrengthInteriorDay";
	string UIWidget = "Spinner";
> = {0.2};
float unD_n
<
	string UIName = "TonemapMidtoneGammaNight";
	string UIWidget = "Spinner";
> = {0.75};
float unD_d
<
	string UIName = "TonemapMidtoneGammaDay";
	string UIWidget = "Spinner";
> = {0.75};
float unD_in
<
	string UIName = "TonemapMidtoneGammaInteriorNight";
	string UIWidget = "Spinner";
> = {0.75};
float unD_id
<
	string UIName = "TonemapMidtoneGammaInteriorDay";
	string UIWidget = "Spinner";
> = {0.75};
float unE_n
<
	string UIName = "TonemapShadowStrengthNight";
	string UIWidget = "Spinner";
> = {0.02};
float unE_d
<
	string UIName = "TonemapShadowStrengthDay";
	string UIWidget = "Spinner";
> = {0.02};
float unE_in
<
	string UIName = "TonemapShadowStrengthInteriorNight";
	string UIWidget = "Spinner";
> = {0.02};
float unE_id
<
	string UIName = "TonemapShadowStrengthInteriorDay";
	string UIWidget = "Spinner";
> = {0.02};
float unF_n
<
	string UIName = "TonemapShadowGammaNight";
	string UIWidget = "Spinner";
> = {0.30};
float unF_d
<
	string UIName = "TonemapShadowGammaDay";
	string UIWidget = "Spinner";
> = {0.30};
float unF_in
<
	string UIName = "TonemapShadowGammaInteriorNight";
	string UIWidget = "Spinner";
> = {0.30};
float unF_id
<
	string UIName = "TonemapShadowGammaInteriorDay";
	string UIWidget = "Spinner";
> = {0.30};
float unW_n
<
	string UIName = "TonemapWhiteNight";
	string UIWidget = "Spinner";
> = {10.0};
float unW_d
<
	string UIName = "TonemapWhiteDay";
	string UIWidget = "Spinner";
> = {10.0};
float unW_in
<
	string UIName = "TonemapWhiteInteriorNight";
	string UIWidget = "Spinner";
> = {10.0};
float unW_id
<
	string UIName = "TonemapWhiteInteriorDay";
	string UIWidget = "Spinner";
> = {10.0};
bool tmapbeforecomp
<
	string UIName = "TonemapBeforeCompensate";
	string UIWidget = "Checkbox";
> = {false};
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
> = {true};
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
bool fadebeforefilm
<
	string UIName = "FadeBeforeFilmFilters";
	string UIWidget = "Checkbox";
> = {false};
bool dodither
<
	string UIName = "EnablePostDither";
	string UIWidget = "Checkbox";
> = {true};
int dither
<
	string UIName = "DitherPattern";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 4;
> = {4};
bool bloomdebug
<
	string UIName = "DebugBloom";
	string UIWidget = "Checkbox";
> = {false};
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
> = {5.0};