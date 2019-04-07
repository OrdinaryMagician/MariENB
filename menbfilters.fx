/*
	menbfilters.fx : MariENB shader routines.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the MIT License.
*/
VS_OUTPUT_POST VS_Pass( VS_INPUT_POST IN )
{
	VS_OUTPUT_POST OUT;
	OUT.vpos =  float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord.xy = IN.txcoord.xy;
	return OUT;
}
float4 PS_FXAA( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = float2(IN.txcoord.x,IN.txcoord.y);
	float4 res = tex2D(SamplerColor,coord);
	if ( !fxaaenable )
		return res;
	float fxaareducemul_ = 1.0/max(abs(fxaareducemul),1.0);
	float fxaareducemin_ = 1.0/max(abs(fxaareducemin),1.0);
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y);
	float3 rgbNW = tex2D(SamplerColor,coord+float2(-1,-1)*bof).rgb;
	float3 rgbNE = tex2D(SamplerColor,coord+float2(1,-1)*bof).rgb;
	float3 rgbSW = tex2D(SamplerColor,coord+float2(-1,1)*bof).rgb;
	float3 rgbSE = tex2D(SamplerColor,coord+float2(1,1)*bof).rgb;
	float3 rgbM = tex2D(SamplerColor,coord).rgb;
	float3 luma = float3(0.299,0.587,0.114);
	float lumaNW = dot(rgbNW,luma);
	float lumaNE = dot(rgbNE,luma);
	float lumaSW = dot(rgbSW,luma);
	float lumaSE = dot(rgbSE,luma);
	float lumaM = dot(rgbM,luma);
	float lumaMin = min(lumaM,min(min(lumaNW,lumaNE),min(lumaSW,lumaSE)));
	float lumaMax = max(lumaM,max(max(lumaNW,lumaNE),max(lumaSW,lumaSE)));
	float2 dir = float2(-((lumaNW+lumaNE)-(lumaSW+lumaSE)),((lumaNW+lumaSW)
		-(lumaNE+lumaSE)));
	float dirReduce = max((lumaNW+lumaNE+lumaSW+lumaSE)*(0.25
		*fxaareducemul_),fxaareducemin_);
	float rcpDirMin = 1.0/(min(abs(dir.x),abs(dir.y))+dirReduce);
	dir = min(float2(fxaaspanmax,fxaaspanmax),max(float2(-fxaaspanmax,
		-fxaaspanmax),dir*rcpDirMin))/bresl;
	float3 rgbA = (1.0/2.0)*(tex2D(SamplerColor,coord+dir*(1.0/3.0-0.5))
		.rgb+tex2D(SamplerColor,coord+dir*(2.0/3.0-0.5)).rgb);
	float3 rgbB = rgbA*(1.0/2.0)+(1.0/4.0)*(tex2D(SamplerColor,coord+dir
		*(0.0/3.0-0.5)).rgb+tex2D(SamplerColor,coord+dir*(3.0/3.0-0.5))
		.rgb);
	float lumaB = dot(rgbB,luma);
	if ( (lumaB < lumaMin) || (lumaB > lumaMax) )
		res.rgb = rgbA;
	else
		res.rgb = rgbB;
	res.a = 1.0;
	return res;
}
float4 PS_Enhance( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = float2(IN.txcoord.x,IN.txcoord.y);
	float4 res = tex2D(SamplerColor,coord);
	float tod = ENightDayFactor;
	float ind = EInteriorFactor;
	if ( bbenable )
	{
		float4 origcolor = res;
		float4 tcol = float4(0,0,0,0);
		float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
		float bbsamp = lerp(lerp(bbsamp_n,bbsamp_d,tod),lerp(bbsamp_in,
			bbsamp_id,tod),ind);
		float bbradius = lerp(lerp(bbradius_n,bbradius_d,tod),
			lerp(bbradius_in,bbradius_id,tod),ind);
		float bbcurve = lerp(lerp(bbcurve_n,bbcurve_d,tod),
			lerp(bbcurve_in,bbcurve_id,tod),ind);
		float bbpow = lerp(lerp(bbpow_n,bbpow_d,tod),lerp(bbpow_in,
			bbpow_id,tod),ind);
		float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*bbsamp;
		int i, j;
		if ( bblevel == 1 )
		{
			for ( i=-2; i<=2; i++ )
				for ( j=-2; j<=2; j++ )
					tcol += gauss5[abs(i)][abs(j)]
						*tex2D(SamplerColor,coord
						+float2(i,j)*bof);
		}
		else if ( bblevel == 2 )
		{
			for ( i=-3; i<=3; i++ )
				for ( j=-3; j<=3; j++ )
					tcol += gauss7[abs(i)][abs(j)]
						*tex2D(SamplerColor,coord
						+float2(i,j)*bof);
		}
		else
		{
			for ( i=-1; i<=1; i++ )
				for ( j=-1; j<=1; j++ )
					tcol += gauss3[abs(i)][abs(j)]
						*tex2D(SamplerColor,coord
						+float2(i,j)*bof);
		}
		float2 uv = (coord.xy-0.5)*bbradius;
		float vig = clamp(pow(saturate(dot(uv.xy,uv.xy)),bbcurve),0.0
			,1.0);
		res.rgb = lerp(origcolor.rgb,tcol.rgb,clamp(vig*bbpow,0.0
			,1.0));
	}
	if ( dkenable )
	{
		float2 bresl = float2(1.0,ScreenSize.w);
		float dkradius = lerp(lerp(dkradius_n,dkradius_d,tod),
			lerp(dkradius_in,dkradius_id,tod),ind);
		float dkbump = lerp(lerp(dkbump_n,dkbump_d,tod),lerp(dkbump_in,
			dkbump_id,tod),ind);
		float dkcurve = lerp(lerp(dkcurve_n,dkcurve_d,tod),
			lerp(dkcurve_in,dkcurve_id,tod),ind);
		float2 bof = bresl*dkradius;
		float val = 0.0;
		if ( coord.x < bof.x )
			val = lerp(val,1,1.0-coord.x/bof.x);
		if ( coord.y < bof.y )
			val = lerp(val,1,1.0-coord.y/bof.y);
		if ( 1.0-coord.x < bof.x )
			val = lerp(val,1,1.0-(1.0-coord.x)/bof.x);
		if ( 1.0-coord.y < bof.y )
			val = lerp(val,1,1.0-(1.0-coord.y)/bof.y);
		val = clamp(val*dkbump,0,1);
		res.rgb = lerp(res.rgb,float3(0,0,0),pow(val,dkcurve));
	}
	if ( ne )
	{
		float nf = lerp(lerp(nf_n,nf_d,tod),lerp(nf_in,nf_id,tod),ind);
		float ns = lerp(lerp(ns_n,ns_d,tod),lerp(ns_in,ns_id,tod),ind);
		float nj = lerp(lerp(nj_n,nj_d,tod),lerp(nj_in,nj_id,tod),ind);
		float ni = lerp(lerp(ni_n,ni_d,tod),lerp(ni_in,ni_id,tod),ind);
		float ts = Timer.x*nf;
		ts *= 1000.0;
		float2 tcs = coord;
		float2 s1 = tcs+float2(0,ts);
		float2 s2 = tcs+float2(ts,0);
		float2 s3 = tcs+float2(ts,ts);
		float n1, n2, n3;
		float2 nr = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w)
			/NOISERES;
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
	}
	if ( compenable )
	{
		float compbump = lerp(lerp(compbump_n,compbump_d,tod),
			lerp(compbump_in,compbump_id,tod),ind);
		float comppow = lerp(lerp(comppow_n,comppow_d,tod),
			lerp(comppow_in,comppow_id,tod),ind);
		float compsat = lerp(lerp(compsat_n,compsat_d,tod),
			lerp(compsat_in,compsat_id,tod),ind);
		float compfactor = lerp(lerp(compfactor_n,compfactor_d,tod),
			lerp(compfactor_in,compfactor_id,tod),ind);
		float4 ovr = pow(saturate(res+compbump),comppow);
		float ovrs = (ovr.r+ovr.g+ovr.b)/3.0;
		ovr = ovr*compsat+ovrs*(1.0-compsat);
		res.rgb -= ovr.rgb*compfactor;
	}
	if ( gradeenable )
	{
		float gradeadd_r = lerp(lerp(gradeadd_r_n,gradeadd_r_d,tod),
			lerp(gradeadd_r_in,gradeadd_r_id,tod),ind);
		float gradeadd_g = lerp(lerp(gradeadd_g_n,gradeadd_g_d,tod),
			lerp(gradeadd_g_in,gradeadd_g_id,tod),ind);
		float gradeadd_b = lerp(lerp(gradeadd_b_n,gradeadd_b_d,tod),
			lerp(gradeadd_b_in,gradeadd_b_id,tod),ind);
		float grademul_r = lerp(lerp(grademul_r_n,grademul_r_d,tod),
			lerp(grademul_r_in,grademul_r_id,tod),ind);
		float grademul_g = lerp(lerp(grademul_g_n,grademul_g_d,tod),
			lerp(grademul_g_in,grademul_g_id,tod),ind);
		float grademul_b = lerp(lerp(grademul_b_n,grademul_b_d,tod),
			lerp(grademul_b_in,grademul_b_id,tod),ind);
		float gradepow_r = lerp(lerp(gradepow_r_n,gradepow_r_d,tod),
			lerp(gradepow_r_in,gradepow_r_id,tod),ind);
		float gradepow_g = lerp(lerp(gradepow_g_n,gradepow_g_d,tod),
			lerp(gradepow_g_in,gradepow_g_id,tod),ind);
		float gradepow_b = lerp(lerp(gradepow_b_n,gradepow_b_d,tod),
			lerp(gradepow_b_in,gradepow_b_id,tod),ind);
		float gradecol_r = lerp(lerp(gradecol_r_n,gradecol_r_d,tod),
			lerp(gradecol_r_in,gradecol_r_id,tod),ind);
		float gradecol_g = lerp(lerp(gradecol_g_n,gradecol_g_d,tod),
			lerp(gradecol_g_in,gradecol_g_id,tod),ind);
		float gradecol_b = lerp(lerp(gradecol_b_n,gradecol_b_d,tod),
			lerp(gradecol_b_in,gradecol_b_id,tod),ind);
		float gradecolfact = lerp(lerp(gradecolfact_n,gradecolfact_d,
			tod),lerp(gradecolfact_in,gradecolfact_id,tod),ind);
		float3 gradeadd = float3(gradeadd_r,gradeadd_g,gradeadd_b);
		float3 grademul = float3(grademul_r,grademul_g,grademul_b);
		float3 gradepow = float3(gradepow_r,gradepow_g,gradepow_b);
		float3 gradecol = float3(gradecol_r,gradecol_g,gradecol_b);
		res.rgb = saturate(res.rgb+gradeadd);
		res.rgb = saturate(res.rgb*grademul);
		res.rgb = saturate(pow(res.rgb,gradepow));
		float tonev = (res.r+res.g+res.b)/3.0;
		float3 tonecolor = gradecol*tonev;
		res.rgb = res.rgb*(1.0-gradecolfact)+tonecolor*gradecolfact;
	}
	if ( dirtenable )
	{
		float2 r = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w)
			/NOISERES;
		float4 ncolc = tex2D(SamplerNoise1,coord*dirtmc*r);
		float2 ds = float2(res.r+res.g,res.g+res.b)/2.0;
		float4 ncoll = tex2D(SamplerNoise1,ds*dirtml);
		res = lerp(res,(ncolc.r+1)*res,
			dirtcfactor*saturate(1-(ds.x+ds.y)*0.25));
		res = lerp(res,(ncoll.r+1)*res,
			dirtlfactor*saturate(1-(ds.x+ds.y)*0.25));
	}
	if ( boxe )
	{
		res.rgb = saturate(res.rgb);
		float boxf = pow(clamp(boxh-abs(2.0*coord.x-1.0),0.0,1.0),boxb)
			*pow(clamp(boxv-abs(2.0*coord.y-1.0),0.0,1.0),boxb);
		res.rgb = lerp(res.rgb*(1.0-boxa),res.rgb,boxf);
	}
	res.a = 1.0;
	return res;
}
float4 ReducePrepass( in float4 color, in float2 coord )
{
	color.rgb = pow(max(color.rgb,0.0),bgamma);
	float4 dac;
	dac.a = (color.r+color.g+color.b)/3.0;
	dac.rgb = dac.a+(color.rgb-dac.a)*bsaturation;
	if ( bdither == 0 )
		dac.rgb += bdbump+tex2D(SamplerNoise3,coord/NOISERES).r*bdmult;
	else if ( bdither == 1 )
		dac.rgb += bdbump+checkers[int(coord.x%2)+2*int(coord.y%2)]
			*bdmult;
	else if ( bdither == 2 )
		dac.rgb += bdbump+ordered2[int(coord.x%2)+2*int(coord.y%2)]
			*bdmult;
	else if ( bdither == 3 )
		dac.rgb += bdbump+ordered3[int(coord.x%3)+3*int(coord.y%3)]
			*bdmult;
	else if ( bdither == 4 )
		dac.rgb += bdbump+ordered4[int(coord.x%4)+4*int(coord.y%4)]
			*bdmult;
	else if ( bdither == 5 )
		dac.rgb += bdbump+ordered8[int(coord.x%8)+8*int(coord.y%8)]
			*bdmult;
	dac = saturate(dac);
	return dac;
}
float4 ReduceCGA( in float4 color, in float2 coord )
{
	float4 dac = ReducePrepass(color,coord);
	if ( bcganum == 0 )
	{
		dac.a = (dac.r+dac.g+dac.b)/3.0;
		return (dac.a>0.5);
	}
	float dist = 2.0;
	int idx = 0;
	if ( bcganum == 1 )
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
	else if ( bcganum == 2 )
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
	else if ( bcganum == 3 )
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
	else if ( bcganum == 4 )
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
	else if ( bcganum == 5 )
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
	else if ( bcganum == 6 )
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
	if ( beganum == 0 )
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
float4 PS_Block( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = float2(IN.txcoord.x,IN.txcoord.y);
	float4 res = tex2D(SamplerColor,coord);
	if ( !benable )
		return res;
	float2 rresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bresl;
	if ( bresw <= 0 || bresh <= 0 )
		bresl = rresl;
	else
	{
		if ( bresw <= 1.0 )
			bresl.x = rresl.x*bresw;
		else
			bresl.x = bresw;
		if ( bresh <= 1.0 )
			bresl.y = rresl.y*bresh;
		else
			bresl.y = bresh;
	}
	float2 ncoord = (coord-float2(0.5,0.5))+float2(0.5,0.5);
	ncoord = floor(ncoord*bresl)/bresl;
	if ( bresw <= 0 || bresh <= 0 )
		ncoord = coord;
	float4 tcol = tex2D(SamplerColor,ncoord);
	/* clamp */
	if ( ncoord.x < 0 || ncoord.x >= 1 || ncoord.y < 0 || ncoord.y >= 1 )
		tcol *= 0;
	if ( bpaltype == 0 )
		res = ReduceCGA(tcol,coord*bresl);
	else if ( bpaltype == 1 )
		res = ReduceEGA(tcol,coord*bresl);
	else if ( bpaltype == 2 )
		res = ReduceRGB2(tcol,coord*bresl);
	else if ( bpaltype == 3 )
		res = ReduceRGB323(tcol,coord*bresl);
	else if ( bpaltype == 4 )
		res = ReduceRGB4(tcol,coord*bresl);
	else if ( bpaltype == 5 )
		res = ReduceRGB565(tcol,coord*bresl);
	else if ( bpaltype == 6 )
		res = ReduceRGB6(tcol,coord*bresl);
	else
		res = tcol;
	res.a = 1.0;
	return res;
}
float4 PS_Curve( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = float2(IN.txcoord.x,IN.txcoord.y);
	float4 res = tex2D(SamplerColor,coord);
	if ( !crtenable )
		return res;
	float4 tcol = res;
	float3 eta = float3(1+chromaab*0.09,1+chromaab*0.06,1+chromaab*0.03);
	float2 center = float2(coord.x-0.5,coord.y-0.5);
	float zfact = 100.0/lenszoom;
	float r2 = center.x*center.x+center.y*center.y;
	float f = 0;
	if( lensdistc == 0.0)
		f = 1+r2*lensdist*0.1;
	else
		f = 1+r2*(lensdist*0.1+lensdistc*0.1*sqrt(r2));
	float x = f*zfact*center.x+0.5;
	float y = f*zfact*center.y+0.5;
	float2 rcoord = (f*eta.r)*zfact*(center.xy*0.5)+0.5;
	float2 gcoord = (f*eta.g)*zfact*(center.xy*0.5)+0.5;
	float2 bcoord = (f*eta.b)*zfact*(center.xy*0.5)+0.5;
	float4 idist = float4(tex2D(SamplerColor,rcoord).r,
		tex2D(SamplerColor,gcoord).g,
		tex2D(SamplerColor,bcoord).b,
		tex2D(SamplerColor,float2(x,y)).a);
	res.rgb = idist.rgb;
	res.a = 1.0;
	return res;
}
float4 PS_Sharp( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = float2(IN.txcoord.x,IN.txcoord.y);
	float4 res = tex2D(SamplerColor,coord);
	if ( !shenable )
		return res;
	float4 origcolor = res;
	float4 tcol = float4(0,0,0,0);
	float2 bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bof = float2(1.0/bresl.x,1.0/bresl.y)*shsamp;
	int i, j;
	tcol = float4(0,0,0,0);
	for ( i=-2; i<=2; i++ )
		for ( j=-2; j<=2; j++ )
			tcol += shmat[abs(i)][abs(j)]
				*tex2D(SamplerColor,coord+float2(i,j)*bof);
	res = res*(1.0-shblend)+tcol*shblend;
	res.a = 1.0;
	return res;
}
technique PostProcess
{
	pass FXAA
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_FXAA();
		AlphaBlendEnable = TRUE;
		SrcBlend = ONE;
		DestBlend = ONE;
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
	pass Reel
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Enhance();
		AlphaBlendEnable = TRUE;
		SrcBlend = ONE;
		DestBlend = ONE;
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
	pass Turboslut
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Sharp();
		AlphaBlendEnable = TRUE;
		SrcBlend = ONE;
		DestBlend = ONE;
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
	pass Retrograde
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Block();
		AlphaBlendEnable = TRUE;
		SrcBlend = ONE;
		DestBlend = ONE;
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
	pass Butt
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Curve();
		AlphaBlendEnable = TRUE;
		SrcBlend = ONE;
		DestBlend = ONE;
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
