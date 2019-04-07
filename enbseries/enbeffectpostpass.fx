/*
	enbeffectpostpass.fx : MariENB3 extra shader.
	(C)2016-2017 Marisa Kirisame, UnSX Team.
	Part of MariENB3, the personal ENB of Marisa for Fallout 4.
	Released under the GNU GPLv3 (or later).
*/
#include "menbglobaldefs.fx"

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
/* new SMAA filter */
string str_smaa = "SMAA";
bool smaaenable
<
	string UIName = "Enable SMAA";
	string UIWidget = "Checkbox";
> = {false};
int smaadebug
<
	string UIName = "SMAA Debugging";
	string UIWidget = "Spinner";
	int UIMin = 0;
	int UIMax = 2;
> = {0};
/* Depth-cutting chroma key */
string str_mask = "Depth Chroma Key";
bool maskenable
<
	string UIName = "Enable Chroma Key";
	string UIWidget = "Checkbox";
> = {false};
float3 mask
<
	string UIName = "Chroma Key Red";
	string UIWidget = "Color";
> = {0.0,1.0,0.0};
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
/* luma sharpen because of reasons */
string str_lsharp = "Luma Sharpen";
bool lsharpenable
<
	string UIName = "Luma Sharpen Enable";
	string UIWidget = "Checkbox";
> = {false};
float lsharpradius
<
	string UIName = "Luma Sharpen Radius";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.8};
float lsharpclamp
<
	string UIName = "Luma Sharpen Clamp";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.02};
float lsharpblend
<
	string UIName = "Luma Sharpen Blending";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.2};
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
float3 vigcolor
<
	string UIName = "Vignette Color";
	string UIWidget = "Vector";
> = {0.0,0.0,0.0};
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

/* gaussian blur matrices */
/* radius: 4, std dev: 1.5 */
static const float gauss4[4] =
{
	0.270682, 0.216745, 0.111281, 0.036633
};

float4 ScreenSize;
Texture2D TextureOriginal;
Texture2D TextureColor;
Texture2D TextureDepth;
Texture2D TextureVignette
<
#ifdef VIGNETTE_DDS
	string ResourceName = "menbvignette.dds";
#else
	string ResourceName = "menbvignette.png";
#endif
>;

SamplerState Sampler
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
	MaxLOD = 0;
};
SamplerState SamplerB
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Border;
	AddressV = Border;
	MaxLOD = 0;
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

VS_OUTPUT_POST VS_PostProcess(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;
	OUT.pos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord.xy = IN.txcoord.xy;
	return OUT;
}

/* helpers */
/* photometric */
#define luminance(x) dot(x,float3(0.2126,0.7152,0.0722))
/* CCIR601 */
//#define luminance(x) dot(x,float3(0.299,0.587,0.114))
float3 rgb2hsv( float3 c )
{
	float4 K = float4(0.0,-1.0/3.0,2.0/3.0,-1.0);
	float4 p = (c.g<c.b)?float4(c.bg,K.wz):float4(c.gb,K.xy);
	float4 q = (c.r<p.x)?float4(p.xyw,c.r):float4(c.r,p.yzx);
	float d = q.x-min(q.w,q.y);
	float e = 1.0e-10;
	return float3(abs(q.z+(q.w-q.y)/(6.0*d+e)),d/(q.x+e),q.x);
}
float3 hsv2rgb( float3 c )
{
	float4 K = float4(1.0,2.0/3.0,1.0/3.0,3.0);
	float3 p = abs(frac(c.x+K.xyz)*6.0-K.w);
	return c.z*lerp(K.x,saturate(p-K.x),c.y);
}

float4 PS_ChromaKey( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !maskenable ) return res;
	float msd = maskd;
	msd = maskd+0.01*masktiltx*(masktiltxcenter-coord.x)
		+0.01*masktilty*(masktiltycenter-coord.y);
	if ( TextureDepth.Sample(Sampler,coord).x > msd )
		return float4(mask.r,mask.g,mask.b,1.0);
	return res;
}

