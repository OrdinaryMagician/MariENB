/*
	enbdepthoffield.fx : MariENB3 prepass shaders.
	(C)2016 Marisa Kirisame, UnSX Team.
	Part of MariENB3, the personal ENB of Marisa for Fallout 4.
	Released under the GNU GPLv3 (or later).
*/
#include "menbglobaldefs.fx"

string str_misc = "Miscellaneous";
/* fixed resolution, keeps blur filters at a consistent internal resolution */
int2 fixed
<
	string UIName = "Fixed Resolution";
	string UIWidget = "Vector";
	int2 UIMin = {0,0};
> = {1920,1080};
float cutoff
<
	string UIName = "Depth Cutoff";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1000000.0;
> = {999949.0};
float zNear
<
	string UIName = "Near Z";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.05};
float zFar
<
	string UIName = "Far Z";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {3098.0};
string str_dist = "Distortion Filters";
float distcha
<
	string UIName = "Distortion Chromatic Aberration";
	string UIWidget = "Spinner";
> = {10.0};
bool waterenable
<
	string UIName = "Enable Underwater";
	string UIWidget = "Checkbox";
> = {false};
float3 uwm
<
	string UIName = "Underwater Frequency";
	string UIWidget = "Vector";
	float3 UIMin = {0.0,0.0,0.0};
> = {1.4,1.6,1.4};
float3 uwf
<
	string UIName = "Underwater Speed";
	string UIWidget = "Vector";
	float3 UIMin = {0.0,0.0,0.0};
> = {10.0,8.0,16.0};
float3 uws
<
	string UIName = "Underwater Amplitude";
	string UIWidget = "Vector";
	float3 UIMin = {0.0,0.0,0.0};
> = {0.3,0.5,0.8};
float uwz
<
	string UIName = "Underwater Zoom";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.5};
bool wateralways
<
	string UIName = "Always Underwater";
	string UIWidget = "Checkbox";
> = {false};
bool heatenable
<
	string UIName = "Enable Hot Air Refraction";
	string UIWidget = "Checkbox";
> = {false};
float heatsize
<
	string UIName = "Heat Texture Size";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {3.5};
float heatspeed
<
	string UIName = "Heat Speed";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.5};
float heatfadepow
<
	string UIName = "Heat Fade Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {200.0};
float heatfademul
<
	string UIName = "Heat Fade Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float heatfadebump
<
	string UIName = "Heat Fade Offset";
	string UIWidget = "Spinner";
> = {0.0};
float heatstrength
<
	string UIName = "Heat Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
float heatpow
<
	string UIName = "Heat Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.2};
float heatfactor_dw
<
	string UIName = "Heat Factor Dawn";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.2};
float heatfactor_sr
<
	string UIName = "Heat Factor Sunrise";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float heatfactor_dy
<
	string UIName = "Heat Factor Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float heatfactor_ss
<
	string UIName = "Heat Factor Sunset";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.7};
float heatfactor_ds
<
	string UIName = "Heat Factor Dusk";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.1};
float heatfactor_nt
<
	string UIName = "Heat Factor Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float heatfactor_i
<
	string UIName = "Heat Factor Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
bool heatalways
<
	string UIName = "Heat Always Enable";
	string UIWidget = "Checkbox";
> = {false};
bool frostenable
<
	string UIName = "Enable Screen Frost";
	string UIWidget = "Checkbox";
> = {false};
float frostpow
<
	string UIName = "Frost Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float froststrength
<
	string UIName = "Frost Strength";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostrpow
<
	string UIName = "Frost Radial Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostrmult
<
	string UIName = "Frost Radial Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostrbump
<
	string UIName = "Frost Radial Offset";
	string UIWidget = "Spinner";
> = {0.0};
float frostblend
<
	string UIName = "Frost Texture Blend";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostbpow
<
	string UIName = "Frost Texture Blend Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostsize
<
	string UIName = "Frost Texture Size";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float frostfactor_dw
<
	string UIName = "Frost Factor Dawn";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.1};
float frostfactor_sr
<
	string UIName = "Frost Factor Sunrise";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float frostfactor_dy
<
	string UIName = "Frost Factor Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float frostfactor_ss
<
	string UIName = "Frost Factor Sunset";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float frostfactor_ds
<
	string UIName = "Frost Factor Dusk";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.1};
float frostfactor_nt
<
	string UIName = "Frost Factor Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
float frostfactor_i
<
	string UIName = "Frost Factor Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
bool frostalways
<
	string UIName = "Frost Always Enable";
	string UIWidget = "Checkbox";
> = {false};
string str_focus = "Focusing Parameters";
/* circle (triangle, actually) average focus */
bool focuscircle
<
	string UIName = "Enable Focus Triangle";
	string UIWidget = "Checkbox";
> = {true};
bool focusdisplay
<
	string UIName = "Display Focus Points";
	string UIWidget = "Checkbox";
> = {false};
bool focusmanual
<
	string UIName = "Enable Manual Focus";
	string UIWidget = "Checkbox";
> = {false};
float focusmanualvalue
<
	string UIName = "Manual Focus Depth";
	string UIWidget = "Checkbox";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.5};
/* center point of focus */
float2 focuscenter
<
	string UIName = "Focus Point Center";
	string UIWidget = "Vector";
	float2 UIMin = {0.0,0.0};
	float2 UIMax = {1.0,1.0};
> = {0.5,0.5};
float focuscircleangle
<
	string UIName = "Focus Triangle Angle";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
/* radius of the focus point triangle */
float focusradius_n
<
	string UIName = "Focus Triangle Radius Night";
	string UIWidget = "Spinner";
> = {20.0};
float focusradius_d
<
	string UIName = "Focus Triangle Radius Day";
	string UIWidget = "Spinner";
> = {20.0};
float focusradius_i
<
	string UIName = "Focus Triangle Radius Interior";
	string UIWidget = "Spinner";
> = {20.0};
/* mix factor with sample at screen center */
float focusmix_n
<
	string UIName = "Focus Triangle Blending Night";
	string UIWidget = "Spinner";
> = {0.5};
float focusmix_d
<
	string UIName = "Focus Triangle Blending Day";
	string UIWidget = "Spinner";
> = {0.5};
float focusmix_i
<
	string UIName = "Focus Triangle Blending Interior";
	string UIWidget = "Spinner";
