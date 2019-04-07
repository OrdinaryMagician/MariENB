/*
	menbextrafilters.fx : MariENB extra shader routines.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the WTFPL.
*/
VS_OUTPUT_POST VS_Pass( VS_INPUT_POST IN )
{
	VS_OUTPUT_POST OUT;
	OUT.vpos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord.xy = IN.txcoord.xy;
	return OUT;
}
/* prepass */
float4 ReducePrepass( in float4 color, in float2 coord )
{
	color.rgb = pow(max(color.rgb,0.0),bgamma);
	float4 dac;
	dac.a = (color.r+color.g+color.b)/3.0;
	dac.rgb = dac.a+(color.rgb-dac.a)*bsaturation;
	if ( dither == 0 )
		dac += bdbump+checkers[int(coord.x%2)+2*int(coord.y%2)]*bdmult;
	else if ( dither == 1 )
		dac += bdbump+ordered2[int(coord.x%2)+2*int(coord.y%2)]*bdmult;
	else if ( dither == 2 )
		dac += bdbump+ordered3[int(coord.x%3)+3*int(coord.y%3)]*bdmult;
	else if ( dither == 3 )
		dac += bdbump+ordered4[int(coord.x%4)+4*int(coord.y%4)]*bdmult;
	else if ( dither == 4 )
		dac += bdbump+ordered8[int(coord.x%8)+8*int(coord.y%8)]*bdmult;
	dac.a = 1.0;
	dac = saturate(dac);
	return dac;
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
		{
			if ( distance(dac.rgb,cga1l[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga1l[i]);
			}
		}
		color.rgb = cga1l[idx];
	}
	else if ( cgapal == 2 )
	{
		for ( int i=0; i<4; i++ )
		{
			if ( distance(dac.rgb,cga1h[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga1h[i]);
			}
		}
		color.rgb = cga1h[idx];
	}
	else if ( cgapal == 3 )
	{
		for ( int i=0; i<4; i++ )
		{
			if ( distance(dac.rgb,cga2l[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga2l[i]);
			}
		}
		color.rgb = cga2l[idx];
	}
	else if ( cgapal == 4 )
	{
		for ( int i=0; i<4; i++ )
		{
			if ( distance(dac.rgb,cga2h[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga2h[i]);
			}
		}
		color.rgb = cga2h[idx];
	}
	else if ( cgapal == 5 )
	{
		for ( int i=0; i<4; i++ )
		{
			if ( distance(dac.rgb,cga3l[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga3l[i]);
			}
		}
		color.rgb = cga3l[idx];
	}
	else if ( cgapal == 6 )
	{
		for ( int i=0; i<4; i++ )
		{
			if ( distance(dac.rgb,cga3h[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga3h[i]);
			}
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
		{
			if ( distance(dac.rgb,stdega[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,stdega[i]);
			}
		}
		color.rgb = stdega[idx];
	}
	else
	{
		for ( int i=0; i<16; i++ )
		{
			if ( distance(dac.rgb,aosega[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,aosega[i]);
			}
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
/* Fuzzy */
float4 PS_Grain( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !ne )
		return res;
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
	if ( nb == 1 )
		res.rgb += nt*ni;
	else if ( nb == 2 )
	{
		res.r = (res.r<0.5)?(2.0*res.r*(0.5+(nt.r*ni)))
			:(1.0-2.0*(1.0-res.r)*(1.0-((0.5+(nt.r*ni)))));
		res.g = (res.g<0.5)?(2.0*res.g*(0.5+(nt.g*ni)))
			:(1.0-2.0*(1.0-res.g)*(1.0-((0.5+(nt.g*ni)))));
		res.b = (res.b<0.5)?(2.0*res.b*(0.5+(nt.b*ni)))
			:(1.0-2.0*(1.0-res.b)*(1.0-((0.5+(nt.b*ni)))));
	}
	else if ( nb == 3 )
		res.rgb *= 1.0+(nt*ni);
	else
		res.rgb = lerp(res.rgb,nt,ni);
	return res;
}
/* Curveshit */
float4 PS_Curve( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !usecurve )
		return res;
	float3 eta = float3(1+chromaab*0.09,1+chromaab*0.06,1+chromaab*0.03);
	float2 center = float2(coord.x-0.5,coord.y-0.5);
	float zfact = 100.0/lenszoom;
	float r2 = center.x*center.x+center.y*center.y;
	float f = 0;
	if( lensdistc == 0.0)
		f = 1+r2*lensdist;
	else
		f = 1+r2*(lensdist+lensdistc*sqrt(r2));
	float x = f*zfact*center.x+0.5;
	float y = f*zfact*center.y+0.5;
	float2 rcoord = (f*eta.r)*zfact*(center.xy*0.5)+0.5;
	float2 gcoord = (f*eta.g)*zfact*(center.xy*0.5)+0.5;
	float2 bcoord = (f*eta.b)*zfact*(center.xy*0.5)+0.5;
	float4 idist = float4(tex2D(SamplerColor,rcoord).r,
		tex2D(SamplerColor,gcoord).g,
		tex2D(SamplerColor,bcoord).b,1.0);
	if ( lensclamp )
	{
		if ( (rcoord.x < 0.0) || (rcoord.x >= 1.0) )
			idist.r *= 0.0;
		if ( (rcoord.y < 0.0) || (rcoord.y >= 1.0) )
			idist.r *= 0.0;
		if ( (gcoord.x < 0.0) || (gcoord.x >= 1.0) )
			idist.g *= 0.0;
		if ( (gcoord.y < 0.0) || (gcoord.y >= 1.0) )
			idist.g *= 0.0;
		if ( (bcoord.x < 0.0) || (bcoord.x >= 1.0) )
			idist.b *= 0.0;
		if ( (bcoord.y < 0.0) || (bcoord.y >= 1.0) )
			idist.b *= 0.0;
	}
	res.rgb = idist.rgb;
	res.a = 1.0;
	return res;
}
/* Retro rockets */
float4 PS_Retro( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !useblock )
		return res;
	float2 rresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float4 tcol;
	float2 bresl = rresl;
	if ( bresx <= 0 || bresy <= 0 )
		bresl = rresl;
	else
	{
		if ( bresx <= 1.0 )
			bresl.x = rresl.x*bresx;
		else
			bresl.x = bresx;
		if ( bresy <= 1.0 )
			bresl.y = rresl.y*bresy;
		else
			bresl.y = bresy;
	}
	float2 ncoord = coord;
	ncoord = (coord-float2(0.5,0.5))+float2(0.5,0.5);
	ncoord = floor(ncoord*bresl)/bresl;
	if ( bresx <= 0 || bresy <= 0 )
		ncoord = coord;
	tcol = tex2D(SamplerColor,ncoord);
	if ( ncoord.x < 0 || ncoord.x >= 1 || ncoord.y < 0 || ncoord.y >= 1 )
		tcol *= 0;
	if ( paltype == 0 )
		res = ReduceCGA(tcol,coord*bresl);
	else if ( paltype == 1 )
		res = ReduceEGA(tcol,coord*bresl);
	else if ( paltype == 2 )
		res = ReduceRGB2(tcol,coord*bresl);
	else if ( paltype == 3 )
		res = ReduceRGB323(tcol,coord*bresl);
	else if ( paltype == 4 )
		res = ReduceRGB4(tcol,coord*bresl);
	else if ( paltype == 5 )
		res = ReduceRGB565(tcol,coord*bresl);
	else if ( paltype == 6 )
		res = ReduceRGB6(tcol,coord*bresl);
	else
		res = tcol;
	res.a = 1.0;
	return res;
}
technique PostProcess
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Grain();
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
		PixelShader = compile ps_3_0 PS_Curve();
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