/* that's right, CRT curvature */
float4 PS_Curvature( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !curveenable ) return res;
	float3 eta = float3(1+chromaab*0.009,1+chromaab*0.006,1+chromaab
		*0.003);
	float2 center = float2(coord.x-0.5,coord.y-0.5);
	float zfact = 100.0/lenszoom;
	float r2 = center.x*center.x+center.y*center.y;
	float f = 1+r2*lensdist*0.01;
	float x = f*zfact*center.x+0.5;
	float y = f*zfact*center.y+0.5;
	float2 rcoord = (f*eta.r)*zfact*(center.xy*0.5)+0.5;
	float2 gcoord = (f*eta.g)*zfact*(center.xy*0.5)+0.5;
	float2 bcoord = (f*eta.b)*zfact*(center.xy*0.5)+0.5;
	int i,j;
	float3 idist = float3(TextureColor.Sample(SamplerB,rcoord).r,
		TextureColor.Sample(SamplerB,gcoord).g,
		TextureColor.Sample(SamplerB,bcoord).b);
	res.rgb = idist.rgb;
	return res;
}

/* Why am I doing this */
float4 PS_Blur( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !bssblurenable ) return res;
	float2 ofs[16] =
	{
		float2(1.0,1.0), float2(-1.0,-1.0),
		float2(-1.0,1.0), float2(1.0,-1.0),
		
		float2(1.0,0.0), float2(-1.0,0.0),
		float2(0.0,1.0), float2(0.0,-1.0),
		
		float2(1.41,0.0), float2(-1.41,0.0),
		float2(0.0,1.41), float2(0.0,-1.41),
		
		float2(1.41,1.41), float2(-1.41,-1.41),
		float2(-1.41,1.41), float2(1.41,-1.41)
	};
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*bssblurradius;
	int i;
	[unroll] for ( i=0; i<16; i++ )
		res += TextureColor.Sample(Sampler,coord+ofs[i]*bof);
	res /= 17.0;
	res.a = 1.0;
	return res;
}
float4 PS_Sharp( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !bsssharpenable ) return res;
	float2 ofs[8] =
	{
		float2(1.0,1.0), float2(-1.0,-1.0),
		float2(-1.0,1.0), float2(1.0,-1.0),
		
		float2(1.41,1.41), float2(-1.41,-1.41),
		float2(-1.41,1.41), float2(1.41,-1.41)
	};
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*bsssharpradius;
	float4 tcol = res;
	int i;
	[unroll] for ( i=0; i<8; i++ )
		tcol += TextureColor.Sample(Sampler,coord+ofs[i]*bof);
	tcol /= 9.0;
	float4 orig = res;
	res = orig*(1.0+dot(orig.rgb-tcol.rgb,0.333333)*bsssharpamount);
	float rg = clamp(pow(orig.b,3.0),0.0,1.0);
	res = lerp(res,orig,rg);
	res.a = 1.0;
	return res;
}
float4 PS_Shift( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !bssshiftenable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*bssshiftradius;
	res.g = TextureColor.Sample(Sampler,coord).g;
	res.r = TextureColor.Sample(Sampler,coord+float2(0,-bof.y)).r;
	res.b = TextureColor.Sample(Sampler,coord+float2(0,bof.y)).b;
	res.a = 1.0;
	return res;
}

/* That "luma sharpen" thingy, added just because someone might want it */
float4 PS_LumaSharp( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !lsharpenable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*lsharpradius;
	float4 crawling = TextureColor.Sample(Sampler,coord+float2(0,-1)*bof);
	crawling += TextureColor.Sample(Sampler,coord+float2(-1,0)*bof);
	crawling += TextureColor.Sample(Sampler,coord+float2(1,0)*bof);
	crawling += TextureColor.Sample(Sampler,coord+float2(0,1)*bof);
	crawling *= 0.25;
	float4 inmyskin = res-crawling;
	float thesewounds = luminance(inmyskin.rgb);
	thesewounds = clamp(thesewounds,-lsharpclamp*0.01,lsharpclamp*0.01);
	float4 theywillnotheal = res+thesewounds*lsharpblend;
	return theywillnotheal;
}

