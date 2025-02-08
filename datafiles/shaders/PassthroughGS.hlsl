struct VS_out
{
	float4 Position : SV_POSITION;
	// float3 Normal   : NORMAL0;
	float4 Color    : COLOR0;
	float2 TexCoord : TEXCOORD0;
};

struct GS_out
{
    float4 Position : SV_POSITION;
	// float3 Normal   : NORMAL0;
	float4 Color    : COLOR0;
	float2 TexCoord : TEXCOORD0;
};

[maxvertexcount(3)]
void main(triangle VS_out input[3], inout TriangleStream<GS_out> output)
{
    for (int i = 0; i < 3; ++i)
    {
        GS_out element;
        element.Position = input[i].Position;
        // element.Normal = input[i].Normal;
        element.Color = input[i].Color;
        element.TexCoord = input[i].TexCoord;
        output.Append(element);
    }
    output.RestartStrip();
}
