#define MATRIX_WORLD                 0
#define MATRIX_WORLD_VIEW            1
#define MATRIX_WORLD_VIEW_PROJECTION 2

cbuffer Matrices : register(b0)
{
	float4x4 gm_Matrices[3];
};

struct VS_in
{
	float3 Position : POSITION;
	// float3 Normal   : NORMAL0;
	float4 Color    : COLOR0;
	float2 TexCoord : TEXCOORD0;
};

struct VS_out
{
	float4 Position : SV_POSITION;
	// float3 Normal   : NORMAL0;
	float4 Color    : COLOR0;
	float2 TexCoord : TEXCOORD0;
};

void main(in VS_in IN, out VS_out OUT)
{
	OUT.Position = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], float4(IN.Position.xyz, 1.0));
	// OUT.Normal = mul(gm_Matrices[MATRIX_WORLD], float4(IN.Normal.xyz, 0.0));
	OUT.Color = IN.Color;
	OUT.TexCoord = IN.TexCoord;
}
