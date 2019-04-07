/*
	menbbloomsettings.fx : MariENB bloom user-tweakable variables.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* bloom blur radius */
float bloomradius
<
	string UIName = "BloomRadius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* bloom mix factors */
float bloommix1
<
	string UIName = "BloomMix1";
	string UIWidget = "Spinner";
> = {0.75};
float bloommix2
<
	string UIName = "BloomMix2";
	string UIWidget = "Spinner";
> = {0.8};
float bloommix3
<
	string UIName = "BloomMix3";
	string UIWidget = "Spinner";
> = {0.85};
float bloommix4
<
	string UIName = "BloomMix4";
	string UIWidget = "Spinner";
> = {0.9};
float bloommix7
<
	string UIName = "BloomMix7";
	string UIWidget = "Spinner";
> = {0.95};
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
> = {0.75};
float bloomsaturation_d
<
	string UIName = "BloomSaturationDay";
	string UIWidget = "Spinner";
> = {0.75};
float bloomsaturation_in
<
	string UIName = "BloomSaturationInteriorNight";
	string UIWidget = "Spinner";
> = {0.75};
float bloomsaturation_id
<
	string UIName = "BloomSaturationInteriorDay";
	string UIWidget = "Spinner";
> = {0.75};
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
> = {20.0};
float bloomcap_d
<
	string UIName = "BloomCapDay";
	string UIWidget = "Spinner";
> = {20.0};
float bloomcap_in
<
	string UIName = "BloomCapInteriorNight";
	string UIWidget = "Spinner";
> = {20.0};
float bloomcap_id
<
	string UIName = "BloomCapInteriorDay";
	string UIWidget = "Spinner";
> = {20.0};
/* bloom tint/blueshift parameters */
float blu_n_r
<
	string UIName = "BlueShiftColorNightRed";
	string UIWidget = "Spinner";
> = {0.2};
float blu_n_g
<
	string UIName = "BlueShiftColorNightGreen";
	string UIWidget = "Spinner";
> = {0.6};
float blu_n_b
<
	string UIName = "BlueShiftColorNightBlue";
	string UIWidget = "Spinner";
> = {1.0};
float blu_d_r
<
	string UIName = "BlueShiftColorDayRed";
	string UIWidget = "Spinner";
> = {0.2};
float blu_d_g
<
	string UIName = "BlueShiftColorDayGreen";
	string UIWidget = "Spinner";
> = {0.6};
float blu_d_b
<
	string UIName = "BlueShiftColorDayBlue";
	string UIWidget = "Spinner";
> = {1.0};
float blu_in_r
<
	string UIName = "BlueShiftColorInteriorNightRed";
	string UIWidget = "Spinner";
> = {0.2};
float blu_in_g
<
	string UIName = "BlueShiftColorInteriorNightGreen";
	string UIWidget = "Spinner";
> = {0.6};
float blu_in_b
<
	string UIName = "BlueShiftColorInteriorNightBlue";
	string UIWidget = "Spinner";
> = {1.0};
float blu_id_r
<
	string UIName = "BlueShiftColorInteriorDayRed";
	string UIWidget = "Spinner";
> = {0.2};
float blu_id_g
<
	string UIName = "BlueShiftColorInteriorDayGreen";
	string UIWidget = "Spinner";
> = {0.6};
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
> = {0.5};
float bsi_d
<
	string UIName = "BlueShiftIntensityDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float bsi_in
<
	string UIName = "BlueShiftIntensityInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float bsi_id
<
	string UIName = "BlueShiftIntensityInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
/* anamorphic bloom (very intensive) */
bool alfenable
<
	string UIName = "EnableAnamorphicBloom";
	string UIWidget = "Checkbox";
> = {true};
float fbl_n
<
	string UIName = "AnamBlendNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.75};
float fbl_d
<
	string UIName = "AnamBlendDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.75};
float fbl_in
<
	string UIName = "AnamBlendInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.75};
float fbl_id
<
	string UIName = "AnamBlendInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.75};
float flu_n_r
<
	string UIName = "AnamBlueShiftColorNightRed";
	string UIWidget = "Spinner";
