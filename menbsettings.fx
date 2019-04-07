/*
	menbsettings.fx : MariENB user-tweakable variables.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the MIT License.
*/
/* FXAA */
bool fxaaenable
<
	string UIName = "EnableFXAA";
	string UIWidget = "Checkbox";
> = {false};
float fxaaspanmax
<
	string UIName = "FXAASpanMax";
	string UIWidget = "Checkbox";
> = {4.0};
float fxaareducemul
<
	string UIName = "FXAAReduceMul";
	string UIWidget = "Checkbox";
> = {16.0};
float fxaareducemin
<
	string UIName = "FXAAReduceMin";
	string UIWidget = "Checkbox";
> = {128.0};
/* border blurring */
bool bbenable
<
	string UIName = "BlurEnable";
	string UIWidget = "Checkbox";
> = {true};
/* border blur sampling range */
float bbsamp_n
<
	string UIName = "BlurSampleNight";
	string UIWidget = "Spinner";
> = {1.0};
float bbsamp_d
<
	string UIName = "BlurSampleDay";
	string UIWidget = "Spinner";
> = {1.0};
float bbsamp_in
<
	string UIName = "BlurSampleInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float bbsamp_id
<
	string UIName = "BlurSampleInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* border blur level */
int bblevel
<
	string UIName = "BlurLevel";
	string UIWidget = "Spinner";
> = {1};
/* blend power of blur */
float bbpow_n
<
	string UIName = "BlurPowerNight";
	string UIWidget = "Spinner";
> = {15.46};
float bbpow_d
<
	string UIName = "BlurPowerDay";
	string UIWidget = "Spinner";
> = {15.46};
float bbpow_in
<
	string UIName = "BlurPowerInteriorNight";
	string UIWidget = "Spinner";
> = {15.46};
float bbpow_id
<
	string UIName = "BlurPowerInteriorDay";
	string UIWidget = "Spinner";
> = {15.46};
/* falloff curve of blur towards center of screen */
float bbcurve_n
<
	string UIName = "BlurCurveNight";
	string UIWidget = "Spinner";
> = {1.2};
float bbcurve_d
<
	string UIName = "BlurCurveDay";
	string UIWidget = "Spinner";
> = {1.2};
float bbcurve_in
<
	string UIName = "BlurCurveInteriorNight";
	string UIWidget = "Spinner";
> = {1.2};
float bbcurve_id
<
	string UIName = "BlurCurveInteriorDay";
	string UIWidget = "Spinner";
> = {1.2};
/* blur falloff radius */
float bbradius_n
<
	string UIName = "BlurRadiusNight";
	string UIWidget = "Spinner";
> = {0.69};
float bbradius_d
<
	string UIName = "BlurRadiusDay";
	string UIWidget = "Spinner";
> = {0.69};
float bbradius_in
<
	string UIName = "BlurRadiusInteriorNight";
	string UIWidget = "Spinner";
> = {0.69};
float bbradius_id
<
	string UIName = "BlurRadiusInteriorDay";
	string UIWidget = "Spinner";
> = {0.69};
/* border darkening */
bool dkenable
<
	string UIName = "DarkEnable";
	string UIWidget = "Checkbox";
> = {true};
/* radius of darkening (relative to screen width) */
float dkradius_n
<
	string UIName = "DarkRadiusNight";
	string UIWidget = "Spinner";
> = {0.37};
float dkradius_d
<
	string UIName = "DarkRadiusDay";
	string UIWidget = "Spinner";
> = {0.37};
float dkradius_in
<
	string UIName = "DarkRadiusInteriorNight";
	string UIWidget = "Spinner";
> = {0.37};
float dkradius_id
<
	string UIName = "DarkRadiusInteriorDay";
	string UIWidget = "Spinner";
> = {0.37};
/* falloff of darkening */
float dkcurve_n
<
	string UIName = "DarkCurveNight";
	string UIWidget = "Spinner";
> = {1.94};
float dkcurve_d
<
	string UIName = "DarkCurveDay";
	string UIWidget = "Spinner";
> = {1.94};
float dkcurve_in
<
	string UIName = "DarkCurveInteriorNight";
	string UIWidget = "Spinner";
> = {1.94};
float dkcurve_id
<
	string UIName = "DarkCurveInteriorDay";
	string UIWidget = "Spinner";
> = {1.94};
/* bump of darkening */
float dkbump_n
<
	string UIName = "DarkBumpNight";
	string UIWidget = "Spinner";
> = {0.79};
float dkbump_d
<
	string UIName = "DarkBumpDay";
	string UIWidget = "Spinner";
