/*
	menbprepassfilters.fx : MariENB prepass shader routines.
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
/*
   Whoever wrote this shit deserves to die a slow, painful death for
   commiting a crime against good programming. I'm leaving the algorithm
   itself unaltered so you can see for yourself just how fucking disgusting it
   is (yes, it says "linearlize").
*/
float linearlizeDepth( float nonlinearDepth )
{
	float2 dofProj = float2(0.0509804,3098.0392);
	float2 dofDist = float2(0.0,0.0509804);
	float4 depth = nonlinearDepth;
	depth.y = -dofProj.x+dofProj.y;
	depth.y = 1.0/depth.y;
	depth.z = depth.y*dofProj.y;
	depth.z = depth.z*-dofProj.x;
	depth.x = dofProj.y*-depth.y+depth.x;
	depth.x = 1.0/depth.x;
	depth.y = depth.z*depth.x;
	depth.x = depth.z*depth.x-dofDist.y;
	depth.x += dofDist.x*-0.5;
	depth.x = max(depth.x,0.0);
	return depth.x;
}
#define depthlinear(x) linearlizeDepth(tex2D(SamplerDepth,x).r)
/* New and improved edge detection, generally useful for contour shading */
float4 PS_Edge( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	if ( noedge )
		return tex2D(SamplerColor,coord);
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) )
		bresl = float2(fixedx,fixedy);
	else
		bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y);
	float mdx, mdy, mud;
	/* this reduces texture fetches by half, big difference */
	float3x3 depths;
	depths[0][0] = depthlinear(coord+float2(-1,-1)*bof);
	depths[1][0] = depthlinear(coord+float2(0,-1)*bof);
	depths[2][0] = depthlinear(coord+float2(1,-1)*bof);
	depths[0][1] = depthlinear(coord+float2(-1,0)*bof);
	depths[1][1] = depthlinear(coord);
	depths[2][1] = depthlinear(coord+float2(1,0)*bof);
	depths[0][2] = depthlinear(coord+float2(-1,1)*bof);
	depths[1][2] = depthlinear(coord+float2(0,1)*bof);
	depths[2][2] = depthlinear(coord+float2(1,1)*bof);
	mdx = GX[0][0]*depths[0][0];
	mdx += GX[1][0]*depths[1][0];
	mdx += GX[2][0]*depths[2][0];
	mdx += GX[0][1]*depths[0][1];
	mdx += GX[1][1]*depths[1][1];
	mdx += GX[2][1]*depths[2][1];
	mdx += GX[0][2]*depths[0][2];
	mdx += GX[1][2]*depths[1][2];
	mdx += GX[2][2]*depths[2][2];
	mdy = GY[0][0]*depths[0][0];
	mdy += GY[1][0]*depths[1][0];
	mdy += GY[2][0]*depths[2][0];
	mdy += GY[0][1]*depths[0][1];
	mdy += GY[1][1]*depths[1][1];
	mdy += GY[2][1]*depths[2][1];
	mdy += GY[0][2]*depths[0][2];
	mdy += GY[1][2]*depths[1][2];
	mdy += GY[2][2]*depths[2][2];
	mud = pow(mdx*mdx+mdy*mdy,0.5);
	float fade = 1.0-tex2D(SamplerDepth,coord).x;
	mud *= saturate(pow(fade,edgefadepow)*edgefademult);
	mud = saturate(pow(mud,edgepow)*edgemult);
	float4 res = tex2D(SamplerColor,coord);
	if ( edgeview )
		res.rgb = mud;
	else
		res.rgb -= mud;
	res.a = 1.0;
	return saturate(res);
}
/* Crappy SSAO */
float3 pseudonormal( float dep, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 ofs1 = float2(0,1.0/bresl.y);
	float2 ofs2 = float2(1.0/bresl.x,0);
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
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) )
		bresl = float2(fixedx,fixedy);
	else
		bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float depth = tex2D(SamplerDepth,coord).x;
	float3 normal = pseudonormal(depth,coord);
	float2 nc = coord*(bresl/256.0);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*ssaoradius;
	float3 rnormal = tex2D(SamplerNoise3,nc).xyz*2.0-1.0;
	normal = normalize(normal+rnormal*ssaonoise);
	float occ = 0.0;
	int i;
	float ldepth = depthlinear(coord);
	for ( i=0; i<16; i++ )
	{
		float3 sample = reflect(ssao_samples[i],normal);
		float sampledepth = depthlinear(coord+sample.xy*bof);
		float diff = sampledepth-ldepth;
		if ( ldepth < sampledepth )
			occ += 1.0/(1.0+pow(diff,2));
	}
	float uocc = saturate(1.0-occ/16.0);
	float fade = 1.0-depth;
	uocc *= saturate(pow(fade,ssaofadepow)*ssaofademult);
	uocc = saturate(pow(uocc,ssaopow)*ssaomult);
	if ( depth >= 0.999999 )
		uocc = 0.0;
	if ( ssaodebug == 1 )
		return saturate(1.0-(uocc*ssaoblend));
	if ( ssaodebug == 2 )
		return (float4(normal.x,normal.y,normal.z,1.0)+1.0)*0.5;
	res.a = saturate(1.0-(uocc*ssaoblend));
	return res;
}
float4 PS_SSAO_Post( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !ssaoenable )
		return res;
	if ( !ssaobenable || (ssaodebug == 2) )
		return res*res.a;
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) )
		bresl = float2(fixedx,fixedy);
	else
		bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y);
	res.a = gauss7[3][3]*tex2D(SamplerColor,coord+float2(-3,-3)*bof).a;
	res.a += gauss7[2][3]*tex2D(SamplerColor,coord+float2(-2,-3)*bof).a;
	res.a += gauss7[1][3]*tex2D(SamplerColor,coord+float2(-1,-3)*bof).a;
	res.a += gauss7[0][3]*tex2D(SamplerColor,coord+float2(0,-3)*bof).a;
	res.a += gauss7[1][3]*tex2D(SamplerColor,coord+float2(1,-3)*bof).a;
	res.a += gauss7[2][3]*tex2D(SamplerColor,coord+float2(2,-3)*bof).a;
	res.a += gauss7[3][3]*tex2D(SamplerColor,coord+float2(3,-3)*bof).a;
	res.a += gauss7[3][2]*tex2D(SamplerColor,coord+float2(-3,-2)*bof).a;
	res.a += gauss7[2][2]*tex2D(SamplerColor,coord+float2(-2,-2)*bof).a;
	res.a += gauss7[1][2]*tex2D(SamplerColor,coord+float2(-1,-2)*bof).a;
	res.a += gauss7[0][2]*tex2D(SamplerColor,coord+float2(0,-2)*bof).a;
	res.a += gauss7[1][2]*tex2D(SamplerColor,coord+float2(1,-2)*bof).a;
	res.a += gauss7[2][2]*tex2D(SamplerColor,coord+float2(2,-2)*bof).a;
	res.a += gauss7[3][2]*tex2D(SamplerColor,coord+float2(3,-2)*bof).a;
	res.a += gauss7[3][1]*tex2D(SamplerColor,coord+float2(-3,-1)*bof).a;
	res.a += gauss7[2][1]*tex2D(SamplerColor,coord+float2(-2,-1)*bof).a;
	res.a += gauss7[1][1]*tex2D(SamplerColor,coord+float2(-1,-1)*bof).a;
	res.a += gauss7[0][1]*tex2D(SamplerColor,coord+float2(0,-1)*bof).a;
	res.a += gauss7[1][1]*tex2D(SamplerColor,coord+float2(1,-1)*bof).a;
	res.a += gauss7[2][1]*tex2D(SamplerColor,coord+float2(2,-1)*bof).a;
	res.a += gauss7[3][1]*tex2D(SamplerColor,coord+float2(3,-1)*bof).a;
	res.a += gauss7[3][0]*tex2D(SamplerColor,coord+float2(-3,0)*bof).a;
	res.a += gauss7[2][0]*tex2D(SamplerColor,coord+float2(-2,0)*bof).a;
	res.a += gauss7[1][0]*tex2D(SamplerColor,coord+float2(-1,0)*bof).a;
	res.a += gauss7[0][0]*tex2D(SamplerColor,coord+float2(0,0)*bof).a;
	res.a += gauss7[1][0]*tex2D(SamplerColor,coord+float2(1,0)*bof).a;
	res.a += gauss7[2][0]*tex2D(SamplerColor,coord+float2(2,0)*bof).a;
	res.a += gauss7[3][0]*tex2D(SamplerColor,coord+float2(3,0)*bof).a;
	res.a += gauss7[3][1]*tex2D(SamplerColor,coord+float2(-3,1)*bof).a;
	res.a += gauss7[2][1]*tex2D(SamplerColor,coord+float2(-2,1)*bof).a;
	res.a += gauss7[1][1]*tex2D(SamplerColor,coord+float2(-1,1)*bof).a;
	res.a += gauss7[0][1]*tex2D(SamplerColor,coord+float2(0,1)*bof).a;
	res.a += gauss7[1][1]*tex2D(SamplerColor,coord+float2(1,1)*bof).a;
	res.a += gauss7[2][1]*tex2D(SamplerColor,coord+float2(2,1)*bof).a;
	res.a += gauss7[3][1]*tex2D(SamplerColor,coord+float2(3,1)*bof).a;
	res.a += gauss7[3][2]*tex2D(SamplerColor,coord+float2(-3,2)*bof).a;
	res.a += gauss7[2][2]*tex2D(SamplerColor,coord+float2(-2,2)*bof).a;
	res.a += gauss7[1][2]*tex2D(SamplerColor,coord+float2(-1,2)*bof).a;
	res.a += gauss7[0][2]*tex2D(SamplerColor,coord+float2(0,2)*bof).a;
	res.a += gauss7[1][2]*tex2D(SamplerColor,coord+float2(1,2)*bof).a;
	res.a += gauss7[2][2]*tex2D(SamplerColor,coord+float2(2,2)*bof).a;
	res.a += gauss7[3][2]*tex2D(SamplerColor,coord+float2(3,2)*bof).a;
	if ( ssaodebug == 1 )
		return res.a;
	res *= res.a;
	return res;
}
/* Focus */
float4 PS_ReadFocus( VS_OUTPUT_POST IN ) : COLOR
{
	if ( dofdisable )
		return 0.0;
	float tod = ENightDayFactor;
	float ind = EInteriorFactor;
	float focusmax = lerp(lerp(focusmax_n,focusmax_d,tod),lerp(focusmax_in,
		focusmax_id,tod),ind);
	float cfocus = min(tex2D(SamplerDepth,0.5),focusmax*0.001);
	if ( !focuscircle )
		return cfocus;
	float focusradius = lerp(lerp(focusradius_n,focusradius_d,tod),
		lerp(focusradius_in,focusradius_id,tod),ind);
	float focusmix = lerp(lerp(focusmix_n,focusmix_d,tod),lerp(focusmix_in,
		focusmix_id,tod),ind);
	float step = (1.0/3.0);
	float mfocus;
	float2 coord;
	float2 bof = float2(1.0,ScreenSize.w)*focusradius*0.001;
	/* unrolled this too... *sigh* */
	coord.x = 0.5+sin(0.0)*bof.x;
	coord.y = 0.5+cos(0.0)*bof.y;
	mfocus = step*min(tex2D(SamplerDepth,coord),focusmax*0.001);
	coord.x = 0.5+sin(2.0*pi*step)*bof.x;
	coord.y = 0.5+cos(2.0*pi*step)*bof.y;
	mfocus += step*min(tex2D(SamplerDepth,coord),focusmax*0.001);
	coord.x = 0.5+sin(4.0*pi*step)*bof.x;
	coord.y = 0.5+cos(4.0*pi*step)*bof.y;
	mfocus += step*min(tex2D(SamplerDepth,coord),focusmax*0.001);
	cfocus = (1.0-focusmix)*cfocus+focusmix*mfocus;
	return cfocus;
}
float4 PS_WriteFocus( VS_OUTPUT_POST IN ) : COLOR
{
	if ( dofdisable )
		return 0.0;
	return max(lerp(tex2D(SamplerPrev,0.5).x,tex2D(SamplerCurr,0.5).x,
		saturate(FadeFactor)),0.0);
}
/* Depth of Field */
float4 PS_DoF( VS_OUTPUT_POST IN, float2 vPos : VPOS, uniform int p ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable || (!doftwopass && (p != 0)) )
		return tex2D(SamplerColor,coord);
	float tod = ENightDayFactor;
	float ind = EInteriorFactor;
	float dofpow = lerp(lerp(dofpow_n,dofpow_d,tod),lerp(dofpow_in,
		dofpow_id,tod),ind);
	float dofmult = lerp(lerp(dofmult_n,dofmult_d,tod),lerp(dofmult_in,
		dofmult_id,tod),ind);
	float doffixedfocuspow = lerp(lerp(doffixedfocuspow_n,
		doffixedfocuspow_d,tod),lerp(doffixedfocuspow_in,
		doffixedfocuspow_id,tod),ind);
	float doffixedfocusmult = lerp(lerp(doffixedfocusmult_n,
		doffixedfocusmult_d,tod),lerp(doffixedfocusmult_in,
		doffixedfocusmult_id,tod),ind);
	float doffixedfocusblend = lerp(lerp(doffixedfocusblend_n,
		doffixedfocusblend_d,tod),lerp(doffixedfocusblend_in,
		doffixedfocusblend_id,tod),ind);
	float doffixedunfocuspow = lerp(lerp(doffixedunfocuspow_n,
		doffixedunfocuspow_d,tod),lerp(doffixedunfocuspow_in,
		doffixedunfocuspow_id,tod),ind);
	float doffixedunfocusmult = lerp(lerp(doffixedunfocusmult_n,
		doffixedunfocusmult_d,tod),lerp(doffixedunfocusmult_in,
		doffixedunfocusmult_id,tod),ind);
	float doffixedunfocusblend = lerp(lerp(doffixedunfocusblend_n,
		doffixedunfocusblend_d,tod),lerp(doffixedunfocusblend_in,
		doffixedunfocusblend_id,tod),ind);
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) )
		bresl = float2(fixedx,fixedy);
	else
		bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y);
	float dep;
	if ( dofsmooth )
	{
		dep = gauss3[1][1]*tex2D(SamplerDepth,coord+float2(-1,-1)*bof);
		dep += gauss3[0][1]*tex2D(SamplerDepth,coord+float2(0,-1)*bof);
		dep += gauss3[1][1]*tex2D(SamplerDepth,coord+float2(1,-1)*bof);
		dep += gauss3[1][0]*tex2D(SamplerDepth,coord+float2(-1,0)*bof);
		dep += gauss3[0][0]*tex2D(SamplerDepth,coord+float2(0,0)*bof);
		dep += gauss3[1][0]*tex2D(SamplerDepth,coord+float2(1,0)*bof);
		dep += gauss3[1][1]*tex2D(SamplerDepth,coord+float2(-1,1)*bof);
		dep += gauss3[0][1]*tex2D(SamplerDepth,coord+float2(0,1)*bof);
		dep += gauss3[1][1]*tex2D(SamplerDepth,coord+float2(1,1)*bof);
	}
	else
		dep = tex2D(SamplerDepth,coord);
	float foc = tex2D(SamplerFocus,coord).x;
	float dfc = abs(dep-foc);
	float dff = abs(dep);
	float dfu = dff;
	dfc = saturate(pow(dfc,dofpow)*dofmult);
	dff = saturate(pow(dff,doffixedfocuspow)*doffixedfocusmult);
	dfu = saturate(pow(dfu,doffixedunfocuspow)*doffixedunfocusmult);
	dfc *= lerp(1.0,dff,doffixedfocusblend);
	dfc += lerp(0.0,dfu,doffixedunfocusblend);
	if ( dofcutoff && (dep >= 0.999999) )
		dfc = 0.0;
	dfc = saturate(dfc);
	/* aaand another unrolled loop */
	float4 res;
	bof *= pow(2,p);
	res = gauss5[2][2]*tex2D(SamplerColor,coord+float2(-2,-2)*bof*dfc);
	res += gauss5[1][2]*tex2D(SamplerColor,coord+float2(-1,-2)*bof*dfc);
	res += gauss5[0][2]*tex2D(SamplerColor,coord+float2(0,-2)*bof*dfc);
	res += gauss5[1][2]*tex2D(SamplerColor,coord+float2(1,-2)*bof*dfc);
	res += gauss5[2][2]*tex2D(SamplerColor,coord+float2(2,-2)*bof*dfc);
	res += gauss5[2][1]*tex2D(SamplerColor,coord+float2(-2,-1)*bof*dfc);
	res += gauss5[1][1]*tex2D(SamplerColor,coord+float2(-1,-1)*bof*dfc);
	res += gauss5[0][1]*tex2D(SamplerColor,coord+float2(0,-1)*bof*dfc);
	res += gauss5[1][1]*tex2D(SamplerColor,coord+float2(1,-1)*bof*dfc);
	res += gauss5[2][1]*tex2D(SamplerColor,coord+float2(2,-1)*bof*dfc);
	res += gauss5[2][0]*tex2D(SamplerColor,coord+float2(-2,0)*bof*dfc);
	res += gauss5[1][0]*tex2D(SamplerColor,coord+float2(-1,0)*bof*dfc);
	res += gauss5[0][0]*tex2D(SamplerColor,coord+float2(0,0)*bof*dfc);
	res += gauss5[1][0]*tex2D(SamplerColor,coord+float2(1,0)*bof*dfc);
	res += gauss5[2][0]*tex2D(SamplerColor,coord+float2(2,0)*bof*dfc);
	res += gauss5[2][1]*tex2D(SamplerColor,coord+float2(-2,1)*bof*dfc);
	res += gauss5[1][1]*tex2D(SamplerColor,coord+float2(-1,1)*bof*dfc);
	res += gauss5[0][1]*tex2D(SamplerColor,coord+float2(0,1)*bof*dfc);
	res += gauss5[1][1]*tex2D(SamplerColor,coord+float2(1,1)*bof*dfc);
	res += gauss5[2][1]*tex2D(SamplerColor,coord+float2(2,1)*bof*dfc);
	res += gauss5[2][2]*tex2D(SamplerColor,coord+float2(-2,2)*bof*dfc);
	res += gauss5[1][2]*tex2D(SamplerColor,coord+float2(-1,2)*bof*dfc);
	res += gauss5[0][2]*tex2D(SamplerColor,coord+float2(0,2)*bof*dfc);
	res += gauss5[1][2]*tex2D(SamplerColor,coord+float2(1,2)*bof*dfc);
	res += gauss5[2][2]*tex2D(SamplerColor,coord+float2(2,2)*bof*dfc);
	if ( dofdebug == 1 )
		return dfc;
	else if ( dofdebug == 2 )
		return tex2D(SamplerDepth,coord);
	return res;
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
		PixelShader = compile ps_3_0 PS_Edge();
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