> = {0.5};
/* maximum focus depth */
float focusmax_n
<
	string UIName = "Focus Maximum Depth Night";
	string UIWidget = "Spinner";
> = {1000.0};
float focusmax_d
<
	string UIName = "Focus Maximum Depth Day";
	string UIWidget = "Spinner";
> = {1000.0};
float focusmax_i
<
	string UIName = "Focus Maximum Depth Interior";
	string UIWidget = "Spinner";
> = {1000.0};
float focuscenterdiscard
<
	string UIName = "Focus Circle Discard Center Depth";
	string UIWidget = "Spinner";
> = {0.0};
/* dof filter */
string str_dof = "Depth Of Field";
/* dof multiplier (makes unfocused depths more blurry) */
float dofmult_n
<
	string UIName = "DOF Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float dofmult_d
<
	string UIName = "DOF Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float dofmult_i
<
	string UIName = "DOF Intensity Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
/* dof power (falloff, kinda) */
float dofpow_n
<
	string UIName = "DOF Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
float dofpow_d
<
	string UIName = "DOF Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
float dofpow_i
<
	string UIName = "DOF Contrast Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
/* dof bump (negative values are useful for "widening" the focused area) */
float dofbump_n
<
	string UIName = "DOF Shift Night";
	string UIWidget = "Spinner";
> = {0.0};
float dofbump_d
<
	string UIName = "DOF Shift Day";
	string UIWidget = "Spinner";
> = {0.0};
float dofbump_i
<
	string UIName = "DOF Shift Interior";
	string UIWidget = "Spinner";
> = {0.0};
/* fixed focused depth factors */
float doffixedfocusmult_n
<
	string UIName = "DOF Fixed Focus Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocusmult_d
<
	string UIName = "DOF Fixed Focus Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocusmult_i
<
	string UIName = "DOF Fixed Focus Intensity Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocuspow_n
<
	string UIName = "DOF Fixed Focus Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocuspow_d
<
	string UIName = "DOF Fixed Focus Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocuspow_i
<
	string UIName = "DOF Fixed Focus Contrast Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float doffixedfocusbump_n
<
	string UIName = "DOF Fixed Focus Shift Night";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedfocusbump_d
<
	string UIName = "DOF Fixed Focus Shift Day";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedfocusbump_i
<
	string UIName = "DOF Fixed Focus Shift Interior";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedfocusblend_n
<
	string UIName = "DOF Fixed Focus Blend Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedfocusblend_d
<
	string UIName = "DOF Fixed Focus Blend Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedfocusblend_i
<
	string UIName = "DOF Fixed Focus Blend Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
/* fixed unfocused depth factors */
float doffixedunfocusmult_n
<
	string UIName = "DOF Fixed Unfocus Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float doffixedunfocusmult_d
<
	string UIName = "DOF Fixed Unfocus Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float doffixedunfocusmult_i
<
	string UIName = "DOF Fixed Unfocus Intensity Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float doffixedunfocuspow_n
<
	string UIName = "DOF Fixed Unfocus Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float doffixedunfocuspow_d
<
	string UIName = "DOF Fixed Unfocus Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float doffixedunfocuspow_i
<
	string UIName = "DOF Fixed Unfocus Contrast Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float doffixedunfocusbump_n
<
	string UIName = "DOF Fixed Unfocus Shift Night";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedunfocusbump_d
<
	string UIName = "DOF Fixed Unfocus Shift Day";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedunfocusbump_i
<
	string UIName = "DOF Fixed Unfocus Shift Interior";
	string UIWidget = "Spinner";
> = {0.0};
float doffixedunfocusblend_n
<
	string UIName = "DOF Fixed Unfocus Blend Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedunfocusblend_d
<
	string UIName = "DOF Fixed Unfocus Blend Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float doffixedunfocusblend_i
<
	string UIName = "DOF Fixed Unfocus Blend Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
/* prevents fixed dof from blurring the skybox */
bool doffixedcut
<
	string UIName = "DOF Fixed Use Cutoff";
	string UIWidget = "Checkbox";
> = {true};
/* disable depth of field */
bool dofdisable
<
	string UIName = "Disable DOF";
	string UIWidget = "Checkbox";
> = {false};
float dofbfact
<
	string UIName = "DOF Bilateral Factor";
	string UIWidget = "Spinner";
> = {20.0};
float dofbradius
<
	string UIName = "DOF Bilateral Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float dofpradius
<
	string UIName = "DOF Gather Blur Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {6.0};
/* cheap performance option */
float dofminblur
<
	string UIName = "DOF Minimum Blur";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
bool dofdebug
<
	string UIName = "Debug Depth";
	string UIWidget = "Checkbox";
> = {false};
bool dfcdebug
<
	string UIName = "Debug Focus";
	string UIWidget = "Checkbox";
> = {false};
/* use "edge vision" filter */
string str_view = "Edgevision";
bool edgevenable
<
	string UIName = "Enable Edgevision";
	string UIWidget = "Checkbox";
> = {false};
/* factors */
float edgevfadepow_n
<
	string UIName = "Edgevision Fade Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float edgevfadepow_d
<
	string UIName = "Edgevision Fade Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float edgevfadepow_i
<
	string UIName = "Edgevision Fade Contrast Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {2.0};
float edgevfademult_n
<
	string UIName = "Edgevision Fade Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float edgevfademult_d
<
	string UIName = "Edgevision Fade Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float edgevfademult_i
<
	string UIName = "Edgevision Fade Intensity Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {500.0};
float edgevpow
<
	string UIName = "Edgevision Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.25};
float edgevmult
<
	string UIName = "Edgevision Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
float edgevradius
<
	string UIName = "Edgevision Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* ssao filter */
string str_ssao = "Ray Marching SSAO";
bool ssaoenable
<
	string UIName = "Enable SSAO";
	string UIWidget = "Checkbox";
> = {false};
float ssaoradius
<
	string UIName = "SSAO Radius";
	string UIWidget = "Spinner";
> = {1.0};
int ssaonoise
<
	string UIName = "SSAO Noise";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 1;
> = {1};
float ssaofadepow_n
<
	string UIName = "SSAO Fade Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.05};
float ssaofadepow_d
<
	string UIName = "SSAO Fade Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.05};
float ssaofadepow_i
<
	string UIName = "SSAO Fade Contrast Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.05};
