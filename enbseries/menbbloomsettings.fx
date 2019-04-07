/*
	menbbloomsettings.fx : MariENB bloom user-tweakable variables.
	(C)2013-2016 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
string str_bloompre = "Bloom Prepass";
/* bloom intensity */
float bloomintensity_n
<
	string UIName = "Bloom Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloomintensity_d
<
	string UIName = "Bloom Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloomintensity_in
<
	string UIName = "Bloom Intensity Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloomintensity_id
<
	string UIName = "Bloom Intensity Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* bloom power (contrast) */
float bloompower_n
<
	string UIName = "Bloom Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloompower_d
<
	string UIName = "Bloom Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloompower_in
<
	string UIName = "Bloom Contrast Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloompower_id
<
	string UIName = "Bloom Contrast Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* bloom saturation */
float bloomsaturation_n
<
	string UIName = "Bloom Saturation Night";
	string UIWidget = "Spinner";
> = {0.75};
float bloomsaturation_d
<
	string UIName = "Bloom Saturation Day";
	string UIWidget = "Spinner";
> = {0.75};
float bloomsaturation_in
<
	string UIName = "Bloom Saturation Interior Night";
	string UIWidget = "Spinner";
> = {0.75};
float bloomsaturation_id
<
	string UIName = "Bloom Saturation Interior Day";
	string UIWidget = "Spinner";
> = {0.75};
/* bloom offset (negative values keep dark areas from muddying up) */
float bloombump_n
<
	string UIName = "Bloom Offset Night";
	string UIWidget = "Spinner";
> = {-0.5};
float bloombump_d
<
	string UIName = "Bloom Offset Day";
	string UIWidget = "Spinner";
> = {-0.5};
float bloombump_in
<
	string UIName = "Bloom Offset Interior Night";
	string UIWidget = "Spinner";
> = {-0.5};
float bloombump_id
<
	string UIName = "Bloom Offset Interior Day";
	string UIWidget = "Spinner";
> = {-0.5};
/* bloom cap (maximum brightness samples can have) */
float bloomcap_n
<
	string UIName = "Bloom Intensity Cap Night";
	string UIWidget = "Spinner";
> = {20.0};
float bloomcap_d
<
	string UIName = "Bloom Intensity Cap Day";
	string UIWidget = "Spinner";
> = {20.0};
float bloomcap_in
<
	string UIName = "Bloom Intensity Cap Interior Night";
	string UIWidget = "Spinner";
> = {20.0};
float bloomcap_id
<
	string UIName = "Bloom Intensity Cap Interior Day";
	string UIWidget = "Spinner";
> = {20.0};
string str_bloomper = "Bloom Per-pass";
/* bloom blur radius */
float bloomradiusx
<
	string UIName = "Bloom Blur Radius X";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloomradiusy
<
	string UIName = "Bloom Blur Radius Y";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* bloom tint/blueshift parameters */
float blu_n_r
<
	string UIName = "Blue Shift Night Red";
	string UIWidget = "Spinner";
> = {0.2};
float blu_n_g
<
	string UIName = "Blue Shift Night Green";
	string UIWidget = "Spinner";
> = {0.6};
float blu_n_b
<
	string UIName = "Blue Shift Night Blue";
	string UIWidget = "Spinner";
> = {1.0};
float blu_d_r
<
	string UIName = "Blue Shift Day Red";
	string UIWidget = "Spinner";
> = {0.2};
float blu_d_g
<
	string UIName = "Blue Shift Day Green";
	string UIWidget = "Spinner";
> = {0.6};
float blu_d_b
<
	string UIName = "Blue Shift Day Blue";
	string UIWidget = "Spinner";
> = {1.0};
float blu_in_r
<
	string UIName = "Blue Shift Interior Night Red";
	string UIWidget = "Spinner";
> = {0.2};
float blu_in_g
<
	string UIName = "Blue Shift Interior Night Green";
	string UIWidget = "Spinner";
> = {0.6};
float blu_in_b
<
	string UIName = "Blue Shift Interior Night Blue";
	string UIWidget = "Spinner";
> = {1.0};
float blu_id_r
<
	string UIName = "Blue Shift Interior Day Red";
	string UIWidget = "Spinner";
> = {0.2};
float blu_id_g
<
	string UIName = "Blue Shift Interior Day Green";
	string UIWidget = "Spinner";
> = {0.6};
float blu_id_b
<
	string UIName = "Blue Shift Interior Day Blue";
	string UIWidget = "Spinner";
> = {1.0};
float bsi_n
<
	string UIName = "Blue Shift Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float bsi_d
<
	string UIName = "Blue Shift Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float bsi_in
