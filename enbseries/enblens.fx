/*
	enblens.fx : MariENB Lens filters.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/*
   This shader left unimplemented. Development of the filter is a massive pain
   in the ass thanks to the incompetence of a certain individual named Boris
   Vorontsov and the major breakage of his ENB project.

   Lots of blind debugging are necessary to get the goddamn thing to compile,
   and from the looks of it the filter, which works flawlessly on MariEFX, is
   completely unportable to this massive bag of dicks. After DAYS of
   selectively commenting out code, the only way it can compile is if the
   shader does NOTHING. For ever minor change to the code, five minutes of
   waiting are needed so the entire thing recompiles! FIVE MINUTES! Just how
   can you fuck up that badly? By comparison eFX takes mere seconds to reload
   everything on the considerably more complex MariEFX project, but this... I
   can't imagine what awful programming resulted in such a terrible bottleneck.

   tl;dr: Fuck you, Boris.

     -- Marisa
*/
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
