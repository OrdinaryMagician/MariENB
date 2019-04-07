/*
	enbbloom.fx : MariENB3 bloom shader.
	(C)2016-2017 Marisa Kirisame, UnSX Team.
	Part of MariENB3, the personal ENB of Marisa for Fallout 4.
	Released under the GNU GPLv3 (or later).
*/
#include "menbglobaldefs.fx"

string str_bloompre = "Bloom Prepass";
/* bloom intensity */
float bloomintensity_n
<
	string UIName = "Bloom Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloomintensity_d
<
	string UIName = "Bloom Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloomintensity_i
<
	string UIName = "Bloom Intensity Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* bloom power (contrast) */
float bloompower_n
<
	string UIName = "Bloom Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloompower_d
<
	string UIName = "Bloom Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloompower_i
<
	string UIName = "Bloom Contrast Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
/* bloom saturation */
float bloomsaturation_n
<
	string UIName = "Bloom Saturation Night";
	string UIWidget = "Spinner";
> = {0.75};
float bloomsaturation_d
<
	string UIName = "Bloom Saturation Day";
	string UIWidget = "Spinner";
> = {0.75};
float bloomsaturation_i
<
	string UIName = "Bloom Saturation Interior";
	string UIWidget = "Spinner";
> = {0.75};
/* bloom offset (negative values keep dark areas from muddying up) */
float bloombump_n
<
	string UIName = "Bloom Offset Night";
	string UIWidget = "Spinner";
> = {-0.5};
float bloombump_d
<
	string UIName = "Bloom Offset Day";
	string UIWidget = "Spinner";
> = {-0.5};
float bloombump_i
<
	string UIName = "Bloom Offset Interior";
	string UIWidget = "Spinner";
> = {-0.5};
/* bloom cap (maximum brightness samples can have) */
float bloomcap_n
<
	string UIName = "Bloom Intensity Cap Night";
	string UIWidget = "Spinner";
> = {20.0};
float bloomcap_d
<
	string UIName = "Bloom Intensity Cap Day";
	string UIWidget = "Spinner";
> = {20.0};
float bloomcap_i
<
	string UIName = "Bloom Intensity Cap Interior";
	string UIWidget = "Spinner";
> = {20.0};
string str_bloomper = "Bloom Per-pass";
/* bloom blur radius */
float bloomradiusx
<
	string UIName = "Bloom Blur Radius X";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloomradiusy
<
	string UIName = "Bloom Blur Radius Y";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float bloomtheta
<
	string UIName = "Bloom Angle";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = {0.0};
/* bloom tint/blueshift parameters */
float3 blu_n
<
	string UIName = "Blue Shift Night";
	string UIWidget = "Color";
> = {0.2,0.6,1.0};
float3 blu_d
<
	string UIName = "Blue Shift Day";
	string UIWidget = "Color";
> = {0.2,0.6,1.0};
float3 blu_i
<
	string UIName = "Blue Shift Interior";
	string UIWidget = "Color";
> = {0.2,0.6,1.0};
float bsi_n
<
	string UIName = "Blue Shift Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float bsi_d
<
	string UIName = "Blue Shift Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float bsi_i
<
	string UIName = "Blue Shift Intensity Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.5};
float bslp
<
	string UIName = "Blue Shift Luminance Factor Per-pass";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.22};
float bsbp
<
	string UIName = "Blue Shift Color Factor Per-pass";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.33};
/* anamorphic bloom (very intensive) */
string str_bloomalf = "Anamorphic Bloom";
bool alfenable
<
	string UIName = "Enable Anamorphic Bloom";
	string UIWidget = "Checkbox";
> = {true};
float fbl_n
<
	string UIName = "Anamorphic Bloom Blend Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.75};
float fbl_d
<
	string UIName = "Anamorphic Bloom Blend Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.75};
float fbl_i
<
	string UIName = "Anamorphic Bloom Blend Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {0.75};
float3 flu_n
<
	string UIName = "Anamorphic Bloom Blue Shift Night";
	string UIWidget = "Color";
> = {0.4,0.1,1.0};
float3 flu_d
<
	string UIName = "Anamorphic Bloom Blue Shift Day";
	string UIWidget = "Color";
