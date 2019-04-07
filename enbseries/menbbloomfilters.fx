/*
	menbbloomfilters.fx : MariENB bloom shader routines.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the WTFPL.
*/
VS_OUTPUT_POST VS_Bloom(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;
	float4 pos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1);
	OUT.vpos = pos;
	OUT.txcoord0.xy = IN.txcoord0.xy+TempParameters.xy;
	return OUT;
}
/* pre-pass bloom texture preparation */
float4 PS_BloomPrePass(VS_OUTPUT_POST In) : COLOR
{
	float tod = ENightDayFactor;
	float ind = EInteriorFactor;
	float bloombump = lerp(lerp(bloombump_n,bloombump_d,tod),
		lerp(bloombump_in,bloombump_id,tod),ind);
	float bloompower = lerp(lerp(bloompower_n,bloompower_d,tod),
		lerp(bloompower_in,bloompower_id,tod),ind);
	float bloomsaturation = lerp(lerp(bloomsaturation_n,bloomsaturation_d,
		tod),lerp(bloomsaturation_in,bloomsaturation_id,tod),ind);
	float bloomintensity = lerp(lerp(bloomintensity_n,bloomintensity_d,
		tod),lerp(bloomintensity_in,bloomintensity_id,tod),ind);
	float2 coord = In.txcoord0.xy;
	float4 res = tex2D(SamplerBloom1,coord);
	res = pow(saturate(res+bloombump),bloompower);
	float ress = (res.r+res.g+res.b)/3.0;
	res = res*bloomsaturation+ress*(1.0-bloomsaturation);
	res.rgb *= bloomintensity;
	return res;
}
/*
   multipass (cannot specify how many bloom textures to use, so considerable
   performance rape. good job, boris)
*/
float4 PS_BloomTexture(VS_OUTPUT_POST In) : COLOR
{
	float2 coord = In.txcoord0.xy;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*pow(4,TempParameters.w);
	/* loop unrolled for speeding up compilation (this is retarded) */
	float4 res;
	res = gauss7[3][3]*tex2D(SamplerBloom1,coord+float2(-3,-3)*bof);
	res += gauss7[2][3]*tex2D(SamplerBloom1,coord+float2(-2,-3)*bof);
	res += gauss7[1][3]*tex2D(SamplerBloom1,coord+float2(-1,-3)*bof);
	res += gauss7[0][3]*tex2D(SamplerBloom1,coord+float2(0,-3)*bof);
	res += gauss7[1][3]*tex2D(SamplerBloom1,coord+float2(1,-3)*bof);
	res += gauss7[2][3]*tex2D(SamplerBloom1,coord+float2(2,-3)*bof);
	res += gauss7[3][3]*tex2D(SamplerBloom1,coord+float2(3,-3)*bof);
	res += gauss7[3][2]*tex2D(SamplerBloom1,coord+float2(-3,-2)*bof);
	res += gauss7[2][2]*tex2D(SamplerBloom1,coord+float2(-2,-2)*bof);
	res += gauss7[1][2]*tex2D(SamplerBloom1,coord+float2(-1,-2)*bof);
	res += gauss7[0][2]*tex2D(SamplerBloom1,coord+float2(0,-2)*bof);
	res += gauss7[1][2]*tex2D(SamplerBloom1,coord+float2(1,-2)*bof);
	res += gauss7[2][2]*tex2D(SamplerBloom1,coord+float2(2,-2)*bof);
	res += gauss7[3][2]*tex2D(SamplerBloom1,coord+float2(3,-2)*bof);
	res += gauss7[3][1]*tex2D(SamplerBloom1,coord+float2(-3,-1)*bof);
	res += gauss7[2][1]*tex2D(SamplerBloom1,coord+float2(-2,-1)*bof);
	res += gauss7[1][1]*tex2D(SamplerBloom1,coord+float2(-1,-1)*bof);
	res += gauss7[0][1]*tex2D(SamplerBloom1,coord+float2(0,-1)*bof);
	res += gauss7[1][1]*tex2D(SamplerBloom1,coord+float2(1,-1)*bof);
	res += gauss7[2][1]*tex2D(SamplerBloom1,coord+float2(2,-1)*bof);
	res += gauss7[3][1]*tex2D(SamplerBloom1,coord+float2(3,-1)*bof);
	res += gauss7[3][0]*tex2D(SamplerBloom1,coord+float2(-3,0)*bof);
	res += gauss7[2][0]*tex2D(SamplerBloom1,coord+float2(-2,0)*bof);
	res += gauss7[1][0]*tex2D(SamplerBloom1,coord+float2(-1,0)*bof);
	res += gauss7[0][0]*tex2D(SamplerBloom1,coord+float2(0,0)*bof);
	res += gauss7[1][0]*tex2D(SamplerBloom1,coord+float2(1,0)*bof);
	res += gauss7[2][0]*tex2D(SamplerBloom1,coord+float2(2,0)*bof);
	res += gauss7[3][0]*tex2D(SamplerBloom1,coord+float2(3,0)*bof);
	res += gauss7[3][1]*tex2D(SamplerBloom1,coord+float2(-3,1)*bof);
	res += gauss7[2][1]*tex2D(SamplerBloom1,coord+float2(-2,1)*bof);
	res += gauss7[1][1]*tex2D(SamplerBloom1,coord+float2(-1,1)*bof);
	res += gauss7[0][1]*tex2D(SamplerBloom1,coord+float2(0,1)*bof);
	res += gauss7[1][1]*tex2D(SamplerBloom1,coord+float2(1,1)*bof);
	res += gauss7[2][1]*tex2D(SamplerBloom1,coord+float2(2,1)*bof);
	res += gauss7[3][1]*tex2D(SamplerBloom1,coord+float2(3,1)*bof);
	res += gauss7[3][2]*tex2D(SamplerBloom1,coord+float2(-3,2)*bof);
	res += gauss7[2][2]*tex2D(SamplerBloom1,coord+float2(-2,2)*bof);
	res += gauss7[1][2]*tex2D(SamplerBloom1,coord+float2(-1,2)*bof);
	res += gauss7[0][2]*tex2D(SamplerBloom1,coord+float2(0,2)*bof);
	res += gauss7[1][2]*tex2D(SamplerBloom1,coord+float2(1,2)*bof);
	res += gauss7[2][2]*tex2D(SamplerBloom1,coord+float2(2,2)*bof);
	res += gauss7[3][2]*tex2D(SamplerBloom1,coord+float2(3,2)*bof);
	res += gauss7[3][3]*tex2D(SamplerBloom1,coord+float2(-3,3)*bof);
	res += gauss7[2][3]*tex2D(SamplerBloom1,coord+float2(-2,3)*bof);
	res += gauss7[1][3]*tex2D(SamplerBloom1,coord+float2(-1,3)*bof);
	res += gauss7[0][3]*tex2D(SamplerBloom1,coord+float2(0,3)*bof);
	res += gauss7[1][3]*tex2D(SamplerBloom1,coord+float2(1,3)*bof);
	res += gauss7[2][3]*tex2D(SamplerBloom1,coord+float2(2,3)*bof);
	res += gauss7[3][3]*tex2D(SamplerBloom1,coord+float2(3,3)*bof);
	return res;
}
/* end pass */
float4 PS_BloomPostPass(VS_OUTPUT_POST In) : COLOR
{
	float2 coord = In.txcoord0.xy;
	float4 res = (tex2D(SamplerBloom1,coord)+tex2D(SamplerBloom2,coord)
		+tex2D(SamplerBloom3,coord)+tex2D(SamplerBloom4,coord)
		+tex2D(SamplerBloom5,coord)+tex2D(SamplerBloom6,coord)
		+tex2D(SamplerBloom7,coord)+tex2D(SamplerBloom8,coord))*0.125;
	return res;
}
/* techniques */
technique BloomPrePass
{
    pass p0
    {
		VertexShader = compile vs_3_0 VS_Bloom();
		PixelShader = compile ps_3_0 PS_BloomPrePass();
		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		CullMode = NONE;
		AlphaBlendEnable = FALSE;
		AlphaTestEnable = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
technique BloomTexture1
{
    pass p0
    {
		VertexShader = compile vs_3_0 VS_Bloom();
		PixelShader = compile ps_3_0 PS_BloomTexture();
		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		CullMode = NONE;
		AlphaBlendEnable = FALSE;
		AlphaTestEnable = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
technique BloomPostPass
{
    pass p0
    {
		VertexShader = compile vs_3_0 VS_Bloom();
		PixelShader = compile ps_3_0 PS_BloomPostPass();
		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		CullMode = NONE;
		AlphaBlendEnable = FALSE;
		AlphaTestEnable = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
