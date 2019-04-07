/*
	menbbloomsettings.fx : MariENB bloom user-tweakable variables.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* bloom mix factors */
float bloommix1
<
	string UIName = "BloomMix1";
	string UIWidget = "Spinner";
> = {1.0};
float bloommix2
<
	string UIName = "BloomMix2";
	string UIWidget = "Spinner";
> = {1.0};
float bloommix3
<
	string UIName = "BloomMix3";
	string UIWidget = "Spinner";
> = {1.0};
float bloommix4
<
	string UIName = "BloomMix4";
	string UIWidget = "Spinner";
> = {1.0};
float bloommix7
<
	string UIName = "BloomMix7";
	string UIWidget = "Spinner";
> = {1.0};
float bloommix8
<
	string UIName = "BloomMix8";
	string UIWidget = "Spinner";
> = {1.0};
float bloommix5
<
	string UIName = "BloomMixNoBlur";
	string UIWidget = "Spinner";
> = {0.0};
float bloommix6
<
	string UIName = "BloomMixBaseImage";
	string UIWidget = "Spinner";
> = {0.0};
/* bloom intensity */
float bloomintensity_n
<
	string UIName = "BloomIntensityNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloomintensity_d
<
	string UIName = "BloomIntensityDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloomintensity_in
<
	string UIName = "BloomIntensityInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloomintensity_id
<
	string UIName = "BloomIntensityInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* bloom power (contrast) */
float bloompower_n
<
	string UIName = "BloomPowerNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloompower_d
<
	string UIName = "BloomPowerDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloompower_in
<
	string UIName = "BloomPowerInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloompower_id
<
	string UIName = "BloomPowerInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* bloom saturation */
float bloomsaturation_n
<
	string UIName = "BloomSaturationNight";
	string UIWidget = "Spinner";
> = {1.0};
float bloomsaturation_d
<
	string UIName = "BloomSaturationDay";
	string UIWidget = "Spinner";
> = {1.0};
float bloomsaturation_in
<
	string UIName = "BloomSaturationInteriorNight";
	string UIWidget = "Spinner";
> = {1.0};
float bloomsaturation_id
<
	string UIName = "BloomSaturationInteriorDay";
	string UIWidget = "Spinner";
> = {1.0};
/* bloom offset (negative values keep dark areas from muddying up) */
float bloombump_n
<
	string UIName = "BloomBumpNight";
	string UIWidget = "Spinner";
> = {-0.5};
float bloombump_d
<
	string UIName = "BloomBumpDay";
	string UIWidget = "Spinner";
> = {-0.5};
float bloombump_in
<
	string UIName = "BloomBumpInteriorNight";
	string UIWidget = "Spinner";
> = {-0.5};
float bloombump_id
<
	string UIName = "BloomBumpInteriorDay";
	string UIWidget = "Spinner";
> = {-0.5};
/* bloom cap (maximum brightness samples can have) */
float bloomcap_n
<
	string UIName = "BloomCapNight";
	string UIWidget = "Spinner";
> = {10.0};
float bloomcap_d
<
	string UIName = "BloomCapDay";
	string UIWidget = "Spinner";
> = {10.0};
float bloomcap_in
<
	string UIName = "BloomCapInteriorNight";
	string UIWidget = "Spinner";
> = {10.0};
float bloomcap_id
<
	string UIName = "BloomCapInteriorDay";
	string UIWidget = "Spinner";
> = {10.0};
/* bloom tint/blueshift parameters */
float blu_n_r
<
	string UIName = "BlueShiftColorNightRed";
	string UIWidget = "Spinner";
> = {0.65};
float blu_n_g
<
	string UIName = "BlueShiftColorNightGreen";
	string UIWidget = "Spinner";
> = {0.37};
float blu_n_b
<
	string UIName = "BlueShiftColorNightBlue";
	string UIWidget = "Spinner";
> = {1.0};
float blu_d_r
<
	string UIName = "BlueShiftColorDayRed";
	string UIWidget = "Spinner";
> = {0.65};
float blu_d_g
<
	string UIName = "BlueShiftColorDayGreen";
	string UIWidget = "Spinner";