> = {0.79};
float dkbump_in
<
	string UIName = "DarkBumpInteriorNight";
	string UIWidget = "Spinner";
> = {0.79};
float dkbump_id
<
	string UIName = "DarkBumpInteriorDay";
	string UIWidget = "Spinner";
> = {0.79};
/* shine/bloom compensation */
bool compenable
<
	string UIName = "EnableCompensate";
	string UIWidget = "Checkbox";
> = {true};
/* compensation factor */
float compfactor_n
<
	string UIName = "CompensateFactorNight";
	string UIWidget = "Spinner";
> = {0.19};
float compfactor_d
<
	string UIName = "CompensateFactorDay";
	string UIWidget = "Spinner";
> = {0.19};
float compfactor_in
<
	string UIName = "CompensateFactorInteriorNight";
	string UIWidget = "Spinner";
> = {0.19};
float compfactor_id
<
	string UIName = "CompensateFactorInteriorDay";
	string UIWidget = "Spinner";
> = {0.19};
/* compensation power */
float comppow_n
<
	string UIName = "CompensatePowerNight";
	string UIWidget = "Spinner";
> = {1.05};
float comppow_d
<
	string UIName = "CompensatePowerDay";
	string UIWidget = "Spinner";
> = {1.05};
float comppow_in
<
	string UIName = "CompensatePowerInteriorNight";
	string UIWidget = "Spinner";
> = {1.05};
float comppow_id
<
	string UIName = "CompensatePowerInteriorDay";
	string UIWidget = "Spinner";
> = {1.05};
/* compensation saturation */
float compsat_n
<
	string UIName = "CompensateSaturationNight";
	string UIWidget = "Spinner";
> = {0.3};
float compsat_d
<
	string UIName = "CompensateSaturationDay";
	string UIWidget = "Spinner";
> = {0.3};
float compsat_in
<
	string UIName = "CompensateSaturationInteriorNight";
	string UIWidget = "Spinner";
> = {0.3};
float compsat_id
<
	string UIName = "CompensateSaturationInteriorDay";
	string UIWidget = "Spinner";
> = {0.3};
/* brightness bump for compensation */
float compbump_n
<
	string UIName = "CompensateBumpNight";
	string UIWidget = "Spinner";
> = {0.0};
float compbump_d
<
	string UIName = "CompensateBumpDay";
	string UIWidget = "Spinner";
> = {0.0};
float compbump_in
<
	string UIName = "CompensateBumpInteriorNight";
	string UIWidget = "Spinner";
> = {0.0};
float compbump_id
<
	string UIName = "CompensateBumpInteriorDay";
	string UIWidget = "Spinner";
> = {0.0};
bool gradeenable
<
	string UIName = "EnableGrading";
	string UIWidget = "Checkbox";
> = {true};
/* miscellaneous color grading parameters */
float gradeadd_r_n
<
	string UIName = "GradingAddRNight";
	string UIWidget = "Spinner";
> = {0.0};
float gradeadd_g_n
<
	string UIName = "GradingAddGNight";
	string UIWidget = "Spinner";
> = {0.0};
float gradeadd_b_n
<
	string UIName = "GradingAddBNight";
	string UIWidget = "Spinner";
> = {0.0};
float gradeadd_r_d
<
	string UIName = "GradingAddRDay";
	string UIWidget = "Spinner";
> = {0.0};
float gradeadd_g_d
<
	string UIName = "GradingAddGDay";
	string UIWidget = "Spinner";
> = {0.0};
float gradeadd_b_d
<
	string UIName = "GradingAddBDay";
	string UIWidget = "Spinner";
> = {0.0};
float gradeadd_r_in
<
	string UIName = "GradingAddRInteriorNight";
	string UIWidget = "Spinner";
> = {0.0};
float gradeadd_g_in
<
	string UIName = "GradingAddGInteriorNight";
	string UIWidget = "Spinner";
> = {0.0};
float gradeadd_b_in
<
	string UIName = "GradingAddBInteriorNight";
	string UIWidget = "Spinner";
> = {0.0};
float gradeadd_r_id
<
	string UIName = "GradingAddRInteriorDay";
	string UIWidget = "Spinner";
> = {0.0};
float gradeadd_g_id
<
	string UIName = "GradingAddGInteriorDay";
	string UIWidget = "Spinner";
> = {0.0};
float gradeadd_b_id
<
	string UIName = "GradingAddBInteriorDay";
	string UIWidget = "Spinner";
> = {0.0};
float grademul_r_n
<
	string UIName = "GradingMulRNight";
	string UIWidget = "Spinner";
