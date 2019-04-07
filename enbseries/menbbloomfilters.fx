/*
	menbbloomfilters.fx : MariENB bloom shader routines.
	(C)2013-2016 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
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
/* pre-pass bloom texture preparation */
float4 PS_BloomPrePass(VS_OUTPUT_POST In) : COLOR
{
	float2 coord = In.txcoord0.xy;
	float bloomcap = tod_ind(bloomcap);
	float bloombump = tod_ind(bloombump);
	float bloompower = tod_ind(bloompower);
	float bloomsaturation = tod_ind(bloomsaturation);
	float bloomintensity = tod_ind(bloomintensity);
	float4 res = tex2D(SamplerBloomC1,coord);
	float3 hsv = rgb2hsv(res.rgb);
	if ( hsv.z > bloomcap ) hsv.z = bloomcap;
	res.rgb = hsv2rgb(hsv);
	res = max(res+bloombump,0);
	hsv = rgb2hsv(res.rgb);
	hsv.y = clamp(hsv.y*bloomsaturation,0.0,1.0);
	hsv.z = pow(hsv.z,bloompower);
	res.rgb = hsv2rgb(hsv)*bloomintensity;
	res.a = 1.0;
	return res;
}
/* Horizontal blur step goes here */
float4 PS_BloomTexture1(VS_OUTPUT_POST In) : COLOR
{
	float2 coord = In.txcoord0.xy;
	float4 res = float4(0,0,0,0);
	int i;
	float sum = 0;
	float2 pp;
	[unroll] for ( i=-7; i<=7; i++ )
	{
		pp = coord+float2(i,0)*TempParameters.z*bloomradiusx;
		res += gauss8[abs(i)]*tex2D(SamplerBloom1,pp);
		sum += ((pp.x>=0)&&(pp.x<1))?gauss8[abs(i)]:0;
	}
	res *= 1.0/sum;
	res.a = 1.0;
	return res;
}
/* This is the vertical step */
float4 PS_BloomTexture2(VS_OUTPUT_POST In) : COLOR
{
	float2 coord = In.txcoord0.xy;
	float4 res = float4(0,0,0,0), base = tex2D(SamplerBloom5,coord);
	int i;
	float sum = 0;
	float2 pp;
	[unroll] for ( i=-7; i<=7; i++ )
	{
		pp = coord+float2(0,i)*TempParameters.z*bloomradiusy;
		res += gauss8[abs(i)]*tex2D(SamplerBloom1,pp);
		sum += ((pp.y>=0)&&(pp.y<1))?gauss8[abs(i)]:0;
	}
	res *= 1.0/sum;
	/* blue shift */
	float3 blu_n = float3(blu_n_r,blu_n_g,blu_n_b);
	float3 blu_d = float3(blu_d_r,blu_d_g,blu_d_b);
	float3 blu_in = float3(blu_in_r,blu_in_g,blu_in_b);
	float3 blu_id = float3(blu_id_r,blu_id_g,blu_id_b);
	float3 blu = tod_ind(blu);
	float bsi = tod_ind(bsi);
	float lm = max(0,luminance(res.rgb)-luminance(base.rgb))*bsi;
	lm = lm/(1.0+lm);
	lm *= 1.0-saturate((TempParameters.w-1.0)*bslp);
	blu = saturate(blu+(TempParameters.w-1.0)*bsbp);
	res.rgb *= lerp(1.0,blu,lm);
	res.a = 1.0;
	return res;
}
/*
   Horizontal anamorphic bloom step. This is somewhat realistic except that
   most lenses (e.g.: glasses, both convex and concave) cause VERTICAL
   anamorphic bloom due to their curvature. However since ENB doesn't let me
   switch the order of the blurring, it's impossible to do so. I don't really
   have a problem with that, this also looks nice.

   I've seen that some ENBs do something almost-maybe-possibly-slightly-similar
   they call "anamorphic lens flare", which has an ass-backwards-retarded
   implementation, which serves to showcase their incompetence. Rather than use
   a single-axis massive-scale blur like I do, they simply awkwardly stretch
   sampling coordinates along one axis, which doesn't even have the same effect
   as it just makes it so bright areas ONLY at the very middle of the screen
   produces sharp bright lines extending towards the sides.
*/
float4 PS_AnamPass(VS_OUTPUT_POST In) : COLOR
{
	if ( !alfenable ) return float4(0,0,0,1);
	float2 coord = In.txcoord0.xy;
	float4 res = float4(0,0,0,0), base = tex2D(SamplerBloom5,coord);
	int i;
	float sum = 0;
	float2 pp;
	[unroll] for ( i=-39; i<=39; i++ )
	{
		pp = coord+float2(i,0)*TempParameters.z*bloomradiusx*flen;
		res += gauss40[abs(i)]*tex2D(SamplerBloom1,pp);
		sum += ((pp.x>=0)&&(pp.x<1))?gauss40[abs(i)]:0;
	}
	res *= 1.0/sum;
	/* blue shift */
	float3 flu_n = float3(flu_n_r,flu_n_g,flu_n_b);
	float3 flu_d = float3(flu_d_r,flu_d_g,flu_d_b);
	float3 flu_in = float3(flu_in_r,flu_in_g,flu_in_b);
	float3 flu_id = float3(flu_id_r,flu_id_g,flu_id_b);
	float3 flu = tod_ind(flu);
	float fsi = tod_ind(fsi);
	float lm = max(0,luminance(res.rgb)-luminance(base.rgb))*fsi;
	lm = lm/(1.0+lm);
	float fbl = tod_ind(fbl);
	float fpw = tod_ind(fpw);
	res.rgb *= lerp(1.0,flu,lm);
	res.rgb = pow(max(0,res.rgb),fpw)*fbl;
	res.a = 1.0;
	return res;
}
/* end pass, mix it all up */
float4 PS_BloomPostPass(VS_OUTPUT_POST In) : COLOR
{
	float2 coord = In.txcoord0.xy;
	float4 res = float4(0,0,0,0);
	res += bloommix1*tex2D(SamplerBloomC1,coord); // P1
	res += bloommix2*tex2D(SamplerBloomC2,coord); // P2
	res += bloommix3*tex2D(SamplerBloomC3,coord); // P3
	res += bloommix4*tex2D(SamplerBloomC4,coord); // P4
	res += bloommix5*tex2D(SamplerBloomC5,coord); // Prepass
	res += bloommix6*tex2D(SamplerBloomC6,coord); // Base
	res += bloommix7*tex2D(SamplerBloomC7,coord); // P5
	res += bloommix8*tex2D(SamplerBloomC8,coord); // P6
	res.rgb /= 6.0;
	res.rgb = clamp(res.rgb,0,32768);
	res.a = 1.0;
	return res;
}
/* crappy lens filter, useful when playing characters with glasses */
float4 PS_LensDirtPass(VS_OUTPUT_POST In) : COLOR
{
	float4 mud = float4(0,0,0,0);
	if ( !dirtenable ) return mud;
	float2 coord = In.txcoord0.xy;
	float2 ccoord = coord;
#ifdef ASPECT_LENSDIRT
	ccoord.y = (coord.y-0.5)*ScreenSize.w+0.5;
#endif
	float4 crap = tex2D(SamplerLens,ccoord);
	mud += dirtmix1*tex2D(SamplerBloomC1,coord); // P1
	mud += dirtmix2*tex2D(SamplerBloomC2,coord); // P2
	mud += dirtmix3*tex2D(SamplerBloomC3,coord); // P3
	mud += dirtmix4*tex2D(SamplerBloomC4,coord); // P4
	mud += dirtmix5*tex2D(SamplerBloomC5,coord); // Prepass
	mud += dirtmix6*tex2D(SamplerBloomC6,coord); // Base
	mud += dirtmix7*tex2D(SamplerBloomC7,coord); // P5
	mud += dirtmix8*tex2D(SamplerBloomC8,coord); // P6
	mud.rgb /= 6.0;
	float3 hsv = rgb2hsv(mud.rgb);
	hsv.y = clamp(hsv.y*dirtsaturation,0.0,1.0);
	mud.rgb = clamp(hsv2rgb(hsv),0,32768);
	float mudmax = luminance(mud.rgb);
	float mudn = max(mudmax/(1.0+mudmax),0.0);
	mudn = pow(mudn,max(ldirtpow-crap.a,0.0));
	mud.rgb *= mudn*ldirtfactor*crap.rgb;
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
