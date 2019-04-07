/*
	menbdrawutil.fx : MariENB drawing utilities.
	(C)2013-2015 Marisa Kirisame, UnSX Team.
	Part of MariENB, the personal ENB of Marisa.
	Released under the GNU GPLv3 (or later).
*/
/*
   This code is unused for now due to the fact ENB just shits itself and
   whitescreens (sometimes goes black for a split second, then back to white)
   when drawing too much text. For no known reason whatsoever, so likely it's
   just because ENB is shit, period.
*/
texture2D tfnt
<
	string ResourceName = "menbcgafont.png";
>;
sampler2D sfnt = sampler_state
{
	Texture = <tfnt>;
	MinFilter = POINT;
	MagFilter = POINT;
	MipFilter = NONE;
	AddressU = Clamp;
	AddressV = Clamp;
	SRGBTexture = FALSE;
	MaxMipLevel = 0;
	MipMapLodBias = 0;
};
/* Get a glyph */
float GetChar( in float2 coord, in int chr, in bool bold )
{
	float2 siz = float2(1./32.,1./16.);
	float cv = float(chr)*siz.x;
	float2 ccoord = float2(frac(cv),siz.y*floor(cv));
	if ( bold ) ccoord.y += 0.5;
	return tex2D(sfnt,ccoord+coord*siz).x;
}
/* Draw a single glyph */
float DrawChar( in float2 coord, inout float2 of, in int chr, in bool bold )
{
	if ( chr == 0 ) return 0.;
	float2 rresl = float2(ScreenSize.x,ScreenSize.x*ScreenSize.w);
	float2 bresl = rresl/8.;
	float2 cc = coord*bresl-of;
	of.x += 1.;
	if ( (cc.x >= 0.) && (cc.y >= 0.) && (cc.x < 1.) && (cc.y < 1.) )
		return GetChar(cc,chr,bold);
	return 0.;
}
/* Draw a string */
float DrawText1( in float2 coord, inout float2 of, in int4 ta, in bool bold )
{
	float res = DrawChar(coord,of,ta.x,bold);
	res += DrawChar(coord,of,ta.y,bold);
	res += DrawChar(coord,of,ta.z,bold);
	res += DrawChar(coord,of,ta.w,bold);
	return res;
}
float DrawText2( in float2 coord, inout float2 of, in int4 ta, in int4 tb,
	in bool bold )
{
	float res = DrawChar(coord,of,ta.x,bold);
	res += DrawChar(coord,of,ta.y,bold);
	res += DrawChar(coord,of,ta.z,bold);
	res += DrawChar(coord,of,ta.w,bold);
	res += DrawChar(coord,of,tb.x,bold);
	res += DrawChar(coord,of,tb.y,bold);
	res += DrawChar(coord,of,tb.z,bold);
	res += DrawChar(coord,of,tb.w,bold);
	return res;
}
float DrawText3( in float2 coord, inout float2 of, in int4 ta, in int4 tb,
	in int4 tc, in bool bold )
{
	float res = DrawChar(coord,of,ta.x,bold);
	res += DrawChar(coord,of,ta.y,bold);
	res += DrawChar(coord,of,ta.z,bold);
	res += DrawChar(coord,of,ta.w,bold);
	res += DrawChar(coord,of,tb.x,bold);
	res += DrawChar(coord,of,tb.y,bold);
	res += DrawChar(coord,of,tb.z,bold);
	res += DrawChar(coord,of,tb.w,bold);
	res += DrawChar(coord,of,tc.x,bold);
	res += DrawChar(coord,of,tc.y,bold);
	res += DrawChar(coord,of,tc.z,bold);
	res += DrawChar(coord,of,tc.w,bold);
	return res;
}
float DrawText4( in float2 coord, inout float2 of, in int4 ta, in int4 tb,
	in int4 tc, in int4 td, in bool bold )
{
	float res = DrawChar(coord,of,ta.x,bold);
	res += DrawChar(coord,of,ta.y,bold);
	res += DrawChar(coord,of,ta.z,bold);
	res += DrawChar(coord,of,ta.w,bold);
	res += DrawChar(coord,of,tb.x,bold);
	res += DrawChar(coord,of,tb.y,bold);
	res += DrawChar(coord,of,tb.z,bold);
	res += DrawChar(coord,of,tb.w,bold);
	res += DrawChar(coord,of,tc.x,bold);
	res += DrawChar(coord,of,tc.y,bold);
	res += DrawChar(coord,of,tc.z,bold);
	res += DrawChar(coord,of,tc.w,bold);
	res += DrawChar(coord,of,td.x,bold);
	res += DrawChar(coord,of,td.y,bold);
	res += DrawChar(coord,of,td.z,bold);
	res += DrawChar(coord,of,td.w,bold);
	return res;
}
/* Draw a float */
float DrawFloat( in float2 coord, inout float2 of, in float f, in bool bold )
{
	float res = 0.;
	if ( f < 0. ) res += DrawChar(coord,of,45,bold);
	int fi = abs(floor(f));
	int nn = fi, i = 0;
	do
	{
		nn /= 10;
		i++;
	} while ( nn > 0 );
	do
	{
		i--;
		res += DrawChar(coord,of,(fi/pow(10,i))%10+48,bold);
	} while ( i > 0 );
	res += DrawChar(coord,of,46,bold);
	float fd = abs(frac(f));
	for ( i=1; i<7; i++ )
		res += DrawChar(coord,of,floor(fd*pow(10,i))%10+48,bold);
	return res;
}
float DrawFloat2( in float2 coord, inout float2 of, in float2 f, in bool bold )
{
	float res = 0.;
	res += DrawFloat(coord,of,f.x,bold);
	res += DrawText1(coord,of,int4(44,32,0,0),bold);
	res += DrawFloat(coord,of,f.y,bold);
	return res;
}
float DrawFloat3( in float2 coord, inout float2 of, in float3 f, in bool bold )
{
	float res = 0.;
	res += DrawFloat(coord,of,f.x,bold);
	res += DrawText1(coord,of,int4(44,32,0,0),bold);
	res += DrawFloat(coord,of,f.y,bold);
	res += DrawText1(coord,of,int4(44,32,0,0),bold);
	res += DrawFloat(coord,of,f.z,bold);
	return res;
}
float DrawFloat4( in float2 coord, inout float2 of, in float4 f, in bool bold )
{
	float res = 0.;
	res += DrawFloat(coord,of,f.x,bold);
	res += DrawText1(coord,of,int4(44,32,0,0),bold);
	res += DrawFloat(coord,of,f.y,bold);
	res += DrawText1(coord,of,int4(44,32,0,0),bold);
	res += DrawFloat(coord,of,f.z,bold);
	res += DrawText1(coord,of,int4(44,32,0,0),bold);
	res += DrawFloat(coord,of,f.w,bold);
	return res;
}
