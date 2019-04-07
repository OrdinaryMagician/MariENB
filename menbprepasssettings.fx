/*
	menbprepasssettings.fx : MariENB prepass user-tweakable variables.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the MIT License.
*/
/* circle average focus */
bool focuscircle
<
	string UIName = "FocusCircleEnable";
	string UIWidget = "Checkbox";
> = {false};
int focusslice
<
	string UIName = "FocusCircleSlices";
	string UIWidget = "Spinner";
> = {4};
int focuscircles
<
	string UIName = "FocusCircleCircles";
	string UIWidget = "Spinner";
> = {1};
float focusradius
<
	string UIName = "FocusCircleRadius";
	string UIWidget = "Spinner";
> = {12.5};
float focusmix
<
	string UIName = "FocusCircleMix";
	string UIWidget = "Spinner";
> = {0.25};
/* cel filter */
bool celenable
<
	string UIName = "CelEnable";
	string UIWidget = "Checkbox";
> = {false};
int celmode
<
	string UIName = "CelMode";
	string UIWidget = "Spinner";
> = {0};
float celradius
<
	string UIName = "CelRadius";
	string UIWidget = "Spinner";
> = {1.0};
float celpower
<
	string UIName = "CelPower";
	string UIWidget = "Spinner";
> = {1.0};
float celbump
<
	string UIName = "CelBump";
	string UIWidget = "Spinner";
> = {0.0};
float celmult
<
	string UIName = "CelMult";
	string UIWidget = "Spinner";
> = {1.0};
float celblend
<
	string UIName = "CelBlend";
	string UIWidget = "Spinner";
> = {1.0};
float celtrim
<
	string UIName = "CelTrim";
	string UIWidget = "Spinner";
> = {1.0};
float celfade
<
	string UIName = "CelFade";
	string UIWidget = "Spinner";
> = {0.5};
/* ssao filter */
bool ssaoenable
<
	string UIName = "SSAOEnable";
	string UIWidget = "Checkbox";
> = {true};
int ssaodebug
<
	string UIName = "SSAODebug";
	string UIWidget = "Spinner";
> = 0;
float ssaonoff1
<
	string UIName = "SSAONormalOffset1";
	string UIWidget = "Spinner";
> = {0.0};
float ssaonoff2
<
	string UIName = "SSAONormalOffset2";
	string UIWidget = "Spinner";
> = {0.1};
float ssaonoff3
<
	string UIName = "SSAONormalOffset3";
	string UIWidget = "Spinner";
> = {0.1};
float ssaonoff4
<
	string UIName = "SSAONormalOffset4";
	string UIWidget = "Spinner";
> = {0.0};
float ssaoradius
<
	string UIName = "SSAORadius";
	string UIWidget = "Spinner";
> = {1.0};
float ssaonoise
<
	string UIName = "SSAONoise";
	string UIWidget = "Spinner";
> = {0.1};
float ssaonoisesize
<
	string UIName = "SSAONoiseSize";
	string UIWidget = "Spinner";
> = {64.0};
float ssaotrim
<
	string UIName = "SSAOTrim";
	string UIWidget = "Spinner";
> = {1.0};
float ssaofade
<
	string UIName = "SSAOFade";
	string UIWidget = "Spinner";
> = {0.5};
float ssaobump
<
	string UIName = "SSAOBump";
	string UIWidget = "Spinner";
> = {0.0};
float ssaomult
<
	string UIName = "SSAOMult";
	string UIWidget = "Spinner";
> = {1.0};
float ssaopow
<
	string UIName = "SSAOPower";
	string UIWidget = "Spinner";
> = {1.0};
float ssaoblend
<
	string UIName = "SSAOBlend";
	string UIWidget = "Spinner";
> = {1.0};
bool ssaobenable
<
	string UIName = "SSAOBlurEnable";
	string UIWidget = "Spinner";
> = {true};
float ssaobradius
<
	string UIName = "SSAOBlurRadius";
	string UIWidget = "Spinner";
> = {1.0};
int ssaoblevel
<
	string UIName = "SSAOBlurLevel";
	string UIWidget = "Spinner";
> = {2};
/* dof filter */
bool dofenable
<
	string UIName = "DoFEnable";
	string UIWidget = "Checkbox";
> = {true};
int dofdebug
<
	string UIName = "DoFDebug";
	string UIWidget = "Spinner";
> = {0};
float dofradius
<
	string UIName = "DoFRadius";
	string UIWidget = "Spinner";
> = {1.0};
int doflevel
<
	string UIName = "DoFLevel";
	string UIWidget = "Spinner";
> = {2};
float dofbump
<
	string UIName = "DoFBump";
	string UIWidget = "Spinner";
> = {0.0};
float dofmult
<
	string UIName = "DoFMult";
	string UIWidget = "Spinner";
> = {1.0};
float dofpow
<
	string UIName = "DoFPow";
	string UIWidget = "Spinner";
> = {1.0};
float dofblend
<
	string UIName = "DoFBlend";
	string UIWidget = "Spinner";
> = {1.0};
float doftrim
<
	string UIName = "DoFTrim";
	string UIWidget = "Spinner";
> = {1.0};