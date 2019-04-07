/*
	menbglobaldefs.fx : MariENB global shared code.
	(C)2013-2017 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* do not touch this! */
#define E_SHADER_3_0
/* are we running on fallout 3 / new vegas or on skyrim? */
//#define FALLOUT
/* time of day and interior interpolation */
#define tod_ind(x) lerp(lerp(x##_n,x##_d,ENightDayFactor),\
	lerp(x##_in,x##_id,ENightDayFactor),EInteriorFactor)
/* weather macros */
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
/* temperate no fog */
#define WT_NEUTRAL	0.0
#define WT_GENERAL	1.0
#define WT_FOREST	2.0
#define WT_DARK		3.0
/* cold no fog */
#define WT_COLD		4.0
#define WT_SPOOKY	5.0
/* warm no fog */
#define WT_WARM		6.0
/* temperate fog */
#define WT_GENERALFOG	7.0
#define WT_GENERALRAIN	8.0
#define WT_FORESTFOG	9.0
#define WT_FORESTRAIN	10.0
#define WT_DARKFOG	11.0
#define WT_DARKRAIN	12.0
/* cold fog */
#define WT_SPOOKYFOG	13.0
#define WT_COLDFOG	14.0
/* warm fog */
#define WT_WARMFOG	15.0
/* temperature and fog interpolation macros */
#define istemperate(x) (((x>=0.0)&&(x<=3.0))||((x>=7.0)&&(x<=12.0)))
#define iscold(x) (((x>=4.0)&&(x<=5.0))||((x>=13.0)&&(x<=14.0)))
#define iswarm(x) ((x==6.0)||(x==15.0))
#define isfog(x) ((x>=7.0)&&(x<=15.0))
#define temperatefactor (istemperate(WeatherAndTime.x)\
	?istemperate(WeatherAndTime.y)?(1.0):(WeatherAndTime.z)\
	:istemperate(WeatherAndTime.y)?(1.0-WeatherAndTime.z):(0.0))
#define coldfactor (iscold(WeatherAndTime.x)\
	?iscold(WeatherAndTime.y)?(1.0):(WeatherAndTime.z)\
	:iscold(WeatherAndTime.y)?(1.0-WeatherAndTime.z):(0.0))
#define warmfactor (iswarm(WeatherAndTime.x)\
	?iswarm(WeatherAndTime.y)?(1.0):(WeatherAndTime.z)\
	:iswarm(WeatherAndTime.y)?(1.0-WeatherAndTime.z):(0.0))
#define fogfactor (isfog(WeatherAndTime.x)\
	?isfog(WeatherAndTime.y)?(1.0):(WeatherAndTime.z)\
	:isfog(WeatherAndTime.y)?(1.0-WeatherAndTime.z):(0.0))
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