> = {0.4,0.1,1.0};
float3 flu_i
<
	string UIName = "Anamorphic Bloom Blue Shift Interior";
	string UIWidget = "Color";
> = {0.4,0.1,1.0};
float fsi_n
<
	string UIName = "Anamorphic Bloom Blue Shift Intensity Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fsi_d
<
	string UIName = "Anamorphic Bloom Blue Shift Intensity Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fsi_i
<
	string UIName = "Anamorphic Bloom Blue Shift Intensity Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fpw_n
<
	string UIName = "Anamorphic Bloom Contrast Night";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fpw_d
<
	string UIName = "Anamorphic Bloom Contrast Day";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float fpw_i
<
	string UIName = "Anamorphic Bloom Contrast Interior";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {1.0};
float flen
<
	string UIName = "Anamorphic Bloom Radius Multiplier";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
> = {4.0};
string str_bloompost = "Bloom Post-pass";
/* bloom mix factors */
float bloommix1
<
	string UIName = "Bloom Pass 1 Blend";
	string UIWidget = "Spinner";
> = {0.75};
float bloommix2
<
	string UIName = "Bloom Pass 2 Blend";
	string UIWidget = "Spinner";
> = {0.8};
float bloommix3
<
	string UIName = "Bloom Pass 3 Blend";
	string UIWidget = "Spinner";
> = {0.85};
float bloommix4
<
	string UIName = "Bloom Pass 4 Blend";
	string UIWidget = "Spinner";
> = {0.9};
float bloommix5
<
	string UIName = "Bloom Pass 5 Blend";
	string UIWidget = "Spinner";
> = {0.95};
float bloommix6
<
	string UIName = "Bloom Pass 6 Blend";
	string UIWidget = "Spinner";
> = {1.0};
float bloommixs
<
	string UIName = "Bloom Single Pass Blend";
	string UIWidget = "Spinner";
> = {1.0};
string str_bloomdirt = "Lens Dirt";
bool dirtenable
<
	string UIName = "Enable Lens Dirt";
	string UIWidget = "Checkbox";
> = {false};
float dirtmix1
<
	string UIName = "Dirt Pass 1 Blend";
	string UIWidget = "Spinner";
> = {0.0};
float dirtmix2
<
	string UIName = "Dirt Pass 2 Blend";
	string UIWidget = "Spinner";
> = {0.1};
float dirtmix3
<
	string UIName = "Dirt Pass 3 Blend";
	string UIWidget = "Spinner";
> = {1.2};
float dirtmix4
<
	string UIName = "Dirt Pass 4 Blend";
	string UIWidget = "Spinner";
> = {0.5};
float dirtmix5
<
	string UIName = "Dirt Pass 5 Blend";
	string UIWidget = "Spinner";
> = {0.25};
float dirtmix6
<
	string UIName = "Dirt Pass 6 Blend";
	string UIWidget = "Spinner";
> = {0.1};
float dirtmixs
<
	string UIName = "Dirt Single Pass Blend";
	string UIWidget = "Spinner";
> = {1.0};
float dirtsaturation
<
	string UIName = "Dirt Saturation";
	string UIWidget = "Spinner";
> = {1.0};
float ldirtpow
<
	string UIName = "Dirt Texture Contrast";
	string UIWidget = "Spinner";
> = {1.25};
float dirtpow
<
	string UIName = "Dirt Contrast";
	string UIWidget = "Spinner";
> = {1.25};
float ldirtfactor
<
	string UIName = "Dirt Factor";
	string UIWidget = "Spinner";
> = {1.5};


