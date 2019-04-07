/*
	menbbloomsettings.fx : MariENB bloom user-tweakable variables.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the WTFPL.
*/
/* bloom intensity */
float bloomintensity_n
<
	string UIName = "BloomIntensityNight";
	string UIWidget = "Spinner";
> = {0.25};
float bloomintensity_d
<
	string UIName = "BloomIntensityDay";
	string UIWidget = "Spinner";
> = {0.25};
float bloomintensity_in
<
	string UIName = "BloomIntensityInteriorNight";
	string UIWidget = "Spinner";
> = {0.25};
float bloomintensity_id
<
	string UIName = "BloomIntensityInteriorDay";
	string UIWidget = "Spinner";
> = {0.25};
/* bloom power */
float bloompower_n
<
	string UIName = "BloomPowerNight";
	string UIWidget = "Spinner";
> = {1.4};
float bloompower_d
<
	string UIName = "BloomPowerDay";
	string UIWidget = "Spinner";
> = {1.4};
float bloompower_in
<
	string UIName = "BloomPowerInteriorNight";
	string UIWidget = "Spinner";
> = {1.4};
float bloompower_id
<
	string UIName = "BloomPowerInteriorDay";
	string UIWidget = "Spinner";
> = {1.4};
/* bloom saturation */
float bloomsaturation_n
<
	string UIName = "BloomSaturationNight";
	string UIWidget = "Spinner";
> = {0.3};
float bloomsaturation_d
<
	string UIName = "BloomSaturationDay";
	string UIWidget = "Spinner";
> = {0.3};
float bloomsaturation_in
<
	string UIName = "BloomSaturationInteriorNight";
	string UIWidget = "Spinner";
> = {0.3};
float bloomsaturation_id
<
	string UIName = "BloomSaturationInteriorDay";
	string UIWidget = "Spinner";
> = {0.3};
/* bloom offset */
float bloombump_n
<
	string UIName = "BloomBumpNight";
	string UIWidget = "Spinner";
> = {-0.10};
float bloombump_d
<
	string UIName = "BloomBumpDay";
	string UIWidget = "Spinner";
> = {-0.10};
float bloombump_in
<
	string UIName = "BloomBumpInteriorNight";
	string UIWidget = "Spinner";
> = {-0.10};
float bloombump_id
<
	string UIName = "BloomBumpInteriorDay";
	string UIWidget = "Spinner";
> = {-0.10};
