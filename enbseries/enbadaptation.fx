/*
	enbadaptation.fx : MariENB3 eye adaptation shader.
	(C)2016-2017 Marisa Kirisame, UnSX Team.
	Part of MariENB3, the personal ENB of Marisa for Fallout 4.
	Released under the GNU GPLv3 (or later).
*/
#include "menbglobaldefs.fx"

float4 AdaptationParameters;

Texture2D TextureCurrent;
Texture2D TexturePrevious;

SamplerState Sampler0
{
	Filter = MIN_MAG_MIP_POINT;
	AddressU = Clamp;
	AddressV = Clamp;
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

VS_OUTPUT_POST VS_Quad( VS_INPUT_POST IN )
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

float4 PS_Downsample( VS_OUTPUT_POST IN, float4 v0 : SV_Position0 ) : SV_Target
{
	float2 coord = IN.txcoord0.xy;
	float ssz = 1.0/16.0;
	float4 res = float4(0,0,0,0);
	int x, y;
	[unroll] for ( y=-8; y<8; y++ ) [unroll] for ( x=-8; x<8; x++ )
	{
		res += TextureCurrent.Sample(Sampler0,coord
			+float2(x+0.5,y+0.5)*ssz);
	}
	res /= 256.0;
	res = luminance(res.rgb);
	res.w = 1.0;
	return res;
}

float4 PS_Adaptation(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
	float2 coord = IN.txcoord0.xy;
	float prev = TexturePrevious.Sample(Sampler0,coord).x;
	float ssz = 1.0/16.0;
	float4 res = float4(0,0,0,0);
	float smpmax = 0.0, smp;
	int x, y;
	[unroll] for ( y=-8; y<8; y++ ) [unroll] for ( x=-8; x<8; x++ )
	{
		smp = TextureCurrent.Sample(Sampler0,coord
			+float2(x+0.5,y+0.5)*ssz).x;
		smpmax = max(smpmax,smp);
		res += smp;
	}
	res /= 256.0;
	res = lerp(res,smpmax,AdaptationParameters.z);
	res = lerp(prev,res,AdaptationParameters.w);
	res = clamp(res,0.0,16384.0);
	float vclip = clamp(res.x,AdaptationParameters.x,
		AdaptationParameters.y);
	res *= vclip/(res+0.000000001);
	res.w = 1.0;
	return res;
}

technique11 Downsample
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsample()));
	}
}
technique11 Draw
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Adaptation()));
	}
}
