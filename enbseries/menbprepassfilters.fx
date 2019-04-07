/*
	menbprepassfilters.fx : MariENB prepass shader routines.
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
/* helper functions */
/* photometric */
#define luminance(x) dot(x,float3(0.2126,0.7152,0.0722))
/* CCIR601 */
//#define luminance(x) dot(x,float3(0.299,0.587,0.114))
/* these are znear/zfar values for Skyrim, but MAY match Fallout too */
float depthlinear( float2 coord )
{
	float z = tex2D(SamplerDepth,coord).x;
	return (2*zNear)/(zFar+zNear-z*(zFar-zNear));
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
/* New and improved edge detection, for contour shading */
float3 Edge( float3 res, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	if ( fixedx>0 ) bresl.x = fixedx;
	if ( fixedy>0 ) bresl.y = fixedy;
	float edgefadepow = lerp(lerp(edgefadepow_n,edgefadepow_d,tod),
		lerp(edgefadepow_in,edgefadepow_id,tod),ind);
	float edgefademult = lerp(lerp(edgefademult_n,edgefademult_d,tod),
		lerp(edgefademult_in,edgefademult_id,tod),ind);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*edgeradius;
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
	if ( abs(cont-dep) > (edgethreshold*0.00001) ) mud = 1.0;
	float fade = 1.0-tex2D(SamplerDepth,coord).x;
	mud *= saturate(pow(fade,edgefadepow)*edgefademult);
	mud = saturate(pow(mud,edgepow)*edgemult);
	if ( edgedebug ) return 1.0-mud;
	return lerp(res,0,mud);
}
/* Secondary "comicbook filter" for additional contour shading */
float3 EdgeColor( float3 res, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	if ( fixedx>0 ) bresl.x = fixedx;
	if ( fixedy>0 ) bresl.y = fixedy;
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*celradius;
	float3 col = tex2D(SamplerColor,coord).rgb;
	float lum = luminance(col);
	float3 ccol = tex2D(SamplerColor,coord+float2(-1,-1)*bof).rgb;
	ccol += tex2D(SamplerColor,coord+float2(0,-1)*bof).rgb;
	ccol += tex2D(SamplerColor,coord+float2(1,-1)*bof).rgb;
	ccol += tex2D(SamplerColor,coord+float2(-1,0)*bof).rgb;
	ccol += tex2D(SamplerColor,coord+float2(1,0)*bof).rgb;
	ccol += tex2D(SamplerColor,coord+float2(-1,1)*bof).rgb;
	ccol += tex2D(SamplerColor,coord+float2(0,1)*bof).rgb;
	ccol += tex2D(SamplerColor,coord+float2(1,1)*bof).rgb;
	ccol /= 8.0;
	float clum = luminance(ccol);
	float mud = abs(clum-lum);
	mud = saturate(pow(mud,celpow)*celmult);
	if ( celdebug ) return 1.0-mud;
	return lerp(res,0,mud);
}
/* old Edgevision mode */
float3 EdgeView( float3 res, float2 coord )
{
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	if ( fixedx>0 ) bresl.x = fixedx;
	if ( fixedy>0 ) bresl.y = fixedy;
	float edgevfadepow = lerp(lerp(edgevfadepow_n,edgevfadepow_d,tod),
		lerp(edgevfadepow_in,edgevfadepow_id,tod),ind);
	float edgevfademult = lerp(lerp(edgevfademult_n,edgevfademult_d,tod),
		lerp(edgevfademult_in,edgevfademult_id,tod),ind);
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
	mud *= saturate(pow(fade,edgevfadepow)*edgevfademult);
	mud = saturate(pow(mud,edgevpow)*edgevmult);
	return mud;
}
/* the pass that happens before everything else */
float4 PS_FirstPass( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( sharpenable ) res.rgb = Sharpen(res.rgb,coord);
	if ( edgeenable ) res.rgb = Edge(res.rgb,coord);
	if ( celenable ) res.rgb = EdgeColor(res.rgb,coord);
	if ( edgevenable ) res.rgb = EdgeView(res.rgb,coord);
	return res;
}
/*
   Thank you Boris for not providing access to a normal buffer. Guesswork using
   the depth buffer results in imprecise normals that aren't smoothed.
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
/* get occlusion using single-pass single-step Ray Marching with 64 samples */
float4 PS_SSAOPrepass( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	float ssaofadepow = lerp(lerp(ssaofadepow_n,ssaofadepow_d,tod),
		lerp(ssaofadepow_in,ssaofadepow_id,tod),ind);
	float ssaofademult = lerp(lerp(ssaofademult_n,ssaofademult_d,tod),
		lerp(ssaofademult_in,ssaofademult_id,tod),ind);
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
	normal = normalize(normal);
	float occ = 0.0;
	int i;
	float3 sample;
	float sdepth, so, delta;
	float sclamp = ssaoclamp/1000.0;
	if ( ssaoquarter ) [unroll] for ( i=0; i<16; i++ )
	{
		sample = reflect(ssao_samples_lq[i],rnormal);
		sample *= sign(dot(normal,sample));
		so = ldepth-sample.z*bof;
		sdepth = depthlinear(coord+bof*sample.xy/ldepth);
		delta = saturate(so-sdepth);
		delta *= 1.0-smoothstep(0.0,sclamp,delta);
		if ( (delta > 0.0) && (delta < sclamp) ) occ += 1.0-delta;
	}
	else [unroll] for ( i=0; i<64; i++ )
	{
		sample = reflect(ssao_samples_hq[i],rnormal);
		sample *= sign(dot(normal,sample));
		so = ldepth-sample.z*bof;
		sdepth = depthlinear(coord+bof*sample.xy/ldepth);
		delta = saturate(so-sdepth);
		delta *= 1.0-smoothstep(0.0,sclamp,delta);
		if ( (delta > 0.0) && (delta < sclamp) ) occ += 1.0-delta;
	}
	float uocc = saturate(occ/(ssaoquarter?16.0:64.0));
	float fade = 1.0-depth;
	uocc *= saturate(pow(fade,ssaofadepow)*ssaofademult);
	uocc = saturate(pow(uocc,ssaopow)*ssaomult);
	res.a = saturate(1.0-(uocc*ssaoblend));
	return res;
}
/* the blur passes use bilateral filtering to mostly preserve borders */
float4 PS_SSAOBlurH( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !ssaoenable ) return res;
	if ( !ssaobenable ) return res;
	float bresl = ScreenSize.x;
	float bof = (1.0/bresl)*ssaobradius;
	float isd, sd, ds, sw, tw = 0;
	res.a = 0.0;
	int i;
	isd = tex2D(SamplerDepth,coord).x;
	[unroll] for ( i=-15; i<=15; i++ )
	{
		sd = tex2D(SamplerDepth,coord+float2(i,0)*bof).x;
		ds = abs(isd-sd)*ssaobfact+0.5;
		sw = 1.0/(ds+1.0);
		sw *= gauss16[abs(i)];
		tw += sw;
		res.a += sw*tex2D(SamplerColor,coord+float2(i,0)*bof).a;
	}
	res.a /= tw;
	return res;
}
float4 PS_SSAOBlurV( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( !ssaoenable ) return res;
	if ( !ssaobenable )
	{
		if ( ssaodebug ) return saturate(res.a);
		return res*res.a;
	}
	float bresl = ScreenSize.x*ScreenSize.w;
	float bof = (1.0/bresl)*ssaobradius;
	float isd, sd, ds, sw, tw = 0;
	res.a = 0.0;
	int i;
	isd = tex2D(SamplerDepth,coord).x;
	[unroll] for ( i=-15; i<=15; i++ )
	{
		sd = tex2D(SamplerDepth,coord+float2(0,i)*bof).x;
		ds = abs(isd-sd)*ssaobfact+0.5;
		sw = 1.0/(ds+1.0);
		sw *= gauss16[abs(i)];
		tw += sw;
		res.a += sw*tex2D(SamplerColor,coord+float2(0,i)*bof).a;
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
	if ( focusmanual ) return focusmanualvalue;
	float focusmax = lerp(lerp(focusmax_n,focusmax_d,tod),lerp(focusmax_in,
		focusmax_id,tod),ind);
	float2 fcenter = float2(focuscenter_x,focuscenter_y);
	float cfocus = min(tex2D(SamplerDepth,fcenter).x,focusmax*0.001);
	if ( !focuscircle ) return cfocus;
	/* using polygons inscribed into a circle, in this case a triangle */
	float focusradius = lerp(lerp(focusradius_n,focusradius_d,tod),
		lerp(focusradius_in,focusradius_id,tod),ind);
	float focusmix = lerp(lerp(focusmix_n,focusmix_d,tod),lerp(focusmix_in,
		focusmix_id,tod),ind);
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
	float dofpow = lerp(lerp(dofpow_n,dofpow_d,tod),lerp(dofpow_in,
		dofpow_id,tod),ind);
	float dofmult = lerp(lerp(dofmult_n,dofmult_d,tod),lerp(dofmult_in,
		dofmult_id,tod),ind);
	float dofbump = lerp(lerp(dofbump_n,dofbump_d,tod),lerp(dofbump_in,
		dofbump_id,tod),ind);
	float doffixedfocuspow = lerp(lerp(doffixedfocuspow_n,
		doffixedfocuspow_d,tod),lerp(doffixedfocuspow_in,
		doffixedfocuspow_id,tod),ind);
	float doffixedfocusmult = lerp(lerp(doffixedfocusmult_n,
		doffixedfocusmult_d,tod),lerp(doffixedfocusmult_in,
		doffixedfocusmult_id,tod),ind);
	float doffixedfocusbump = lerp(lerp(doffixedfocusbump_n,
		doffixedfocusbump_d,tod),lerp(doffixedfocusbump_in,
		doffixedfocusbump_id,tod),ind);
	float doffixedfocusblend = lerp(lerp(doffixedfocusblend_n,
		doffixedfocusblend_d,tod),lerp(doffixedfocusblend_in,
		doffixedfocusblend_id,tod),ind);
	float doffixedunfocuspow = lerp(lerp(doffixedunfocuspow_n,
		doffixedunfocuspow_d,tod),lerp(doffixedunfocuspow_in,
		doffixedunfocuspow_id,tod),ind);
	float doffixedunfocusmult = lerp(lerp(doffixedunfocusmult_n,
		doffixedunfocusmult_d,tod),lerp(doffixedunfocusmult_in,
		doffixedunfocusmult_id,tod),ind);
	float doffixedunfocusbump = lerp(lerp(doffixedunfocusbump_n,
		doffixedunfocusbump_d,tod),lerp(doffixedunfocusbump_in,
		doffixedunfocusbump_id,tod),ind);
	float doffixedunfocusblend = lerp(lerp(doffixedunfocusblend_n,
		doffixedunfocusblend_d,tod),lerp(doffixedunfocusblend_in,
		doffixedunfocusblend_id,tod),ind);
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y);
	float dep = tex2D(SamplerDepth,coord).x;
	float foc = tex2D(SamplerFocus,coord).x;
	float dfc = abs(dep-foc);
	float dff = abs(dep);
	float dfu = dff;
	if ( doffixedcut && (dep >= cutoff*0.000001) ) dfu *= 0;
	/*
	   Change power of dof based on field of view. Works only in Skyrim,
	   Boris is just such a fucking assbutt that he doesn't update the
	   FO3/FNV version to be feature-equal to this, inventing pathetic
	   excuses. The FieldOfView variable seems to hold bogus values in
	   Fallout completely unrelated to actual FOV (yes, I checked if it's
	   in radians, and no, it isn't). The value appears to be 1.134452.
	   I'll try to investigate its origins someday.
	*/
	if ( dofrelfov )
	{
		float relfovfactor = lerp(lerp(relfovfactor_n,relfovfactor_d,
			tod),lerp(relfovfactor_in,relfovfactor_id,tod),ind);
		float relfov = (FieldOfView-fovdefault)/fovdefault;
		dofpow = max(0,dofpow+relfov*relfovfactor);
	}
	dfc = clamp(pow(dfc,dofpow)*dofmult+dofbump,0.0,1.0);
	dff = clamp(pow(dff,doffixedfocuspow)*doffixedfocusmult
		+doffixedfocusbump,0.0,1.0);
	dfu = clamp(pow(dfu,doffixedunfocuspow)*doffixedunfocusmult
		+doffixedunfocusbump,0.0,1.0);
	dfc *= lerp(1.0,dff,doffixedfocusblend);
	dfc += lerp(0.0,dfu,doffixedunfocusblend);
	dfc = saturate(dfc);
	float4 res = tex2D(SamplerColor,coord);
	res.a = dfc;
	return res;
}
/*
   This method skips blurring areas that are perfectly in focus. The
   performance gain is negligible in most cases, though. It also provides the
   option to use or NOT use bilateral filtering. Which I'll probably remove
   soon because no bilateral filtering is pointless.
*/
float4 PS_DoFBlurH( VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return tex2D(SamplerColor,coord);
	float dfc = tex2D(SamplerColor,coord).a;
	if ( dofdebug ) return tex2D(SamplerDepth,coord).x;
	if ( dfcdebug ) return dfc;
	float bresl = (fixedx>0)?fixedx:ScreenSize.x;
	float bof = (1.0/bresl)*dofbradius;
	float4 res = float4(0,0,0,0);
	if ( dfc <= 0.0 )
	{
		res = tex2D(SamplerColor,coord);
		res.a = dfc;
		return res;
	}
	int i;
	if ( dofbilateral )
	{
		float isd, sd, ds, sw, tw = 0;
		isd = dfc;
		[unroll] for ( i=-7; i<=7; i++ )
		{
			sd = tex2D(SamplerColor,coord+float2(i,0)*bof*dfc).a;
			ds = abs(isd-sd)*dofbfact+0.5;
			sw = 1.0/(ds+1.0);
			sw *= gauss8[abs(i)];
			tw += sw;
			res += sw*tex2D(SamplerColor,coord+float2(i,0)*bof
				*dfc);
		}
		res /= tw;
	}
	else
	{
		[unroll] for ( i=-7; i<=7; i++ )
			res += gauss8[abs(i)]*tex2D(SamplerColor,coord
				+float2(i,0)*bof*dfc);
	}
	res.a = dfc;
	return res;
}
float4 PS_DoFBlurV( VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2 coord = IN.txcoord.xy;
	if ( dofdisable ) return tex2D(SamplerColor,coord);
	float dfc = tex2D(SamplerColor,coord).a;
	if ( dofdebug ) return tex2D(SamplerDepth,coord).x;
	if ( dfcdebug ) return dfc;
	float bresl = (fixedy>0)?fixedy:(ScreenSize.x*ScreenSize.w);
	float bof = (1.0/bresl)*dofbradius;
	float4 res = float4(0,0,0,0);
	if ( dfc <= 0.0 )
	{
		res = tex2D(SamplerColor,coord);
		res.a = dfc;
		return res;
	}
	int i;
	if ( dofbilateral )
	{
		float isd, sd, ds, sw, tw = 0;
		isd = dfc;
		[unroll] for ( i=-7; i<=7; i++ )
		{
			sd = tex2D(SamplerColor,coord+float2(0,i)*bof*dfc).a;
			ds = abs(isd-sd)*dofbfact+0.5;
			sw = 1.0/(ds+1.0);
			sw *= gauss8[abs(i)];
			tw += sw;
			res += sw*tex2D(SamplerColor,coord+float2(0,i)*bof
				*dfc);
		}
		res /= tw;
	}
	else
	{
		[unroll] for ( i=-7; i<=7; i++ )
			res += gauss8[abs(i)]*tex2D(SamplerColor,coord
				+float2(0,i)*bof*dfc);
	}
	res.a = 1.0;
	return res;
}
/*
   Underwater distortion, which currently has no real use due to Boris being
   lazy. fWaterLevel doesn't yet provide any usable values.
*/
float2 UnderwaterDistort( float2 coord )
{
	float2 ofs = float2(0.0,0.0);
	float siny = sin(pi*2.0*(coord.y*uwm1+Timer.x*uwf1*100.0))*uws1;
	ofs.y = siny+sin(pi*2.0*(coord.x*uwm2+Timer.x*uwf2*100.0))*uws2;
	ofs.x = siny+sin(pi*2.0*(coord.x*uwm3+Timer.x*uwf3*100.0))*uws3;
	ofs -= (coord-0.5)*2.0*uwz;
	return coord+ofs*0.01;
}
/*
   Distant hot air refraction. Not very realistic, but does the job. Currently
   it isn't fully depth-aware, so you'll see that close objects get distorted
   around their borders.
*/
float2 DistantHeat( float2 coord )
{
	float2 bresl;
	float dep, odep;
	dep = tex2D(SamplerDepth,coord).x;
	float distfade = clamp(pow(dep,heatfadepow)*heatfademul+heatfadebump,
		0.0,1.0);
	if ( distfade <= 0.0 ) return coord;
	float todpow = pow(tod*(1.0-ind),heattodpow);
	if ( !heatalways && (todpow <= 0.0) ) return coord;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 nc = coord*(bresl/256.0)*heatsize;
	float2 ts = float2(0.01,1.0)*Timer.x*10000.0*heatspeed;
	float2 ofs = tex2D(SamplerHeat,nc+ts).xy;
	ofs = (ofs-0.5)*2.0;
	ofs *= pow(length(ofs),heatpow);
	if ( !heatalways ) ofs *= todpow;
	odep = tex2D(SamplerDepth,coord+ofs*heatstrength*distfade*0.01).x;
	float odistfade = clamp(pow(odep,heatfadepow)*heatfademul+heatfadebump,
		0.0,1.0);
	if ( odistfade <= 0.0 ) return coord;
	return coord+ofs*heatstrength*distfade*0.01;
}
/* The pass that happens after everything else */
float4 PS_LastPass( VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float2 ofs = coord;
	if ( waterenable ) ofs = UnderwaterDistort(ofs);
	if ( heatenable ) ofs = DistantHeat(ofs);
	ofs -= coord;
	float4 res;
	if ( distcha != 0.0 )
	{
		float2 ofr, ofg, ofb;
		ofr = ofs*(1.0-distcha*0.01);
		ofg = ofs;
		ofb = ofs*(1.0+distcha*0.01);
		res = float4(tex2D(SamplerColor,coord+ofr).r,
			tex2D(SamplerColor,coord+ofg).g,
			tex2D(SamplerColor,coord+ofb).b,1.0);
	}
	else res = tex2D(SamplerColor,coord+ofs);
	if ( !focusdisplay ) return res;
	/* put red dots where focus points are */
	float2 fcenter = float2(focuscenter_x,focuscenter_y);
	if ( distance(coord,fcenter) < 0.01 ) res.rgb = float3(1,0,0);
	float cstep = (1.0/3.0);
	float2 tcoord;
	float focusradius = lerp(lerp(focusradius_n,focusradius_d,tod),
		lerp(focusradius_in,focusradius_id,tod),ind);
	float2 bof = float2(1.0,1.0/ScreenSize.w)*focusradius*0.01;
	float fan = focuscircleangle*2.0*pi;
	tcoord.x = fcenter.x+sin(fan)*bof.x;
	tcoord.y = fcenter.y+cos(fan)*bof.y;
	if ( distance(coord,tcoord) < 0.01 ) res.rgb = float3(1,0,0);
	tcoord.x = fcenter.x+sin(fan+2.0*pi*cstep)*bof.x;
	tcoord.y = fcenter.y+cos(fan+2.0*pi*cstep)*bof.y;
	if ( distance(coord,tcoord) < 0.01 ) res.rgb = float3(1,0,0);
	tcoord.x = fcenter.x+sin(fan+4.0*pi*cstep)*bof.x;
	tcoord.y = fcenter.y+cos(fan+4.0*pi*cstep)*bof.y;
	if ( distance(coord,tcoord) < 0.01 ) res.rgb = float3(1,0,0);
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
		PixelShader = compile ps_3_0 PS_FirstPass();
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
		PixelShader = compile ps_3_0 PS_SSAOBlurH();
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
		PixelShader = compile ps_3_0 PS_SSAOBlurV();
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
		PixelShader = compile ps_3_0 PS_DoFBlurH();
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
		PixelShader = compile ps_3_0 PS_DoFBlurV();
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
		PixelShader = compile ps_3_0 PS_LastPass();
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
