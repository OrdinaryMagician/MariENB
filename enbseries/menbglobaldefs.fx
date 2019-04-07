/*
	menbglobaldefs.fx : MariENB global shared code.
	(C)2013-2016 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* do not touch this! */
#define E_SHADER_3_0
/* are we running on fallout 3 / new vegas or on skyrim? */
//#define FALLOUT
/* time of day and interior interpolation */
#ifdef FALLOUT
#define tod_ind(x) lerp(lerp(x##_n,x##_d,ENightDayFactor),\
	(x##_in+x##_id)*0.5,EInteriorFactor)
#else
#define tod_ind(x) lerp(lerp(x##_n,x##_d,ENightDayFactor),\
	lerp(x##_in,x##_id,ENightDayFactor),EInteriorFactor)
#endif
/* weather macros */
#define WT_TEMPERATE 0.0
#define WT_HOT 1.0
#define WT_COLD 2.0
#define weatherfactor(id) ((WeatherAndTime.x==id)?(WeatherAndTime.y==id)\
	?(1.0):(WeatherAndTime.z):(WeatherAndTime.y==id)\
	?(1.0-WeatherAndTime.z):(0.0))
/*
   Explanation of macro, because some of the people reading this likely don't
   know what a ternary conditional is:

   (WeatherAndTime.x==id)  -> transitioning to wanted weather?
   ?(WeatherAndTime.y==id) -> coming from wanted weather?
   ?(1.0)                  -> if so, always 1
   :(WeatherAndTime.z)     -> if not, return transition
   :(WeatherAndTime.y==id) -> not transitioning but coming from wanted weather?
   ?(1.0-WeatherAndTime.z) -> return inverse transition
   :(0.0)                  -> otherwise return 0
*/
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
//#define ASPECT_LENSDIRT
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
//#define LENSDIRT_DDS
//#define FROST_DDS
//#define FROSTBUMP_DDS
/* optional heavy features (can be toggled to reduce compile times) */
//#define MARIENB_SSAO