/* gaussian blur matrices */
/* radius: 4, std dev: 1.5 */
/*static const float gauss4[4] =
{
	0.270682, 0.216745, 0.111281, 0.036633
};*/
/* radius: 8, std dev: 3 */
static const float gauss8[8] =
{
	0.134598, 0.127325, 0.107778, 0.081638,
	0.055335, 0.033562, 0.018216, 0.008847
};
/* radius: 40, std dev: 15 */
/*static const float gauss40[40] =
{
	0.026823, 0.026763, 0.026585, 0.026291,
	0.025886, 0.025373, 0.024760, 0.024055,
	0.023267, 0.022404, 0.021478, 0.020499,
	0.019477, 0.018425, 0.017352, 0.016269,
	0.015186, 0.014112, 0.013056, 0.012025,
	0.011027, 0.010067, 0.009149, 0.008279,
	0.007458, 0.006688, 0.005972, 0.005308,
	0.004697, 0.004139, 0.003630, 0.003170,
	0.002756, 0.002385, 0.002055, 0.001763,
	0.001506, 0.001280, 0.001084, 0.000913
};*/
/* radius: 80, std dev: 30 */
static const float gauss80[80] =
{
	0.013406, 0.013398, 0.013376, 0.013339, 0.013287, 0.013221,
	0.013140, 0.013046, 0.012938, 0.012816, 0.012681, 0.012534,
	0.012375, 0.012205, 0.012023, 0.011831, 0.011629, 0.011417,
	0.011198, 0.010970, 0.010735, 0.010493, 0.010245, 0.009992,
	0.009735, 0.009473, 0.009209, 0.008941, 0.008672, 0.008402,
	0.008131, 0.007860, 0.007590, 0.007321, 0.007053, 0.006788,
	0.006525, 0.006266, 0.006010, 0.005759, 0.005511, 0.005269,
	0.005031, 0.004799, 0.004573, 0.004352, 0.004138, 0.003929,
	0.003727, 0.003532, 0.003343, 0.003160, 0.002985, 0.002816,
	0.002653, 0.002497, 0.002348, 0.002205, 0.002068, 0.001938,
	0.001814, 0.001696, 0.001584, 0.001478, 0.001377, 0.001282,
	0.001192, 0.001107, 0.001027, 0.000952, 0.000881, 0.000815,
	0.000753, 0.000694, 0.000640, 0.000589, 0.000542, 0.000497,
	0.000456, 0.000418
};
/* mathematical constants */
static const float pi = 3.1415926535898;

float4 ScreenSize;
float ENightDayFactor;
float EInteriorFactor;
float4 TimeOfDay1;
float4 TimeOfDay2;

Texture2D TextureDownsampled;
Texture2D TextureColor;

Texture2D RenderTarget1024;
Texture2D RenderTarget512;
Texture2D RenderTarget256;
Texture2D RenderTarget128;
Texture2D RenderTarget64;
Texture2D RenderTarget32;
Texture2D RenderTargetRGBA64F;

Texture2D TextureLens
<
#ifdef LENSDIRT_DDS
	string ResourceName = "menblens.dds";
#else
	string ResourceName = "menblens.png";
#endif
>;

SamplerState Sampler
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Border;
	AddressV = Border;
};
SamplerState Sampler2
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
};

SamplerState SamplerLens
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Mirror;
	AddressV = Mirror;
};

struct VS_INPUT_POST
{
	float3 pos : POSITION;
	float2 txcoord : TEXCOORD0;
};
struct VS_OUTPUT_POST
{
	float4 pos : SV_POSITION;
	float2 txcoord0 : TEXCOORD0;
};

VS_OUTPUT_POST VS_Quad(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;
	OUT.pos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord0.xy = IN.txcoord.xy;
	return OUT;
}

/* helper functions */
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

/* pre-pass bloom texture preparation */
float4 PS_PrePass( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord0.xy;
	float bloomcap = tod_ind(bloomcap);
	float bloombump = tod_ind(bloombump);
	float bloompower = tod_ind(bloompower);
	float bloomsaturation = tod_ind(bloomsaturation);
	float bloomintensity = tod_ind(bloomintensity);
	float4 res = TextureDownsampled.Sample(Sampler2,coord);
	float3 hsv = rgb2hsv(res.rgb);
	hsv.z = min(hsv.z,bloomcap);
	res.rgb = hsv2rgb(hsv);
	res = max(res+bloombump,0.0);
	hsv = rgb2hsv(res.rgb);
	hsv.y = clamp(hsv.y*bloomsaturation,0.0,1.0);
	hsv.z = pow(hsv.z,bloompower);
	res.rgb = hsv2rgb(hsv)*bloomintensity;
	res.a = 1.0;
	return res;
}

