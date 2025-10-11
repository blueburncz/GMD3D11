StructuredBuffer<float> g_Input : register(t0);
RWStructuredBuffer<float> g_Output : register(u0);

[numthreads(64, 1, 1)]
void main(uint3 threadID : SV_DispatchThreadID)
{
	g_Output[threadID.x] = g_Input[threadID.x] * 2.0f;
}
