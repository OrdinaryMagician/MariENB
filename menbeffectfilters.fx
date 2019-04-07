/*
	menbeffectfilters.fx : MariENB base shader routines.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the MIT License.
*/
VS_OUTPUT_POST VS_Pass( VS_INPUT_POST IN )
{
	VS_OUTPUT_POST OUT;
	OUT.vpos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord0.xy = IN.txcoord0.xy;
	return OUT;
}
/* MariENB shader */
float4 PS_Mari( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord0.xy;
	float4 res = tex2D(_s0,coord);
	float tod = ENightDayFactor;
	float ind = EInteriorFactor;
	/* screen mud goes here */
	if ( softbloom )
	{
		float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
		float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*softbloomsmp;
		int i,j;
		if ( softbloomlv == 1 )
		{
			for ( i=-2; i<=2; i++ )
				for ( j=-2; j<=2; j++ )
					res += gauss5[abs(i)][abs(j)]
						*tex2D(_s3,coord+float2(i,j)
						*bof)*EBloomAmount;
		}
		else if ( softbloomlv == 2 )
		{
			for ( i=-3; i<=3; i++ )
				for ( j=-3; j<=3; j++ )
					res += gauss7[abs(i)][abs(j)]
						*tex2D(_s3,coord+float2(i,j)
						*bof)*EBloomAmount;
		}
		else
		{
			for ( i=-1; i<=1; i++ )
				for ( j=-1; j<=1; j++ )
					res += gauss3[abs(i)][abs(j)]
						*tex2D(_s3,coord+float2(i,j)
						*bof)*EBloomAmount;
		}
	}
	else
		res += tex2D(_s3,coord)*EBloomAmount;
	float4 adapt = tex2D(_s4,0.5);
	/* adaptation */
	if ( aenable )
	{
		float adapts = clamp((adapt.r+adapt.g+adapt.b)/3.0,0.0,50.0);
		float amin = lerp(lerp(amin_n,amin_d,tod),lerp(amin_in,amin_id,
			tod),ind);
		float amax = lerp(lerp(amax_n,amax_d,tod),lerp(amax_in,amax_id,
			tod),ind);
		res.rgb = res.rgb/(adapts*amax+amin);
	}
	/* tone mapping */
	if ( tmenable )
	{
		float tone = lerp(lerp(tone_n,tone_d,tod),lerp(tone_in,tone_id,
			tod),ind);
		float tovr = lerp(lerp(tovr_n,tovr_d,tod),lerp(tovr_in,tovr_id,
			tod),ind);
		res.rgb = (res.rgb*(1+res.rgb/tovr))/(res.rgb+tone);
	}
	/* palette texture */
	if ( palenable )
	{
		float palb = lerp(lerp(palb_n,palb_d,tod),lerp(palb_in,palb_id,
			tod),ind);
		res.rgb = saturate(res.rgb);
		float3 bright = adapt.rgb/(adapt.rgb+1.0);
		float brights = (bright.r+bright.g+bright.b)/3.0;
		float3 pal = float3(tex2D(_s7,float2(res.r,brights)).r,
			tex2D(_s7,float2(res.g,brights)).g,
			tex2D(_s7,float2(res.b,brights)).b);
		res.rgb = res.rgb*(1.0-palb)+pal.rgb*palb;
	}
	res.a = 1.0;
	return res;

}
/*
   So... let me get this straight... rather than simply switching techniques,
   Boris just compiles the program twice with and without this macro, then
   toggling "UseEffect" switches between each variation? What the fuck?
*/
#ifndef ENB_FLIPTECHNIQUE
technique Shader_D6EC7DD1
#else
technique Shader_ORIGINALPOSTPROCESS
#endif
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Mari();
		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		ZEnable = FALSE;
		ZWriteEnable = FALSE;
		CullMode = NONE;
		AlphaTestEnable = FALSE;
		AlphaBlendEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
#ifndef ENB_FLIPTECHNIQUE
technique Shader_ORIGINALPOSTPROCESS
#else
technique Shader_D6EC7DD1
#endif
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		/*
		   >2014
		   >inline assembly
		   Have to keep this part intact, sadly
		   Boris what the fuck have you done
		*/
		PixelShader = asm
		{
			ps_3_0
			def c6,0,0,0,0
			def c7,0.212500006,0.715399981,0.0720999986,1
			dcl_texcoord v0.xy
			dcl_2d s0
			dcl_2d s1
			dcl_2d s2
			rcp r0.x,c2.y
			texld r1,v0,s2
			mul r0.yz,r1.xxyw,c1.y
			rcp r0.w,r0.y
			mul r0.z,r0.w,r0.z
			texld r1,v0,s1
			mul r1.xyz,r1,c1.y
			dp3 r0.w,c7,r1
			mul r1.w,r0.w,r0.z
			mad r0.z,r0.z,r0.w,c7.w
			rcp r0.z,r0.z
			mad r0.x,r1.w,r0.x,c7.w
			mul r0.x,r0.x,r1.w
			mul r0.x,r0.z,r0.x
			cmp r0.x,-r0.w,c6.x,r0.x
			rcp r0.z,r0.w
			mul r0.z,r0.z,r0.x
			add_sat r0.x,-r0.x,c2.x
			texld r2,v0,s0
			mul r2.xyz,r2,c1.y
			mul r2.xyz,r0.x,r2
			mad r1.xyz,r1,r0.z,r2
			dp3 r0.x,r1,c7
			mov r1.w,c7.w
			lrp r2,c3.x,r1,r0.x
			mad r1,r0.x,c4,-r2
			mad r1,c4.w,r1,r2
			mad r1,c3.w,r1,-r0.y
			mad r0,c3.z,r1,r0.y
			add r1,-r0,c5
			mad oC0,c5.w,r1,r0
		};
		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		ZEnable = FALSE;
		ZWriteEnable = FALSE;
		CullMode = NONE;
		AlphaTestEnable = FALSE;
		AlphaBlendEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