/*
   progressive downsizing of textures, with interpolation.
   
   First downsample is unnecessary because both textures are the same size.
*/
float4 PS_Downsize( VS_OUTPUT_POST IN, float4 v0 : SV_Position0,
	uniform Texture2D intex, uniform float insz ) : SV_Target
{
	float2 coord = IN.txcoord0.xy;
	float2 ssz;
	if ( insz <= 0.0 ) return intex.Sample(Sampler2,coord);
	ssz = float2(1.0/insz,1.0/insz);
	float4 res = 0.25*(intex.Sample(Sampler2,coord)
		+intex.Sample(Sampler2,coord+float2(ssz.x,0.0))
		+intex.Sample(Sampler2,coord+float2(0.0,ssz.y))
		+intex.Sample(Sampler2,coord+float2(ssz.x,ssz.y)));
	return res;
}

/*
   Anamorphic bloom step. Secondary bloom stretched along an axis.

   I've seen that some ENBs do something almost-maybe-possibly-slightly-similar
   they call "anamorphic lens flare", which has an ass-backwards-retarded
   implementation, which serves to showcase their incompetence. Rather than use
   a single-axis massive-scale blur like I do, they simply awkwardly stretch
   sampling coordinates along one axis, which doesn't even have the same effect
   as it just makes it so bright areas ONLY at the very middle of the screen
   produces sharp bright lines extending towards the sides.
*/
float4 Anamorphic( float2 coord, Texture2D intex, float insz )
{
	float4 res = float4(0.0,0.0,0.0,0.0),
		base = RenderTargetRGBA64F.Sample(Sampler,coord);
	int i;
	float sum = 0.0;
	float2 pp;
	float2 dir = float2(cos(bloomtheta*2*pi),sin(bloomtheta*2*pi))
		*flen/insz;
	[unroll] for ( i=-79; i<=79; i++ )
	{
		pp = coord+dir*i;
		res += gauss80[abs(i)]*intex.Sample(Sampler,pp);
		sum += ((pp.x>=0.0)&&(pp.x<1.0))?gauss80[abs(i)]:0.0;
	}
	res *= 1.0/sum;
	float3 flu = tod_ind(flu);
	float fsi = tod_ind(fsi);
	float lm = max(0,luminance(res.rgb)-luminance(base.rgb))*fsi;
	lm = lm/(1.0+lm);
	res.rgb *= lerp(1.0,flu,lm);
	float fbl = tod_ind(fbl);
	float fpw = tod_ind(fpw);
	res.rgb = pow(max(0,res.rgb),fpw)*fbl;
	return res;
}

/* blur step goes here */
float4 PS_HorizontalBlur( VS_OUTPUT_POST IN, float4 v0 : SV_Position0,
	uniform Texture2D intex, uniform float insz ) : SV_Target
{
	float2 coord = IN.txcoord0.xy;
	float4 res = float4(0.0,0.0,0.0,0.0);
	int i;
	float sum = 0.0;
	float2 pp;
	float2 dir = float2(cos(bloomtheta*2*pi),sin(bloomtheta*2*pi))
		*bloomradiusx/insz;
	[unroll] for ( i=-7; i<=7; i++ )
	{
		pp = coord+dir*i;
		res += gauss8[abs(i)]*intex.Sample(Sampler,pp);
		sum += ((pp.x>=0.0)&&(pp.x<1.0))?gauss8[abs(i)]:0.0;
	}
	res *= 1.0/sum;
	if ( alfenable ) res += Anamorphic(coord,intex,insz);
	res.a = 1.0;
	return res;
}

