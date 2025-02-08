#include "CommonPS.hlsl"

struct VS_out
{
	float4 Position : SV_POSITION;
	// float3 Normal   : NORMAL0;
	float4 Color    : COLOR0;
	float2 TexCoord : TEXCOORD0;
};

struct PS_out
{
	float4 Color : SV_Target0;
};

void main(in VS_out IN, out PS_out OUT)
{
	OUT.Color = IN.Color * gm_BaseTextureObject.Sample(gm_BaseTexture, IN.TexCoord);
}
