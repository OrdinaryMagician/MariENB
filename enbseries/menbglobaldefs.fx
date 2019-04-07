/*
	menbglobaldefs.fx : MariENB3 global shared code.
	(C)2016 Marisa Kirisame, UnSX Team.
	Part of MariENB3, the personal ENB of Marisa for Fallout 4.
	Released under the GNU GPLv3 (or later).
*/
/* are we running on skyrim special edition or on fallout 4? */
#define SKYRIMSE
/* time of day and interior interpolation */
#define ndfact clamp(0.5+(TimeOfDay1.z+(TimeOfDay1.y+TimeOfDay1.w)*0.5)*0.5\
	-(TimeOfDay2.y+(TimeOfDay1.x+TimeOfDay2.x)*0.5)*0.5,0.0,1.0)
#define tod_ind(a) lerp(lerp(a##_n,a##_d,ndfact),a##_i,EInteriorFactor)
#define todx_ind(a) lerp(a##_dw*TimeOfDay1.x+a##_sr*TimeOfDay1.y+a##_dy\
	*TimeOfDay1.z+a##_ss*TimeOfDay1.w+a##_ds*TimeOfDay2.x+a##_nt\
	*TimeOfDay2.y,a##_i,EInteriorFactor)
/* weather macros (not very useful yet) */
#define WT_TEMPERATE 0.0
#define WT_HOT 1.0
#define WT_COLD 2.0
#define weatherfactor(id) ((Weather.x==id)?(Weather.y==id)?(1.0):(Weather.z)\
	:(Weather.y==id)?(1.0-Weather.z):(0.0))
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
