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
/*
   Thank you Boris for not providing access to a normal buffer. Guesswork using
   the depth buffer results in imprecise normals that aren't smoothed. Plus
   there is no way to get the normal data from textures either. Also, three
   texture fetches are needed instead of one (great!)
*/
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
float4 PS_MiscPrepass( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( sharpenable ) res.rgb = Sharpen(res.rgb,coord);
	res.rgb = DepthGrade(res.rgb,coord);
	if ( edgevenable ) res.rgb = EdgeView(res.rgb,coord);
	if ( comenable ) res.rgb = EdgeDetect(res.rgb,coord);
	if ( contenable ) res.rgb = LineView(res.rgb,coord);
	if ( fogenable ) res.rgb = Limbo(res.rgb,coord);
	return res;
}
/* this SSAO algorithm is honestly a big mess */
float4 PS_SSAOPrepass( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	float ssaofadepow = tod_ind(ssaofadepow);
	float ssaofademult = tod_ind(ssaofademult);
	if ( !ssaoenable ) return res;
	float depth = tex2D(SamplerDepth,coord).x;
	float ldepth = depthlinear(coord);
	if ( depth >= cutoff*0.000001 )
	{
		res.a = 1.0;
		return res;
	}
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float3 normal = pseudonormal(depth,coord);
	float2 nc = coord*(bresl/256.0);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*ssaoradius;
	float2 nc2 = tex2D(SamplerNoise3,nc+48000.0*Timer.x*ssaonoise).xy;
	float3 rnormal = tex2D(SamplerNoise3,nc2).xyz*2.0-1.0;
	rnormal = normalize(rnormal);
	float occ = 0.0;
	int i;
	float3 sample;
	float sdepth, so, delta;
	float sclamp = ssaoclamp/100000.0;
	float sclampmin = ssaoclampmin/100000.0;
	[loop] for ( i=0; i<64; i++ )
	{
		sample = reflect(ssao_samples[i],rnormal);
		sample *= sign(dot(normal,sample));
		so = ldepth-sample.z*bof.x;
		sdepth = depthlinear(coord+bof*sample.xy/ldepth);
		delta = saturate(so-sdepth);
		delta *= 1.0-smoothstep(0.0,sclamp,delta);
		if ( (delta > sclampmin) && (delta < sclamp) )
			occ += 1.0-delta;
	}
	float uocc = saturate(occ/64.0);
	float fade = 1.0-depth;
	uocc *= saturate(pow(max(0,fade),ssaofadepow)*ssaofademult);
	uocc = saturate(pow(max(0,uocc),ssaopow)*ssaomult+ssaobump);
	res.a = saturate(1.0-(uocc*ssaoblend));
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
	ofs *= max(tod_ind(heatfactor),0.0);
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
/*
   The blur pass uses bilateral filtering to mostly preserve borders.
   An additional factor using difference of normals was tested, but the
   performance decrease was too much, so it's gone forever.

   This has been reverted into a single pass since separable blur seems to
   cause some ugly artifacting.
*/
float4 PS_SSAOBlur( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !ssaoenable ) return res;
	if ( !ssaobenable )
	{
		if ( ssaodebug ) return saturate(res.a);
		return res*res.a;
	}
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*ssaobradius;
	float isd, sd, ds, sw, tw = 0;
	res.a = 0.0;
	int i, j;
	isd = tex2D(SamplerDepth,coord).x;
	[loop] for ( j=-7; j<=7; j++ ) [loop] for ( i=-7; i<=7; i++ )
	{
		sd = tex2D(SamplerDepth,coord+float2(i,j)*bof).x;
		ds = 1.0/pow(1.0+abs(isd-sd),ssaobfact);
		sw = ds;
		sw *= gauss8[abs(i)]*gauss8[abs(j)];
		tw += sw;
		res.a += sw*tex2D(SamplerColor,coord+float2(i,j)*bof).a;
	}
	res.a /= tw;
	if ( ssaodebug ) return saturate(res.a);
	res *= res.a;
	return res;
}
/* Focus */
float4 PS_ReadFocus( VS_OUTPUT_POST IN ) : COLOR
{
	if ( dofdisable ) return 0.0;
	if ( focuscircle < 0 ) return focusmanualvalue*0.001;
	float focusmax = tod_ind(focusmax);
	float2 fcenter = float2(focuscenter_x*0.01,focuscenter_y*0.01);
	float cfocus = min(tex2D(SamplerDepth,fcenter).x,focusmax*0.001);
	if ( focuscircle == 0 ) return cfocus;
	if ( focuscircle == 2 )
	{
		int i, j;
		float mfocus = 0.0;
		float2 px;
		[unroll] for( j=0; j<8; j++ ) [unroll] for( i=0; i<8; i++ )
		{
			px = float2((i+0.5)/8.0,(j+0.5)/8.0);
			mfocus += min(tex2D(SamplerDepth,px).x,focusmax*0.001);
		}
		return mfocus/64.0;
	}
	/* using polygons inscribed into a circle, in this case a triangle */
	float focusradius = tod_ind(focusradius);
	float focusmix = tod_ind(focusmix);
	float cstep = (1.0/3.0);
	float mfocus;
	float2 coord;
	float2 bof = float2(1.0,1.0/ScreenSize.w)*focusradius*0.01;
	float fan = focuscircleangle*2.0*pi;
	coord.x = fcenter.x+sin(fan)*bof.x;
	coord.y = fcenter.y+cos(fan)*bof.y;
	mfocus = cstep*min(tex2D(SamplerDepth,coord).x,focusmax*0.001);
	coord.x = fcenter.x+sin(fan+2.0*pi*cstep)*bof.x;
	coord.y = fcenter.y+cos(fan+2.0*pi*cstep)*bof.y;
	mfocus += cstep*min(tex2D(SamplerDepth,coord).x,focusmax*0.001);
	coord.x = fcenter.x+sin(fan+4.0*pi*cstep)*bof.x;
	coord.y = fcenter.y+cos(fan+4.0*pi*cstep)*bof.y;
	mfocus += cstep*min(tex2D(SamplerDepth,coord).x,focusmax*0.001);
	cfocus = (1.0-focusmix)*cfocus+focusmix*mfocus;
	return cfocus;
}
float4 PS_WriteFocus( VS_OUTPUT_POST IN ) : COLOR
{
	if ( dofdisable ) return 0.0;
	return max(lerp(tex2D(SamplerPrev,0.5).x,tex2D(SamplerCurr,0.5).x,
		saturate(FadeFactor)),0.0);
}
/* Depth of Field */
float4 PS_DoFPrepass( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return tex2D(SamplerColor,coord);
	float dofpow = tod_ind(dofpow);
	float dofmult = tod_ind(dofmult);
	float dofbump = tod_ind(dofbump);
	float doffixedfocuspow = tod_ind(doffixedfocuspow);
	float doffixedfocusmult = tod_ind(doffixedfocusmult);
	float doffixedfocusbump = tod_ind(doffixedfocusbump);
	float doffixedfocusblend = tod_ind(doffixedunfocusblend);
	float doffixedunfocuspow = tod_ind(doffixedunfocuspow);
	float doffixedunfocusmult = tod_ind(doffixedunfocusmult);
	float doffixedunfocusbump = tod_ind(doffixedunfocusbump);
	float doffixedunfocusblend = tod_ind(doffixedunfocusblend);
	float dep = tex2D(SamplerDepth,coord).x;
	float foc = tex2D(SamplerFocus,coord).x;
	/* cheap tilt */
	foc = foc+0.01*doftiltx*(doftiltxcenter-coord.x)
		+0.01*doftilty*(doftiltycenter-coord.y);
	float dff = abs(dep-doffixedfocusdepth);
	dff = clamp(pow(dff,doffixedfocuspow)*doffixedfocusmult
		+doffixedfocusbump,0.0,1.0);
	if ( dep > doffixedfocuscap ) dff = 1.0;
	float dfu = abs(dep-doffixedunfocusdepth);
	dfu = clamp(pow(dfu,doffixedunfocuspow)*doffixedunfocusmult
		+doffixedunfocusbump,0.0,1.0);
	if ( doffixedcut && (dep >= cutoff*0.000001) ) dfu *= 0;
	float dfc = abs(dep-foc);
	dfc = clamp(pow(dfc,dofpow)*dofmult+dofbump,0.0,1.0);
	if ( doffixedonly ) dfc *= 0;
	dfc += lerp(0.0,dfu,doffixedunfocusblend);
	dfc *= lerp(1.0,dff,doffixedfocusblend);
	dfc = saturate(dfc);
	float4 res = tex2D(SamplerColor,coord);
	res.a = dfc;
	return res;
}
/* helper code for simplifying these */
#define gcircle(x) float2(cos(x),sin(x))
float4 dofsample( float2 coord, float2 bsz, float blur, bool bDoHighlight,
	out float4 deps, out float4 dfcs )
{
	float4 res;
	float cstep = 2.0*pi*(1.0/3.0);
	float ang = 0.5*pi;
	res.r = tex2D(SamplerColor,coord+gcircle(ang)*bsz*dofpcha*0.1).r;
	deps.r = tex2D(SamplerDepth,coord+gcircle(ang)*bsz*dofpcha*0.1).x;
	dfcs.r = tex2D(SamplerColor,coord+gcircle(ang)*bsz*dofpcha*0.1).a;
	ang += cstep;
	res.g = tex2D(SamplerColor,coord+gcircle(ang)*bsz*dofpcha*0.1).g;
	deps.g = tex2D(SamplerDepth,coord+gcircle(ang)*bsz*dofpcha*0.1).x;
	dfcs.g = tex2D(SamplerColor,coord+gcircle(ang)*bsz*dofpcha*0.1).a;
	ang += cstep;
	res.b = tex2D(SamplerColor,coord+gcircle(ang)*bsz*dofpcha*0.1).b;
	deps.b = tex2D(SamplerDepth,coord+gcircle(ang)*bsz*dofpcha*0.1).x;
	dfcs.b = tex2D(SamplerColor,coord+gcircle(ang)*bsz*dofpcha*0.1).a;
	if ( bDoHighlight )
	{
		float l = luminance(res.rgb);
		float threshold = max((l-dofbthreshold)*dofbgain,0.0);
		res += lerp(0,res,threshold*blur);
	}
	res.a = tex2D(SamplerColor,coord).a;
	deps.a = tex2D(SamplerDepth,coord).x;
	dfcs.a = res.a;
	return res;
}
/* gather blur pass  */
float4 PS_DoFGather( VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return tex2D(SamplerColor,coord);
	float dfc = tex2D(SamplerColor,coord).a;
	if ( dofdebug ) return tex2D(SamplerDepth,coord).x;
	if ( dfcdebug ) return dfc;
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = 1.0/bresl;
	/*
	   Skip blurring areas that are perfectly in focus. The performance
	   gain is negligible in most cases, though.
	*/
	if ( dfc <= dofminblur ) return tex2D(SamplerColor,coord);
	float4 res = float4(0,0,0,0);
	float dep = tex2D(SamplerDepth,coord).x;
	float2 bsz = bof*dofpradius*dfc;
	float4 sc, ds, sd, sw, tw = float4(0,0,0,0);
	[unroll] for ( int i=0; i<32; i++ )
	{
		sc = dofsample(coord+poisson32[i]*bsz,bsz,dfc,dofhilite,ds,sd);
		sw.r = (ds.r>dep)?1.0:sd.r;
		sw.g = (ds.g>dep)?1.0:sd.g;
		sw.b = (ds.b>dep)?1.0:sd.b;
		sw.a = (ds.a>dep)?1.0:sd.a;
		tw += sw;
		res += sc*sw;
	}
	res /= tw;
	res.a = dfc;
	return res;
}
/* "bokeh" blur pass */
float4 PS_DoFBorkeh( VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return tex2D(SamplerColor,coord);
	float dfc = tex2D(SamplerColor,coord).a;
	if ( dofdebug ) return tex2D(SamplerDepth,coord).x;
	if ( dfcdebug ) return dfc;
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = 1.0/bresl;
	float4 res = tex2D(SamplerColor,coord);
	res.a = 0.0;
	/*
	   Skip blurring areas that are perfectly in focus. The performance
	   gain is negligible in most cases, though.
	*/
	if ( dfc <= dofminblur ) return res;
	float dep = tex2D(SamplerDepth,coord).x;
	float2 sf = bof+(tex2D(SamplerNoise3,coord*(bresl/256.0)).xy*2.0-1.0)
		*dofbnoise*0.001;
	float2 sr = sf*dofbradius*dfc;
	int rsamples;
	float bstep, bw;
	float4 sc, ds, sd, sw, tw = float4(1,1,1,1);
	float2 rcoord;
	#define dofbrings 7
	#define dofbsamples 3
	[unroll] for ( int i=1; i<=dofbrings; i++ )
	{
		rsamples = i*dofbsamples;
		[unroll] for ( int j=0; j<rsamples; j++ )
		{
			bstep = pi*2.0/(float)rsamples;
			rcoord = gcircle(j*bstep)*i;
			bw = lerp(1.0,(float)i/(float)dofbrings,dofbbias);
			sc = dofsample(coord+rcoord*sr,sr*i,dfc,dofhilite,ds,sd);
			sw.r = (ds.r>dep)?1.0:sd.r;
			sw.g = (ds.g>dep)?1.0:sd.g;
			sw.b = (ds.b>dep)?1.0:sd.b;
			sw.a = (ds.a>dep)?1.0:sd.a;
			res += sc*sw*bw;
			tw += sw*bw;
		}
	}
	res /= tw;
	res.a = dfc;
	return res;
}
float4 PS_DoFPostBlur( VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return tex2D(SamplerColor,coord);
	float dfc = tex2D(SamplerColor,coord).a;
	if ( dofdebug ) return tex2D(SamplerDepth,coord).x;
	if ( dfcdebug ) return dfc;
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = (1.0/bresl)*dofpbradius;
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
	float4 res = tex2D(SamplerColor,coord);
	if ( !dofpostblur ) return float4(res.rgb,1.0);
	int i;
	[unroll] for ( i=0; i<16; i++ )
		res += tex2D(SamplerColor,coord+ofs[i]*bof*dfc);
	res /= 17.0;
	res.a = 1.0;
	return res;
}
/* focus point debug */
float4 PS_FocusDebug( VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !focusdisplay || (focuscircle < 0) ) return res;
	if ( focuscircle == 2 )
	{
		int i, j;
		float2 px;
		[unroll] for( j=0; j<8; j++ ) [unroll] for( i=0; i<8; i++ )
		{
			px = float2((i+0.5)/8.0,(j+0.5)/8.0);
			if ( distance(coord,px) < 0.005 )
				res.rgb = float3(1,0,0);
		}
		return res;
	}
	float2 fcenter = float2(focuscenter_x*0.01,focuscenter_y*0.01);
	if ( distance(coord,fcenter) < 0.005 ) res.rgb = float3(1,0,0);
	if ( focuscircle == 0 ) return res;
	float cstep = (1.0/3.0);
	float2 tcoord;
	float focusradius = tod_ind(focusradius);
	float2 bof = float2(1.0,1.0/ScreenSize.w)*focusradius*0.01;
	float fan = focuscircleangle*2.0*pi;
	tcoord.x = fcenter.x+sin(fan)*bof.x;
	tcoord.y = fcenter.y+cos(fan)*bof.y;
	if ( distance(coord,tcoord) < 0.005 ) res.rgb = float3(1,0,0);
	tcoord.x = fcenter.x+sin(fan+2.0*pi*cstep)*bof.x;
	tcoord.y = fcenter.y+cos(fan+2.0*pi*cstep)*bof.y;
	if ( distance(coord,tcoord) < 0.005 ) res.rgb = float3(1,0,0);
	tcoord.x = fcenter.x+sin(fan+4.0*pi*cstep)*bof.x;
	tcoord.y = fcenter.y+cos(fan+4.0*pi*cstep)*bof.y;
	if ( distance(coord,tcoord) < 0.005 ) res.rgb = float3(1,0,0);
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
		PixelShader = compile ps_3_0 PS_MiscPrepass();
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
		PixelShader = compile ps_3_0 PS_SSAOPrepass();
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
technique PostProcess4
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_SSAOBlur();
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
		PixelShader = compile ps_3_0 PS_DoFPrepass();
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
		PixelShader = compile ps_3_0 PS_DoFGather();
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
		PixelShader = compile ps_3_0 PS_DoFPostBlur();
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
		PixelShader = compile ps_3_0 PS_FocusDebug();
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

technique PostProcessB <string UIName="Bokeh DOF";>
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_MiscPrepass();
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
technique PostProcessB2
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_SSAOPrepass();
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
technique PostProcessB3
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
technique PostProcessB4
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_SSAOBlur();
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
technique PostProcessB5
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_DoFPrepass();
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
technique PostProcessB6
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_DoFBorkeh();
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
technique PostProcessB7
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_DoFPostBlur();
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
technique PostProcessB8
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_FocusDebug();
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