float ssaofademult_n
<
	string UIName = "SSAO Fade Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float ssaofademult_d
<
	string UIName = "SSAO Fade Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float ssaofademult_i
<
	string UIName = "SSAO Fade Intensity Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float ssaomult
<
	string UIName = "SSAO Intensity";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float ssaopow
<
	string UIName = "SSAO Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.5};
float ssaoblend
<
	string UIName = "SSAO Blending";
	string UIWidget = "Spinner";
> = {1.0};
bool ssaobenable
<
	string UIName = "SSAO Blur";
	string UIWidget = "Checkbox";
> = {true};
float ssaobfact
<
	string UIName = "SSAO Bilateral Factor";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1000.0};
float ssaoclamp
<
	string UIName = "SSAO Range";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float ssaoclampmin
<
	string UIName = "SSAO Range Min";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.0};
float ssaobradius
<
	string UIName = "SSAO Blur Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
bool ssaodebug
<
	string UIName = "Debug SSAO";
	string UIWidget = "Checkbox";
> = {false};
bool ssaoquarter
<
	string UIName = "SSAO Use Less Samples";
	string UIWidget = "Checkbox";
> = {true};
bool ssaohalfblur
<
	string UIName = "SSAO Blur Use Less Samples";
	string UIWidget = "Checkbox";
> = {true};

/* mathematical constants */
static const float pi = 3.1415926535898;

/* edge detect factors */
static const float3x3 GX =
{
	-1, 0, 1,
	-2, 0, 2,
	-1, 0, 1
};
static const float3x3 GY =
{
	 1, 2, 1,
	 0, 0, 0,
	-1,-2,-1
};
/* radius: 8, std dev: 6 */
static const float gauss8[8] =
{
	0.084247, 0.083085, 0.079694, 0.074348,
	0.067460, 0.059533, 0.051099, 0.042657
};
/* radius: 16, std dev: 13 */
static const float gauss16[16] =
{
	0.040012, 0.039893, 0.039541, 0.038960,
	0.038162, 0.037159, 0.035969, 0.034612,
	0.033109, 0.031485, 0.029764, 0.027971,
	0.026131, 0.024268, 0.022405, 0.020563
};
/* SSAO samples */
static const float3 ssao_samples_lq[16] = 
{
	float3( 0.0000,-0.0002, 0.0000),float3(-0.0004, 0.0013, 0.0014),
	float3(-0.0030, 0.0048,-0.0034),float3( 0.0147, 0.0046,-0.0026),
	float3(-0.0097, 0.0275,-0.0092),float3(-0.0178,-0.0072, 0.0491),
	float3( 0.0227,-0.0431,-0.0681),float3( 0.1052, 0.0332,-0.0588),
	float3( 0.0997, 0.0056, 0.1473),float3(-0.1252, 0.2019, 0.0564),
	float3(-0.1054,-0.2072, 0.2271),float3(-0.0542, 0.3096, 0.2814),
	float3( 0.0072,-0.3534, 0.4035),float3(-0.0024,-0.2385, 0.6260),
	float3(-0.1940, 0.5722,-0.5602),float3(-0.0910,-0.7548,-0.6497)
};
static const float3 ssao_samples_hq[64] =
{
	float3( 0.0000,-0.0000,-0.0000),float3( 0.0000, 0.0000,-0.0000),
	float3( 0.0001,-0.0000,-0.0000),float3( 0.0002, 0.0001,-0.0001),
	float3(-0.0000,-0.0005, 0.0000),float3( 0.0004,-0.0004,-0.0006),
	float3( 0.0005,-0.0011,-0.0004),float3(-0.0000, 0.0013,-0.0014),
	float3( 0.0024, 0.0006, 0.0013),float3(-0.0017,-0.0017, 0.0030),
	float3(-0.0037, 0.0033,-0.0011),float3( 0.0010, 0.0018,-0.0063),
	float3( 0.0059, 0.0056,-0.0020),float3(-0.0009, 0.0083,-0.0063),
	float3(-0.0110, 0.0065,-0.0016),float3( 0.0089, 0.0070,-0.0108),
	float3(-0.0115,-0.0134,-0.0062),float3(-0.0121,-0.0172, 0.0071),
	float3(-0.0066, 0.0246,-0.0060),float3( 0.0057,-0.0279, 0.0109),
	float3(-0.0269,-0.0160,-0.0164),float3( 0.0402, 0.0045, 0.0034),
	float3( 0.0248,-0.0045, 0.0390),float3( 0.0110,-0.0491,-0.0159),
	float3(-0.0193,-0.0431, 0.0363),float3( 0.0441, 0.0271,-0.0426),
	float3( 0.0385,-0.0428,-0.0482),float3(-0.0623,-0.0501, 0.0249),
	float3( 0.0683,-0.0000, 0.0631),float3( 0.1008, 0.0180,-0.0114),
	float3(-0.0156,-0.0713, 0.0871),float3(-0.0561,-0.0757, 0.0822),
	float3( 0.0714, 0.0850,-0.0805),float3(-0.1320,-0.0042, 0.0711),
	float3( 0.1553, 0.0486,-0.0167),float3(-0.1164,-0.0125,-0.1341),
	float3( 0.1380,-0.1230,-0.0562),float3( 0.0868,-0.1897,-0.0175),
	float3( 0.0749, 0.1495, 0.1525),float3(-0.2038,-0.1324,-0.0235),
	float3( 0.0205, 0.1920, 0.1784),float3( 0.1637,-0.0964,-0.2092),
	float3( 0.2875, 0.0966,-0.0020),float3( 0.0572,-0.0180,-0.3194),
	float3(-0.3329, 0.0981,-0.0189),float3( 0.2627, 0.2092,-0.1585),
	float3( 0.1783,-0.3359,-0.1108),float3( 0.2675, 0.2056,-0.2533),
	float3(-0.1852, 0.3017,-0.2759),float3(-0.0944, 0.3532, 0.3061),
	float3(-0.0022,-0.3744, 0.3404),float3(-0.0600,-0.4031,-0.3487),
	float3(-0.2663, 0.4915, 0.1004),float3(-0.2442, 0.4253, 0.3468),
	float3( 0.2583, 0.1321,-0.5645),float3(-0.0219, 0.4516, 0.4943),
	float3(-0.5503, 0.2597,-0.3590),float3( 0.2239,-0.5571,-0.4398),
	float3(-0.7210,-0.1982, 0.2339),float3( 0.7948,-0.1848, 0.1145),
	float3(-0.7190, 0.1767, 0.4489),float3(-0.5617, 0.5845,-0.4116),
	float3(-0.8919,-0.0384, 0.3360),float3(-0.0144, 0.9775,-0.2105)
};
/* For high quality DOF */
static const float2 poisson32[32] =
{
	float2( 0.7284430,-0.1927130),float2( 0.4051600,-0.2312710),
	float2( 0.9535280, 0.0669683),float2( 0.6544140,-0.4439470),
	float2( 0.6029910, 0.1058970),float2( 0.2637500,-0.7163810),
	float2( 0.9105380,-0.3889810),float2( 0.5942730,-0.7400740),
	float2( 0.8215680, 0.3162520),float2( 0.3577550, 0.4884250),
	float2( 0.6935990, 0.7070140),float2( 0.0470570, 0.1961800),
	float2(-0.0977021, 0.6241300),float2( 0.2110300, 0.8778350),
	float2(-0.3743440, 0.2494580),float2( 0.0144776,-0.0766484),
	float2(-0.3377660,-0.1255100),float2( 0.3136420, 0.1077710),
	float2(-0.5204340, 0.8369860),float2(-0.1182680, 0.9801750),
	float2(-0.6969480,-0.3869330),float2(-0.6156080, 0.0307209),
	float2(-0.3806790,-0.6055360),float2(-0.1909570,-0.3861330),
	float2(-0.2449080,-0.8655030),float2( 0.0822108,-0.4975580),
	float2(-0.5649250, 0.5756740),float2(-0.8741830,-0.1685750),
	float2( 0.0761715,-0.9631760),float2(-0.9218270, 0.2121210),
	float2(-0.6378530, 0.3053550),float2(-0.8425180, 0.4753000)
};

