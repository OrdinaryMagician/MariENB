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
	OUT.txcoord.xy = IN.txcoord.xy;
	return OUT;
}
/* Focus */
float4 PS_ReadFocus( VS_OUTPUT_POST IN ) : COLOR
{
	float cfocus = tex2D(SamplerDepth,0.5).x;
	if ( !focuscircle || (focusslice <= 0) || (focuscircles <= 0) )
		return cfocus;
	int i, j;
	float step = (1.0/focusslice);
	float mfocus;
	float2 coord;
	float2 bof = float2(1.0,ScreenSize.w)*focusradius*0.01;
	for ( i=0; i<focuscircles; i++ )
	{
		mfocus = 0.0;
		for ( j=0; j<focusslice; j++ )
		{
			coord.x = 0.5+cos(2.0*pi*float(j)*step)*bof.x;
			coord.y = 0.5+sin(2.0*pi*float(j)*step)*bof.y;
			mfocus += step*tex2D(SamplerDepth,coord).x;
		}
		bof *= 0.5;
		cfocus = (1.0-focusmix)*cfocus+focusmix*mfocus;
	}
	return cfocus;
}
float4 PS_WriteFocus( VS_OUTPUT_POST IN ) : COLOR
{
	return max(lerp(tex2D(SamplerPrev,0.5).x,tex2D(SamplerCurr,0.5).x,
		saturate(FadeFactor)),0.0);
}
/* Dummy */
float4 PS_DummyPrepass( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	return tex2D(SamplerColor,IN.txcoord.xy);
}
/* border detect */
float4 PS_Border( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !celenable )
		return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*celradius;
	float3x3 GX = {-1,0,1,-2,0,2,-1,0,1}, GY = {1,2,1,0,0,0,-1,-2,-1};
	float mdx = 0, mdy = 0, mud;
	int i,j;
	for ( i=-1; i<=1; i++ )
	{
		for ( j=-1; j<=1; j++ )
		{
			mdx += GX[i+1][j+1]*tex2D(SamplerDepth,coord
				+float2(i,j)*bof).x;
			mdy += GY[i+1][j+1]*tex2D(SamplerDepth,coord
				+float2(i,j)*bof).x;
		}
	}
	mud = pow(pow(mdx,2)+pow(mdy,2),0.5);
	mud = saturate(pow(mud+celbump,celpower)*celmult);
	float depth = tex2D(SamplerDepth,coord).x;
	if ( depth >= celtrim )
		mud = 0.0;
	mud *= saturate(depth*celfade);
	if ( celmode == 1 )
		res.rgb = (1.0-saturate(tex2D(SamplerDepth,coord).x))
			*(1.0-saturate(mud*celblend));
	else if ( celmode == 2 )
		res.rgb *= saturate(mud*celblend);
	else if ( celmode == 3 )
		res.rgb = saturate(mud*celblend);
	else
		res.rgb *= 1.0-saturate(mud*celblend);
	return res;
}
/* SSAO */
float3 pseudonormal( float dep, float2 coord )
{
	float2 ofs1 = float2(ssaonoff1*0.01,ssaonoff2*0.01);
	float2 ofs2 = float2(ssaonoff3*0.01,ssaonoff4*0.01);
	float dep1 = tex2D(SamplerDepth,coord+ofs1).x;
	float dep2 = tex2D(SamplerDepth,coord+ofs2).x;
	float3 p1 = float3(ofs1,dep1-dep);
	float3 p2 = float3(ofs2,dep2-dep);
	float3 normal = cross(p1,p2);
	normal.z = -normal.z;
	return normalize(normal);
}
float4 PS_SSAO( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !ssaoenable )
		return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*ssaoradius;
	float depth = tex2D(SamplerDepth,coord).x;
	float3 normal = pseudonormal(depth,coord);
	float2 nc = tex2D(SamplerNoise,coord).xy;
	normal += ssaonoise*normalize(tex2D(SamplerNoise,
		float2(1.0,ScreenSize.w)*nc*ssaonoisesize).xyz*2.0-1.0);
	normal = normalize(normal);
	float occ = 0.0;
	int i;
	for( i=0; i<16; i++ )
	{
		float3 cs = ssao_samples[i];
		cs = reflect(cs,normal);
		float2 tc = float2(coord+i*cs.xy*bof);
		float nd = tex2D(SamplerDepth,tc).x;
		float dif = nd-depth;
		float fall;
		if ( nd > depth )
			occ += 1.0/(1.0+(pow(dif,2)));
	}
	float uocc = 1.0-(occ/16.0);
	uocc = saturate(pow(uocc+ssaobump,ssaopow)*ssaomult);
	uocc *= saturate(depth*ssaofade);
	if ( depth >= ssaotrim )
		uocc = 0.0;
	if ( ssaodebug == 1 )
		return uocc;
	else if ( ssaodebug == 2 )
		return (float4(normal.x,normal.y,normal.z,1.0)+1.0)*0.5;
	res.a = (1.0-(uocc*ssaoblend));
	return res;
}
float4 PS_SSAO_Post( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !ssaoenable )
		return res;
	if ( !ssaobenable || (ssaodebug != 0) )
		return res*res.a;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*ssaobradius;
	int i,j;
	res.a *= 0;
	if ( ssaoblevel == 1 )
	{
		for ( i=-2; i<=2; i++ )
			for ( j=-2; j<=2; j++ )
				res.a += gauss5[abs(i)][abs(j)]
					*tex2D(SamplerColor,coord+float2(i,j)
					*bof).a;
	}
	else if ( ssaoblevel == 2 )
	{
		for ( i=-3; i<=3; i++ )
			for ( j=-3; j<=3; j++ )
				res.a += gauss7[abs(i)][abs(j)]
					*tex2D(SamplerColor,coord+float2(i,j)
					*bof).a;
	}
	else
	{
		for ( i=-1; i<=1; i++ )
			for ( j=-1; j<=1; j++ )
				res.a += gauss3[abs(i)][abs(j)]
					*tex2D(SamplerColor,coord+float2(i,j)
					*bof).a;
	}
	res *= res.a;
	return res;
}
/* Depth of Field */
float4 PS_DoF( VS_OUTPUT_POST IN, float2 vPos : VPOS, uniform int p ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	if ( !dofenable )
		return tex2D(SamplerColor,coord);
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*dofradius
		*pow(clamp(doflevel+1,1,3),p);
	float dep = tex2D(SamplerDepth,coord).x;
	float foc = tex2D(SamplerFocus,coord).x;
	float dfc = abs(dep-foc);
	dfc = saturate(pow(dfc+dofbump,dofpow)*dofmult);
	if ( dep >= doftrim )
		dfc = 0.0;
	int i,j;
	float4 res = 0.0;
	if ( doflevel == 1 )
	{
		for ( i=-2; i<=2; i++ )
			for ( j=-2; j<=2; j++ )
				res += gauss5[abs(i)][abs(j)]
					*tex2D(SamplerColor,coord+float2(i,j)
					*bof*dfc);
	}
	else if ( doflevel == 2 )
	{
		for ( i=-3; i<=3; i++ )
			for ( j=-3; j<=3; j++ )
				res += gauss7[abs(i)][abs(j)]
					*tex2D(SamplerColor,coord+float2(i,j)
					*bof*dfc);
	}
	else
	{
		for ( i=-1; i<=1; i++ )
			for ( j=-1; j<=1; j++ )
				res += gauss3[abs(i)][abs(j)]
					*tex2D(SamplerColor,coord+float2(i,j)
					*bof*dfc);
	}
	if ( dofdebug == 1 )
		return dfc;
	else if ( dofdebug == 2 )
		return dep;
	return (1.0-dofblend)*tex2D(SamplerColor,coord)+dofblend*res;
}
technique ReadFocus
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_ReadFocus();
		ZENABLE = FALSE;
		CullMode = NONE;
		ALPHATESTENABLE = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		AlphaBlendEnable = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
technique WriteFocus
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_WriteFocus();
		ZENABLE = FALSE;
		CullMode = NONE;
		ALPHATESTENABLE = FALSE;
		SEPARATEALPHABLENDENABLE = FALSE;
		AlphaBlendEnable = FALSE;
		FogEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
technique PostProcess
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Border();
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
		PixelShader = compile ps_3_0 PS_SSAO();
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
		PixelShader = compile ps_3_0 PS_SSAO_Post();
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
technique PostProcess4
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_DoF(0);
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
technique PostProcess5
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_DoF(1);
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