/* vignette filtering */
float4 PS_Vignette( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	float4 vigdata = float4(0,0,0,0);
	if ( vigshape == 0 )
	{
		/* circular vignette */
		float2 uv = ((coord-0.5)*float2(1.0,ScreenSize.w))*2.0;
		vigdata.a = dot(uv,uv);
		vigdata.a = clamp(pow(vigdata.a,vigpow)*vigmul+vigbump,
			0.0,1.0);
		vigdata.rgb = vigcolor;
	}
	else if ( vigshape == 1 )
	{	
		/* box vignette */
		float2 uv = coord.xy*(1.0-coord.yx)*4.0;
		vigdata.a = 1.0-(uv.x*uv.y);
		vigdata.a = clamp(pow(max(vigdata.a,0.0),vigpow)*vigmul+vigbump,
			0.0,1.0);
		vigdata.rgb = vigcolor;
	}
	else
	{
		/* textured vignette (rgb = color, alpha = blend) */
		vigdata = TextureVignette.Sample(Sampler,coord);
	}
	/* apply blur */
	if ( bblurenable )
	{
		float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
		float bfact = clamp(pow(max(vigdata.a,0.0),bblurpow)*bblurmul
			+bblurbump,0.0,1.0);
		float2 bof = (1.0/bresl)*bblurradius*bfact;
		res.rgb *= 0;
		int i,j;
		[unroll] for ( i=-3; i<4; i++ ) [unroll] for ( j=-3; j<4; j++ )
			res.rgb += gauss4[abs(i)]*gauss4[abs(j)]
				*TextureColor.Sample(Sampler,coord
				+float2(i,j)*bof).rgb;
	}
	/* apply color */
	if ( vigenable )
	{
		float3 outcol;
		if ( vigmode == 0 )
			outcol = vigdata.rgb;
		else if ( vigmode == 1 )
			outcol = res.rgb+vigdata.rgb;
		else if ( vigmode == 2 )
			outcol = res.rgb*vigdata.rgb;
		res.rgb = lerp(res.rgb,outcol,vigdata.a);
	}
	return clamp(res,0.0,1.0);
}

