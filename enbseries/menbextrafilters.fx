/*
	menbextrafilters.fx : MariENB extra shader routines.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
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
/* helpers */
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
		[unroll] for ( int i=0; i<4; i++ )
			if ( distance(dac.rgb,cga1l[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga1l[i]);
			}
		color.rgb = cga1l[idx];
	}
	else if ( cgapal == 2 )
	{
		[unroll] for ( int i=0; i<4; i++ )
			if ( distance(dac.rgb,cga1h[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga1h[i]);
			}
		color.rgb = cga1h[idx];
	}
	else if ( cgapal == 3 )
	{
		[unroll] for ( int i=0; i<4; i++ )
			if ( distance(dac.rgb,cga2l[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga2l[i]);
			}
		color.rgb = cga2l[idx];
	}
	else if ( cgapal == 4 )
	{
		[unroll] for ( int i=0; i<4; i++ )
			if ( distance(dac.rgb,cga2h[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga2h[i]);
			}
		color.rgb = cga2h[idx];
	}
	else if ( cgapal == 5 )
	{
		[unroll] for ( int i=0; i<4; i++ )
			if ( distance(dac.rgb,cga3l[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,cga3l[i]);
			}
		color.rgb = cga3l[idx];
	}
	else if ( cgapal == 6 )
	{
		[unroll] for ( int i=0; i<4; i++ )
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
		[unroll] for ( int i=0; i<16; i++ )
			if ( distance(dac.rgb,stdega[i]) < dist )
			{
				idx = i;
				dist = distance(dac.rgb,stdega[i]);
			}
		color.rgb = stdega[idx];
	}
	else
	{
		[unroll] for ( int i=0; i<16; i++ )
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
/* ASCII art (more like CP437 art) */
float4 PS_ASCII( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !asciienable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 fresl = float2(FONT_WIDTH,FONT_HEIGHT);
	float2 cresl = float2(GLYPH_WIDTH,GLYPH_HEIGHT);
	float2 bscl = floor(bresl/cresl);
	float3 col = tex2D(SamplerColor,floor(bscl*coord)/bscl).rgb;
	int lum = luminance(col)*FONT_LEVELS;
	float2 itx = floor(coord*bresl);
	float2 blk = floor(itx/cresl)*cresl;
	float2 ofs = itx-blk;
	ofs.y += lum*cresl.y;
	ofs /= fresl;
	float gch = tex2D(SamplerFont,ofs).x;
	if ( gch < 0.5 ) res.rgb = res.rgb*asciiblend;
	else
	{
		if ( asciimono ) res.rgb = 1.0;
		else res.rgb = col;
	}
	return res;
}
/* Painting filter */
float4 PS_Paint1( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !paintenable ) return res;
	/* Kuwahara filter */
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*paintradius;
	float n = 16.0;
	float3 m[4], s[4], c;
	int i, j;
	[unroll] for ( i=0; i<4; i++ )
	{
		m[i] = float3(0,0,0);
		s[i] = float3(0,0,0);
	}
	[unroll] for ( i=-3; i<=0; i++ ) [unroll] for ( j=-3; j<=0; j++ )
	{
		c = tex2D(SamplerColor,coord+float2(i,j)*bof).rgb;
		m[0] += c;
		s[0] += c*c;
	}
	[unroll] for ( i=-3; i<=0; i++ ) [unroll] for ( j=0; j<=3; j++ )
	{
		c = tex2D(SamplerColor,coord+float2(i,j)*bof).rgb;
		m[1] += c;
		s[1] += c*c;
	}
	[unroll] for ( i=0; i<=3; i++ ) [unroll] for ( j=-3; j<=0; j++ )
	{
		c = tex2D(SamplerColor,coord+float2(i,j)*bof).rgb;
		m[2] += c;
		s[2] += c*c;
	}
	[unroll] for ( i=0; i<=3; i++ ) [unroll] for ( j=0; j<=3; j++ )
	{
		c = tex2D(SamplerColor,coord+float2(i,j)*bof).rgb;
		m[3] += c;
		s[3] += c*c;
	}
	float min_sigma2 = 1e+2, sigma2;
	[unroll] for ( i=0; i<4; i++ )
	{
		m[i] /= n;
		s[i] = abs(s[i]/n-m[i]*m[i]);
		sigma2 = s[i].r+s[i].g+s[i].b;
		if ( sigma2 >= min_sigma2 ) continue;
		min_sigma2 = sigma2;
		res.rgb = m[i];
	}
	return res;
}
float4 PS_Paint2( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !paintenable ) return res;
	/* Median filter */
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*paintmradius;
	float3 m1, m2, m3;
	float3 a, b, c;
	a = tex2D(SamplerColor,coord+float2(-1,-1)*bof).rgb;
	b = tex2D(SamplerColor,coord+float2( 0,-1)*bof).rgb;
	c = tex2D(SamplerColor,coord+float2( 1,-1)*bof).rgb;
	m1 = (luminance(a)<luminance(b))?((luminance(b)<luminance(c))?b
		:max(a,c)):((luminance(a)<luminance(c))?a:max(b,c));
	a = tex2D(SamplerColor,coord+float2(-1, 0)*bof).rgb;
	b = tex2D(SamplerColor,coord+float2( 0, 0)*bof).rgb;
	c = tex2D(SamplerColor,coord+float2( 1, 0)*bof).rgb;
	m2 = (luminance(a)<luminance(b))?((luminance(b)<luminance(c))?b
		:max(a,c)):((luminance(a)<luminance(c))?a:max(b,c));
	a = tex2D(SamplerColor,coord+float2(-1, 1)*bof).rgb;
	b = tex2D(SamplerColor,coord+float2( 0, 1)*bof).rgb;
	c = tex2D(SamplerColor,coord+float2( 1, 1)*bof).rgb;
	m3 = (luminance(a)<luminance(b))?((luminance(b)<luminance(c))?b
		:max(a,c)):((luminance(a)<luminance(c))?a:max(b,c));
	res.rgb = (luminance(m1)<luminance(m2))?((luminance(m2)<luminance(m3))
		?m2:max(m1,m3)):((luminance(m1)<luminance(m3))?m1:max(m2,m3));
	return res;
}
float4 PS_ChromaKey( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !maskenable ) return res;
	if ( tex2D(SamplerDepth,coord).x > maskd )
		return float4(maskr,maskg,maskb,1.0);
	return res;
}
technique PostProcess
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Paint1();
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
		PixelShader = compile ps_3_0 PS_Paint2();
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
		PixelShader = compile ps_3_0 PS_ChromaKey();
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
technique PostProcess5
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_ASCII();
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
