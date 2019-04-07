//	K ENB  
//	Multiple Passes Lenzes w_Individual Size and Color Control 
//	Code extensive modifications by KYO aka Oyama w/some help from Boris ;)
//	Lenz Texture by OpethFeldt
//	Copyright (c) 2007-2013 Boris Vorontsov
//	Medium Hexagons

//=====================================================================================================
//	Internal parameters
//=====================================================================================================

float ELenzIntensity=1.0;	//[Global Intensity]
float LenzScaleFactor=0.288;	//[Global Scale, will affect all lenzes]	//1.0, 0.75, 0.66, 0.5, 0.25, 0.33, 0.322, so on

float LenzFactorDraw=1.0;	//[Allows for separated factors in case of additional Draw techniques, such as Draw2, ect...]

float LenzContrastDraw=1.3;	//[Contrast to clouds - More is weaker opacity compared to clouds]

/**
 *	Separated Lenzes controls for Draw techniques : Offset, Scale, Scale Factor, Color RGB, Color Multiplier
 *	KYO : color balance will also act as a separate intensity control for each lenz 
 *	Color : 1.0, 1.0, 1.0 is full intensity / opacity
 *	If color components are below 1.0, lenz is losing opacity
 *	You can counterbalance it by increasing f#_ColorMultiplier over 1.0
 *	Fine tuning is balancing global intensity, RGB balance, multiplier
 */

//Lenz #1
#define f1_LenzOffset		-0.8				//Position from Sun to Eye	
#define f1_LenzScale		0.093				//Size of the Lenz Flare
#define f1_LenzFactor		1.0				//Multiplier for Size, in case 2 lenzes are sharing close offset a/o scale	
#define	f1_LenzColor		float3(0.75, 0.75, 0.50)	//Color in RGB (0.00 to 1.00) for the Lenz Flare	
#define	f1_ColorMultiplier	1.0				//Color Multiplier, in case RGB values are too low - Fine Tuning

//Lenz #2
#define f2_LenzOffset		-0.54	
#define f2_LenzScale		0.066
#define f2_LenzFactor		1.0	
#define	f2_LenzColor		float3(0.85, 0.65, 0.85)	
#define	f2_ColorMultiplier	1.2

//Lenz #3
#define f3_LenzOffset		-0.34	
#define f3_LenzScale		0.100
#define f3_LenzFactor		1.0
#define	f3_LenzColor		float3(1.0, 1.0, 1.0)	
#define	f3_ColorMultiplier	1.0

//Lenz #4
#define f4_LenzOffset		-0.14	
#define f4_LenzScale		0.099
#define f4_LenzFactor		0.75	
#define	f4_LenzColor		float3(0.25, 1.0, 0.75)	
#define	f4_ColorMultiplier	1.0

//Lenz #5
#define f5_LenzOffset		-0.27	
#define f5_LenzScale		0.072
#define f5_LenzFactor		1.0	
#define	f5_LenzColor		float3(0.3, 0.3, 0.25)
#define	f5_ColorMultiplier	2.0

//Lenz #6
#define f6_LenzOffset		-0.3	
#define f6_LenzScale		0.115
#define f6_LenzFactor		0.75	
#define	f6_LenzColor		float3(0.20, 0.30, 0.35)	
#define	f6_ColorMultiplier	1.2

//Lenz #7
#define f7_LenzOffset		-0.4	
#define f7_LenzScale		0.098
#define f7_LenzFactor		1.0	
#define	f7_LenzColor		float3(1.0, 1.0, 1.0)
#define	f7_ColorMultiplier	1.0

//Lenz #8
#define f8_LenzOffset		-0.2	
#define f8_LenzScale		0.081
#define f8_LenzFactor		0.5	
#define	f8_LenzColor		float3(0.25, 0.95, 0.45)	
#define	f8_ColorMultiplier	1.8

//Lenz #9
#define f9_LenzOffset		-0.1	
#define f9_LenzScale		0.121
#define f9_LenzFactor		0.85	
#define	f9_LenzColor		float3(1.0, 1.0, 1.0)	
#define	f9_ColorMultiplier	1.0

//Lenz #10
#define f10_LenzOffset		0.0	
#define f10_LenzScale		0.111
#define f10_LenzFactor		1.0	
#define	f10_LenzColor		float3(0.55, 0.55, 0.55)	
#define	f10_ColorMultiplier	1.0

//Lenz #11
#define f11_LenzOffset		0.8	
#define f11_LenzScale		0.234
#define f11_LenzFactor		1.11	
#define	f11_LenzColor		float3(0.35, 0.45, 0.62)
#define	f11_ColorMultiplier	2.0

//Lenz #12
#define f12_LenzOffset		0.9	
#define f12_LenzScale		0.144
#define f12_LenzFactor		1.11	
#define	f12_LenzColor		float3(0.35, 0.35, 0.42)
#define	f12_ColorMultiplier	1.0