/* This is the vertical step */
float4 PS_VerticalBlur( VS_OUTPUT_POST IN, float4 v0 : SV_Position0,
	uniform Texture2D intex, uniform float insz,
	uniform float bpass ) : SV_Target
{

	float2 coord = IN.txcoord0.xy;
	float4 res = float4(0.0,0.0,0.0,0.0),
		base = RenderTargetRGBA64F.Sample(Sampler,coord);
	int i;
	float sum = 0.0;
	float2 pp;
	float2 dir = float2(sin(bloomtheta*2*pi),-cos(bloomtheta*2*pi))
		*bloomradiusy/insz;
	[unroll] for ( i=-7; i<=7; i++ )
	{
		pp = coord+dir*i;
		res += gauss8[abs(i)]*intex.Sample(Sampler,pp);
		sum += ((pp.y>=0.0)&&(pp.y<1.0))?gauss8[abs(i)]:0.0;
	}
	res *= 1.0/sum;
	float3 blu = tod_ind(blu);
	float bsi = tod_ind(bsi);
	float lm = max(0,luminance(res.rgb)-luminance(base.rgb))*bsi;
	lm = lm/(1.0+lm);
	lm *= 1.0-saturate(bpass*bslp);
	blu = saturate(blu+bpass*bsbp);
	res.rgb *= lerp(1.0,blu,lm);
	res.a = 1.0;
	return res;
}

/* end pass, mix it all up */
float4 PS_PostPass( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord0.xy;
	float4 res = bloommix1*RenderTarget1024.Sample(Sampler2,coord);
	res += bloommix2*RenderTarget512.Sample(Sampler2,coord);
	res += bloommix3*RenderTarget256.Sample(Sampler2,coord);
	res += bloommix4*RenderTarget128.Sample(Sampler2,coord);
	res += bloommix5*RenderTarget64.Sample(Sampler2,coord);
	res += bloommix6*RenderTarget32.Sample(Sampler2,coord);
	res.rgb /= 6.0;
	res.rgb = clamp(res.rgb,0.0,32768.0);
	res.a = 1.0;
	if ( !dirtenable ) return res;
	/* crappy lens filter, useful when playing characters with glasses */
	float2 ccoord = coord;
#ifdef ASPECT_LENSDIRT
	ccoord.y = (coord.y-0.5)*ScreenSize.w+0.5;
#endif
	float4 crap = TextureLens.Sample(SamplerLens,ccoord);
	float4 mud = dirtmix1*RenderTarget1024.Sample(Sampler2,coord);
	mud += dirtmix2*RenderTarget512.Sample(Sampler2,coord);
	mud += dirtmix3*RenderTarget256.Sample(Sampler2,coord);
	mud += dirtmix4*RenderTarget128.Sample(Sampler2,coord);
	mud += dirtmix5*RenderTarget64.Sample(Sampler2,coord);
	mud += dirtmix6*RenderTarget32.Sample(Sampler2,coord);
	mud.rgb /= 6.0;
	float3 hsv = rgb2hsv(mud.rgb);
	hsv.y = clamp(hsv.y*dirtsaturation,0.0,1.0);
	mud.rgb = clamp(hsv2rgb(hsv),0.0,32768.0);
	mud.rgb = pow(mud.rgb,dirtpow);
	float mudmax = luminance(mud.rgb);
	float mudn = max(mudmax/(1.0+mudmax),0.0);
	mudn = pow(mudn,max(ldirtpow-crap.a,0.0));
	mud.rgb *= mudn*ldirtfactor*crap.rgb;
	res += max(mud,0.0);
	res.a = 1.0;
	return res;
}

float4 PS_SPostPass( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord0.xy;
	float4 res = bloommixs*RenderTarget128.Sample(Sampler2,coord);
	res.rgb = clamp(res.rgb,0.0,32768.0);
	res.a = 1.0;
	if ( !dirtenable ) return res;
	/* crappy lens filter, useful when playing characters with glasses */
	float2 ccoord = coord;
#ifdef ASPECT_LENSDIRT
	ccoord.y = (coord.y-0.5)*ScreenSize.w+0.5;
#endif
	float4 crap = TextureLens.Sample(SamplerLens,ccoord);
	float4 mud = dirtmixs*RenderTarget32.Sample(Sampler2,coord);
	mud.rgb = pow(mud.rgb,dirtpow);
	float3 hsv = rgb2hsv(mud.rgb);
	hsv.y = clamp(hsv.y*dirtsaturation,0.0,1.0);
	mud.rgb = clamp(hsv2rgb(hsv),0.0,32768.0);
	float mudmax = luminance(mud.rgb);
	float mudn = max(mudmax/(1.0+mudmax),0.0);
	mudn = pow(mudn,max(ldirtpow-crap.a,0.0));
	mud.rgb *= mudn*ldirtfactor*crap.rgb;
	res += max(mud,0.0);
	res.a = 1.0;
	return res;
}

