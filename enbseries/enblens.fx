/* This shader intentionally left blank */
struct VS_INPUT_POST
{
	float3 pos : POSITION;
	float2 txcoord	: TEXCOORD0;
};
struct VS_OUTPUT_POST
{
	float4 pos : SV_POSITION;
	float2 txcoord0	: TEXCOORD0;
};
VS_OUTPUT_POST VS_Quad(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;
	float4 pos;
	pos.xyz = IN.pos.xyz;
	pos.w = 1.0;
	OUT.pos = pos;
	OUT.txcoord0.xy = IN.txcoord.xy;
	return OUT;
}
float4 PS_Nothing(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
	return float4(0.0,0.0,0.0,1.0);
}
technique11 Nothing
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0,VS_Quad()));
		SetPixelShader(CompileShader(ps_5_0,PS_Nothing()));
	}
}
