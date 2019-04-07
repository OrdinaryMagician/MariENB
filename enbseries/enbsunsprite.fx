/*
	enbsunsprite.fx : MariENB sun sprite filters.
	(C)2013-2016 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/* This shader intentionally does nothing */
struct VS_OUTPUT_POST
{
	float4 vpos : POSITION;
	float2 txcoord : TEXCOORD0;
};
struct VS_INPUT_POST
{
	float3 pos : POSITION;
	float2 txcoord : TEXCOORD0;
};
VS_OUTPUT_POST VS_Dummy( VS_INPUT_POST IN )
{
	VS_OUTPUT_POST OUT;
	float4 pos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.vpos = pos;
	OUT.txcoord.xy = IN.txcoord.xy;
	return OUT;
}
float4 PS_Dummy( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	return 0.0;
}
technique Draw
{
	pass P0
	{
		VertexShader = compile vs_3_0 VS_Dummy();
		PixelShader = compile ps_3_0 PS_Dummy();
		AlphaBlendEnable = TRUE;
		SrcBlend = ONE;
		DestBlend = ONE;
		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable = FALSE;
		ZEnable = FALSE;
		CullMode = NONE;
		ALPHATESTENABLE = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		StencilEnable = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
