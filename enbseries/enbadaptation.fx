/* This shader intentionally left unchanged */
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
VS_OUTPUT_POST VS_Quad(VS_INPUT_POST IN,
	uniform float sizeX, uniform float sizeY)
{
	VS_OUTPUT_POST OUT;
	float4 pos;
	pos.xyz = IN.pos.xyz;
	pos.w = 1.0;
	OUT.pos = pos;
	float2 offset;
	offset.x = sizeX;
	offset.y = sizeY;
	OUT.txcoord0.xy = IN.txcoord.xy+offset.xy;
	return OUT;
}
float4 PS_Downsample(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
	float4 res;
	float2 pos, coord;
	float4 curr = 0.0, currmax = 0.0;
	const float scale = 1.0/16.0, step = 1.0/16.0, halfstep = 0.5/16.0;
	pos.x = -0.5+halfstep;
	for (int x=0; x<16; x++)
	{
		pos.y = -0.5+halfstep;
		for (int y=0; y<16; y++)
		{
			coord = pos.xy*scale;
			float4 tempcurr = TextureCurrent.Sample(Sampler0,
				IN.txcoord0.xy+coord.xy);
			currmax = max(currmax,tempcurr);
			curr += tempcurr;
			pos.y += step;
		}
		pos.x += step;
	}
	curr /= 256.0;
	res = curr;
	res = max(res.x,max(res.y,res.z));
	res.w = 1.0;
	return res;
}
float4 PS_Adaptation(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
	float4 res;
	float prev = TexturePrevious.Sample(Sampler0,IN.txcoord0.xy).x;
	float2 pos;
	float curr = 0.0, currmax = 0.0;
	const float step = 1.0/16.0, halfstep = 0.5/16.0;
	pos.x = halfstep;
	for (int x=0; x<16; x++)
	{
		pos.y = halfstep;
		for (int y=0; y<16; y++)
		{
			float tempcurr = TextureCurrent.Sample(Sampler0,
				IN.txcoord0.xy+pos.xy).x;
			currmax = max(currmax,tempcurr);
			curr += tempcurr;
			pos.y += step;
		}
		pos.x += step;
	}
	curr /= 256.0;
	curr = lerp(curr,currmax,AdaptationParameters.z);
	res = lerp(prev,curr,AdaptationParameters.w);
	res = max(res,0.001);
	res = min(res,16384.0);
	float valmax, valcut;
	valmax = max(res.x,max(res.y,res.z));
	valcut = max(valmax,AdaptationParameters.x);
	valcut = min(valcut,AdaptationParameters.y);
	res *= valcut/(valmax+0.000000001);
	res.w = 1.0;
	return res;
}
technique11 Downsample
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad(0.0,0.0)));
		SetPixelShader(CompileShader(ps_5_0,PS_Downsample()));
	}
}
technique11 Draw
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad(0.0,0.0)));
		SetPixelShader(CompileShader(ps_5_0,PS_Adaptation()));
	}
}