> = {0.4};
float flu_n_g
<
	string UIName = "AnamBlueShiftColorNightGreen";
	string UIWidget = "Spinner";
> = {0.1};
float flu_n_b
<
	string UIName = "AnamBlueShiftColorNightBlue";
	string UIWidget = "Spinner";
> = {1.0};
float flu_d_r
<
	string UIName = "AnamBlueShiftColorDayRed";
	string UIWidget = "Spinner";
> = {0.5};
float flu_d_g
<
	string UIName = "AnamBlueShiftColorDayGreen";
	string UIWidget = "Spinner";
> = {0.1};
float flu_d_b
<
	string UIName = "AnamBlueShiftColorDayBlue";
	string UIWidget = "Spinner";
> = {1.0};
float flu_in_r
<
	string UIName = "AnamBlueShiftColorInteriorNightRed";
	string UIWidget = "Spinner";
> = {0.5};
float flu_in_g
<
	string UIName = "AnamBlueShiftColorInteriorNightGreen";
	string UIWidget = "Spinner";
> = {0.1};
float flu_in_b
<
	string UIName = "AnamBlueShiftColorInteriorNightBlue";
	string UIWidget = "Spinner";
> = {1.0};
float flu_id_r
<
	string UIName = "AnamBlueShiftColorInteriorDayRed";
	string UIWidget = "Spinner";
> = {0.5};
float flu_id_g
<
	string UIName = "AnamBlueShiftColorInteriorDayGreen";
	string UIWidget = "Spinner";
> = {0.1};
float flu_id_b
<
	string UIName = "AnamBlueShiftColorInteriorDayBlue";
	string UIWidget = "Spinner";
> = {1.0};
float fsi_n
<
	string UIName = "AnamBlueShiftIntensityNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fsi_d
<
	string UIName = "AnamBlueShiftIntensityDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fsi_in
<
	string UIName = "AnamBlueShiftIntensityInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fsi_id
<
	string UIName = "AnamBlueShiftIntensityInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fpw_n
<
	string UIName = "AnamPowerNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fpw_d
<
	string UIName = "AnamPowerDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fpw_in
<
	string UIName = "AnamPowerInteriorNight";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fpw_id
<
	string UIName = "AnamPowerInteriorDay";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float flen
<
	string UIName = "AnamLengthMultiplier";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
bool dirtenable
<
	string UIName = "EnableLensDirt";
	string UIWidget = "Checkbox";
> = {false};
float dirtmix1
<
	string UIName = "DirtMix1";
	string UIWidget = "Spinner";
> = {0.0};
float dirtmix2
<
	string UIName = "DirtMix2";
	string UIWidget = "Spinner";
> = {0.1};
float dirtmix3
<
	string UIName = "DirtMix3";
	string UIWidget = "Spinner";
> = {1.2};
float dirtmix4
<
	string UIName = "DirtMix4";
	string UIWidget = "Spinner";
> = {0.5};
float dirtmix7
<
	string UIName = "DirtMix7";
	string UIWidget = "Spinner";
> = {1.0};
float dirtmix8
<
	string UIName = "DirtMix8";
	string UIWidget = "Spinner";
> = {3.0};
float dirtmix5
<
	string UIName = "DirtMixNoBlur";
	string UIWidget = "Spinner";
> = {0.0};
float dirtmix6
<
	string UIName = "DirtMixBaseImage";
	string UIWidget = "Spinner";
> = {0.0};
bool dirtaspect
<
	string UIName = "DirtPreserveAspect";
	string UIWidget = "Checkbox";
> = {true};
float lstarf
<
	string UIName = "DirtDiffraction";
	string UIWidget = "Spinner";
> = {0.25};
float ldirtbumpx
<
	string UIName = "DirtBumpPower";
	string UIWidget = "Spinner";
> = {1.25};
float ldirtpow
<
	string UIName = "DirtPower";
	string UIWidget = "Spinner";
> = {1.25};
float ldirtfactor
<
	string UIName = "DirtFactor";
	string UIWidget = "Spinner";
> = {1.5};