/*
	menbeffectfilters.fx : MariENB base shader routines.
	(C)2013-2014 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the WTFPL.
*/
VS_OUTPUT_POST VS_Pass( VS_INPUT_POST IN )
{
	VS_OUTPUT_POST OUT;
	OUT.vpos = float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	OUT.txcoord0.xy = IN.txcoord0.xy;
	return OUT;
}
/* MariENB shader */
float4 PS_Mari( VS_OUTPUT_POST IN, float2 vPos : VPOS ) : COLOR
{
	float2 coord = IN.txcoord0.xy;
	float4 res = tex2D(_s0,coord);
	float tod = ENightDayFactor;
	float ind = EInteriorFactor;
	/* Border darken, commonly known as "vignette" */
	float2 bresl = float2(1.0,ScreenSize.w);
	float dkradius = lerp(lerp(dkradius_n,dkradius_d,tod),lerp(dkradius_in,
		dkradius_id,tod),ind);
	float dkbump = lerp(lerp(dkbump_n,dkbump_d,tod),lerp(dkbump_in,
		dkbump_id,tod),ind);
	float dkcurve = lerp(lerp(dkcurve_n,dkcurve_d,tod),lerp(dkcurve_in,
		dkcurve_id,tod),ind);
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
	/* adaptation */
	float4 adapt = tex2D(_s4,0.5);
	float adapts = clamp((adapt.r+adapt.g+adapt.b)/3.0,0.0,50.0);
	float amin = lerp(lerp(amin_n,amin_d,tod),lerp(amin_in,amin_id,tod),
		ind);
	float amax = lerp(lerp(amax_n,amax_d,tod),lerp(amax_in,amax_id,tod),
		ind);
	res.rgb = res.rgb/(adapts*amax+amin);
	/* color grading prepass overbright/oversaturation compensation */
	float comppow = lerp(lerp(comppow_n,comppow_d,tod),lerp(comppow_in,
		comppow_id,tod),ind);
	float compsat = lerp(lerp(compsat_n,compsat_d,tod),lerp(compsat_in,
		compsat_id,tod),ind);
	float compfactor = lerp(lerp(compfactor_n,compfactor_d,tod),
		lerp(compfactor_in,compfactor_id,tod),ind);
	float4 ovr = pow(res,comppow);
	float ovrs = (ovr.r+ovr.g+ovr.b)/3.0;
	ovr = ovr*compsat+ovrs*(1.0-compsat);
	res.rgb -= ovr.rgb*compfactor;
	/* screen mud goes here */
	if ( softbloom )
	{
		if ( (fixedx > 0) && (fixedy > 0) )
			bresl = float2(fixedx,fixedy);
		else
			bresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
		bof = float2(1.0/bresl.x,1.0/bresl.y);
		res += gauss5[2][2]*tex2D(_s3,coord+float2(-2,-2)*bof);
		res += gauss5[1][2]*tex2D(_s3,coord+float2(-1,-2)*bof);
		res += gauss5[0][2]*tex2D(_s3,coord+float2(0,-2)*bof);
		res += gauss5[1][2]*tex2D(_s3,coord+float2(1,-2)*bof);
		res += gauss5[2][2]*tex2D(_s3,coord+float2(2,-2)*bof);
		res += gauss5[2][1]*tex2D(_s3,coord+float2(-2,-1)*bof);
		res += gauss5[1][1]*tex2D(_s3,coord+float2(-1,-1)*bof);
		res += gauss5[0][1]*tex2D(_s3,coord+float2(0,-1)*bof);
		res += gauss5[1][1]*tex2D(_s3,coord+float2(1,-1)*bof);
		res += gauss5[2][1]*tex2D(_s3,coord+float2(2,-1)*bof);
		res += gauss5[2][0]*tex2D(_s3,coord+float2(-2,0)*bof);
		res += gauss5[1][0]*tex2D(_s3,coord+float2(-1,0)*bof);
		res += gauss5[0][0]*tex2D(_s3,coord+float2(0,0)*bof);
		res += gauss5[1][0]*tex2D(_s3,coord+float2(1,0)*bof);
		res += gauss5[2][0]*tex2D(_s3,coord+float2(2,0)*bof);
		res += gauss5[2][1]*tex2D(_s3,coord+float2(-2,1)*bof);
		res += gauss5[1][1]*tex2D(_s3,coord+float2(-1,1)*bof);
		res += gauss5[0][1]*tex2D(_s3,coord+float2(0,1)*bof);
		res += gauss5[1][1]*tex2D(_s3,coord+float2(1,1)*bof);
		res += gauss5[2][1]*tex2D(_s3,coord+float2(2,1)*bof);
		res += gauss5[2][2]*tex2D(_s3,coord+float2(-2,2)*bof);
		res += gauss5[1][2]*tex2D(_s3,coord+float2(-1,2)*bof);
		res += gauss5[0][2]*tex2D(_s3,coord+float2(0,2)*bof);
		res += gauss5[1][2]*tex2D(_s3,coord+float2(1,2)*bof);
		res += gauss5[2][2]*tex2D(_s3,coord+float2(2,2)*bof);
		res *= EBloomAmount;
	}
	else
		res += tex2D(_s3,coord)*EBloomAmount;
	/*
	   color grading (brightness, contrast, gamma, tinting, everything you
	   could ever need)
	*/
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
	float3 grademul = float3(grademul_r,grademul_g,grademul_b);
	float3 gradepow = float3(gradepow_r,gradepow_g,gradepow_b);
	float3 gradecol = float3(gradecol_r,gradecol_g,gradecol_b);
	res.rgb = saturate(pow(res.rgb,gradepow));
	res.rgb = saturate(res.rgb*grademul);
	float tonev = (res.r+res.g+res.b)/3.0;
	float3 tonecolor = gradecol*tonev;
	res.rgb = res.rgb*(1.0-gradecolfact)+tonecolor*gradecolfact;
	/* letterbox filter */
	res.rgb = saturate(res.rgb);
	float boxf = pow(clamp(boxv-abs(2.0*coord.y-1.0),0.0,1.0),boxb);
	res.rgb = lerp(res.rgb*(1.0-boxa),res.rgb,boxf);
	res.a = 1.0;
	return res;
}
/*
   So... let me get this straight... rather than simply switching techniques,
   Boris just compiles the program twice with and without this macro, then
   toggling "UseEffect" switches between each variation? What the fuck?
*/
#ifndef ENB_FLIPTECHNIQUE
technique Shader_D6EC7DD1
#else
technique Shader_ORIGINALPOSTPROCESS
#endif
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		PixelShader = compile ps_3_0 PS_Mari();
		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		ZEnable = FALSE;
		ZWriteEnable = FALSE;
		CullMode = NONE;
		AlphaTestEnable = FALSE;
		AlphaBlendEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