//Lenz #13
#define f13_LenzOffset		1.0	
#define f13_LenzScale		0.174
#define f13_LenzFactor		1.11	
#define	f13_LenzColor		float3(0.35, 0.35, 0.42)
#define	f13_ColorMultiplier	1.0

//Lenz #14
#define f14_LenzOffset		0.42	
#define f14_LenzScale		0.064
#define f14_LenzFactor		1.11	
#define	f14_LenzColor		float3(0.35, 0.35, 0.42)
#define	f14_ColorMultiplier	1.0

//Lenz #15
#define f15_LenzOffset		0.53	
#define f15_LenzScale		0.074
#define f15_LenzFactor		1.11	
#define	f15_LenzColor		float3(0.35, 0.35, 0.42)
#define	f15_ColorMultiplier	1.0

//Lenz #16
#define f16_LenzOffset		0.65	
#define f16_LenzScale		0.094
#define f16_LenzFactor		1.11	
#define	f16_LenzColor		float3(0.35, 0.35, 0.42)
#define	f16_ColorMultiplier	1.0

//Lenz #17
#define f17_LenzOffset		0.76	
#define f17_LenzScale		0.104
#define f17_LenzFactor		1.11	
#define	f17_LenzColor		float3(0.35, 0.35, 0.42)
#define	f17_ColorMultiplier	1.0

//Lenz #18
#define f18_LenzOffset		0.9	
#define f18_LenzScale		0.114
#define f18_LenzFactor		1.11	
#define	f18_LenzColor		float3(0.35, 0.35, 0.42)
#define	f18_ColorMultiplier	1.0

//Lenz #19
#define f19_LenzOffset		1.0	
#define f19_LenzScale		0.174
#define f19_LenzFactor		1.11	
#define	f19_LenzColor		float3(0.35, 0.35, 0.42)
#define	f19_ColorMultiplier	1.0

//Lenz #20
#define f20_LenzOffset		1.2	
#define f20_LenzScale		0.224
#define f20_LenzFactor		1.11	
#define	f20_LenzColor		float3(0.35, 0.35, 0.42)
#define	f20_ColorMultiplier	1.0

//Lenz #21
#define f21_LenzOffset		1.6	
#define f21_LenzScale		0.234
#define f21_LenzFactor		1.11	
#define	f21_LenzColor		float3(0.35, 0.35, 0.42)
#define	f21_ColorMultiplier	1.0

//Lenz #22
#define f22_LenzOffset		1.9	
#define f22_LenzScale		0.064
#define f22_LenzFactor		1.11	
#define	f22_LenzColor		float3(0.35, 0.35, 0.42)
#define	f22_ColorMultiplier	1.0

//Add or Remove additional Lenzes controls here, as done above
//This being done, a/o remove passes of technique below

//=====================================================================================================
//	External parameters
//=====================================================================================================
//Keyboard controlled temporary variables (in some versions exists in the config file). 
//Press and hold key 1,2,3...8 together with PageUp or PageDown to modify. By default all set to 1.0
float4	tempF1; //0,1,2,3
float4	tempF2; //5,6,7,8
float4	tempF3; //9,0
//x=Width, y=1/Width, z=ScreenScaleY, w=1/ScreenScaleY
float4	ScreenSize;
//x=generic timer in range 0..1, period of 16777216 ms (4.6 hours), w=frame time elapsed (in seconds)
float4	Timer;
//xy=sun position on screen, w=visibility
float4	LightParameters;

//textures
texture2D texColor;
texture2D texMask;

sampler2D SamplerColor = sampler_state
{
	Texture   = <texColor>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;				
	MipMapLodBias=0;
};

sampler2D SamplerMask = sampler_state
{
	Texture   = <texMask>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

struct VS_OUTPUT_POST
{
	float4 vpos  : POSITION;
	float2 txcoord : TEXCOORD0;
};

struct VS_INPUT_POST
{
	float3 pos  : POSITION;
	float2 txcoord : TEXCOORD0;
};

/**
 * Several sprites moving similar to lenz effect
 * They are transformed in vertex shader and drawed separately for better performance
 * Offset is set in passes of technique
 */

VS_OUTPUT_POST VS_Draw(VS_INPUT_POST IN, uniform float offset, uniform float scale)
{
	VS_OUTPUT_POST OUT;

	float4 pos=float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);
	pos.y*=ScreenSize.z;

	//create own parameters instead of this, including uv offsets
	float2 shift=LightParameters.xy * offset;
	pos.xy=pos.xy * (scale * LenzScaleFactor) - shift;

	OUT.vpos=pos;
	OUT.txcoord.xy=IN.txcoord.xy;

	return OUT;
}

float4 PS_Draw(VS_OUTPUT_POST IN, float2 vPos : VPOS, uniform float3 colorfilter, uniform float colormultiplier) : COLOR
{
	float4 res;
	float2 coord=IN.txcoord.xy;

	//read sun visibility as amount of effect
	float sunmask=tex2D(SamplerMask, float2(0.5, 0.5)).x;
	sunmask=pow(sunmask, LenzContrastDraw);						//more contrast to clouds	
	clip(sunmask-0.02);//early exit if too low

	float4 origcolor=tex2D(SamplerColor, coord.xy);
	sunmask*=LightParameters.w * (ELenzIntensity * LenzFactorDraw);
	res.xyz=origcolor * sunmask;

	float clipper=dot(res.xyz, 0.333);
	clip(clipper-0.0003);//skip draw if black

	res.xyz*=colorfilter * colormultiplier;
	res.w=1.0;
	return res;
}

