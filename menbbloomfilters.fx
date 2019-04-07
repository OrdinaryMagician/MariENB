/*
	menbbloomfilters.fx : MariENB bloom shader routines.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the MIT License.
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
	float2 coord = In.txcoord0.xy;
	if ( !preenable )
		return tex2D(SamplerBloom1,coord);
	float4 res = 0.0;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*presample;
	int i, j;
	if ( prelevel == 1 )
	{
		for ( i=-2; i<=2; i++ )
			for ( j=-2; j<=2; j++ )
				res += gauss5[abs(i)][abs(j)]
					*tex2D(SamplerBloom1,coord+float2(i,j)
					*bof);
	}
	else if ( prelevel == 2 )
	{
		for ( i=-3; i<=3; i++ )
			for ( j=-3; j<=3; j++ )
				res += gauss7[abs(i)][abs(j)]
					*tex2D(SamplerBloom1,coord+float2(i,j)
					*bof);
	}
	else
	{
		for ( i=-1; i<=1; i++ )
			for ( j=-1; j<=1; j++ )
				res += gauss3[abs(i)][abs(j)]
					*tex2D(SamplerBloom1,coord+float2(i,j)
					*bof);
	}
	return res;
}
/* multipass */
float4 PS_BloomTexture(VS_OUTPUT_POST In) : COLOR
{
	float2 coord = In.txcoord0.xy;
	float4 res = 0.0;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*postsample
		*(TempParameters.w+0.25);
	int i, j;
	if ( postlevel == 1 )
	{
		for ( i=-2; i<=2; i++ )
			for ( j=-2; j<=2; j++ )
				res += gauss5[abs(i)][abs(j)]
					*tex2D(SamplerBloom1,coord+float2(i,j)
					*bof);
	}
	else if ( postlevel == 2 )
	{
		for ( i=-3; i<=3; i++ )
			for ( j=-3; j<=3; j++ )
				res += gauss7[abs(i)][abs(j)]
					*tex2D(SamplerBloom1,coord+float2(i,j)
					*bof);
	}
	else
	{
		for ( i=-1; i<=1; i++ )
			for ( j=-1; j<=1; j++ )
				res += gauss3[abs(i)][abs(j)]
					*tex2D(SamplerBloom1,coord+float2(i,j)
					*bof);
	}
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
	res = pow(saturate(res+bloombump),bloompower);
	float ress = (res.r+res.g+res.b)/3.0;
	res = res*bloomsaturation+ress*(1.0-bloomsaturation);
	res.rgb *= bloomintensity;
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
technique BloomTexture2
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