> = {0.37};
float blu_d_b
<
	string UIName = "BlueShiftColorDayBlue";
	string UIWidget = "Spinner";
> = {1.0};
float blu_in_r
<
	string UIName = "BlueShiftColorInteriorNightRed";
	string UIWidget = "Spinner";
> = {0.65};
float blu_in_g
<
	string UIName = "BlueShiftColorInteriorNightGreen";
	string UIWidget = "Spinner";
> = {0.37};
float blu_in_b
<
	string UIName = "BlueShiftColorInteriorNightBlue";
	string UIWidget = "Spinner";
> = {1.0};
float blu_id_r
<
	string UIName = "BlueShiftColorInteriorDayRed";
	string UIWidget = "Spinner";
> = {0.65};
float blu_id_g
<
	string UIName = "BlueShiftColorInteriorDayGreen";
	string UIWidget = "Spinner";
> = {0.37};
float blu_id_b
<
	string UIName = "BlueShiftColorInteriorDayBlue";
	string UIWidget = "Spinner";
> = {1.0};
float bsi_n
<
	string UIName = "BlueShiftIntensityNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bsi_d
<
	string UIName = "BlueShiftIntensityDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bsi_in
<
	string UIName = "BlueShiftIntensityInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bsi_id
<
	string UIName = "BlueShiftIntensityInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* anamorphic lens flare (very intensive) */
bool alfenable
<
	string UIName = "EnableAnamorphicLensFlare";
	string UIWidget = "Checkbox";
> = {true};
float fbl_n
<
	string UIName = "FlareBlendNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fbl_d
<
	string UIName = "FlareBlendDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fbl_in
<
	string UIName = "FlareBlendInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fbl_id
<
	string UIName = "FlareBlendInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float flu_n_r
<
	string UIName = "FlareBlueShiftColorNightRed";
	string UIWidget = "Spinner";
> = {0.65};
float flu_n_g
<
	string UIName = "FlareBlueShiftColorNightGreen";
	string UIWidget = "Spinner";
> = {0.37};
float flu_n_b
<
	string UIName = "FlareBlueShiftColorNightBlue";
	string UIWidget = "Spinner";
> = {1.0};
float flu_d_r
<
	string UIName = "FlareBlueShiftColorDayRed";
	string UIWidget = "Spinner";
> = {0.65};
float flu_d_g
<
	string UIName = "FlareBlueShiftColorDayGreen";
	string UIWidget = "Spinner";
> = {0.37};
float flu_d_b
<
	string UIName = "FlareBlueShiftColorDayBlue";
	string UIWidget = "Spinner";
> = {1.0};
float flu_in_r
<
	string UIName = "FlareBlueShiftColorInteriorNightRed";
	string UIWidget = "Spinner";
> = {0.65};
float flu_in_g
<
	string UIName = "FlareBlueShiftColorInteriorNightGreen";
	string UIWidget = "Spinner";
> = {0.37};
float flu_in_b
<
	string UIName = "FlareBlueShiftColorInteriorNightBlue";
	string UIWidget = "Spinner";
> = {1.0};
float flu_id_r
<
	string UIName = "FlareBlueShiftColorInteriorDayRed";
	string UIWidget = "Spinner";
> = {0.65};
float flu_id_g
<
	string UIName = "FlareBlueShiftColorInteriorDayGreen";
	string UIWidget = "Spinner";
> = {0.37};
float flu_id_b
<
	string UIName = "FlareBlueShiftColorInteriorDayBlue";
	string UIWidget = "Spinner";
> = {1.0};
float fsi_n
<
	string UIName = "FlareBlueShiftIntensityNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fsi_d
<
	string UIName = "FlareBlueShiftIntensityDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fsi_in
<
	string UIName = "FlareBlueShiftIntensityInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fsi_id
<
	string UIName = "FlareBlueShiftIntensityInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fpw_n
<
	string UIName = "FlarePowerNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fpw_d
<
	string UIName = "FlarePowerDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fpw_in
<
	string UIName = "FlarePowerInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fpw_id
<
	string UIName = "FlarePowerInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};