/* paint filter */
float4 PS_Kuwahara( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !oilenable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = 1.0/bresl;
	float n = 16.0;
	float3 m[4] =
	{
		float3(0,0,0),float3(0,0,0),float3(0,0,0),float3(0,0,0)
	}, s[4] =
	{
		float3(0,0,0),float3(0,0,0),float3(0,0,0),float3(0,0,0)
	}, c;
	int i, j;
	[loop] for ( i=-3; i<=0; i++ ) [loop] for ( j=-3; j<=0; j++ )
	{
		c = TextureColor.Sample(Sampler,coord+float2(i,j)*bof).rgb;
		m[0] += c;
		s[0] += c*c;
	}
	[loop] for ( i=-3; i<=0; i++ ) [loop] for ( j=0; j<=3; j++ )
	{
		c = TextureColor.Sample(Sampler,coord+float2(i,j)*bof).rgb;
		m[1] += c;
		s[1] += c*c;
	}
	[loop] for ( i=0; i<=3; i++ ) [loop] for ( j=-3; j<=0; j++ )
	{
		c = TextureColor.Sample(Sampler,coord+float2(i,j)*bof).rgb;
		m[2] += c;
		s[2] += c*c;
	}
	[loop] for ( i=0; i<=3; i++ ) [loop] for ( j=0; j<=3; j++ )
	{
		c = TextureColor.Sample(Sampler,coord+float2(i,j)*bof).rgb;
		m[3] += c;
		s[3] += c*c;
	}
	float min_sigma2 = 1e+2, sigma2;
	[unroll] for ( i=0; i<4; i++ )
	{
		m[i] /= n;
		s[i] = abs(s[i]/n-m[i]*m[i]);
		sigma2 = s[i].r+s[i].g+s[i].b;
		if ( sigma2 >= min_sigma2 ) continue;
		min_sigma2 = sigma2;
		res.rgb = m[i];
	}
	return res;
}
/* remove speckles from kuwahara filter */
float4 PS_Median( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !oilenable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = 1.0/bresl;
	float3 m1, m2, m3;
	float3 a, b, c;
	a = TextureColor.Sample(Sampler,coord+float2(-1,-1)*bof).rgb;
	b = TextureColor.Sample(Sampler,coord+float2( 0,-1)*bof).rgb;
	c = TextureColor.Sample(Sampler,coord+float2( 1,-1)*bof).rgb;
	m1 = (luminance(a)<luminance(b))?((luminance(b)<luminance(c))?b
		:max(a,c)):((luminance(a)<luminance(c))?a:max(b,c));
	a = TextureColor.Sample(Sampler,coord+float2(-1, 0)*bof).rgb;
	b = TextureColor.Sample(Sampler,coord+float2( 0, 0)*bof).rgb;
	c = TextureColor.Sample(Sampler,coord+float2( 1, 0)*bof).rgb;
	m2 = (luminance(a)<luminance(b))?((luminance(b)<luminance(c))?b
		:max(a,c)):((luminance(a)<luminance(c))?a:max(b,c));
	a = TextureColor.Sample(Sampler,coord+float2(-1, 1)*bof).rgb;
	b = TextureColor.Sample(Sampler,coord+float2( 0, 1)*bof).rgb;
	c = TextureColor.Sample(Sampler,coord+float2( 1, 1)*bof).rgb;
	m3 = (luminance(a)<luminance(b))?((luminance(b)<luminance(c))?b
		:max(a,c)):((luminance(a)<luminance(c))?a:max(b,c));
	res.rgb = (luminance(m1)<luminance(m2))?((luminance(m2)<luminance(m3))
		?m2:max(m1,m3)):((luminance(m1)<luminance(m3))?m1:max(m2,m3));
	return res;
}

/* Legacy MariENB FXAA, useful for further smoothing the paint filter */
float4 PS_FXAA( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = float2(IN.txcoord.x,IN.txcoord.y);
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !fxaaenable ) return res;
	float fxaareducemul_ = 1.0/max(abs(fxaareducemul),1.0);
	float fxaareducemin_ = 1.0/max(abs(fxaareducemin),1.0);
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y);
	float3 rgbNW = TextureColor.Sample(Sampler,coord+float2(-1,-1)*bof).rgb;
	float3 rgbNE = TextureColor.Sample(Sampler,coord+float2(1,-1)*bof).rgb;
	float3 rgbSW = TextureColor.Sample(Sampler,coord+float2(-1,1)*bof).rgb;
	float3 rgbSE = TextureColor.Sample(Sampler,coord+float2(1,1)*bof).rgb;
	float3 rgbM = TextureColor.Sample(Sampler,coord).rgb;
	float3 luma = float3(0.299,0.587,0.114);
	float lumaNW = dot(rgbNW,luma);
	float lumaNE = dot(rgbNE,luma);
	float lumaSW = dot(rgbSW,luma);
	float lumaSE = dot(rgbSE,luma);
	float lumaM = dot(rgbM,luma);
	float lumaMin = min(lumaM,min(min(lumaNW,lumaNE),min(lumaSW,lumaSE)));
	float lumaMax = max(lumaM,max(max(lumaNW,lumaNE),max(lumaSW,lumaSE)));
	float2 dir = float2(-((lumaNW+lumaNE)-(lumaSW+lumaSE)),((lumaNW+lumaSW)
		-(lumaNE+lumaSE)));
	float dirReduce = max((lumaNW+lumaNE+lumaSW+lumaSE)*(0.25
		*fxaareducemul_),fxaareducemin_);
	float rcpDirMin = 1.0/(min(abs(dir.x),abs(dir.y))+dirReduce);
	dir = min(float2(fxaaspanmax,fxaaspanmax),max(float2(-fxaaspanmax,
		-fxaaspanmax),dir*rcpDirMin))/bresl;
	float3 rgbA = (1.0/2.0)*(TextureColor.Sample(Sampler,coord+dir
		*(1.0/3.0-0.5)).rgb+TextureColor.Sample(Sampler,coord+dir
		*(2.0/3.0-0.5)).rgb);
	float3 rgbB = rgbA*(1.0/2.0)+(1.0/4.0)*(TextureColor.Sample(Sampler,
		coord+dir*(0.0/3.0-0.5)).rgb+TextureColor.Sample(Sampler,coord
		+dir*(3.0/3.0-0.5)).rgb);
	float lumaB = dot(rgbB,luma);
	if ( (lumaB < lumaMin) || (lumaB > lumaMax) ) res.rgb = rgbA;
	else res.rgb = rgbB;
	res.a = 1.0;
	return res;
}