float4 Timer;
float4 ScreenSize;
float4 Weather;
float ENightDayFactor;
float EInteriorFactor;
float4 TimeOfDay1;
float4 TimeOfDay2;
float4 DofParameters;

Texture2D TextureCurrent;
Texture2D TexturePrevious;
Texture2D TextureOriginal;
Texture2D TextureColor;
Texture2D TextureDepth;
Texture2D TextureFocus;

Texture2D RenderTargetR16F; /* for SSAO */
Texture2D RenderTargetR32F; /* for DOF */

Texture2D TextureNoise3
<
	string ResourceName = "menbnoise2.png";
>;
Texture2D TextureHeat
<
#ifdef HEAT_DDS
	string ResourceName = "menbheat.dds";
#else
	string ResourceName = "menbheat.png";
#endif
>;
Texture2D TextureFrost
<
#ifdef FROST_DDS
	string ResourceName = "menbfrost.dds";
#else
	string ResourceName = "menbfrost.png";
#endif
>;
Texture2D TextureFrostBump
<
#ifdef FROSTBUMP_DDS
	string ResourceName = "menbfrostbump.dds";
#else
	string ResourceName = "menbfrostbump.png";
#endif
>;

SamplerState Sampler0
{
	Filter = MIN_MAG_MIP_POINT;
	AddressU = Clamp;
	AddressV = Clamp;
};
SamplerState Sampler1
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
};
SamplerState Sampler2
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Wrap;
	AddressV = Wrap;
};

struct VS_INPUT_POST
{
	float3 pos : POSITION;
	float2 txcoord : TEXCOORD0;
};
struct VS_OUTPUT_POST
{
	float4 pos : SV_POSITION;
	float2 txcoord : TEXCOORD0;
};

VS_OUTPUT_POST VS_Quad( VS_INPUT_POST IN )
{
	VS_OUTPUT_POST OUT;
	OUT.pos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord.xy = IN.txcoord.xy;
	return OUT;
}

/* helper functions */
/* photometric */
#define luminance(x) dot(x,float3(0.2126,0.7152,0.0722))
/* CCIR601 */
//#define luminance(x) dot(x,float3(0.299,0.587,0.114))
/* these are znear/zfar values for Skyrim, but MAY match Fallout too */
float depthlinear( float2 coord )
{
	float z = TextureDepth.SampleLevel(Sampler1,coord,0).x;
	return (2*zNear)/(zFar+zNear-z*(zFar-zNear));
}

/*
   Thank you Boris for not providing access to a normal buffer. Guesswork using
   the depth buffer results in imprecise normals that aren't smoothed. Plus
   there is no way to get the normal data from textures either. Also, three
   texture fetches are needed instead of one (great!)
*/
float3 pseudonormal( float dep, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 ofs1 = float2(0,1.0/bresl.y);
	float2 ofs2 = float2(1.0/bresl.x,0);
	float dep1 = TextureDepth.SampleLevel(Sampler1,coord+ofs1,0).x;
	float dep2 = TextureDepth.SampleLevel(Sampler1,coord+ofs2,0).x;
	float3 p1 = float3(ofs1,dep1-dep);
	float3 p2 = float3(ofs2,dep2-dep);
	float3 normal = cross(p1,p2);
	normal.z = -normal.z;
	return normalize(normal);
}

