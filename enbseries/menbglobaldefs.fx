/*
	menbglobaldefs.fx : MariENB global shared code.
	(C)2013-2017 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* do not touch this! */
#define E_SHADER_3_0
/* time of day and interior interpolation */
#define tod_ind(x) lerp(lerp(x##_n,x##_d,ENightDayFactor),x##_i,\
	EInteriorFactor)
/* asset definitions */
/* texture sizes */
#define NOISESIZE 256.0
#define HEATSIZE 1024.0
#define FROSTSIZE 1024.0
/* LUT mode (use only one) - The 256px option was discarded for size reasons */
//#define LUTMODE_LEGACY
//#define LUTMODE_16
#define LUTMODE_64
/* some textures can be provided as DDS rather than PNG to save space */
//#define HEAT_DDS
//#define FROST_DDS
//#define FROSTBUMP_DDS
//#define VIGNETTE_DDS