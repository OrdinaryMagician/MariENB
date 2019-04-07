/*
	menbextrasettings.fx : MariENB extra user-tweakable variables.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the WTFPL.
*/
bool ne
<
	string UIName = "UseGrain";
	string UIWidget = "Checkbox";
> = {false};
float nf
<
	string UIName = "GrainFrequency";
	string UIWidget = "Spinner";
> = {0.25};
float ni
<
	string UIName = "GrainIntensity";
	string UIWidget = "Spinner";
> = {0.15};
float ns
<
	string UIName = "GrainSaturation";
	string UIWidget = "Spinner";
> = {0.0};
bool np
<
	string UIName = "GrainTwoPass";
	string UIWidget = "Checkbox";
> = {false};
int nb
<
	string UIName = "GrainBlend";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 3;
> = {0};
float nk
<
	string UIName = "GrainTwoPassFactor";
	string UIWidget = "Spinner";
> = {0.04};
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
float nj
<
	string UIName = "GrainPower";
	string UIWidget = "Spinner";
> = {4.33};
bool usecurve
<
	string UIName = "UseCurve";
	string UIWidget = "Checkbox";
> = {false};
float chromaab
<
	string UIName = "CurveChromaAberration";
	string UIWidget = "Spinner";
> = {0.07};
float lenszoom
<
	string UIName = "CurveLensZoom";
	string UIWidget = "Spinner";
> = {50.25};
float lensdist
<
	string UIName = "CurveLensDistortion";
	string UIWidget = "Spinner";
> = {0.0};
float lensdistc
<
	string UIName = "CurveLensDistortionCubic";
	string UIWidget = "Spinner";
> = {0.0};
bool lensclamp
<
	string UIName = "CurveLensClamp";
	string UIWidget = "Checkbox";
> = {true};
bool useblock
<
	string UIName = "UseBlockGFX";
	string UIWidget = "Checkbox";
> = {false};
float bresx
<
	string UIName = "EmulatedResX";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float bresy
<
	string UIName = "EmulatedResY";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
int paltype
<
	string UIName = "PaletteType";
	string UIWidget = "Spinner";
	int UIMin = -1;
	int UIMax = 6;
> = {2};
int cgapal
<
	string UIName = "CGAPalette";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 6;
> = {1};
int egapal
<
	string UIName = "EGAPalette";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 1;
> = {0};
int dither
<
	string UIName = "DitherMode";
	string UIWidget = "Spinner";
	int UIMin = -1;
	int UIMax = 4;
> = {4};
float bgamma
<
	string UIName = "GammaMod";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.65};
float bdbump
<
	string UIName = "DitherBump";
	string UIWidget = "Spinner";
> = {-0.1};
float bdmult
<
	string UIName = "DitherMultiplier";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.3};
float bsaturation
<
	string UIName = "SaturationMod";
	string UIWidget = "Spinner";
> = {1.0};