> = {1.02};
float grademul_g_n
<
	string UIName = "GradingMulGNight";
	string UIWidget = "Spinner";
> = {1.08};
float grademul_b_n
<
	string UIName = "GradingMulBNight";
	string UIWidget = "Spinner";
> = {1.04};
float grademul_r_d
<
	string UIName = "GradingMulRDay";
	string UIWidget = "Spinner";
> = {1.02};
float grademul_g_d
<
	string UIName = "GradingMulGDay";
	string UIWidget = "Spinner";
> = {1.08};
float grademul_b_d
<
	string UIName = "GradingMulBDay";
	string UIWidget = "Spinner";
> = {1.04};
float grademul_r_in
<
	string UIName = "GradingMulRInteriorNight";
	string UIWidget = "Spinner";
> = {1.02};
float grademul_g_in
<
	string UIName = "GradingMulGInteriorNight";
	string UIWidget = "Spinner";
> = {1.08};
float grademul_b_in
<
	string UIName = "GradingMulBInteriorNight";
	string UIWidget = "Spinner";
> = {1.04};
float grademul_r_id
<
	string UIName = "GradingMulRInteriorDay";
	string UIWidget = "Spinner";
> = {1.02};
float grademul_g_id
<
	string UIName = "GradingMulGInteriorDay";
	string UIWidget = "Spinner";
> = {1.08};
float grademul_b_id
<
	string UIName = "GradingMulBInteriorDay";
	string UIWidget = "Spinner";
> = {1.04};
float gradepow_r_n
<
	string UIName = "GradingPowRNight";
	string UIWidget = "Spinner";
> = {1.07};
float gradepow_g_n
<
	string UIName = "GradingPowGNight";
	string UIWidget = "Spinner";
> = {1.12};
float gradepow_b_n
<
	string UIName = "GradingPowBNight";
	string UIWidget = "Spinner";
> = {1.08};
float gradepow_r_d
<
	string UIName = "GradingPowRDay";
	string UIWidget = "Spinner";
> = {1.07};
float gradepow_g_d
<
	string UIName = "GradingPowGDay";
	string UIWidget = "Spinner";
> = {1.12};
float gradepow_b_d
<
	string UIName = "GradingPowBDay";
	string UIWidget = "Spinner";
> = {1.08};
float gradepow_r_in
<
	string UIName = "GradingPowRInteriorNight";
	string UIWidget = "Spinner";
> = {1.07};
float gradepow_g_in
<
	string UIName = "GradingPowGInteriorNight";
	string UIWidget = "Spinner";
> = {1.12};
float gradepow_b_in
<
	string UIName = "GradingPowBInteriorNight";
	string UIWidget = "Spinner";
> = {1.08};
float gradepow_r_id
<
	string UIName = "GradingPowRInteriorDay";
	string UIWidget = "Spinner";
> = {1.07};
float gradepow_g_id
<
	string UIName = "GradingPowGInteriorDay";
	string UIWidget = "Spinner";
> = {1.12};
float gradepow_b_id
<
	string UIName = "GradingPowBInteriorDay";
	string UIWidget = "Spinner";
> = {1.08};
float gradecol_r_n
<
	string UIName = "GradingColRNight";
	string UIWidget = "Spinner";
> = {0.04};
float gradecol_g_n
<
	string UIName = "GradingColGNight";
	string UIWidget = "Spinner";
> = {0.07};
float gradecol_b_n
<
	string UIName = "GradingColBNight";
	string UIWidget = "Spinner";
> = {0.59};
float gradecol_r_d
<
	string UIName = "GradingColRDay";
	string UIWidget = "Spinner";
> = {0.04};
float gradecol_g_d
<
	string UIName = "GradingColGDay";
	string UIWidget = "Spinner";
> = {0.07};
float gradecol_b_d
<
	string UIName = "GradingColBDay";
	string UIWidget = "Spinner";
> = {0.59};
float gradecol_r_in
<
	string UIName = "GradingColRInteriorNight";
	string UIWidget = "Spinner";
> = {0.04};
float gradecol_g_in
<
	string UIName = "GradingColGInteriorNight";
	string UIWidget = "Spinner";
> = {0.07};
float gradecol_b_in
<
	string UIName = "GradingColBInteriorNight";
	string UIWidget = "Spinner";
> = {0.59};
float gradecol_r_id
<
	string UIName = "GradingColRInteriorDay";
	string UIWidget = "Spinner";
> = {0.04};
float gradecol_g_id
<
	string UIName = "GradingColGInteriorDay";
	string UIWidget = "Spinner";
