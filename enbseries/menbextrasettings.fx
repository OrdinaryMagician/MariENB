/*
	menbextrasettings.fx : MariENB extra user-tweakable variables.
	(C)2013-2017 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/*
   Paint filters:
   -1 : Disabled
    0 : Oil painting filter, mixes Kuwahara with median for a smooth result
    1 : "Van Gogh" filter, ported from https://www.shadertoy.com/view/MdGSDG
        with some small changes
    2 : "Watercolor" filter, ported from https://www.shadertoy.com/view/ltyGRV
        also with some small changes
    
*/
string str_paint = "Painting Filters";
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
/* lens curve with chromatic aberration */
string str_curve = "Lens Curvature";
bool curveenable
<
	string UIName = "Enable Curvature";
	string UIWidget = "Checkbox";
> = {false};
float chromaab
<
	string UIName = "Curve Chromatic Aberration";
	string UIWidget = "Spinner";
> = {0.0};
float lenszoom
<
	string UIName = "Curve Zooming";
	string UIWidget = "Spinner";
> = {50.0};
float lensdist
<
	string UIName = "Curve Distortion";
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
/* colour matrix */
string str_cmat = "Color Matrix";
bool cmatenable
<
	string UIName = "Enable Color Matrix";
	string UIWidget = "Checkbox";
> = {false};
float cmat_rr
<
	string UIName = "Color Matrix Red Red";
	string UIWidget = "Spinner";
> = {1.0};
float cmat_rg
<
	string UIName = "Color Matrix Red Green";
	string UIWidget = "Spinner";
> = {0.0};
float cmat_rb
<
	string UIName = "Color Matrix Red Blue";
	string UIWidget = "Spinner";
> = {0.0};
float cmat_gr
<
	string UIName = "Color Matrix Green Red";
	string UIWidget = "Spinner";
> = {0.0};
float cmat_gg
<
	string UIName = "Color Matrix Green Green";
	string UIWidget = "Spinner";
> = {1.0};
float cmat_gb
<
	string UIName = "Color Matrix Green Blue";
	string UIWidget = "Spinner";
> = {0.0};
float cmat_br
<
	string UIName = "Color Matrix Blue Red";
	string UIWidget = "Spinner";
> = {0.0};
float cmat_bg
<
	string UIName = "Color Matrix Blue Green";
	string UIWidget = "Spinner";
> = {0.0};
float cmat_bb
<
	string UIName = "Color Matrix Blue Blue";
	string UIWidget = "Spinner";
> = {1.0};
bool cmatnormalize
<
	string UIName = "Normalize Matrix";
	string UIWidget = "Checkbox";
> = {false};
/* hue-saturation */
string str_hs = "Hue-Saturation";
bool hsenable
<
	string UIName = "Enable Hue-Saturation";
	string UIWidget = "Checkbox";
> = {false};
float hsover
<
	string UIName = "Overlap";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 0.5;
> = {0.0};
float hshue_a
<
	string UIName = "Global Hue";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hssat_a
<
	string UIName = "Global Saturation";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hsval_a
<
	string UIName = "Global Value";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hshue_r
<
	string UIName = "Red Hue";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hssat_r
<
	string UIName = "Red Saturation";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hsval_r
<
	string UIName = "Red Value";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hshue_y
<
	string UIName = "Yellow Hue";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hssat_y
<
	string UIName = "Yellow Saturation";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hsval_y
<
	string UIName = "Yellow Value";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hshue_g
<
	string UIName = "Green Hue";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hssat_g
<
	string UIName = "Green Saturation";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hsval_g
<
	string UIName = "Green Value";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hshue_c
<
	string UIName = "Cyan Hue";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hssat_c
<
	string UIName = "Cyan Saturation";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hsval_c
<
	string UIName = "Cyan Value";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hshue_b
<
	string UIName = "Blue Hue";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hssat_b
<
	string UIName = "Blue Saturation";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hsval_b
<
	string UIName = "Blue Value";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hshue_m
<
	string UIName = "Magenta Hue";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hssat_m
<
	string UIName = "Magenta Saturation";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
float hsval_m
<
	string UIName = "Magenta Value";
	string UIWidget = "Spinner";
	float UIMin = -1.0;
	float UIMax = 1.0;
> = {0.0};
/* colour balance */
