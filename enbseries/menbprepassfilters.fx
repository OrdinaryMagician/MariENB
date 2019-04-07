/*
	menbprepassfilters.fx : MariENB prepass shader routines.
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
	mud *= saturate(pow(max(0,fade),edgevfadepow)*edgevfademult);
	mud = saturate(pow(max(0,mud),edgevpow)*edgevmult);
	return mud;
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
/* Squeezed in are Edgevision and Sharpen and ssao prepass */
float4 PS_EdgePlusSSAOPrepass( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float4 res = tex2D(SamplerColor,coord);
	if ( sharpenable ) res.rgb = Sharpen(res.rgb,coord);
	if ( edgevenable ) res.rgb = EdgeView(res.rgb,coord);
	/* get occlusion using single-step Ray Marching with 64 samples */
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
	if ( ssaoquarter ) [unroll] for ( i=0; i<16; i++ )
	{
		sample = reflect(ssao_samples_lq[i],rnormal);
		sample *= sign(dot(normal,sample));
		so = ldepth-sample.z*bof.x;
		sdepth = depthlinear(coord+bof*sample.xy/ldepth);
		delta = saturate(so-sdepth);
		delta *= 1.0-smoothstep(0.0,sclamp,delta);
		if ( (delta > sclampmin) && (delta < sclamp) )
			occ += 1.0-delta;
	}
	else [unroll] for ( i=0; i<64; i++ )
	{
		sample = reflect(ssao_samples_hq[i],rnormal);
		sample *= sign(dot(normal,sample));
		so = ldepth-sample.z*bof.x;
		sdepth = depthlinear(coord+bof*sample.xy/ldepth);
		delta = saturate(so-sdepth);
		delta *= 1.0-smoothstep(0.0,sclamp,delta);
		if ( (delta > sclampmin) && (delta < sclamp) )
			occ += 1.0-delta;
	}
	float uocc = saturate(occ/(ssaoquarter?16.0:64.0));
	float fade = 1.0-depth;
	uocc *= saturate(pow(max(0,fade),ssaofadepow)*ssaofademult);
	uocc = saturate(pow(max(0,uocc),ssaopow)*ssaomult);
	res.a = saturate(1.0-(uocc*ssaoblend));
	return res;
}
/*
   Underwater distortion, which currently has no real use due to Boris being
   lazy. fWaterLevel doesn't yet provide any usable values.
*/
float2 UnderwaterDistort( float2 coord )
{
	if ( !wateralways ) return coord;
	float2 ofs = float2(0.0,0.0);
	float siny = sin(pi*2.0*(coord.y*uwm1+Timer.x*uwf1*100.0))*uws1;
	ofs.y = siny+sin(pi*2.0*(coord.x*uwm2+Timer.x*uwf2*100.0))*uws2;
	ofs.x = siny+sin(pi*2.0*(coord.x*uwm3+Timer.x*uwf3*100.0))*uws3;
	ofs -= (coord-0.5)*2.0*uwz;
	return coord+ofs*0.01;
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
	float todpow = pow(max(0,ENightDayFactor*min(1.0,weatherfactor(WT_HOT)
		+1.0-EInteriorFactor)),
		heattodpow);
	if ( !heatalways && (todpow <= 0.0) ) return coord;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 nc = coord*(bresl/HEATSIZE)*heatsize;
	float2 ts = float2(0.01,1.0)*Timer.x*10000.0*heatspeed;
	float2 ofs = tex2D(SamplerHeat,nc+ts).xy;
	ofs = (ofs-0.5)*2.0;
	ofs *= pow(length(ofs),heatpow);
	if ( !heatalways ) ofs *= todpow
#ifndef FALLOUT
		*weatherfactor(WT_HOT)
#endif
		;
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
	if ( waterenable ) ofs = UnderwaterDistort(ofs);
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
   The blur passes use bilateral filtering to mostly preserve borders.
   An additional factor using difference of normals was tested, but the
   performance decrease was too much, so it's gone forever.
*/
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
	if ( ssaohalfblur ) [unroll] for ( i=-7; i<=7; i++ )
	{
		sd = tex2D(SamplerDepth,coord+float2(i,0)*bof).x;
		ds = 1.0/pow(1.0+abs(isd-sd),ssaobfact);
		sw = ds;
		sw *= gauss8[abs(i)];
		tw += sw;
		res.a += sw*tex2D(SamplerColor,coord+float2(i,0)*bof).a;
	}
	else [unroll] for ( i=-15; i<=15; i++ )
	{
		sd = tex2D(SamplerDepth,coord+float2(i,0)*bof).x;
		ds = 1.0/pow(1.0+abs(isd-sd),ssaobfact);
		sw = ds;
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
	if ( ssaohalfblur ) [unroll] for ( i=-7; i<=7; i++ )
	{
		sd = tex2D(SamplerDepth,coord+float2(0,i)*bof).x;
		ds = 1.0/pow(1.0+abs(isd-sd),ssaobfact);
		sw = ds;
		sw *= gauss8[abs(i)];
		tw += sw;
		res.a += sw*tex2D(SamplerColor,coord+float2(0,i)*bof).a;
	}
	else [unroll] for ( i=-15; i<=15; i++ )
	{
		sd = tex2D(SamplerDepth,coord+float2(0,i)*bof).x;
		ds = 1.0/pow(1.0+abs(isd-sd),ssaobfact);
		sw = ds;
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
	if ( focuscircle < 0 ) return focusmanualvalue;
	float focusmax = tod_ind(focusmax);
	float2 fcenter = float2(focuscenter_x,focuscenter_y);
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
	float dfc = abs(dep-foc);
	float dff = abs(dep);
	float dfu = dff;
	if ( doffixedcut && (dep >= cutoff*0.000001) ) dfu *= 0;
	/*
	   Change power of dof based on field of view. Works only in Skyrim.
	   The FieldOfView variable seems to hold bogus values in Fallout
	   completely unrelated to actual FOV (yes, I checked if it's in
	   radians, and no, it isn't). The value appears to be 1.134452. Who
	   could I blame for this mess? Boris? Bethesda? Hell if I know.
	*/
#ifndef FALLOUT
	if ( dofrelfov )
	{
		float relfovfactor = tod_ind(relfovfactor);
		float relfov = (FieldOfView-fovdefault)/fovdefault;
		dofpow = max(0,dofpow+relfov*relfovfactor);
	}
#endif
	dfc = clamp(pow(dfc,dofpow)*dofmult+dofbump,0.0,1.0);
	dff = clamp(pow(dff,doffixedfocuspow)*doffixedfocusmult
		+doffixedfocusbump,0.0,1.0);
	dfu = clamp(pow(dfu,doffixedunfocuspow)*doffixedunfocusmult
		+doffixedunfocusbump,0.0,1.0);
	if ( doffixedonly ) dfc *= 0;
	dfc *= lerp(1.0,dff,doffixedfocusblend);
	dfc += lerp(0.0,dfu,doffixedunfocusblend);
	dfc = saturate(dfc);
	float4 res = tex2D(SamplerColor,coord);
	res.a = dfc;
	return res;
}
/*
   This method skips blurring areas that are perfectly in focus. The
   performance gain is negligible in most cases, though.
*/
/* gather blur pass */
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
	if ( dfc <= dofminblur ) return tex2D(SamplerColor,coord);
	float4 res = float4(0,0,0,0);
	float dep = tex2D(SamplerDepth,coord).x;
	float sd, ds, sw, tw = 0;
	float2 bsz = bof*dofpradius*dfc;
	float4 sc;
	[unroll] for ( int i=0; i<32; i++ )
	{
		sc = tex2Dlod(SamplerColor,float4(coord.x
			+poisson32[i].x*bsz.x,coord.y+poisson32[i].y
			*bsz.y,0.0,dfc*4.0));
		ds = tex2D(SamplerDepth,coord+poisson32[i]*bsz).x;
		sd = tex2D(SamplerColor,coord+poisson32[i]*bsz).a;
		sw = (ds>dep)?1.0:sd;
		tw += sw;
		res += sc*sw;
	}
	res /= tw;
	res.a = 1.0;
	return res;
}
/* Screen frost shader. Not very realistic either, but looks fine too. */
float2 ScreenFrost( float2 coord )
{
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 nc = coord*(bresl/FROSTSIZE)*frostsize;
	float2 ofs = tex2D(SamplerFrostBump,nc).xy;
	ofs = (ofs-0.5)*2.0;
	ofs *= pow(length(ofs),frostpow)*froststrength;
	if ( !frostalways ) ofs *=
#ifndef FALLOUT
		weatherfactor(WT_COLD)+(1.0-weatherfactor(WT_HOT))*
#endif
		(1.0-ENightDayFactor)*frostnight;
	if ( EInteriorFactor == 1.0 ) ofs *= frostind;
	float dist = distance(coord,float2(0.5,0.5))*2.0;
	ofs *= clamp(pow(dist,frostrpow)*frostrmult+frostrbump,0.0,1.0);
	return coord+ofs;
}
/* screen frost overlay */
float4 PS_FrostPass( VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float2 coord = IN.txcoord.xy;
	float2 bresl;
	if ( (fixedx > 0) && (fixedy > 0) ) bresl = float2(fixedx,fixedy);
	else bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float4 res;
	if ( frostenable )
	{
		float2 ofs = ScreenFrost(coord);
		ofs -= coord;
		if ( (distcha != 0.0) && (length(ofs) != 0.0) )
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
		float2 nc = coord*(bresl/FROSTSIZE)*frostsize;
		float bmp = pow(max(0,tex2D(SamplerFrost,nc).x),frostbpow);
		float dist = distance(coord,float2(0.5,0.5))*2.0;
		dist = clamp(pow(dist,frostrpow)*frostrmult+frostrbump,0.0,
			1.0)*frostblend;
		if ( !frostalways ) dist *=
#ifndef FALLOUT
			weatherfactor(WT_COLD)+(1.0-weatherfactor(WT_HOT))*
#endif
			(1.0-ENightDayFactor)*frostnight;
		if ( EInteriorFactor == 1.0 ) dist *= frostind;
		res.rgb *= 1.0+bmp*dist;
	}
	else res = tex2D(SamplerColor,coord);
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
	float2 fcenter = float2(focuscenter_x,focuscenter_y);
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
		PixelShader = compile ps_3_0 PS_EdgePlusSSAOPrepass();
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
		PixelShader = compile ps_3_0 PS_FrostPass();
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