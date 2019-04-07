/*
	menbextrafilters.fx : MariENB extra shader routines.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
#define tod ENightDayFactor
#define ind EInteriorFactor
VS_OUTPUT_POST VS_Pass( VS_INPUT_POST IN )
{
	VS_OUTPUT_POST OUT;
	OUT.vpos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord.xy = IN.txcoord.xy;
	return OUT;
}
/* helpers */
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
/* prepass */
float4 ReducePrepass( in float4 col, in float2 coord )
{
	float3 hsv = rgb2hsv(col);
	hsv.y *= bsaturation;
	hsv.z = pow(hsv.z,bgamma);
	col.rgb = hsv2rgb(saturate(hsv));
	if ( dither == 0 )
		col += bdbump+checkers[int(coord.x%2)+2*int(coord.y%2)]*bdmult;
	else if ( dither == 1 )
		col += bdbump+ordered2[int(coord.x%2)+2*int(coord.y%2)]*bdmult;
	else if ( dither == 2 )
		col += bdbump+ordered3[int(coord.x%3)+3*int(coord.y%3)]*bdmult;
	else if ( dither == 3 )
		col += bdbump+ordered4[int(coord.x%4)+4*int(coord.y%4)]*bdmult;
	else if ( dither == 4 )
		col += bdbump+ordered8[int(coord.x%8)+8*int(coord.y%8)]*bdmult;
	col = saturate(col);
	return col;
}
float4 ReduceCGA( in float4 color, in float2 coord )
{
	float4 dac = ReducePrepass(color,coord);
	if ( cgapal == 0 )
	{
		dac.a = (dac.r+dac.g+dac.b)/3.0;
		return (dac.a>0.5);
	}
	float dist = 2.0;
	int idx = 0;
	if ( cgapal == 1 )
	{
		for ( int i=0; i<4; i++ )
			if ( distance(dac.rgb,cga1l[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga1l[i]);
			}
		color.rgb = cga1l[idx];
	}
	else if ( cgapal == 2 )
	{
		for ( int i=0; i<4; i++ )
			if ( distance(dac.rgb,cga1h[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga1h[i]);
			}
		color.rgb = cga1h[idx];
	}
	else if ( cgapal == 3 )
	{
		for ( int i=0; i<4; i++ )
			if ( distance(dac.rgb,cga2l[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga2l[i]);
			}
		color.rgb = cga2l[idx];
	}
	else if ( cgapal == 4 )
	{
		for ( int i=0; i<4; i++ )
			if ( distance(dac.rgb,cga2h[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga2h[i]);
			}
		color.rgb = cga2h[idx];
	}
	else if ( cgapal == 5 )
	{
		for ( int i=0; i<4; i++ )
			if ( distance(dac.rgb,cga3l[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga3l[i]);
			}
		color.rgb = cga3l[idx];
	}
	else if ( cgapal == 6 )
	{
		for ( int i=0; i<4; i++ )
			if ( distance(dac.rgb,cga3h[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga3h[i]);
			}
		color.rgb = cga3h[idx];
	}
	return color;
}
float4 ReduceEGA( in float4 color, in float2 coord )
{
	float4 dac = ReducePrepass(color,coord);
	float dist = 2.0;
	int idx = 0;
	if ( egapal == 0 )
	{
		for ( int i=0; i<16; i++ )
			if ( distance(dac.rgb,stdega[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,stdega[i]);
			}
		color.rgb = stdega[idx];
	}
	else
	{
		for ( int i=0; i<16; i++ )
			if ( distance(dac.rgb,aosega[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,aosega[i]);
			}
		color.rgb = aosega[idx];
	}
	return color;
}
float4 ReduceRGB2( in float4 color, in float2 coord )
{
	float4 dac = ReducePrepass(color,coord);
	color.rgb = trunc(dac.rgb*4.0)/4.0;
	return color;
}
float4 ReduceRGB323( in float4 color, in float2 coord )
{
	float4 dac = ReducePrepass(color,coord);
	color.rgb = trunc(dac.rgb*float3(8.0,4.0,8.0))/float3(8.0,4.0,8.0);
	return color;
}
float4 ReduceRGB4( in float4 color, in float2 coord )
{
	float4 dac = ReducePrepass(color,coord);
	color.rgb = trunc(dac.rgb*16.0)/16.0;
	return color;
}
float4 ReduceRGB565( in float4 color, in float2 coord )
{
	float4 dac = ReducePrepass(color,coord);
	color.rgb = trunc(dac.rgb*float3(32.0,64.0,32.0))
		/float3(32.0,64.0,32.0);
	return color;
}
float4 ReduceRGB6( in float4 color, in float2 coord )
{
	float4 dac = ReducePrepass(color,coord);
	color.rgb = trunc(dac.rgb*64.0)/64.0;
	return color;
}
/* darken borders */
float3 Vignette( float3 res, float2 coord )
{
	float dkradius = lerp(lerp(dkradius_n,dkradius_d,tod),lerp(dkradius_in,
		dkradius_id,tod),ind);
	float dkbump = lerp(lerp(dkbump_n,dkbump_d,tod),lerp(dkbump_in,
		dkbump_id,tod),ind);
	float dkcurve = lerp(lerp(dkcurve_n,dkcurve_d,tod),lerp(dkcurve_in,
		dkcurve_id,tod),ind);
	float val = distance(coord,0.5)*2.0+dkradius;
	val = saturate(val+dkbump);
	return lerp(res,float3(0,0,0),pow(val,dkcurve));
}
/* letterbox filter */
float3 Letterbox( float3 res, float2 coord )
{
	if ( abs(2.0*coord.y-1.0) > boxv ) return float3(0,0,0);
	return res;
}
/* Fuzzy */
float3 FilmGrain( float3 res, float2 coord )
{
	float ts = Timer.x*nf;
	float2 tcs = coord.xy;
	float2 s1 = tcs+float2(0,ts);
	float2 s2 = tcs+float2(ts,0);
	float2 s3 = tcs+float2(ts,ts);
	float n1, n2, n3;
	float2 nr = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w)/256.0;
	if ( np )
	{
		n1 = tex2D(SamplerNoise2,s1*nm11*nr).r;
		n2 = tex2D(SamplerNoise2,s2*nm12*nr).g;
		n3 = tex2D(SamplerNoise2,s3*nm13*nr).b;
		s1 = tcs+float2(ts+n1*nk,n2*nk);
		s2 = tcs+float2(n2,ts+n3*nk);
		s3 = tcs+float2(ts+n3*nk,ts+n1*nk);
		n1 = tex2D(SamplerNoise2,s1*nm21*nr).r;
		n2 = tex2D(SamplerNoise2,s2*nm22*nr).g;
		n3 = tex2D(SamplerNoise2,s3*nm23*nr).b;
	}
	else
	{
		n1 = tex2D(SamplerNoise3,s1*nm1*nr).r;
		n2 = tex2D(SamplerNoise3,s2*nm2*nr).g;
		n3 = tex2D(SamplerNoise3,s3*nm3*nr).b;
	}
	float n4 = (n1+n2+n3)/3;
	float3 ng = float3(n4,n4,n4);
	float3 nc = float3(n1,n2,n3);
	float3 nt = pow(clamp(lerp(ng,nc,ns),0.0,1.0),nj);
	if ( nb == 1 ) return res+nt*ni;
	if ( nb == 2 )
	{
		float3 tcol = res;
		tcol.r = (tcol.r<0.5)?(2.0*tcol.r*(0.5+(nt.r*ni)))
			:(1.0-2.0*(1.0-tcol.r)*(1.0-((0.5+(nt.r*ni)))));
		tcol.g = (tcol.g<0.5)?(2.0*tcol.g*(0.5+(nt.g*ni)))
			:(1.0-2.0*(1.0-tcol.g)*(1.0-((0.5+(nt.g*ni)))));
		tcol.b = (tcol.b<0.5)?(2.0*tcol.b*(0.5+(nt.b*ni)))
			:(1.0-2.0*(1.0-tcol.b)*(1.0-((0.5+(nt.b*ni)))));
		return tcol;
	}
	if ( nb == 3 )
	{
		float bn = 1.0-saturate((res.r+res.g+res.b)/3.0);
		bn = pow(bn,bnp);
		float3 nn = saturate(nt*bn);
		float3 tcol = res;
		tcol.r = (tcol.r>0.5)?(2.0*tcol.r*(0.5+(nn.r*ni)))
			:(1.0-2.0*(1.0-tcol.r)*(1.0-((0.5+(nn.r*ni)))));
		tcol.g = (tcol.g>0.5)?(2.0*tcol.g*(0.5+(nn.g*ni)))
			:(1.0-2.0*(1.0-tcol.g)*(1.0-((0.5+(nn.g*ni)))));
		tcol.b = (tcol.b>0.5)?(2.0*tcol.b*(0.5+(nn.b*ni)))
			:(1.0-2.0*(1.0-tcol.b)*(1.0-((0.5+(nn.b*ni)))));
		return tcol;
	}
	return lerp(res,nt,ni);
}
/* CINEMATIC!!! */
float4 PS_PoopyFilm( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( ne ) res.rgb = FilmGrain(res.rgb,coord);
	if ( dkenable ) res.rgb = Vignette(res.rgb,coord);
	if ( boxenable ) res.rgb = Letterbox(res.rgb,coord);
	res.a = 1.0;
	return res;
}
/* REVOLUTIONARY ULTRA-AWESOME FILTER */
float4 PS_Aberration( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !usecurve ) return res;
	float3 eta = float3(1+chromaab*0.09,1+chromaab*0.06,1+chromaab*0.03);
	float2 mid = coord-0.5;
	float2 rc = eta.r*(1.0-chromaab*0.1)*mid+0.5;
	float2 gc = eta.g*(1.0-chromaab*0.1)*mid+0.5;
	float2 bc = eta.b*(1.0-chromaab*0.1)*mid+0.5;
	float3 ab = float3(tex2D(SamplerColor,rc).r,tex2D(SamplerColor,gc).g,
		tex2D(SamplerColor,bc).b);
	res.rgb = ab;
	res.a = 1.0;
	return res;
}
/* Retro rockets */
float4 PS_Retro( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !useblock ) return res;
	float2 rresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float4 tcol;
	float2 bresl = rresl;
	float2 sresl = float2(sresx,sresy);
	if ( bresx <= 0 || bresy <= 0 ) bresl = rresl;
	else
	{
		if ( bresx <= 1.0 ) bresl.x = rresl.x*bresx;
		else bresl.x = bresx;
		if ( bresy <= 1.0 ) bresl.y = rresl.y*bresy;
		else bresl.y = bresy;
	}
	if ( sresl.x <= 0 ) sresl.x = rresl.x/bresl.x;
	if ( sresl.y <= 0 ) sresl.y = rresl.y/bresl.y;
	float2 ncoord = coord*(rresl/bresl);
	ncoord = (-0.5/sresl)*(rresl/bresl)+ncoord/sresl+0.5;
	ncoord = floor(ncoord*bresl)/bresl;
	if ( bresx <= 0 || bresy <= 0 ) ncoord = coord;
	tcol = tex2D(SamplerColor,ncoord);
	if ( paltype == 0 ) res = ReduceCGA(tcol,(coord*rresl)/sresl);
	else if ( paltype == 1 ) res = ReduceEGA(tcol,(coord*rresl)/sresl);
	else if ( paltype == 2 ) res = ReduceRGB2(tcol,(coord*rresl)/sresl);
	else if ( paltype == 3 ) res = ReduceRGB323(tcol,(coord*rresl)/sresl);
	else if ( paltype == 4 ) res = ReduceRGB4(tcol,(coord*rresl)/sresl);
	else if ( paltype == 5 ) res = ReduceRGB565(tcol,(coord*rresl)/sresl);
	else if ( paltype == 6 ) res = ReduceRGB6(tcol,(coord*rresl)/sresl);
	else res = tcol;
	if ( ncoord.x < 0 || ncoord.x >= 1 || ncoord.y < 0 || ncoord.y >= 1 )
		res *= 0;
	res.a = 1.0;
	return res;
}
technique PostProcess
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Aberration();
		DitherEnable = FALSE;
		ZEnable = FALSE;
		CullMode = NONE;
		ALPHATESTENABLE = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		AlphaBlendEnable = FALSE;
		StencilEnable = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
technique PostProcess2
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_PoopyFilm();
		DitherEnable = FALSE;
		ZEnable = FALSE;
		CullMode = NONE;
		ALPHATESTENABLE = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		AlphaBlendEnable = FALSE;
		StencilEnable = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
technique PostProcess3
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Retro();
		DitherEnable = FALSE;
		ZEnable = FALSE;
		CullMode = NONE;
		ALPHATESTENABLE = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		AlphaBlendEnable = FALSE;
		StencilEnable = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}