#ifndef ENB_FLIPTECHNIQUE
technique Shader_ORIGINALPOSTPROCESS
#else
technique Shader_D6EC7DD1
#endif
{
	pass p0
	{
		VertexShader = compile vs_3_0 VS_Pass();
		/*
		   >2014
		   >inline assembly
		   Have to keep this part intact, sadly
		   Boris what the fuck have you done
		*/
		PixelShader = asm
		{
			ps_3_0
			def c6,0,0,0,0
			def c7,0.212500006,0.715399981,0.0720999986,1
			dcl_texcoord v0.xy
			dcl_2d s0
			dcl_2d s1
			dcl_2d s2
			rcp r0.x,c2.y
			texld r1,v0,s2
			mul r0.yz,r1.xxyw,c1.y
			rcp r0.w,r0.y
			mul r0.z,r0.w,r0.z
			texld r1,v0,s1
			mul r1.xyz,r1,c1.y
			dp3 r0.w,c7,r1
			mul r1.w,r0.w,r0.z
			mad r0.z,r0.z,r0.w,c7.w
			rcp r0.z,r0.z
			mad r0.x,r1.w,r0.x,c7.w
			mul r0.x,r0.x,r1.w
			mul r0.x,r0.z,r0.x
			cmp r0.x,-r0.w,c6.x,r0.x
			rcp r0.z,r0.w
			mul r0.z,r0.z,r0.x
			add_sat r0.x,-r0.x,c2.x
			texld r2,v0,s0
			mul r2.xyz,r2,c1.y
			mul r2.xyz,r0.x,r2
			mad r1.xyz,r1,r0.z,r2
			dp3 r0.x,r1,c7
			mov r1.w,c7.w
			lrp r2,c3.x,r1,r0.x
			mad r1,r0.x,c4,-r2
			mad r1,c4.w,r1,r2
			mad r1,c3.w,r1,-r0.y
			mad r0,c3.z,r1,r0.y
			add r1,-r0,c5
			mad oC0,c5.w,r1,r0
		};
		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		ZEnable = FALSE;
		ZWriteEnable = FALSE;
		CullMode = NONE;
		AlphaTestEnable = FALSE;
		AlphaBlendEnable = FALSE;
		SRGBWRITEENABLE = FALSE;
	}
}