technique11 BloomSimplePass <string UIName="MariENB Simple Bloom"; string RenderTarget="RenderTargetRGBA64F";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_PrePass()));
	}
}

technique11 BloomSimplePass1 <string RenderTarget="RenderTarget1024";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTargetRGBA64F,0.0)));
	}
}
technique11 BloomSimplePass2 <string RenderTarget="RenderTarget512";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget1024,1024.0)));
	}
}
technique11 BloomSimplePass3 <string RenderTarget="RenderTarget256";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget512,512.0)));
	}
}
technique11 BloomSimplePass4 <string RenderTarget="RenderTarget128";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget256,256.0)));
	}
}
technique11 BloomSimplePass5 <string RenderTarget="RenderTarget64";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget128,128.0)));
	}
}
technique11 BloomSimplePass6 <string RenderTarget="RenderTarget32";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget64,64.0)));
	}
}

technique11 BloomSimplePass7
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_HorizontalBlur(RenderTarget128,128.0)));
	}
}
technique11 BloomSimplePass8 <string RenderTarget="RenderTarget128";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_VerticalBlur(TextureColor,128.0,3.0)));
	}
}

technique11 BloomSimplePass9
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_HorizontalBlur(RenderTarget32,32.0)));
	}
}
technique11 BloomSimplePass10 <string RenderTarget="RenderTarget32";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_VerticalBlur(TextureColor,32.0,5.0)));
	}
}

technique11 BloomSimplePass11
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_SPostPass()));
	}
}

technique11 BloomPass <string UIName="MariENB Multi Bloom"; string RenderTarget="RenderTargetRGBA64F";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_PrePass()));
	}
}

technique11 BloomPass1 <string RenderTarget="RenderTarget1024";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTargetRGBA64F,0.0)));
	}
}
technique11 BloomPass2 <string RenderTarget="RenderTarget512";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget1024,1024.0)));
	}
}
technique11 BloomPass3 <string RenderTarget="RenderTarget256";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget512,512.0)));
	}
}
technique11 BloomPass4 <string RenderTarget="RenderTarget128";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget256,256.0)));
	}
}
technique11 BloomPass5 <string RenderTarget="RenderTarget64";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget128,128.0)));
	}
}
technique11 BloomPass6 <string RenderTarget="RenderTarget32";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget64,64.0)));
	}
}

technique11 BloomPass7
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_HorizontalBlur(RenderTarget1024,1024.0)));
	}
}
technique11 BloomPass8 <string RenderTarget="RenderTarget1024";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_VerticalBlur(TextureColor,1024.0,0.0)));
	}
}

technique11 BloomPass9
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_HorizontalBlur(RenderTarget512,512.0)));
	}
}
technique11 BloomPass10 <string RenderTarget="RenderTarget512";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_VerticalBlur(TextureColor,512.0,1.0)));
	}
}

technique11 BloomPass11
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_HorizontalBlur(RenderTarget256,256.0)));
	}
}
technique11 BloomPass12 <string RenderTarget="RenderTarget256";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_VerticalBlur(TextureColor,256.0,2.0)));
	}
}

technique11 BloomPass13
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_HorizontalBlur(RenderTarget128,128.0)));
	}
}
technique11 BloomPass14 <string RenderTarget="RenderTarget128";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_VerticalBlur(TextureColor,128.0,3.0)));
	}
}

technique11 BloomPass15
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_HorizontalBlur(RenderTarget64,64.0)));
	}
}
technique11 BloomPass16 <string RenderTarget="RenderTarget64";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_VerticalBlur(TextureColor,64.0,4.0)));
	}
}

technique11 BloomPass17
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_HorizontalBlur(RenderTarget32,32.0)));
	}
}
technique11 BloomPass18 <string RenderTarget="RenderTarget32";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_VerticalBlur(TextureColor,32.0,5.0)));
	}
}

technique11 BloomPass19
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_PostPass()));
	}
}