/* Colour matrix */
float3 ColorMatrix( float3 res )
{
	float3x3 cmat = float3x3(cmat_rr,cmat_rg,cmat_rb,
		cmat_gr,cmat_gg,cmat_gb,
		cmat_br,cmat_bg,cmat_bb);
	res = mul(res,cmat);
	if ( cmatnormalize )
	{
		float cmscale = (cmat._11+cmat._12+cmat._13+cmat._21
			+cmat._22+cmat._23+cmat._31+cmat._32+cmat._33)/3.0;
		res /= cmscale;
	}
	return res;
}

/* Hue-Saturation filter from GIMP */
float hs_hue_overlap( float hue_p, float hue_s, float res )
{
	float v = hue_p+hue_s;
	res += (hshue_a+v)/2.0;
	return res%1.0;
}
float hs_hue( float hue, float res )
{
	res += (hshue_a+hue)/2.0;
	return res%1.0;
}
float hs_sat( float sat, float res )
{
	float v = hssat_a+sat;
	res *= v+1.0;
	return clamp(res,0.0,1.0);
}
float hs_val( float val, float res )
{
	float v = (hsval_a+val)/2.0;
	if ( v < 0.0 ) return res*(v+1.0);
	return res+(v*(1.0-res));
}
float3 HueSaturation( float3 res )
{
	float3 hsv = rgb2hsv(res);
	float ch = hsv.x*6.0;
	int ph = 0, sh = 0;
	float pv = 0.0, sv = 0.0;
	bool usesh = false;
	float hues[6] = {hshue_r,hshue_y,hshue_g,hshue_c,hshue_b,hshue_m};
	float sats[6] = {hssat_r,hssat_y,hssat_g,hssat_c,hssat_b,hssat_m};
	float vals[6] = {hsval_r,hsval_y,hsval_g,hsval_c,hsval_b,hsval_m};
	float v;
	[loop] for ( float h=0.0; h<7.0; h+=1.0 )
	{
		float ht = h+0.5;
		if ( ch < ht+hsover )
		{
			ph = floor(h);
			if ( (hsover > 0.0) && (ch > ht-hsover) )
			{
				usesh = true;
				sh = ph+1;
				sv = (ch-ht+hsover)/(2.0*hsover);
				pv = 1.0-sv;
			}
			else usesh = false;
			break;
		}
	}
	if ( ph >= 6 )
	{
		ph = 0;
		usesh = false;
	}
	if ( sh >= 6 ) sh = 0;
	if ( usesh )
	{
		hsv.x = hs_hue_overlap(hues[ph]*pv,hues[sh]*sv,hsv.x);
		hsv.y = hs_sat(sats[ph],hsv.y)*pv+hs_sat(sats[sh],hsv.y)*sv;
		hsv.z = hs_val(vals[ph],hsv.z)*pv+hs_val(vals[sh],hsv.z)*sv;
	}
	else
	{
		hsv.x = hs_hue(hues[ph],hsv.x);
		hsv.y = hs_sat(sats[ph],hsv.y);
		hsv.z = hs_val(vals[ph],hsv.z);
	}
	return hsv2rgb(hsv);
}