/* SSAO Prepass */
float4 PS_SSAOPre( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	/* get occlusion using single-step Ray Marching with 64 samples */
	float ssaofadepow = tod_ind(ssaofadepow);
	float ssaofademult = tod_ind(ssaofademult);
	if ( !ssaoenable ) return 0.0;
	float depth = TextureDepth.Sample(Sampler1,coord).x;
	float ldepth = depthlinear(coord);
	if ( depth >= cutoff*0.000001 ) return 1.0;
	float2 bresl;
	if ( (fixed.x > 0) && (fixed.y > 0) ) bresl = fixed;
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float3 normal = pseudonormal(depth,coord);
	float2 nc = coord*(bresl/256.0);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*ssaoradius;
	float2 nc2 = TextureNoise3.SampleLevel(Sampler2,nc+48000.0*Timer.x
		*ssaonoise,0).xy;
	float3 rnormal = TextureNoise3.SampleLevel(Sampler2,nc2,0).xyz*2.0-1.0;
	rnormal = normalize(rnormal);
	float occ = 0.0;
	int i;
	float3 sample;
	float sdepth, so, delta;
	float sclamp = ssaoclamp/100000.0;
	float sclampmin = ssaoclampmin/100000.0;
	if ( ssaoquarter ) [unroll] for ( i=0; i<16; i++ )
	{
		sample = reflect(ssao_samples_lq[i],rnormal);
		sample *= sign(dot(normal,sample));
		so = ldepth-sample.z*bof.x;
		sdepth = depthlinear(coord+bof*sample.xy/ldepth);
		delta = saturate(so-sdepth);
		delta *= 1.0-smoothstep(0.0,sclamp,delta);
		if ( (delta > sclampmin) && (delta < sclamp) )
			occ += 1.0-delta;
	}
	else [unroll] for ( i=0; i<64; i++ )
	{
		sample = reflect(ssao_samples_hq[i],rnormal);
		sample *= sign(dot(normal,sample));
		so = ldepth-sample.z*bof.x;
		sdepth = depthlinear(coord+bof*sample.xy/ldepth);
		delta = saturate(so-sdepth);
		delta *= 1.0-smoothstep(0.0,sclamp,delta);
		if ( (delta > sclampmin) && (delta < sclamp) )
			occ += 1.0-delta;
	}
	float uocc = saturate(occ/(ssaoquarter?16.0:64.0));
	float fade = 1.0-depth;
	uocc *= saturate(pow(max(0,fade),ssaofadepow)*ssaofademult);
	uocc = saturate(pow(max(0,uocc),ssaopow)*ssaomult);
	return saturate(1.0-(uocc*ssaoblend));
}
/*
   The blur passes use bilateral filtering to mostly preserve borders.
   An additional factor using difference of normals was tested, but the
   performance decrease was too much, so it's gone forever.
*/
float4 PS_SSAOBlurH( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	if ( !ssaoenable ) return 0.0;
	if ( !ssaobenable ) return TextureColor.Sample(Sampler1,coord);
	float bresl = ScreenSize.x;
	float bof = (1.0/bresl)*ssaobradius;
	float isd, sd, ds, sw, tw = 0;
	float res = 0.0;
	int i;
	isd = TextureDepth.Sample(Sampler1,coord).x;
	if ( ssaohalfblur ) [unroll] for ( i=-7; i<=7; i++ )
	{
		sd = TextureDepth.Sample(Sampler1,coord+float2(i,0)*bof).x;
		ds = 1.0/pow(1.0+abs(isd-sd),ssaobfact);
		sw = ds;
		sw *= gauss8[abs(i)];
		tw += sw;
		res += sw*TextureColor.Sample(Sampler1,coord+float2(i,0)
			*bof).x;
	}
	else [unroll] for ( i=-15; i<=15; i++ )
	{
		sd = TextureDepth.Sample(Sampler1,coord+float2(i,0)*bof).x;
		ds = 1.0/pow(1.0+abs(isd-sd),ssaobfact);
		sw = ds;
		sw *= gauss16[abs(i)];
		tw += sw;
		res += sw*TextureColor.Sample(Sampler1,coord+float2(i,0)
			*bof).x;
	}
	res /= tw;
	return res;
}
float4 PS_SSAOBlurV( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	if ( !ssaoenable ) return 0.0;
	if ( !ssaobenable ) return TextureColor.Sample(Sampler1,coord);
	float bresl = ScreenSize.x*ScreenSize.w;
	float bof = (1.0/bresl)*ssaobradius;
	float isd, sd, ds, sw, tw = 0;
	float res = 0.0;
	int i;
	isd = TextureDepth.Sample(Sampler1,coord).x;
	if ( ssaohalfblur ) [unroll] for ( i=-7; i<=7; i++ )
	{
		sd = TextureDepth.Sample(Sampler1,coord+float2(0,i)*bof).x;
		ds = 1.0/pow(1.0+abs(isd-sd),ssaobfact);
		sw = ds;
		sw *= gauss8[abs(i)];
		tw += sw;
		res += sw*TextureColor.Sample(Sampler1,coord+float2(0,i)
			*bof).x;
	}
	else [unroll] for ( i=-15; i<=15; i++ )
	{
		sd = TextureDepth.Sample(Sampler1,coord+float2(0,i)*bof).x;
		ds = 1.0/pow(1.0+abs(isd-sd),ssaobfact);
		sw = ds;
		sw *= gauss16[abs(i)];
		tw += sw;
		res += sw*TextureColor.Sample(Sampler1,coord+float2(0,i)
			*bof).x;
	}
	res /= tw;
	return res;
}

/* precalculate DOF factors */
float4 PS_DoFPrepass( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return 0.0;
	float dofpow = tod_ind(dofpow);
	float dofmult = tod_ind(dofmult);
	float dofbump = tod_ind(dofbump);
	float doffixedfocuspow = tod_ind(doffixedfocuspow);
	float doffixedfocusmult = tod_ind(doffixedfocusmult);
	float doffixedfocusbump = tod_ind(doffixedfocusbump);
	float doffixedfocusblend = tod_ind(doffixedfocusblend);
	float doffixedunfocuspow = tod_ind(doffixedunfocuspow);
	float doffixedunfocusmult = tod_ind(doffixedunfocusmult);
	float doffixedunfocusbump = tod_ind(doffixedunfocusbump);
	float doffixedunfocusblend = tod_ind(doffixedunfocusblend);
	float dep = TextureDepth.Sample(Sampler1,coord).x;
	float foc = TextureFocus.Sample(Sampler1,coord).x;
	float dfc = abs(dep-foc);
	float dff = abs(dep);
	float dfu = dff;
	if ( doffixedcut && (dep >= cutoff*0.000001) ) dfu *= 0;
	dfc = clamp(pow(dfc,dofpow)*dofmult+dofbump,0.0,1.0);
	dff = clamp(pow(dff,doffixedfocuspow)*doffixedfocusmult
		+doffixedfocusbump,0.0,1.0);
	dfu = clamp(pow(dfu,doffixedunfocuspow)*doffixedunfocusmult
		+doffixedunfocusbump,0.0,1.0);
	dfc *= lerp(1.0,dff,doffixedfocusblend);
	dfc += lerp(0.0,dfu,doffixedunfocusblend);
	return max(0.0,dfc);
}