> = {0.07};
float gradecol_b_id
<
	string UIName = "GradingColBInteriorDay";
	string UIWidget = "Spinner";
> = {0.59};
float gradecolfact_n
<
	string UIName = "GradingColFactorNight";
	string UIWidget = "Spinner";
> = {-0.24};
float gradecolfact_d
<
	string UIName = "GradingColFactorDay";
	string UIWidget = "Spinner";
> = {-0.24};
float gradecolfact_in
<
	string UIName = "GradingColFactorInteriorNight";
	string UIWidget = "Spinner";
> = {-0.24};
float gradecolfact_id
<
	string UIName = "GradingColFactorInteriorDay";
	string UIWidget = "Spinner";
> = {-0.24};
/* Soft grain */
bool ne
<
	string UIName = "EnableSoftGrain";
	string UIWidget = "Checkbox";
> = {true};
/* soft grain speed */
float nf_n
<
	string UIName = "SoftGrainSpeedNight";
	string UIWidget = "Spinner";
> = {2.68};
float nf_d
<
	string UIName = "SoftGrainSpeedDay";
	string UIWidget = "Spinner";
> = {2.68};
float nf_in
<
	string UIName = "SoftGrainSpeedInteriorNight";
	string UIWidget = "Spinner";
> = {2.68};
float nf_id
<
	string UIName = "SoftGrainSpeedInteriorDay";
	string UIWidget = "Spinner";
> = {2.68};
/* soft grain intensity */
float ni_n
<
	string UIName = "SoftGrainIntensityNight";
	string UIWidget = "Spinner";
> = {0.04};
float ni_d
<
	string UIName = "SoftGrainIntensityDay";
	string UIWidget = "Spinner";
> = {0.04};
float ni_in
<
	string UIName = "SoftGrainIntensityInteriorNight";
	string UIWidget = "Spinner";
> = {0.04};
float ni_id
<
	string UIName = "SoftGrainIntensityInteriorDay";
	string UIWidget = "Spinner";
> = {0.04};
/* soft grain saturation */
float ns_n
<
	string UIName = "SoftGrainSaturationNight";
	string UIWidget = "Spinner";
> = {0.09};
float ns_d
<
	string UIName = "SoftGrainSaturationDay";
	string UIWidget = "Spinner";
> = {0.09};
float ns_in
<
	string UIName = "SoftGrainSaturationInteriorNight";
	string UIWidget = "Spinner";
> = {0.09};
float ns_id
<
	string UIName = "SoftGrainSaturationInteriorDay";
	string UIWidget = "Spinner";
> = {0.09};
/* Two-pass noise */
bool np
<
	string UIName = "SoftGrainTwopass";
	string UIWidget = "Checkbox";
> = {true};
/* grain blend function: 0 normal, 1 add, 2 overlay, 3 multiply */
int nb
<
	string UIName = "SoftGrainBlendfunc";
	string UIWidget = "Spinner";
> = {1};
/* grain deviation */
float nk
<
	string UIName = "SoftGrainDeviation";
	string UIWidget = "Spinner";
> = {0.05};
/* grain magnification */
float nm1
<
	string UIName = "SoftGrainMagnification1";
	string UIWidget = "Spinner";
> = {1.25};
float nm2
<
	string UIName = "SoftGrainMagnification2";
	string UIWidget = "Spinner";
> = {0.64};
float nm3
<
	string UIName = "SoftGrainMagnification3";
	string UIWidget = "Spinner";
> = {0.35};
/* grain magnification pass 1 */
float nm11
<
	string UIName = "SoftGrainMagnification11";
	string UIWidget = "Spinner";
> = {2.05};
float nm12
<
	string UIName = "SoftGrainMagnification12";
	string UIWidget = "Spinner";
> = {3.11};
float nm13
<
	string UIName = "SoftGrainMagnification13";
	string UIWidget = "Spinner";
> = {2.22};
/* grain magnification pass 2 */
float nm21
<
	string UIName = "SoftGrainMagnification21";
	string UIWidget = "Spinner";
> = {4.25};
float nm22
<
	string UIName = "SoftGrainMagnification22";
	string UIWidget = "Spinner";
> = {0.42};
float nm23
<
	string UIName = "SoftGrainMagnification23";
	string UIWidget = "Spinner";
> = {6.29};
/* grain power */
float nj_n
<
	string UIName = "SoftGrainPowerNight";
	string UIWidget = "Spinner";
> = {2.93};
float nj_d
<
	string UIName = "SoftGrainPowerDay";
	string UIWidget = "Spinner";
