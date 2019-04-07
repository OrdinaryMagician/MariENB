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

#ifndef HQBLOOM
/* gaussian blur matrices */
/* radius: 4, std dev: 1.5 */
static const float gauss4[4] =
{
	0.270682, 0.216745, 0.111281, 0.036633
};
#define hvgauss gauss4
#define hvgausssz 3
#else
/* radius: 8, std dev: 3 */
static const float gauss8[8] =
{
	0.134598, 0.127325, 0.107778, 0.081638,
	0.055335, 0.033562, 0.018216, 0.008847
};
#define hvgauss gauss8
#define hvgausssz 7
#endif
#ifndef HQBLOOM
/* radius: 20, std dev: 7.5 */
static const float gauss20[20] =
{
	0.053690, 0.053215, 0.051815, 0.049562,
	0.046572, 0.042992, 0.038987, 0.034732,
	0.030397, 0.026134, 0.022073, 0.018314,
	0.014928, 0.011953, 0.009403, 0.007266,
	0.005516, 0.004114, 0.003014, 0.002169
};
#define angauss gauss20
#define angausssz 19
#else
/* radius: 40, std dev: 15 */
static const float gauss40[40] =
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
};
#define angauss gauss40
#define angausssz 39
#endif
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
Texture2D RenderTarget16;

SamplerState Sampler
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Border;
	AddressV = Border;
	MaxLOD = 0;
};
SamplerState Sampler2
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
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

/* progressive downsizing of textures, with interpolation. */
float4 PS_Downsize( VS_OUTPUT_POST IN, float4 v0 : SV_Position0,
	uniform Texture2D intex, uniform float insz ) : SV_Target
{
	float2 coord = IN.txcoord0.xy;
	float2 ssz;
	if ( insz <= 0.0 ) return intex.Sample(Sampler2,coord);
	ssz = float2(1.0/insz,1.0/insz)*0.5;
	float4 res = 0.25*(intex.Sample(Sampler2,coord+float2(-ssz.x,-ssz.y))
		+intex.Sample(Sampler2,coord+float2(ssz.x,-ssz.y))
		+intex.Sample(Sampler2,coord+float2(-ssz.x,ssz.y))
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
		base = RenderTarget1024.Sample(Sampler,coord);
	int i;
	float sum = 0.0;
	float inc = flen/insz;
	float2 pp;
	[unroll] for ( i=-angausssz; i<=angausssz; i++ )
	{
		pp = coord+float2(i,0)*inc;
		res += angauss[abs(i)]*intex.Sample(Sampler,pp);
		sum += ((pp.x>=0.0)&&(pp.x<1.0))?angauss[abs(i)]:0.0;
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
	float inc = bloomradiusx/insz;
	float2 pp;
	[unroll] for ( i=-hvgausssz; i<=hvgausssz; i++ )
	{
		pp = coord+float2(i,0)*inc;
		res += hvgauss[abs(i)]*intex.Sample(Sampler,pp);
		sum += ((pp.x>=0.0)&&(pp.x<1.0))?hvgauss[abs(i)]:0.0;
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
		base = RenderTarget1024.Sample(Sampler,coord);
	int i;
	float sum = 0.0;
	float inc = bloomradiusy/insz;
	float2 pp;
	[unroll] for ( i=-hvgausssz; i<=hvgausssz; i++ )
	{
		pp = coord+float2(0,i)*inc;
		res += hvgauss[abs(i)]*intex.Sample(Sampler,pp);
		sum += ((pp.y>=0.0)&&(pp.y<1.0))?hvgauss[abs(i)]:0.0;
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
	float4 res = bloommix1*RenderTarget512.Sample(Sampler2,coord);
	res += bloommix2*RenderTarget256.Sample(Sampler2,coord);
	res += bloommix3*RenderTarget128.Sample(Sampler2,coord);
	res += bloommix4*RenderTarget64.Sample(Sampler2,coord);
	res += bloommix5*RenderTarget32.Sample(Sampler2,coord);
	res += bloommix6*RenderTarget16.Sample(Sampler2,coord);
	res.rgb /= 6.0;
	res.rgb = clamp(res.rgb,0.0,32768.0);
	res.a = 1.0;
	return res;
}

float4 PS_SPostPass( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord0.xy;
	float4 res = bloommixs*RenderTarget64.Sample(Sampler2,coord);
	res.rgb = clamp(res.rgb,0.0,32768.0);
	res.a = 1.0;
	return res;
}

technique11 BloomSimplePass <string UIName="MariENB Simple Bloom"; string RenderTarget="RenderTarget1024";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_PrePass()));
	}
}
technique11 BloomSimplePass1 <string RenderTarget="RenderTarget512";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget1024,1024.0)));
	}
}
technique11 BloomSimplePass2 <string RenderTarget="RenderTarget256";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget512,512.0)));
	}
}
technique11 BloomSimplePass3 <string RenderTarget="RenderTarget128";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget256,256.0)));
	}
}
technique11 BloomSimplePass4 <string RenderTarget="RenderTarget64";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget128,128.0)));
	}
}
technique11 BloomSimplePass5
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_HorizontalBlur(RenderTarget64,64.0)));
	}
}
technique11 BloomSimplePass6 <string RenderTarget="RenderTarget64";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_VerticalBlur(TextureColor,64.0,3.0)));
	}
}
technique11 BloomSimplePass7
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_SPostPass()));
	}
}