/* apply SSAO to screen */
float4 PS_SSAOApply( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureOriginal.Sample(Sampler1,coord);
	if ( !ssaoenable ) return res;
	float mud = RenderTargetR16F.Sample(Sampler1,coord).x;
	if ( ssaodebug ) return saturate(mud);
	return res*mud;
}

/* old Edgevision mode */
float3 EdgeView( float3 res, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	if ( fixed.x>0 && fixed.y>0 ) bresl = fixed;
	float edgevfadepow = tod_ind(edgevfadepow);
	float edgevfademult = tod_ind(edgevfademult);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*edgevradius;
	float mdx = 0, mdy = 0, mud = 0;
	/* this reduces texture fetches by half, big difference */
	float3x3 depths;
	depths[0][0] = depthlinear(coord+float2(-1,-1)*bof);
	depths[0][1] = depthlinear(coord+float2( 0,-1)*bof);
	depths[0][2] = depthlinear(coord+float2( 1,-1)*bof);
	depths[1][0] = depthlinear(coord+float2(-1, 0)*bof);
	depths[1][1] = depthlinear(coord+float2( 0, 0)*bof);
	depths[1][2] = depthlinear(coord+float2( 1, 0)*bof);
	depths[2][0] = depthlinear(coord+float2(-1, 1)*bof);
	depths[2][1] = depthlinear(coord+float2( 0, 1)*bof);
	depths[2][2] = depthlinear(coord+float2( 1, 1)*bof);
	mdx += GX[0][0]*depths[0][0];
	mdx += GX[0][1]*depths[0][1];
	mdx += GX[0][2]*depths[0][2];
	mdx += GX[1][0]*depths[1][0];
	mdx += GX[1][1]*depths[1][1];
	mdx += GX[1][2]*depths[1][2];
	mdx += GX[2][0]*depths[2][0];
	mdx += GX[2][1]*depths[2][1];
	mdx += GX[2][2]*depths[2][2];
	mdy += GY[0][0]*depths[0][0];
	mdy += GY[0][1]*depths[0][1];
	mdy += GY[0][2]*depths[0][2];
	mdy += GY[1][0]*depths[1][0];
	mdy += GY[1][1]*depths[1][1];
	mdy += GY[1][2]*depths[1][2];
	mdy += GY[2][0]*depths[2][0];
	mdy += GY[2][1]*depths[2][1];
	mdy += GY[2][2]*depths[2][2];
	mud = pow(mdx*mdx+mdy*mdy,0.5);
	float fade = 1.0-TextureDepth.Sample(Sampler1,coord).x;
	mud *= saturate(pow(max(0,fade),edgevfadepow)*edgevfademult);
	mud = saturate(pow(max(0,mud),edgevpow)*edgevmult);
	return mud;
}

/* Edgevision and Sharpen */
float4 PS_Edge( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler1,coord);
	if ( edgevenable ) res.rgb = EdgeView(res.rgb,coord);
	return res;
}

/*
   Underwater distortion, which currently has no real use due to Boris being
   lazy. fWaterLevel doesn't yet provide any usable values.
*/
float2 UnderwaterDistort( float2 coord )
{
	if ( !wateralways ) return coord;
	float2 ofs = float2(0.0,0.0);
	float siny = sin(pi*2.0*(coord.y*uwm.x+Timer.x*uwf.x*100.0))*uws.x;
	ofs.y = siny+sin(pi*2.0*(coord.x*uwm.y+Timer.x*uwf.y*100.0))*uws.y;
	ofs.x = siny+sin(pi*2.0*(coord.x*uwm.z+Timer.x*uwf.z*100.0))*uws.z;
	ofs -= (coord-0.5)*2.0*uwz;
	return coord+ofs*0.01;
}

/* Distant hot air refraction. Not very realistic, but does the job. */
float2 DistantHeat( float2 coord )
{
	float2 bresl;
	float dep, odep;
	dep = TextureDepth.Sample(Sampler1,coord).x;
	float distfade = clamp(pow(max(0,dep),heatfadepow)*heatfademul
		+heatfadebump,0.0,1.0);
	if ( distfade <= 0.0 ) return coord;
	float todpow = todx_ind(heatfactor);
	if ( !heatalways && (todpow <= 0.0) ) return coord;
	if ( (fixed.x > 0) && (fixed.y > 0) ) bresl = fixed;
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 nc = coord*(bresl/HEATSIZE)*heatsize;
	float2 ts = float2(0.01,1.0)*Timer.x*10000.0*heatspeed;
	float2 ofs = TextureHeat.SampleLevel(Sampler2,nc+ts,0).xy;
	ofs = (ofs-0.5)*2.0;
	ofs *= pow(length(ofs),heatpow);
	ofs *= todpow;
	if ( !heatalways ) ofs *= weatherfactor(WT_HOT);
	odep = TextureDepth.SampleLevel(Sampler1,coord+ofs*heatstrength
		*distfade*0.01,0).x;
	float odistfade = clamp(pow(max(0,odep),heatfadepow)*heatfademul
		+heatfadebump,0.0,1.0);
	if ( odistfade <= 0.0 ) return coord;
	return coord+ofs*heatstrength*distfade*0.01;
}

/* Screen distortion filters */
float4 PS_Distortion( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float2 bresl;
	if ( (fixed.x > 0) && (fixed.y > 0) ) bresl = fixed;
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 ofs = coord;
	if ( waterenable ) ofs = UnderwaterDistort(ofs);
	if ( heatenable ) ofs = DistantHeat(ofs);
	ofs -= coord;
	float4 res;
	if ( (distcha == 0.0) || (length(ofs) == 0.0) )
		return TextureColor.Sample(Sampler1,coord+ofs);
	float2 ofr, ofg, ofb;
	ofr = ofs*(1.0-distcha*0.01);
	ofg = ofs;
	ofb = ofs*(1.0+distcha*0.01);
	res = float4(TextureColor.Sample(Sampler1,coord+ofr).r,
		TextureColor.Sample(Sampler1,coord+ofg).g,
		TextureColor.Sample(Sampler1,coord+ofb).b,
		TextureColor.Sample(Sampler1,coord+ofs).a);
	return res;
}

/* This will do absolutely nothing */
float4 PS_Aperture( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	return float4(0,0,0,1);
}