> = {2.93};
float nj_in
<
	string UIName = "SoftGrainPowerInteriorNight";
	string UIWidget = "Spinner";
> = {2.93};
float nj_id
<
	string UIName = "SoftGrainPowerInteriorDay";
	string UIWidget = "Spinner";
> = {2.93};
/* Block graphics filter with palette reduction */
bool benable
<
	string UIName = "EnableBlockGFX";
	string UIWidget = "Checkbox";
> = {false};
/* emulated resolution for block graphics (0 or less for real resolution) */
float bresw
<
	string UIName = "BlockGFXResolutionW";
	string UIWidget = "Spinner";
> = {1.0};
float bresh
<
	string UIName = "BlockGFXResolutionH";
	string UIWidget = "Spinner";
> = {1.0};
/* palette type for block graphics */
int bpaltype
<
	string UIName = "BlockGFXpalette";
	string UIWidget = "Spinner";
> = {5};
/* CGA subpalette */
int bcganum
<
	string UIName = "BlockGFXcgamode";
	string UIWidget = "Spinner";
> = {0};
/* EGA subpalette */
int beganum
<
	string UIName = "BlockGFXegamode";
	string UIWidget = "Spinner";
> = {0};
/* Dithering method */
int bdither
<
	string UIName= "BlockGFXDither";
	string UIWidget = "Spinner";
> = {4};
/* Gamma modifier */
float bgamma
<
	string UIName= "BlockGFXPrepassGamma";
	string UIWidget = "Spinner";
> = {1.0};
/* dither bump */
float bdbump
<
	string UIName= "BlockGFXDitherBump";
	string UIWidget = "Spinner";
> = {-0.01};
/* dither multiplier */
float bdmult
<
	string UIName= "BlockGFXDitherMultiplier";
	string UIWidget = "Spinner";
> = {0.02};
/* dither saturation */
float bsaturation
<
	string UIName= "BlockGFXPrepassSaturation";
	string UIWidget = "Spinner";
> = {1.0};
/* Dirty screen effect (static noise) */
bool dirtenable
<
	string UIName = "EnableDirt";
	string UIWidget = "Checkbox";
> = {true};
/* dirt amount */
float dirtcfactor
<
	string UIName = "DirtCoordFactor";
	string UIWidget = "Spinner";
> = {0.09};
float dirtlfactor
<
	string UIName = "DirtLuminanceFactor";
	string UIWidget = "Spinner";
> = {0.0};
float dirtmc
<
	string UIName = "DirtCoordMagnification";
	string UIWidget = "Spinner";
> = {3.04};
float dirtml
<
	string UIName = "DirtLuminanceMagnification";
	string UIWidget = "Spinner";
> = {1.0};
/* Letterbox */
bool boxe
<
	string UIName = "EnableBox";
	string UIWidget = "Checkbox";
> = {true};
/* horizontal factor */
float boxh
<
	string UIName = "BoxHorizontal";
	string UIWidget = "Spinner";
> = {1.5};
/* vertical factor */
float boxv
<
	string UIName = "BoxVertical";
	string UIWidget = "Spinner";
> = {1.0};
/* softening */
float boxb
<
	string UIName = "BoxSoften";
	string UIWidget = "Spinner";
> = {0.02};
/* box alpha */
float boxa
<
	string UIName = "BoxAlpha";
	string UIWidget = "Spinner";
> = {6.07};
/* Use CRT curvature shader */
bool crtenable
<
	string UIName = "EnableCurvature";
	string UIWidget = "Checkbox";
> = {false};
/* chromatic aberration on CRT: fancy effect that isn't really realistic */
float chromaab
<
	string UIName = "CurveChromaticAberration";
	string UIWidget = "Spinner";
> = {0.93};
/* curvature lens zoom (0.5 = none) */
float lenszoom
<
	string UIName = "CurveZoom";
	string UIWidget = "Spinner";
> = {50.0};
/* curvature lens distortion */
float lensdist
<
	string UIName = "CurveLens";
	string UIWidget = "Spinner";
> = {0.0};
/* curvature CUBIC lens distortion */
float lensdistc
<
	string UIName = "CurveLensCubic";
	string UIWidget = "Spinner";
> = {0.0};
/* Use sharpening filter */
bool shenable
<
	string UIName = "EnableSharpen";
	string UIWidget = "Checkbox";
> = {false};
float shsamp
<
	string UIName = "SharpenSample";
	string UIWidget = "Spinner";
> = {0.6};
float shblend
<
	string UIName = "SharpenBlend";
	string UIWidget = "Spinner";
> = {0.2};
