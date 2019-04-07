/*
	menbglobaldefs.fx : MariENB 3 global shared code.
	(C)2015 Marisa Kirisame, UnSX Team.
	Part of MariENB 3, the personal ENB of Marisa for Fallout 4.
	Released under the GNU GPLv3 (or later).
*/
/*
   TODO time of day interpolation
   guessed formula, not used yet since it's a lot of work to make separate
   variables for now.
*/
//#define tod(x) (x##_dw*TimeOfDay1.x+x##_sr*TimeOfDay1.y+x##_dy*TimeOfDay1.z\
//	+x##_ss*TimeOfDay1.w+x##_ds*TimeOfDay2.x+x##_nt*TimeOfDay2.y)
#define tod(x) x
/* weather macros */
#define WT_TEMPERATE 0.0
#define WT_HOT 1.0
#define WT_COLD 2.0
#define weatherfactor(id) ((Weather.x==id)?(Weather.y==id)\
	?(1.0):(Weather.z):(Weather.y==id)\
	?(1.0-Weather.z):(0.0))
/* asset definitions */
/* ascii art font */
#define FONT_WIDTH   8
#define FONT_HEIGHT  4096
#define GLYPH_WIDTH  8
#define GLYPH_HEIGHT 16
#define FONT_LEVELS  255
/*
   aspect correction for certain overlays
    uncommented : the textures are 1:1 and must be corrected
    commented : the textures are 16:9 or whatever ratio you use
*/
#define ASPECT_LENSDIRT
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
#define LENSDIRT_DDS
//#define FROST_DDS
//#define FROSTBUMP_DDS
/* experimental features (TODO) */
//#define USE_BOKEH
//#define MULTIPASS_RMAO