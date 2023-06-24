struct VS_in
{
	float3 Position : POSITION0;
	float2 TexCoord : TEXCOORD0;
	uint InstanceID : SV_InstanceID;
};

struct VS_out
{
	float4 Position : SV_POSITION;
	float2 TexCoord : TEXCOORD0;
};

float3 u_instanceData[2];

void main(in VS_in IN, out VS_out OUT)
{
	float3 position = IN.Position + u_instanceData[uint(IN.InstanceID)];
	OUT.Position = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], float4(position.x, position.y, position.z, 1.0));
	OUT.TexCoord = IN.TexCoord;
}
