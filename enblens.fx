/*
	enblens.fx : MariENB Lens filters.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the MIT License.
*/
/* Effects have yet to be implemented. Sorry for the inconvenience. */
struct VS_OUTPUT_POST
{
	float4 vpos : POSITION;
	float2 txcoord0 : TEXCOORD0;
};
struct VS_INPUT_POST
{
	float3 pos : POSITION;
	float2 txcoord0 : TEXCOORD0;
};
VS_OUTPUT_POST VS_Dummy( VS_INPUT_POST IN )
{
	VS_OUTPUT_POST OUT;
	OUT.vpos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord0.xy = IN.txcoord0.xy;
	return OUT;
}
float4 PS_Dummy( VS_OUTPUT_POST In ) : COLOR
{
	return 0.0;
}
technique Draw
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Dummy();
		PixelShader = compile ps_3_0 PS_Dummy();
		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		CullMode = NONE;
		AlphaBlendEnable = FALSE;
		AlphaTestEnable = FALSE;
		SeparateAlphaBlendEnable = FALSE;
		SRGBWriteEnable = FALSE;
	}
}
technique LensPostPass
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Dummy();
		PixelShader = compile ps_3_0 PS_Dummy();
		AlphaBlendEnable = TRUE;
		SrcBlend = ONE;
		DestBlend = ONE;
		ColorWriteEnable = RED|GREEN|BLUE;
		CullMode = NONE;
		AlphaTestEnable = FALSE;
		SeparateAlphaBlendEnable = FALSE;
		SRGBWriteEnable = FALSE;
	}
}