<
	string UIName = "Blue Shift Intensity Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float bsi_id
<
	string UIName = "Blue Shift Intensity Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float bslp
<
	string UIName = "Blue Shift Luminance Factor Per-pass";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.22};
float bsbp
<
	string UIName = "Blue Shift Color Factor Per-pass";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.33};
/* anamorphic bloom (very intensive) */
string str_bloomalf = "Anamorphic Bloom";
bool alfenable
<
	string UIName = "Enable Anamorphic Bloom";
	string UIWidget = "Checkbox";
> = {true};
float fbl_n
<
	string UIName = "Anamorphic Bloom Blend Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.75};
float fbl_d
<
	string UIName = "Anamorphic Bloom Blend Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.75};
float fbl_in
<
	string UIName = "Anamorphic Bloom Blend Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.75};
float fbl_id
<
	string UIName = "Anamorphic Bloom Blend Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.75};
float flu_n_r
<
	string UIName = "Anamorphic Bloom Blue Shift Night Red";
	string UIWidget = "Spinner";
> = {0.4};
float flu_n_g
<
	string UIName = "Anamorphic Bloom Blue Shift Night Green";
	string UIWidget = "Spinner";
> = {0.1};
float flu_n_b
<
	string UIName = "Anamorphic Bloom Blue Shift Night Blue";
	string UIWidget = "Spinner";
> = {1.0};
float flu_d_r
<
	string UIName = "Anamorphic Bloom Blue Shift Day Red";
	string UIWidget = "Spinner";
> = {0.5};
float flu_d_g
<
	string UIName = "Anamorphic Bloom Blue Shift Day Green";
	string UIWidget = "Spinner";
> = {0.1};
float flu_d_b
<
	string UIName = "Anamorphic Bloom Blue Shift Day Blue";
	string UIWidget = "Spinner";
> = {1.0};
float flu_in_r
<
	string UIName = "Anamorphic Bloom Blue Shift Interior Night Red";
	string UIWidget = "Spinner";
> = {0.5};
float flu_in_g
<
	string UIName = "Anamorphic Bloom Blue Shift Interior Night Green";
	string UIWidget = "Spinner";
> = {0.1};
float flu_in_b
<
	string UIName = "Anamorphic Bloom Blue Shift Interior Night Blue";
	string UIWidget = "Spinner";
> = {1.0};
float flu_id_r
<
	string UIName = "Anamorphic Bloom Blue Shift Interior Day Red";
	string UIWidget = "Spinner";
> = {0.5};
float flu_id_g
<
	string UIName = "Anamorphic Bloom Blue Shift Interior Day Green";
	string UIWidget = "Spinner";
> = {0.1};
float flu_id_b
<
	string UIName = "Anamorphic Bloom Blue Shift Interior Day Blue";
	string UIWidget = "Spinner";
> = {1.0};
float fsi_n
<
	string UIName = "Anamorphic Bloom Blue Shift Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fsi_d
<
	string UIName = "Anamorphic Bloom Blue Shift Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fsi_in
<
	string UIName = "Anamorphic Bloom Blue Shift Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fsi_id
<
	string UIName = "Anamorphic Bloom Blue Shift Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fpw_n
<
	string UIName = "Anamorphic Bloom Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fpw_d
<
	string UIName = "Anamorphic Bloom Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fpw_in
<
	string UIName = "Anamorphic Bloom Contrast Interior Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fpw_id
<
	string UIName = "Anamorphic Bloom Contrast Interior Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float flen
<
	string UIName = "Anamorphic Bloom Radius Multiplier";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
string str_bloompost = "Bloom Post-pass";
/* bloom mix factors */
float bloommix1
<
	string UIName = "Bloom Pass 1 Blend";
	string UIWidget = "Spinner";
> = {0.75};
float bloommix2
<
	string UIName = "Bloom Pass 2 Blend";
	string UIWidget = "Spinner";
> = {0.8};
float bloommix3
<
	string UIName = "Bloom Pass 3 Blend";
	string UIWidget = "Spinner";
> = {0.85};
float bloommix4
<
	string UIName = "Bloom Pass 4 Blend";
	string UIWidget = "Spinner";
> = {0.9};
float bloommix7
<
	string UIName = "Bloom Pass 7 Blend";
	string UIWidget = "Spinner";
> = {0.95};
float bloommix8
<
	string UIName = "Bloom Pass 8 Blend";
	string UIWidget = "Spinner";
> = {1.0};
float bloommix5
<
	string UIName = "Bloom Prepass Blend";
	string UIWidget = "Spinner";
> = {0.0};
float bloommix6
<
	string UIName = "Bloom Base Blend";
	string UIWidget = "Spinner";
> = {0.0};
