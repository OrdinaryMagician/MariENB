/*
	menbextrasettings.fx : MariENB extra user-tweakable variables.
	(C)2013-2017 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* Paint filter */
string str_paint = "Painting Filter";
bool oilenable
<
	string UIName = "Enable Oil Filter";
	string UIWidget = "Checkbox";
> = {false};
/* legacy FXAA filter */
string str_fxaa = "FXAA";
bool fxaaenable
<
	string UIName = "Enable FXAA";
	string UIWidget = "Checkbox";
> = {false};
float fxaaspanmax
<
	string UIName = "FXAA Span Max";
	string UIWidget = "Checkbox";
> = {4.0};
float fxaareducemul
<
	string UIName = "FXAA Reduce Mul";
	string UIWidget = "Checkbox";
> = {16.0};
float fxaareducemin
<
	string UIName = "FXAA Reduce Min";
	string UIWidget = "Checkbox";
> = {128.0};
/* Depth-cutting chroma key */
string str_mask = "Depth Chroma Key";
bool maskenable
<
	string UIName = "Enable Chroma Key";
	string UIWidget = "Checkbox";
> = {false};
float maskr
<
	string UIName = "Chroma Key Red";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
float maskg
<
	string UIName = "Chroma Key Green";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {1.0};
float maskb
<
	string UIName = "Chroma Key Blue";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
float maskd
<
	string UIName = "Chroma Key Depth";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};
/* tilting */
float masktiltxcenter
<
	string UIName = "Chroma Key Depth Horizontal Tilt Center";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};
float masktiltycenter
<
	string UIName = "Chroma Key Depth Vertical Tilt Center";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};
float masktiltx
<
	string UIName = "Chroma Key Depth Horizontal Tilt";
	string UIWidget = "Spinner";
> = {0.0};
float masktilty
<
	string UIName = "Chroma Key Depth Vertical Tilt";
	string UIWidget = "Spinner";
> = {0.0};
/* BlurSharpShift, some people are obsessed with this nonsense */
string str_bss = "BlurSharpShift";
bool bssblurenable
<
	string UIName = "Enable Blur";
	string UIWidget = "Checkbox";
> = {false};
float bssblurradius
<
	string UIName = "Blur Sampling Range";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
bool bsssharpenable
<
	string UIName = "Enable Sharp";
	string UIWidget = "Checkbox";
> = {false};
float bsssharpradius
<
	string UIName = "Sharp Sampling Range";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bsssharpamount
<
	string UIName = "Sharpening Amount";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {6.0};
bool bssshiftenable
<
	string UIName = "Enable Shift";
	string UIWidget = "Checkbox";
> = {false};
float bssshiftradius
<
	string UIName = "Shift Sampling Range";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.75};
/* very cinematic black bars */
string str_box = "Black Bars";
bool boxenable
<
	string UIName = "Enable Black Bars";
	string UIWidget = "Checkbox";
> = {false};
float boxh
<
	string UIName = "Box Horizontal Ratio";
	string UIWidget = "Spinner";
	float UIMin = 1.0;
> = {2.39};
float boxv
<
	string UIName = "Box Vertical Ratio";
	string UIWidget = "Spinner";
	float UIMin = 1.0;
> = {1.0};
/* vignette */
string str_vignette = "Vignette with border blur";
bool vigenable
<
	string UIName = "Enable Vignette";
	string UIWidget = "Checkbox";
> = {false};
bool bblurenable
<
	string UIName = "Enable Border Blur";
	string UIWidget = "Checkbox";
> = {false};
/* 0 = circle, 1 = box, 2 = texture */
int vigshape
<
	string UIName = "Vignette Shape";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 2;
> = {0};
/* 0 = overwrite, 1 = add, 2 = multiply */
int vigmode
<
	string UIName = "Vignette Blending Mode";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 2;
> = {0};
float vigpow
<
	string UIName = "Vignette Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float vigmul
<
	string UIName = "Vignette Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float vigbump
<
	string UIName = "Vignette Shift";
	string UIWidget = "Spinner";
> = {0.0};
float vigcolor_r
<
	string UIName = "Vignette Color Red";
	string UIWidget = "Spinner";
> = {0.0};
float vigcolor_g
<
	string UIName = "Vignette Color Green";
	string UIWidget = "Spinner";
> = {0.0};
float vigcolor_b
<
	string UIName = "Vignette Color Blue";
	string UIWidget = "Spinner";
> = {0.0};
float bblurpow
<
	string UIName = "Border Blur Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bblurmul
<
	string UIName = "Border Blur Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bblurbump
<
	string UIName = "Border Blur Shift";
	string UIWidget = "Spinner";
> = {0.0};
float bblurradius
<
	string UIName = "Border Blur Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};