/* Focus */
float4 PS_ReadFocus( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	if ( dofdisable ) return 0.0;
	if ( focusmanual ) return focusmanualvalue;
	float focusmax = tod_ind(focusmax);
	float cfocus = min(TextureDepth.Sample(Sampler1,focuscenter).x,
		focusmax*0.001);
	if ( !focuscircle ) return cfocus;
	/* using polygons inscribed into a circle, in this case a triangle */
	float focusradius = tod_ind(focusradius);
	float focusmix = tod_ind(focusmix);
	float cstep = (1.0/3.0);
	float sfocus, mfocus[4];
	float2 coord;
	float2 bof = float2(1.0,1.0/ScreenSize.w)*focusradius*0.01;
	float fan = focuscircleangle*2.0*pi;
	coord.x = focuscenter.x+sin(fan)*bof.x;
	coord.y = focuscenter.y+cos(fan)*bof.y;
	mfocus[0] = min(TextureDepth.Sample(Sampler1,coord).x,
		focusmax*0.001);
	coord.x = focuscenter.x+sin(fan+2.0*pi*cstep)*bof.x;
	coord.y = focuscenter.y+cos(fan+2.0*pi*cstep)*bof.y;
	mfocus[1] = min(TextureDepth.Sample(Sampler1,coord).x,
		focusmax*0.001);
	coord.x = focuscenter.x+sin(fan+4.0*pi*cstep)*bof.x;
	coord.y = focuscenter.y+cos(fan+4.0*pi*cstep)*bof.y;
	mfocus[2] = min(TextureDepth.Sample(Sampler1,coord).x,
		focusmax*0.001);
	if ( (mfocus[0] <= focuscenterdiscard)
		&& (mfocus[1] <= focuscenterdiscard)
		&& (mfocus[2] <= focuscenterdiscard) )
		mfocus[3] = focuscenterdiscard;
	else if ( mfocus[0] <= focuscenterdiscard )
	{
		if ( mfocus[1] <= focuscenterdiscard ) mfocus[3] = mfocus[2];
		else mfocus[3] = 0.5*(mfocus[1]+mfocus[2]);
	}
	else if ( mfocus[1] <= focuscenterdiscard )
	{
		if ( mfocus[2] <= focuscenterdiscard ) mfocus[3] = mfocus[0];
		else mfocus[3] = 0.5*(mfocus[0]+mfocus[2]);
	}
	else if ( mfocus[2] <= focuscenterdiscard )
		mfocus[3] = 0.5*(mfocus[0]+mfocus[1]);
	else mfocus[3] = cstep*(mfocus[0]+mfocus[1]+mfocus[2]);
	if ( cfocus <= focuscenterdiscard ) cfocus = mfocus[3];
	else cfocus = (1.0-focusmix)*cfocus+focusmix*mfocus[3];
	return cfocus;
}

float4 PS_Focus( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	if ( dofdisable ) return 0.0;
	return max(lerp(TexturePrevious.Sample(Sampler0,0.5).x,
		TextureCurrent.Sample(Sampler0,0.5).x,
		saturate(DofParameters.w)),0.0);
}

/* gather blur pass */
float4 PS_DoFBlur( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return TextureColor.Sample(Sampler1,coord);
	float dfc = RenderTargetR32F.Sample(Sampler1,coord).x;
	if ( dofdebug ) return TextureDepth.Sample(Sampler1,coord).x;
	if ( dfcdebug ) return dfc;
	float2 bresl;
	if ( (fixed.x > 0) && (fixed.y > 0) ) bresl = fixed;
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = 1.0/bresl;
	if ( dfc <= dofminblur ) return TextureColor.Sample(Sampler1,coord);
	float4 res = float4(0,0,0,0);
	float dep = TextureDepth.Sample(Sampler1,coord).x;
	float sd, ds, sw, tw = 0;
	float2 bsz = bof*dofpradius*dfc;
	float4 sc;
	[unroll] for ( int i=0; i<32; i++ )
	{
		sc = TextureColor.SampleLevel(Sampler1,coord+poisson32[i]*bsz,
			dfc*4.0);
		ds = TextureDepth.SampleLevel(Sampler1,coord+poisson32[i]*bsz,
			0).x;
		sd = RenderTargetR32F.SampleLevel(Sampler1,coord+poisson32[i]
			*bsz,0).x;
		sw = (ds>dep)?1.0:sd;
		tw += sw;
		res += sc*sw;
	}
	res /= tw;
	return res;
	
}

/* simple gaussian / bilateral blur */
float4 PS_DoFBlurH( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return TextureColor.Sample(Sampler1,coord);
	float dfc = RenderTargetR32F.Sample(Sampler1,coord).x;
	if ( dofdebug ) return TextureDepth.Sample(Sampler1,coord).x;
	if ( dfcdebug ) return dfc;
	float bresl = (fixed.x>0)?fixed.x:ScreenSize.x;
	float bof = (1.0/bresl)*dofbradius;
	float4 res = float4(0,0,0,0);
	if ( dfc <= dofminblur ) return TextureColor.Sample(Sampler1,coord);
	int i;
	float isd, sd, ds, sw, tw = 0;
	isd = dfc;
	[unroll] for ( i=-7; i<=7; i++ )
	{
		sd = RenderTargetR32F.SampleLevel(Sampler1,coord+float2(i,0)
			*bof*dfc,0).x;
		ds = abs(isd-sd)*dofbfact+0.5;
		sw = 1.0/(ds+1.0);
		sw *= gauss8[abs(i)];
		tw += sw;
		res += sw*TextureColor.SampleLevel(Sampler1,coord+float2(i,0)
			*bof*dfc,0);
	}
	res /= tw;
	return res;
}
float4 PS_DoFBlurV( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return TextureColor.Sample(Sampler1,coord);
	float dfc = RenderTargetR32F.Sample(Sampler1,coord).x;
	if ( dofdebug ) return TextureDepth.Sample(Sampler1,coord).x;
	if ( dfcdebug ) return dfc;
	float bresl = (fixed.y>0)?fixed.y:(ScreenSize.x*ScreenSize.w);
	float bof = (1.0/bresl)*dofbradius;
	float4 res = float4(0,0,0,0);
	if ( dfc <= dofminblur ) return TextureColor.Sample(Sampler1,coord);
	int i;
	float isd, sd, ds, sw, tw = 0;
	isd = dfc;
	[unroll] for ( i=-7; i<=7; i++ )
	{
		sd = RenderTargetR32F.SampleLevel(Sampler1,coord+float2(0,i)
			*bof*dfc,0).x;
		ds = abs(isd-sd)*dofbfact+0.5;
		sw = 1.0/(ds+1.0);
		sw *= gauss8[abs(i)];
		tw += sw;
		res += sw*TextureColor.SampleLevel(Sampler1,coord+float2(0,i)
			*bof*dfc,0);
	}
	res /= tw;
	return res;
}

