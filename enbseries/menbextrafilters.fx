/*
	menbextrafilters.fx : MariENB extra shader routines.
	(C)2013-2016 Marisa Kirisame, UnSX Team.
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
	hsv.y = clamp(hsv.y*bsaturation,0.0,1.0);
	hsv.z = pow(max(0,hsv.z),bgamma);
	col.rgb = hsv2rgb(saturate(hsv));
	if ( dither == 0 )
		col += bdbump+checkers[int(coord.x%2)+2*int(coord.y%2)]*bdmult;
	else if ( dither == 1 )
		col += bdbump+ordered2[int(coord.x%2)+2*int(coord.y%2)]*bdmult;
	else if ( dither == 2 )
		col += bdbump+ordered8[int(coord.x%8)+8*int(coord.y%8)]*bdmult;
	col = saturate(col);
	return col;
}
/*
   CGA had seven graphic modes (320x200 modes have low/high contrast versions):
    - 640x200 monochrome, which doesn't really need a palette here, as it can
	  be done procedurally with minimum effort.
	- 320x200 black/cyan/magenta/white
	- 320x200 black/green/red/brown
	- 320x200 black/cyan/red/white
*/
float4 ReduceCGA( in float4 color, in float2 coord )
{
	float4 dac = clamp(ReducePrepass(color,coord),0.02,0.98);
	float2 lc = float2((dac.r+cgapal)/7.0,
		dac.g/64.0+floor(dac.b*64.0)/64.0);
	return tex2D(SamplerCGA,lc);
}
/*
   EGA technically only had a fixed 16-colour palette, but when VGA came out,
   it was possible to tweak the DAC, allowing for custom palettes.
   AOS EGA is a palette based on my terminal colour scheme on Linux, which I
   also use for AliceOS.
*/
float4 ReduceEGA( in float4 color, in float2 coord )
{
	float4 dac = clamp(ReducePrepass(color,coord),0.02,0.98);
	float2 lc = float2((dac.r+egapal)/2.0,
		dac.g/64.0+floor(dac.b*64.0)/64.0);
	return tex2D(SamplerEGA,lc);
}
/* A two bits per channel mode that can usually fit VGA mode 13h and mode x */
float4 ReduceRGB2( in float4 color, in float2 coord )
{
	float4 dac = ReducePrepass(color,coord);
	color.rgb = trunc(dac.rgb*4.0)/4.0;
	return color;
}
/*
   The classic 16-bit colour mode everyone from my generation would remember,
   especially that subtle green tint and the banding due to lack of dithering
   in most games and GPUs at that time.
*/
float4 ReduceRGB565( in float4 color, in float2 coord )
{
	float4 dac = ReducePrepass(color,coord);
	color.rgb = trunc(dac.rgb*float3(32.0,64.0,32.0))
		/float3(32.0,64.0,32.0);
	return color;
}
/* Various VGA 256-colour palettes: Doom, Quake I, and the standard. */
float4 ReduceVGA( in float4 color, in float2 coord )
{
	float4 dac = clamp(ReducePrepass(color,coord),0.02,0.98);
	float2 lc = float2((dac.r+vgapal)/15.0,
		dac.g/64.0+floor(dac.b*64.0)/64.0);
	return tex2D(SamplerVGA,lc);
}
/* Retro rockets */
float4 PS_Retro( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColorb,coord);
	if ( !useblock ) return res;
	float2 rresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float4 tcol;
	float2 bresl = rresl;
	if ( bresx <= 0 || bresy <= 0 ) bresl = rresl;
	else
	{
		if ( bresx <= 1.0 ) bresl.x = rresl.x*bresx;
		else bresl.x = bresx;
		if ( bresy <= 1.0 ) bresl.y = rresl.y*bresy;
		else bresl.y = bresy;
	}
	float2 ncoord = (coord-0.5)+0.5;
	ncoord = floor(ncoord*bresl)/bresl;
	ncoord += 0.5/bresl;
	if ( bresx <= 0 || bresy <= 0 ) ncoord = coord;
	tcol = tex2D(SamplerColorb,ncoord);
	if ( paltype == 0 ) res = ReduceCGA(tcol,coord*bresl);
	else if ( paltype == 1 ) res = ReduceEGA(tcol,coord*bresl);
	else if ( paltype == 2 ) res = ReduceRGB2(tcol,coord*bresl);
	else if ( paltype == 3 ) res = ReduceVGA(tcol,coord*bresl);
	else if ( paltype == 4 ) res = ReduceRGB565(tcol,coord*bresl);
	else res = tcol;
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
	/*
	   Here I use the "cheap" method, based on the overall luminance of
	   each glyph, rather than attempt to search for the best fitting glyph
	   for each cell. If you want to know why, take a look at the ASCII
	   filter bundled with the Dolphin emulator, and be prepared for the
	   resulting seconds per frame it runs at. The calculations needed for
	   such a filter are completely insane even for the highest-end GPUs.
	*/
	float3 col = tex2D(SamplerColor,floor(bscl*coord)/bscl).rgb;
	int lum = clamp(luminance(col)*FONT_LEVELS,0,FONT_LEVELS);
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
float4 PS_ChromaKey( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !maskenable ) return res;
	float dep = tex2D(SamplerDepth,coord).x;
	float msd = maskd;
	msd = maskd+0.01*masktiltx*(masktiltxcenter-coord.x)
		+0.01*masktilty*(masktiltycenter-coord.y);
	if ( dep > msd )
		return float4(maskr,maskg,maskb,1.0);
	return res;
}
/* 2x2 RGBI dot matrix, not even close to anything that exists IRL but meh */
float4 PS_DotMatrix( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !dotenable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	bresl.xy *= 1.0/(dotsize*2.0);
	float4 dac = float4(res.r*0.5,res.g*0.5,res.b*0.5,
		(res.r+res.g+res.b)/6.0);
	/*
	   There are two types of CRTs: aperture grille and shadow mask.
	   The former is blurry and has scanlines (rather big ones, even), but
	   is cheap to emulate; while the latter is the one most known for its
	   crisp, square pixels with minimal distortion. Most individuals into
	   this whole "retro graphics" stuff prefer aperture grille, which
	   looks like shit, then again, that's the sort of visual quality they
	   want. The main issue with shadow mask CRTs is that it's impossible
	   to accurately emulate them unless done on a screen with a HUGE
	   resolution. After all, the subpixels need to be clearly visible, and
	   if on top of it you add curvature distortion, you need to reduce
	   moire patterns that will inevitably show up at low resolutions.
	   
	   It would be more desirable to eventually have flat panels that can
	   display arbitrary resolutions using a form of scaling that preserves
	   square pixels with unnoticeable distortion (typically, with nearest
	   neighbour you'd get some pixels that are bigger/smaller than others
	   if the upscale resolution isn't an integer multiple of the real
	   resolution.
	   
	   This 2x2 RGBI thing is a rather naïve filter I made many years ago,
	   it looks unlike any real CRT, but scales well. Its only problem is
	   moire patterns when using the default size of 2x2.
	*/
	float4 dots = tex2D(SamplerDots,coord*bresl)*dac;
	float3 tcol = pow(max(0,dots.rgb+dots.a),dotpow)*dotmult;
	res.rgb = res.rgb*(1-dotblend)+tcol*dotblend;
	return res;
}
/* that's right, CRT curvature */
float4 PS_Curvature( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !curveenable ) return res;
	float3 eta = float3(1+chromaab*0.009,1+chromaab*0.006,1+chromaab
		*0.003);
	float2 center = float2(coord.x-0.5,coord.y-0.5);
	float zfact = 100.0/lenszoom;
	float r2 = center.x*center.x+center.y*center.y;
	float f = 1+r2*lensdist*0.01;
	float x = f*zfact*center.x+0.5;
	float y = f*zfact*center.y+0.5;
	float2 rcoord = (f*eta.r)*zfact*(center.xy*0.5)+0.5;
	float2 gcoord = (f*eta.g)*zfact*(center.xy*0.5)+0.5;
	float2 bcoord = (f*eta.b)*zfact*(center.xy*0.5)+0.5;
	int i,j;
	float3 idist = float3(tex2D(SamplerColorb,rcoord).r,
		tex2D(SamplerColorb,gcoord).g,
		tex2D(SamplerColorb,bcoord).b);
	res.rgb = idist.rgb;
	return res;
}
/* Why am I doing this */
float4 PS_Blur( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !bssblurenable ) return res;
	float2 ofs[16] =
	{
		float2(1.0,1.0), float2(-1.0,-1.0),
		float2(-1.0,1.0), float2(1.0,-1.0),
		
		float2(1.0,0.0), float2(-1.0,0.0),
		float2(0.0,1.0), float2(0.0,-1.0),
		
		float2(1.41,0.0), float2(-1.41,0.0),
		float2(0.0,1.41), float2(0.0,-1.41),
		
		float2(1.41,1.41), float2(-1.41,-1.41),
		float2(-1.41,1.41), float2(1.41,-1.41)
	};
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*bssblurradius;
	int i;
	[unroll] for ( i=0; i<16; i++ )
		res += tex2D(SamplerColor,coord+ofs[i]*bof);
	res /= 17.0;
	res.a = 1.0;
	return res;
}
float4 PS_Sharp( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !bsssharpenable ) return res;
	float2 ofs[8] =
	{
		float2(1.0,1.0), float2(-1.0,-1.0),
		float2(-1.0,1.0), float2(1.0,-1.0),
		
		float2(1.41,1.41), float2(-1.41,-1.41),
		float2(-1.41,1.41), float2(1.41,-1.41)
	};
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*bsssharpradius;
	float4 tcol = res;
	int i;
	[unroll] for ( i=0; i<8; i++ )
		tcol += tex2D(SamplerColor,coord+ofs[i]*bof);
	tcol /= 9.0;
	float4 orig = res;
	res = orig*(1.0+dot(orig.rgb-tcol.rgb,0.333333)*bsssharpamount);
	float rg = clamp(pow(orig.b,3.0),0.0,1.0);
	res = lerp(res,orig,rg);
	res.a = 1.0;
	return res;
}
float4 PS_Shift( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !bssshiftenable ) return res;
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*bssshiftradius;
	res.g = tex2D(SamplerColor,coord).g;
	res.r = tex2D(SamplerColor,coord+float2(0,-bof.y)).r;
	res.b = tex2D(SamplerColor,coord+float2(0,bof.y)).b;
	res.a = 1.0;
	return res;
}
/*
   Extra ideas:
    - Bring back depth-relative colour grading
    - Try to resurrect oil filter
    - Provide an alternate, smaller font for ASCII filter (miniwi seems like
      a good candidate, since it's 4x8)
    - [Enhancement] Separate extra filters into different "batches" to get over
      the "8 technique limit" (if it's still a thing in current ENB).
    - More palettes?
*/
technique PostProcess
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Blur();
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
		PixelShader = compile ps_3_0 PS_Sharp();
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
		PixelShader = compile ps_3_0 PS_Shift();
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
technique PostProcess5
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
technique PostProcess6
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
technique PostProcess7
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_DotMatrix();
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
technique PostProcess8
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Curvature();
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