technique11 BloomPass <string UIName="MariENB Multi Bloom"; string RenderTarget="RenderTarget1024";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_PrePass()));
	}
}
technique11 BloomPass1 <string RenderTarget="RenderTarget512";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget1024,1024.0)));
	}
}
technique11 BloomPass2 <string RenderTarget="RenderTarget256";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget512,512.0)));
	}
}
technique11 BloomPass3 <string RenderTarget="RenderTarget128";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget256,256.0)));
	}
}
technique11 BloomPass4 <string RenderTarget="RenderTarget64";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget128,128.0)));
	}
}
technique11 BloomPass5 <string RenderTarget="RenderTarget32";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget64,64.0)));
	}
}
technique11 BloomPass6 <string RenderTarget="RenderTarget16";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsize(RenderTarget32,32.0)));
	}
}
technique11 BloomPass7
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_HorizontalBlur(RenderTarget512,512.0)));
	}
}
technique11 BloomPass8 <string RenderTarget="RenderTarget512";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_VerticalBlur(TextureColor,512.0,0.0)));
	}
}
technique11 BloomPass9
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_HorizontalBlur(RenderTarget256,256.0)));
	}
}
technique11 BloomPass10 <string RenderTarget="RenderTarget256";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_VerticalBlur(TextureColor,256.0,1.0)));
	}
}
technique11 BloomPass11
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_HorizontalBlur(RenderTarget128,128.0)));
	}
}
technique11 BloomPass12 <string RenderTarget="RenderTarget128";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_VerticalBlur(TextureColor,128.0,2.0)));
	}
}
technique11 BloomPass13
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_HorizontalBlur(RenderTarget64,64.0)));
	}
}
technique11 BloomPass14 <string RenderTarget="RenderTarget64";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_VerticalBlur(TextureColor,64.0,3.0)));
	}
}
technique11 BloomPass15
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_HorizontalBlur(RenderTarget32,32.0)));
	}
}
technique11 BloomPass16 <string RenderTarget="RenderTarget32";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_VerticalBlur(TextureColor,32.0,4.0)));
	}
}
technique11 BloomPass17
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_HorizontalBlur(RenderTarget16,16.0)));
	}
}
technique11 BloomPass18 <string RenderTarget="RenderTarget16";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_VerticalBlur(TextureColor,16.0,5.0)));
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