/* Screen frost shader. Not very realistic either, but looks fine too. */
float2 ScreenFrost( float2 coord )
{
	float2 bresl;
	if ( (fixed.x > 0) && (fixed.y > 0) ) bresl = fixed;
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 nc = coord*(bresl/FROSTSIZE)*frostsize;
	float2 ofs = TextureFrostBump.Sample(Sampler2,nc).xy;
	ofs = (ofs-0.5)*2.0;
	ofs *= pow(length(ofs),frostpow)*froststrength;
	float todpow = todx_ind(frostfactor);
	if ( !frostalways ) ofs *= weatherfactor(WT_COLD)
		+(1.0-weatherfactor(WT_HOT))*todpow;
	else ofs *= todpow;
	float dist = distance(coord,float2(0.5,0.5))*2.0;
	ofs *= clamp(pow(dist,frostrpow)*frostrmult+frostrbump,0.0,1.0);
	return coord+ofs;
}

/* screen frost overlay */
float4 PS_FrostPass( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float2 bresl;
	if ( (fixed.x > 0) && (fixed.y > 0) ) bresl = fixed;
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float4 res;
	[branch] if ( frostenable )
	{
		float2 ofs = ScreenFrost(coord);
		ofs -= coord;
		if ( (distcha != 0.0) && (length(ofs) != 0.0) )
		{
			float2 ofr, ofg, ofb;
			ofr = ofs*(1.0-distcha*0.01);
			ofg = ofs;
			ofb = ofs*(1.0+distcha*0.01);
			res = float4(TextureColor.Sample(Sampler1,coord+ofr).r,
				TextureColor.Sample(Sampler1,coord+ofg).g,
				TextureColor.Sample(Sampler1,coord+ofb).b,1.0);
		}
		else res = TextureColor.Sample(Sampler1,coord+ofs);
		float2 nc = coord*(bresl/FROSTSIZE)*frostsize;
		float bmp = pow(max(0,TextureFrost.SampleLevel(Sampler2,nc,
			0).x),frostbpow);
		float dist = distance(coord,float2(0.5,0.5))*2.0;
		dist = clamp(pow(dist,frostrpow)*frostrmult+frostrbump,0.0,
			1.0)*frostblend;
		float todpow = todx_ind(frostfactor);
		/* Weathers not implemented in FO4 ENB as of 0.291 */
		if ( !frostalways ) dist *= weatherfactor(WT_COLD)
			+(1.0-weatherfactor(WT_HOT))*todpow;
		else dist *= todpow;
		res.rgb *= 1.0+bmp*dist;
	}
	else res = TextureColor.Sample(Sampler1,coord);
	if ( !focusdisplay ) return res;
	if ( distance(coord,focuscenter) < 0.01 ) res.rgb = float3(1,0,0);
	float cstep = (1.0/3.0);
	float2 tcoord;
	float focusradius = tod_ind(focusradius);
	float2 bof = float2(1.0,1.0/ScreenSize.w)*focusradius*0.01;
	float fan = focuscircleangle*2.0*pi;
	tcoord.x = focuscenter.x+sin(fan)*bof.x;
	tcoord.y = focuscenter.y+cos(fan)*bof.y;
	if ( distance(coord,tcoord) < 0.01 ) res.rgb = float3(1,0,0);
	tcoord.x = focuscenter.x+sin(fan+2.0*pi*cstep)*bof.x;
	tcoord.y = focuscenter.y+cos(fan+2.0*pi*cstep)*bof.y;
	if ( distance(coord,tcoord) < 0.01 ) res.rgb = float3(1,0,0);
	tcoord.x = focuscenter.x+sin(fan+4.0*pi*cstep)*bof.x;
	tcoord.y = focuscenter.y+cos(fan+4.0*pi*cstep)*bof.y;
	if ( distance(coord,tcoord) < 0.01 ) res.rgb = float3(1,0,0);
	return res;
}

technique11 Aperture
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Aperture()));
	}
}

technique11 ReadFocus
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_ReadFocus()));
	}
}

technique11 Focus
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Focus()));
	}
}

technique11 PrepassNB <string UIName="MariENB Bilateral Blur DoF";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_SSAOPre()));
	}
}
technique11 PrepassNB1
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_SSAOBlurH()));
	}
}
technique11 PrepassNB2 <string RenderTarget="RenderTargetR16F";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_SSAOBlurV()));
	}
}
technique11 PrepassNB3 <string RenderTarget="RenderTargetR32F";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_DoFPrepass()));
	}
}
technique11 PrepassNB4
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_SSAOApply()));
	}
}
technique11 PrepassNB5
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Edge()));
	}
}
technique11 PrepassNB6
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Distortion()));
	}
}
technique11 PrepassNB7
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_DoFBlurH()));
	}
}
technique11 PrepassNB8
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_DoFBlurV()));
	}
}
technique11 PrepassNB9
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_FrostPass()));
	}
}

technique11 Prepass <string UIName="MariENB Gather Blur DoF";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_SSAOPre()));
	}
}
technique11 Prepass1
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_SSAOBlurH()));
	}
}
technique11 Prepass2 <string RenderTarget="RenderTargetR16F";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_SSAOBlurV()));
	}
}
technique11 Prepass3 <string RenderTarget="RenderTargetR32F";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_DoFPrepass()));
	}
}
technique11 Prepass4
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_SSAOApply()));
	}
}
technique11 Prepass5
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Edge()));
	}
}
technique11 Prepass6
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Distortion()));
	}
}
technique11 Prepass7
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_DoFBlur()));
	}
}
technique11 Prepass8
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_FrostPass()));
	}
}
