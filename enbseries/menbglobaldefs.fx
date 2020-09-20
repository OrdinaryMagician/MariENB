/*
	menbglobaldefs.fx : MariENB3 global shared code.
	(C)2016-2020 Marisa Kirisame, UnSX Team.
	Part of MariENB3, the personal ENB of Marisa for Fallout 4.
	Released under the GNU GPLv3 (or later).
*/
/* are we running on skyrim special edition or on fallout 4? */
//#define SKYRIMSE
/* [New in 3.5.1] increase the quality of bloom by using larger matrices */
//#define HQBLOOM
/* [New in 3.5.1] compiles in SMAA support */
#define WITH_SMAA
/* time of day and interior interpolation */
#define ndfact clamp(0.5+(TimeOfDay1.z+(TimeOfDay1.y+TimeOfDay1.w)*0.5)*0.5\
	-(TimeOfDay2.y+(TimeOfDay1.x+TimeOfDay2.x)*0.5)*0.5,0.0,1.0)
#define tod_ind(a) lerp(lerp(a##_n,a##_d,ndfact),a##_i,EInteriorFactor)
#define todx_ind(a) lerp(a##_dw*TimeOfDay1.x+a##_sr*TimeOfDay1.y+a##_dy\
	*TimeOfDay1.z+a##_ss*TimeOfDay1.w+a##_ds*TimeOfDay2.x+a##_nt\
	*TimeOfDay2.y,a##_i,EInteriorFactor)
/* weather macros (not very useful yet) */
#define weatherfactor(id) ((Weather.x==id)?(Weather.y==id)?(1.0):(Weather.z)\
	:(Weather.y==id)?(1.0-Weather.z):(0.0))
/*
   Explanation of macro, because some of the people reading this likely don't
   know what a ternary conditional is:

   (Weather.x==id)  -> transitioning to wanted weather?
   ?(Weather.y==id) -> coming from wanted weather?
   ?(1.0)                  -> if so, always 1
   :(Weather.z)     -> if not, return transition
   :(Weather.y==id) -> not transitioning but coming from wanted weather?
   ?(1.0-Weather.z) -> return inverse transition
   :(0.0)                  -> otherwise return 0
*/
/* temperate no fog */
#define WT_NEUTRAL	0.0
#define WT_GENERAL	1.0
#define WT_DARK		2.0
/* cold no fog */
#define WT_HARBOR	3.0
#define WT_FROSTY	4.0
/* warm no fog */
#define WT_HEAT		5.0
#define WT_SCORCHED	6.0
/* temperate fog */
#define WT_GENERALFOG	7.0
#define WT_GENERALRAIN	8.0
#define WT_DARKFOG	9.0
#define WT_DARKRAIN	10.0
/* cold fog */
#define WT_HARBORFOG	11.0
#define WT_FROSTYFOG	12.0
#define WT_HARBORRAIN	13.0
/* warm fog */
#define WT_HEATFOG	14.0
#define WT_SCORCHEDFOG	15.0
/* temperature and fog interpolation macros */
#define istemperate(x) (((x>=0.0)&&(x<=2.0))||((x>=7.0)&&(x<=10.0)))
#define iscold(x) (((x>=3.0)&&(x<=4.0))||((x>=11.0)&&(x<=13.0)))
#define iswarm(x) (((x>=5.0)&&(x<=6.0))||((x>=14.0)&&(x<=15.0)))
#define isfog(x) ((x>=7.0)&&(x<=15.0))
#define temperatefactor (istemperate(Weather.x)?istemperate(Weather.y)?(1.0)\
	:(Weather.z):istemperate(Weather.y)?(1.0-Weather.z):(0.0))
#define coldfactor (iscold(Weather.x)?iscold(Weather.y)?(1.0):(Weather.z)\
	:iscold(Weather.y)?(1.0-Weather.z):(0.0))
#define warmfactor (iswarm(Weather.x)?iswarm(Weather.y)?(1.0):(Weather.z)\
	:iswarm(Weather.y)?(1.0-Weather.z):(0.0))
#define fogfactor (isfog(Weather.x)?isfog(Weather.y)?(1.0):(Weather.z)\
	:isfog(Weather.y)?(1.0-Weather.z):(0.0))
/* asset definitions */
/* texture sizes */
#define NOISESIZE 256.0
#define HEATSIZE 512.0
#define FROSTSIZE 1024.0
/* some textures can be provided as DDS rather than PNG to save space */
//#define HEAT_DDS
//#define FROST_DDS
//#define VIGNETTE_DDS
/* SMAA quality */
//#define SMAA_PRESET_LOW
//#define SMAA_PRESET_MEDIUM
//#define SMAA_PRESET_HIGH
#define SMAA_PRESET_ULTRA
