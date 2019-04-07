/*
	menbbloomfilters.fx : MariENB bloom shader routines.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
#define tod ENightDayFactor
#define ind EInteriorFactor
VS_OUTPUT_POST VS_Bloom(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;
	float4 pos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1);
	OUT.vpos = pos;
	OUT.txcoord0.xy = IN.txcoord0.xy+TempParameters.xy;
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
/* pre-pass bloom texture preparation, nothing is done */
float4 PS_BloomPrePass(VS_OUTPUT_POST In) : COLOR
{
	float2 coord = In.txcoord0.xy;
	float bloomcap = lerp(lerp(bloomcap_n,bloomcap_d,tod),lerp(bloomcap_in,
		bloomcap_id,tod),ind);
	float bloombump = lerp(lerp(bloombump_n,bloombump_d,tod),
		lerp(bloombump_in,bloombump_id,tod),ind);
	float bloompower = lerp(lerp(bloompower_n,bloompower_d,tod),
		lerp(bloompower_in,bloompower_id,tod),ind);
	float bloomsaturation = lerp(lerp(bloomsaturation_n,bloomsaturation_d,
		tod),lerp(bloomsaturation_in,bloomsaturation_id,tod),ind);
	float bloomintensity = lerp(lerp(bloomintensity_n,bloomintensity_d,
		tod),lerp(bloomintensity_in,bloomintensity_id,tod),ind);
	float4 res = tex2D(SamplerBloom1,coord);
	float3 hsv = rgb2hsv(res.rgb);
	if ( hsv.z > bloomcap ) hsv.z = bloomcap;
	res.rgb = hsv2rgb(hsv);
	res = max(res+bloombump,0);
	hsv = rgb2hsv(res.rgb);
	hsv.y *= bloomsaturation;
	hsv.z = pow(hsv.z,bloompower);
	res.rgb = hsv2rgb(hsv)*bloomintensity;
	res.a = 1.0;
	return res;
}
/* Thankfully this allows for separate axis blur */
float4 PS_BloomTexture1(VS_OUTPUT_POST In) : COLOR
{
	float2 coord = In.txcoord0.xy;
	float4 res = float4(0,0,0,0);
	int i;
	[unroll] for ( i=-7; i<=7; i++ )
		res += gauss8[abs(i)]*tex2D(SamplerBloom1,coord+float2(i,0)
			*TempParameters.z*bloomradius);
	res.a = 1.0;
	return res;
}
float4 PS_BloomTexture2(VS_OUTPUT_POST In) : COLOR
{
	float2 coord = In.txcoord0.xy;
	float4 res = float4(0,0,0,0), base = tex2D(SamplerBloom1,coord);
	int i;
	[unroll] for ( i=-7; i<=7; i++ )
		res += gauss8[abs(i)]*tex2D(SamplerBloom1,coord+float2(0,i)
			*TempParameters.z*bloomradius);
	/* blue shift */
	float3 blu_n = float3(blu_n_r,blu_n_g,blu_n_b);
	float3 blu_d = float3(blu_d_r,blu_d_g,blu_d_b);
	float3 blu_in = float3(blu_in_r,blu_in_g,blu_in_b);
	float3 blu_id = float3(blu_id_r,blu_id_g,blu_id_b);
	float3 blu = lerp(lerp(blu_n,blu_d,tod),lerp(blu_in,blu_id,tod),ind);
	float bsi = lerp(lerp(bsi_n,bsi_d,tod),lerp(bsi_in,bsi_id,tod),ind);
	float lm = max(0,luminance(res.rgb)-luminance(base.rgb))*10*bsi;
	lm = lm/(1.0+lm);
	lm *= 1.0-saturate((TempParameters.w-1.0)*0.22);
	blu = saturate(blu+(TempParameters.w-1.0)*0.33);
	res.rgb *= lerp(1.0,blu,lm);
	res.a = 1.0;
	return res;
}
/* Anamorphic bloom */
float4 PS_AnamPass(VS_OUTPUT_POST In) : COLOR
{
	if ( !alfenable ) return float4(0,0,0,1);
	float2 coord = In.txcoord0.xy;
	float4 res = float4(0,0,0,0), base = tex2D(SamplerBloom1,coord);
	int i;
	[unroll] for ( i=-79; i<=79; i++ )
		res += gauss80[abs(i)]*tex2D(SamplerBloom1,coord+float2(i,0)
			*TempParameters.z*bloomradius*flen);
	/* blue shift */
	float3 flu_n = float3(flu_n_r,flu_n_g,flu_n_b);
	float3 flu_d = float3(flu_d_r,flu_d_g,flu_d_b);
	float3 flu_in = float3(flu_in_r,flu_in_g,flu_in_b);
	float3 flu_id = float3(flu_id_r,flu_id_g,flu_id_b);
	float3 flu = lerp(lerp(flu_n,flu_d,tod),lerp(flu_in,flu_id,tod),ind);
	float fsi = lerp(lerp(fsi_n,fsi_d,tod),lerp(fsi_in,fsi_id,tod),ind);
	float lm = max(0,luminance(res.rgb)-luminance(base.rgb))*10*fsi;
	lm = lm/(1.0+lm);
	float fbl = lerp(lerp(fbl_n,fbl_d,tod),lerp(fbl_in,fbl_id,tod),ind);
	float fpw = lerp(lerp(fpw_n,fpw_d,tod),lerp(fpw_in,fpw_id,tod),ind);
	res.rgb *= lerp(1.0,flu,lm);
	res.rgb = pow(res.rgb,fpw)*fbl;
	res.a = 1.0;
	return res;
}
/* end pass */
float4 PS_BloomPostPass(VS_OUTPUT_POST In) : COLOR
{
	float2 coord = In.txcoord0.xy;
	float4 res = float4(0,0,0,0);
	res += bloommix1*tex2D(SamplerBloom1,coord); // P1
	res += bloommix2*tex2D(SamplerBloom2,coord); // P2
	res += bloommix3*tex2D(SamplerBloom3,coord); // P3
	res += bloommix4*tex2D(SamplerBloom4,coord); // P4
	res += bloommix5*tex2D(SamplerBloom5,coord); // Prepass
	res += bloommix6*tex2D(SamplerBloom6,coord); // Base
	res += bloommix7*tex2D(SamplerBloom7,coord); // P5
	res += bloommix8*tex2D(SamplerBloom8,coord); // P6
	res.rgb /= 6.0;
	if ( alfenable ) res.rgb *= 0.5;
	res.rgb = clamp(res.rgb,0,32768);
	res.a = 1.0;
	return res;
}
/* crappy lens filter */
float4 PS_LensDirtPass(VS_OUTPUT_POST In) : COLOR
{
	float4 mud = float4(0,0,0,0);
	if ( !dirtenable ) return mud;
	float2 coord = In.txcoord0.xy;
	float2 ccoord = coord;
	if ( dirtaspect ) ccoord.y = (coord.y-0.5)*ScreenSize.w+0.5;
	float4 crap = tex2D(SamplerLens,ccoord);
	float4 crapb = tex2D(SamplerLensbump,ccoord);
	float craps = tex2D(SamplerLensdiff,coord).x;
	craps = (1.0-lstarf)+lstarf*craps;
	float bump = max(crapb.w+1.0-abs(dot(abs(0.5-coord.xy),crapb.xy)),0.0);
	bump = pow(bump,crapb.w*ldirtbumpx);
	mud += dirtmix1*tex2D(SamplerBloom1,coord); // P1
	mud += dirtmix2*tex2D(SamplerBloom2,coord); // P2
	mud += dirtmix3*tex2D(SamplerBloom3,coord); // P3
	mud += dirtmix4*tex2D(SamplerBloom4,coord); // P4
	mud += dirtmix5*tex2D(SamplerBloom5,coord); // Prepass
	mud += dirtmix6*tex2D(SamplerBloom6,coord); // Base
	mud += dirtmix7*tex2D(SamplerBloom7,coord); // P5
	mud += dirtmix8*tex2D(SamplerBloom8,coord); // P6
	mud.rgb /= 6.0;
	if ( alfenable ) mud.rgb *= 0.5;
	mud.rgb = clamp(mud.rgb,0,32768);
	float mudmax = luminance(mud.rgb);
	float mudn = max(mudmax/(1.0+mudmax),0.0);
	mudn = pow(mudn,max(ldirtpow-crap.a,0.0));
	mud.rgb *= mudn*ldirtfactor*craps*crap.rgb*bump;
	mud.a = 1.0;
	return mud;
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
		PixelShader = compile ps_3_0 PS_BloomTexture1();
		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		CullMode = NONE;
		AlphaBlendEnable = FALSE;
		AlphaTestEnable = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
	pass p1
	{
		AlphaBlendEnable = true;
		SrcBlend = One;
		DestBlend = One;
		PixelShader = compile ps_3_0 PS_AnamPass();
	}
}
technique BloomTexture2
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Bloom();
		PixelShader = compile ps_3_0 PS_BloomTexture2();
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
	pass p1
	{
		AlphaBlendEnable = true;
		SrcBlend = One;
		DestBlend = One;
		PixelShader = compile ps_3_0 PS_LensDirtPass();
	}
}
