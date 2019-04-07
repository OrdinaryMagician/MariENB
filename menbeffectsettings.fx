/*
	menbeffectsettings.fx : MariENB base user-tweakable variables.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the MIT License.
*/
/* Soften bloom */
bool softbloom
<
	string UIName = "EnableBloomSoften";
	string UIWidget = "Checkbox";
> = {true};
int softbloomlv
<
	string UIName = "BloomSoftenLevel";
	string UIWidget = "Slider";
> = {2};
float softbloomsmp
<
	string UIName = "BloomSoftenRadius";
	string UIWidget = "Slider";
> = {1.0};
/* Adaptation */
bool aenable
<
	string UIName = "EnableAdaptation";
	string UIWidget = "Checkbox";
> = {true};
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
bool tmenable
<
	string UIName = "EnableTonemapping";
	string UIWidget = "Checkbox";
> = {true};
float tone_n
<
	string UIName = "TonemappingNight";
	string UIWidget = "Spinner";
> = {1.0};
float tone_d
<
	string UIName = "TonemappingDay";
	string UIWidget = "Spinner";
> = {1.0};
float tone_in
<
	string UIName = "TonemappingInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float tone_id
<
	string UIName = "TonemappingInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
float tovr_n
<
	string UIName = "TonemappingOversaturationNight";
	string UIWidget = "Spinner";
> = {1.0};
float tovr_d
<
	string UIName = "TonemappingOversaturationDay";
	string UIWidget = "Spinner";
> = {1.0};
float tovr_in
<
	string UIName = "TonemappingOversaturationInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float tovr_id
<
	string UIName = "TonemappingOversaturationInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* palette texture */
bool palenable
<
	string UIName = "EnablePalette";
	string UIWidget = "Checkbox";
> = {true};
float palb_n
<
	string UIName = "PaletteBlendNight";
	string UIWidget = "Spinner";
> = {1.0};
float palb_d
<
	string UIName = "PaletteBlendDay";
	string UIWidget = "Spinner";
> = {1.0};
float palb_in
<
	string UIName = "PaletteBlendInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float palb_id
<
	string UIName = "PaletteBlendInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