//-------------------------------------------------------------------------------------------------------------------------

/**
 *	TECHNIQUES
 */

technique Draw
{
	pass P0
	{
		VertexShader = compile vs_3_0 VS_Draw(f1_LenzOffset, (f1_LenzScale * f1_LenzFactor));	//offset, scale, scale factor
		PixelShader  = compile ps_3_0 PS_Draw(f1_LenzColor, f1_ColorMultiplier);		//Color RGB

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P1
	{
		VertexShader = compile vs_3_0 VS_Draw(f2_LenzOffset, (f2_LenzScale * f2_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f2_LenzColor, f2_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P2
	{
		VertexShader = compile vs_3_0 VS_Draw(f3_LenzOffset, (f3_LenzScale * f3_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f3_LenzColor, f3_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P3
	{
		VertexShader = compile vs_3_0 VS_Draw(f4_LenzOffset, (f4_LenzScale * f4_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f4_LenzColor, f4_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P4
	{
		VertexShader = compile vs_3_0 VS_Draw(f5_LenzOffset, (f5_LenzScale * f5_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f5_LenzColor, f5_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P5
	{
		VertexShader = compile vs_3_0 VS_Draw(f6_LenzOffset, (f6_LenzScale * f6_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f6_LenzColor, f6_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P6
	{
		VertexShader = compile vs_3_0 VS_Draw(f7_LenzOffset, (f7_LenzScale * f7_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f7_LenzColor, f7_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P7
	{
		VertexShader = compile vs_3_0 VS_Draw(f8_LenzOffset, (f8_LenzScale * f8_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f8_LenzColor, f8_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P8
	{
		VertexShader = compile vs_3_0 VS_Draw(f9_LenzOffset, (f9_LenzScale * f9_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f9_LenzColor, f9_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P9
	{
		VertexShader = compile vs_3_0 VS_Draw(f10_LenzOffset, (f10_LenzScale * f10_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f10_LenzColor, f10_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P10
	{
		VertexShader = compile vs_3_0 VS_Draw(f11_LenzOffset, (f11_LenzScale * f11_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f11_LenzColor, f11_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P11
	{
		VertexShader = compile vs_3_0 VS_Draw(f11_LenzOffset, (f12_LenzScale * f12_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f12_LenzColor, f12_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P12
	{
		VertexShader = compile vs_3_0 VS_Draw(f13_LenzOffset, (f13_LenzScale * f13_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f13_LenzColor, f13_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P13
	{
		VertexShader = compile vs_3_0 VS_Draw(f14_LenzOffset, (f14_LenzScale * f14_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f14_LenzColor, f14_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P14
	{
		VertexShader = compile vs_3_0 VS_Draw(f15_LenzOffset, (f15_LenzScale * f15_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f15_LenzColor, f15_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P15
	{
		VertexShader = compile vs_3_0 VS_Draw(f16_LenzOffset, (f16_LenzScale * f16_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f16_LenzColor, f16_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P16
	{
		VertexShader = compile vs_3_0 VS_Draw(f17_LenzOffset, (f17_LenzScale * f17_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f17_LenzColor, f17_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P17
	{
		VertexShader = compile vs_3_0 VS_Draw(f18_LenzOffset, (f18_LenzScale * f18_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f18_LenzColor, f18_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P18
	{
		VertexShader = compile vs_3_0 VS_Draw(f19_LenzOffset, (f19_LenzScale * f19_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f19_LenzColor, f19_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P19
	{
		VertexShader = compile vs_3_0 VS_Draw(f20_LenzOffset, (f20_LenzScale * f20_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f20_LenzColor, f20_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P20
	{
		VertexShader = compile vs_3_0 VS_Draw(f21_LenzOffset, (f21_LenzScale * f21_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f21_LenzColor, f21_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}

	pass P21
	{
		VertexShader = compile vs_3_0 VS_Draw(f22_LenzOffset, (f22_LenzScale * f22_LenzFactor));
		PixelShader  = compile ps_3_0 PS_Draw(f22_LenzColor, f22_ColorMultiplier);

		AlphaBlendEnable=TRUE;
		SrcBlend=ONE;
		DestBlend=ONE;

		ColorWriteEnable = ALPHA|RED|GREEN|BLUE;
		DitherEnable=FALSE;
		ZEnable=FALSE;
		CullMode=NONE;
		ALPHATESTENABLE=FALSE;
		SEPARATEALPHABLENDENABLE=FALSE;
		StencilEnable=FALSE;
		FogEnable=FALSE;
		SRGBWRITEENABLE=FALSE;
	}
}
// KYO : and so on...