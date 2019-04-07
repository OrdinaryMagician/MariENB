/*
	menbbloomsettings.fx : MariENB bloom user-tweakable variables.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the MIT License.
*/
/* do bloom prepass blur */
bool preenable
<
	string UIName = "PreEnable";
	string UIWidget = "Checkbox";
> = {true};
/* bloom prepass blur radius */
float presample
<
	string UIName = "PreSample";
	string UIWidget = "Spinner";
> = {2.0};
/* bloom prepass blur level */
int prelevel
<
	string UIName = "PreLevel";
	string UIWidget = "Spinner";
> = {2};
/* bloom postpass blur radius */
float postsample
<
	string UIName = "PostSample";
	string UIWidget = "Spinner";
> = {8.0};
/* bloom postpas blur level */
int postlevel
<
	string UIName = "PostLevel";
	string UIWidget = "Spinner";
> = {1};
/* bloom intensity */
float bloomintensity
<
	string UIName = "BloomIntensity";
	string UIWidget = "Spinner";
> = {0.25};
/* bloom power */
float bloompower
<
	string UIName = "BloomPower";
	string UIWidget = "Spinner";
> = {1.4};
/* bloom saturation */
float bloomsaturation
<
	string UIName = "BloomSaturation";
	string UIWidget = "Spinner";
> = {0.3};
/* bloom offset */
float bloombump
<
	string UIName = "BloomBump";
	string UIWidget = "Spinner";
> = {-0.10};
