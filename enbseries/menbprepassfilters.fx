/*
	menbprepassfilters.fx : MariENB prepass shader routines.
	(C)2013-2017 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
VS_OUTPUT_POST VS_Pass( VS_INPUT_POST IN )
{
	VS_OUTPUT_POST OUT;
	OUT.vpos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord.xy = IN.txcoord.xy;
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
float depthlinear( float2 coord )
{
	float z = tex2D(SamplerDepth,coord).x;
	return (2*zNear)/(zFar+zNear-z*(zFar-zNear));
}
/* Colour grading based on depth */
float3 DepthGradeRGB( float3 res, float dfc )
{
	float dgrademul_r = tod_ind(dgrademul_r);
	float dgrademul_g = tod_ind(dgrademul_g);
	float dgrademul_b = tod_ind(dgrademul_b);
	float dgradepow_r = tod_ind(dgradepow_r);
	float dgradepow_g = tod_ind(dgradepow_g);
	float dgradepow_b = tod_ind(dgradepow_b);
	float3 dgrademul = float3(dgrademul_r,dgrademul_g,dgrademul_b);
	float3 dgradepow = float3(dgradepow_r,dgradepow_g,dgradepow_b);
	return lerp(res,pow(max(0,res),dgradepow)*dgrademul,dfc);
}
float3 DepthGradeColor( float3 res, float dfc )
{
	float dgradecol_r = tod_ind(dgradecol_r);
	float dgradecol_g = tod_ind(dgradecol_g);
	float dgradecol_b = tod_ind(dgradecol_b);
	float dgradecolfact = tod_ind(dgradecolfact);
	float3 dgradecol = float3(dgradecol_r,dgradecol_g,dgradecol_b);
	float tonev = luminance(res);
	float3 tonecolor = dgradecol*tonev;
	return lerp(res,res*(1.0-dgradecolfact)+tonecolor*dgradecolfact,dfc);
}
float3 DepthGradeHSV( float3 res, float dfc )
{
	float dgradesatmul = tod_ind(dgradesatmul);
	float dgradesatpow = tod_ind(dgradesatpow);
	float dgradevalmul = tod_ind(dgradevalmul);
	float dgradevalpow = tod_ind(dgradevalpow);
	float3 hsv = rgb2hsv(res);
	hsv.y = clamp(pow(max(0,hsv.y),dgradesatpow)*dgradesatmul,0.0,1.0);
	hsv.z = pow(max(0,hsv.z),dgradevalpow)*dgradevalmul;
	return lerp(res,hsv2rgb(hsv),dfc);
}
float3 DepthGrade( float3 res, float2 coord )
{
	float dep = tex2D(SamplerDepth,coord).x;
	float dfc = abs(dep-dgradedfoc*0.001);
	float dgradedpow = tod_ind(dgradedpow);
	float dgradedmul = tod_ind(dgradedmul);
	float dgradedbump = tod_ind(dgradedbump);
	float dgradedblend = tod_ind(dgradedblend);
	dfc = clamp(pow(dfc,dgradedpow)*dgradedmul+dgradedbump,0.0,1.0)
		*dgradedblend;
	if ( dgradeenable1 ) res = DepthGradeRGB(res,dfc);
	if ( dcolorizeafterhsv )
	{
		if ( dgradeenable3 ) res = DepthGradeHSV(res,dfc);
		if ( dgradeenable2 ) res = DepthGradeColor(res,dfc);
	}
	else
	{
		if ( dgradeenable2 ) res = DepthGradeColor(res,dfc);
		if ( dgradeenable3 ) res = DepthGradeHSV(res,dfc);
	}
	return res;
}
/* That "luma sharpen" thingy, added just because someone might want it */
float3 Sharpen( float3 res, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	if ( fixedx>0 ) bresl.x = fixedx;
	if ( fixedy>0 ) bresl.y = fixedy;
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*sharpradius;
	float4 crawling = tex2D(SamplerColor,coord+float2(0,-1)*bof);
	crawling += tex2D(SamplerColor,coord+float2(-1,0)*bof);
	crawling += tex2D(SamplerColor,coord+float2(1,0)*bof);
	crawling += tex2D(SamplerColor,coord+float2(0,1)*bof);
	crawling *= 0.25;
	float3 inmyskin = res-crawling.rgb;
	float thesewounds = luminance(inmyskin);
	thesewounds = clamp(thesewounds,-sharpclamp*0.01,sharpclamp*0.01);
	float3 theywillnotheal = res+thesewounds*sharpblend;
	return theywillnotheal;
}
/* old Edgevision mode */
float3 EdgeView( float3 res, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	if ( fixedx>0 ) bresl.x = fixedx;
	if ( fixedy>0 ) bresl.y = fixedy;
	float edgevfadepow = tod_ind(edgevfadepow);
	float edgevfademult = tod_ind(edgevfademult);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*edgevradius;
	float mdx = 0, mdy = 0, mud = 0;
	/* this reduces texture fetches by half, big difference */
	float3x3 depths;
	depths[0][0] = depthlinear(coord+float2(-1,-1)*bof);
	depths[0][1] = depthlinear(coord+float2( 0,-1)*bof);
	depths[0][2] = depthlinear(coord+float2( 1,-1)*bof);
	depths[1][0] = depthlinear(coord+float2(-1, 0)*bof);
	depths[1][1] = depthlinear(coord+float2( 0, 0)*bof);
	depths[1][2] = depthlinear(coord+float2( 1, 0)*bof);
	depths[2][0] = depthlinear(coord+float2(-1, 1)*bof);
	depths[2][1] = depthlinear(coord+float2( 0, 1)*bof);
	depths[2][2] = depthlinear(coord+float2( 1, 1)*bof);
	mdx += GX[0][0]*depths[0][0];
	mdx += GX[0][1]*depths[0][1];
	mdx += GX[0][2]*depths[0][2];
	mdx += GX[1][0]*depths[1][0];
	mdx += GX[1][1]*depths[1][1];
	mdx += GX[1][2]*depths[1][2];
	mdx += GX[2][0]*depths[2][0];
	mdx += GX[2][1]*depths[2][1];
	mdx += GX[2][2]*depths[2][2];
	mdy += GY[0][0]*depths[0][0];
	mdy += GY[0][1]*depths[0][1];
	mdy += GY[0][2]*depths[0][2];
	mdy += GY[1][0]*depths[1][0];
	mdy += GY[1][1]*depths[1][1];
	mdy += GY[1][2]*depths[1][2];
	mdy += GY[2][0]*depths[2][0];
	mdy += GY[2][1]*depths[2][1];
	mdy += GY[2][2]*depths[2][2];
	mud = pow(mdx*mdx+mdy*mdy,0.5);
	float fade = 1.0-tex2D(SamplerDepth,coord).x;
	mud *= clamp(pow(max(0.0,fade),edgevfadepow)*edgevfademult,0.0,1.0);
	mud = clamp(pow(max(0.0,mud),edgevpow)*edgevmult,0.0,1.0);
	if ( edgevblend ) return res-(edgevinv?1.0-mud:mud);
	return edgevinv?1.0-mud:mud;
}
/* luminance edge detection */
float3 EdgeDetect( float3 res, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	if ( fixedx>0 ) bresl.x = fixedx;
	if ( fixedy>0 ) bresl.y = fixedy;
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*comradius;
	float mdx = 0, mdy = 0, mud = 0;
	float3x3 lums;
	float3 col = tex2D(SamplerColor,coord+float2(-1,-1)*bof).rgb;
	lums[0][0] = luminance(col);
	col = tex2D(SamplerColor,coord+float2(0,-1)*bof).rgb;
	lums[0][1] = luminance(col);
	col = tex2D(SamplerColor,coord+float2(1,-1)*bof).rgb;
	lums[0][2] = luminance(col);
	col = tex2D(SamplerColor,coord+float2(-1,0)*bof).rgb;
	lums[1][0] = luminance(col);
	col = tex2D(SamplerColor,coord+float2(0,0)*bof).rgb;
	lums[1][1] = luminance(col);
	col = tex2D(SamplerColor,coord+float2(1,0)*bof).rgb;
	lums[1][2] = luminance(col);
	col = tex2D(SamplerColor,coord+float2(-1,1)*bof).rgb;
	lums[2][0] = luminance(col);
	col = tex2D(SamplerColor,coord+float2(0,1)*bof).rgb;
	lums[2][1] = luminance(col);
	col = tex2D(SamplerColor,coord+float2(1,1)*bof).rgb;
	lums[2][2] = luminance(col);
	mdx += GX[0][0]*lums[0][0];
	mdx += GX[0][1]*lums[0][1];
	mdx += GX[0][2]*lums[0][2];
	mdx += GX[1][0]*lums[1][0];
	mdx += GX[1][1]*lums[1][1];
	mdx += GX[1][2]*lums[1][2];
	mdx += GX[2][0]*lums[2][0];
	mdx += GX[2][1]*lums[2][1];
	mdx += GX[2][2]*lums[2][2];
	mdy += GY[0][0]*lums[0][0];
	mdy += GY[0][1]*lums[0][1];
	mdy += GY[0][2]*lums[0][2];
	mdy += GY[1][0]*lums[1][0];
	mdy += GY[1][1]*lums[1][1];
	mdy += GY[1][2]*lums[1][2];
	mdy += GY[2][0]*lums[2][0];
	mdy += GY[2][1]*lums[2][1];
	mdy += GY[2][2]*lums[2][2];
	mud = pow(max(mdx*mdx+mdy*mdy,0.0),0.5);
	mud = clamp(pow(max(mud,0.0),compow)*commult,0.0,1.0);
	if ( comblend ) return res-(cominv?1.0-mud:mud);
	return cominv?1.0-mud:mud;
}
/* linevision filter */
float3 LineView( float3 res, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	if ( fixedx>0 ) bresl.x = fixedx;
	if ( fixedy>0 ) bresl.y = fixedy;
	float contfadepow = tod_ind(contfadepow);
	float contfademult = tod_ind(contfademult);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*contradius;
	float dep = depthlinear(coord);
	float cont = depthlinear(coord+float2(-1,-1)*bof);
	cont += depthlinear(coord+float2(0,-1)*bof);
	cont += depthlinear(coord+float2(1,-1)*bof);
	cont += depthlinear(coord+float2(-1,0)*bof);
	cont += depthlinear(coord+float2(1,0)*bof);
	cont += depthlinear(coord+float2(-1,1)*bof);
	cont += depthlinear(coord+float2(0,1)*bof);
	cont += depthlinear(coord+float2(1,1)*bof);
	cont /= 8.0;
	float mud = 0.0;
	if ( abs(cont-dep) > (contthreshold*0.00001) ) mud = 1.0;
	float fade = 1.0-tex2D(SamplerDepth,coord).x;
	mud *= clamp(pow(max(0.0,fade),contfadepow)*contfademult,0.0,1.0);
	mud = clamp(pow(max(0.0,mud),contpow)*contmult,0.0,1.0);
	if ( contblend ) return res-(continv?1.0-mud:mud);
	return continv?1.0-mud:mud;
}
/* fog filter */
float3 Limbo( float3 res, float2 coord )
{
	float mud = clamp(pow(max(0.0,depthlinear(coord)),fogpow)*fogmult
		+fogbump,0.0,1.0);
	if ( foglimbo ) return fogcolor*mud;
	return lerp(res,fogcolor,mud);
}
float4 PS_DepthGrading( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( sharpenable ) res.rgb = Sharpen(res.rgb,coord);
	res.rgb = DepthGrade(res.rgb,coord);
	return res;
}
float4 PS_EdgeFilters( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( edgevenable ) res.rgb = EdgeView(res.rgb,coord);
	if ( comenable ) res.rgb = EdgeDetect(res.rgb,coord);
	if ( contenable ) res.rgb = LineView(res.rgb,coord);
	if ( fogenable ) res.rgb = Limbo(res.rgb,coord);
	return res;
}
/* Distant hot air refraction. Not very realistic, but does the job. */
float2 DistantHeat( float2 coord )
{
	float2 bresl;
	float dep, odep;
	dep = tex2D(SamplerDepth,coord).x;
	float distfade = clamp(pow(max(0,dep),heatfadepow)*heatfademul
		+heatfadebump,0.0,1.0);
	if ( distfade <= 0.0 ) return coord;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 nc = coord*(bresl/HEATSIZE)*heatsize;
	float2 ts = float2(0.01,1.0)*Timer.x*10000.0*heatspeed;
	float2 ofs = tex2D(SamplerHeat,nc+ts).xy;
	ofs = (ofs-0.5)*2.0;
	ofs *= pow(length(ofs),heatpow);
	if ( !heatalways ) ofs *= max(tod_ind(heatfactor),0.0)
		*max(0.0,warmfactor-coldfactor);
	odep = tex2D(SamplerDepth,coord+ofs*heatstrength*distfade*0.01).x;
	float odistfade = clamp(pow(max(0,odep),heatfadepow)*heatfademul
		+heatfadebump,0.0,1.0);
	if ( odistfade <= 0.0 ) return coord;
	return coord+ofs*heatstrength*distfade*0.01;
}
/* Screen distortion filters */
float4 PS_Distortion( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 ofs = coord;
	if ( heatenable ) ofs = DistantHeat(ofs);
	ofs -= coord;
	float4 res;
	if ( (distcha == 0.0) || (length(ofs) == 0) )
		return tex2D(SamplerColor,coord+ofs);
	float2 ofr, ofg, ofb;
	ofr = ofs*(1.0-distcha*0.01);
	ofg = ofs;
	ofb = ofs*(1.0+distcha*0.01);
	res = float4(tex2D(SamplerColor,coord+ofr).r,
		tex2D(SamplerColor,coord+ofg).g,
		tex2D(SamplerColor,coord+ofb).b,
		tex2D(SamplerColor,coord+ofs).a);
	return res;
}
technique PostProcess
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_EdgeFilters();
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
		PixelShader = compile ps_3_0 PS_DepthGrading();
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
		PixelShader = compile ps_3_0 PS_Distortion();
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