/* Colour Balance filter from GIMP */

/* Additional filters that don't fit in enbeffect */
float4 PS_Append( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( cmatenable ) res.rgb = ColorMatrix(res.rgb);
	if ( hsenable ) res.rgb = HueSaturation(res.rgb);
	res.rgb = max(res.rgb,0.0);
	res.a = 1.0;
	return res;
}

/* ultimate super-cinematic immersive black bars */
float4 PS_Cinematic( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res = TextureColor.Sample(Sampler,coord);
	if ( !boxenable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float sar = bresl.x/bresl.y;
	float tar = boxh/boxv;
	float2 box = (sar<tar)?float2(0.0,(bresl.y-(bresl.x/tar))*0.5)
		:float2((bresl.x-(bresl.y*tar))*0.5,0.0);
	box /= bresl;
	/* this is some kind of advanced black magic I can't understand */
	float2 test = saturate((coord*coord-coord)-(box*box-box));
	if ( -test.x != test.y ) res *= 0.0;
	return res;
}

/* begin SMAA integration code */

Texture2D RenderTargetRGBA32;	// for edges
Texture2D RenderTargetRGBA64;	// for blend
Texture2D TextureArea
<
	string ResourceName = "SMAA/AreaTex.dds";
>;
Texture2D TextureSearch
<
	string ResourceName = "SMAA/SearchTex.dds";
>;

#define SMAA_RT_METRICS float4(1.0/ScreenSize.x,1.0/(ScreenSize.x*ScreenSize.w),ScreenSize.x,ScreenSize.x*ScreenSize.w)
#define SMAA_HLSL_4_1

#include "SMAA/SMAA.fxh"

DepthStencilState DisableDepthReplaceStencil
{
	DepthEnable = FALSE;
	StencilEnable = TRUE;
	FrontFaceStencilPass = REPLACE;
};
DepthStencilState DisableDepthUseStencil
{
	DepthEnable = FALSE;
	StencilEnable = TRUE;
	FrontFaceStencilFunc = EQUAL;
};
BlendState NoBlending
{
	AlphaToCoverageEnable = FALSE;
	BlendEnable[0] = FALSE;
};

VS_OUTPUT_POST SMAAEdgeDetectionWrapVS( VS_INPUT_POST IN,
	out float4 offset[3] : TEXCOORD1 )
{
	VS_OUTPUT_POST OUT = VS_PostProcess(IN);
	if ( smaaenable ) SMAAEdgeDetectionVS(IN.txcoord.xy,offset);
	return OUT;
}
VS_OUTPUT_POST SMAABlendingWeightCalculationWrapVS( VS_INPUT_POST IN,
	out float2 pixcoord : TEXCOORD1, out float4 offset[3] : TEXCOORD2 )
{
	VS_OUTPUT_POST OUT = VS_PostProcess(IN);
	if ( smaaenable )
		SMAABlendingWeightCalculationVS(IN.txcoord.xy,pixcoord,offset);
	return OUT;
}
VS_OUTPUT_POST SMAANeighborhoodBlendingWrapVS( VS_INPUT_POST IN,
	out float4 offset : TEXCOORD1 )
{
	VS_OUTPUT_POST OUT = VS_PostProcess(IN);
	if ( smaaenable ) SMAANeighborhoodBlendingVS(IN.txcoord.xy,offset);
	return OUT;
}

float4 SMAAEdgeDetectionWrapPS( VS_OUTPUT_POST IN,
	float4 offset[3] : TEXCOORD1 ) : SV_Target
{
	if ( !smaaenable ) return float4(0.0,0.0,0.0,1.0);
	float2 coord = IN.txcoord.xy;
	float2 edges;
	//edges = SMAADepthEdgeDetectionPS(coord,offset,TextureDepth);
	//edges = SMAALumaEdgeDetectionPS(coord,offset,TextureColor);
	edges = SMAAColorEdgeDetectionPS(coord,offset,TextureColor);
	return float4(edges,0.0,1.0);
}
float4 SMAABlendingWeightCalculationWrapPS( VS_OUTPUT_POST IN,
	float2 pixcoord : TEXCOORD1, float4 offset[3] : TEXCOORD2 ) : SV_Target
{
	if ( !smaaenable ) return float4(0.0,0.0,0.0,1.0);
	return SMAABlendingWeightCalculationPS(IN.txcoord.xy,pixcoord,offset,
		RenderTargetRGBA32,TextureArea,TextureSearch,0.0);
}
float4 SMAANeighborhoodBlendingWrapPS( VS_OUTPUT_POST IN,
	float4 offset : TEXCOORD1 ) : SV_Target
{
	float2 coord = IN.txcoord.xy;
	float4 res;
	if ( !smaaenable ) res = TextureColor.Sample(Sampler,coord);
	else res = SMAANeighborhoodBlendingPS(coord,offset,TextureColor,
		RenderTargetRGBA64);
	float3 RGB = res.rgb*(res.rgb*(res.rgb*0.305306011+0.682171111)
		+0.012522878);
	res.rgb = RGB;
	res.a = 1.0;
	if ( smaadebug == 1 ) return RenderTargetRGBA32.Sample(Sampler,coord);
	if ( smaadebug == 2 ) return RenderTargetRGBA64.Sample(Sampler,coord);
	return res;
}
float4 PS_ToSRGB( VS_OUTPUT_POST IN ) : SV_Target
{
	float4 res = TextureColor.Sample(Sampler,IN.txcoord.xy);
	float3 S1 = sqrt(res.rgb);
	float3 S2 = sqrt(S1);
	float3 S3 = sqrt(S2);
	float3 sRGB = 0.662002687*S1+0.684122060*S2-0.323583601*S3
		-0.0225411470*res.rgb;
	res.rgb = sRGB;
	return res;
}

/* end SMAA integration code */

technique11 ExtraFilters <string UIName="MariENB";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_Append()));
	}
}
technique11 ExtraFilters1
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_Kuwahara()));
	}
}
technique11 ExtraFilters2
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_Median()));
	}
}
technique11 ExtraFilters3 <string RenderTarget="RenderTargetRGBA32";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,SMAAEdgeDetectionWrapVS()));
		SetPixelShader(CompileShader(ps_5_0,SMAAEdgeDetectionWrapPS()));
		SetDepthStencilState(DisableDepthReplaceStencil,1);
		SetBlendState(NoBlending,float4(0.0,0.0,0.0,0.0),0xFFFFFFFF);
	}
}
technique11 ExtraFilters4 <string RenderTarget="RenderTargetRGBA64";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,SMAABlendingWeightCalculationWrapVS()));
		SetPixelShader(CompileShader(ps_5_0,SMAABlendingWeightCalculationWrapPS()));
		SetDepthStencilState(DisableDepthUseStencil,1);
		SetBlendState(NoBlending, float4(0.0,0.0,0.0,0.0),0xFFFFFFFF);
	}
}
technique11 ExtraFilters5
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_ToSRGB()));
	}
}
technique11 ExtraFilters6
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,SMAANeighborhoodBlendingWrapVS()));
		SetPixelShader(CompileShader(ps_5_0,SMAANeighborhoodBlendingWrapPS()));
	}
}
technique11 ExtraFilters7
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_FXAA()));
	}
}
technique11 ExtraFilters8
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_LumaSharp()));
	}
}
technique11 ExtraFilters9
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_Blur()));
	}
}
technique11 ExtraFilters10
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_Sharp()));
	}
}
technique11 ExtraFilters11
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_Shift()));
	}
}
technique11 ExtraFilters12
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_ChromaKey()));
	}
}
technique11 ExtraFilters13
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_Vignette()));
	}
}
technique11 ExtraFilters14
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_Curvature()));
	}
}
technique11 ExtraFilters15
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_PostProcess()));
		SetPixelShader(CompileShader(ps_5_0,PS_Cinematic()));
	}
}
