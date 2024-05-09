#include <VMTHookManager.hpp>

#include <d3d11.h>
#include <d3dcompiler.h>
#include <iostream>
#include <vector>
#include <Windows.h>

#pragma comment(lib, "d3d11.lib")

extern ID3D11PixelShader* g_OverridePS;
extern ID3D11VertexShader* g_OverrideVS;

ID3D11Device* g_Device = nullptr;
ID3D11DeviceContext* g_Context = nullptr;
VMTHookManager g_ContextHookManager;
char* g_ErrorString = nullptr;
size_t g_DrawInstanced = 0;

enum class ID3D11DeviceContextVtbl
{
    VSSetConstantBuffers = 7,
    PSSetShaderResources,
    PSSetShader,
    PSSetSamplers,
    VSSetShader,
    DrawIndexed,
    Draw,
};

void __stdcall Draw(ID3D11DeviceContext* Context, UINT VertexCount, UINT StartVertexLocation)
{
    static auto fn = reinterpret_cast<void(__thiscall*)(ID3D11DeviceContext*, UINT, UINT)>(
        g_ContextHookManager.dwGetMethodAddress((UINT)ID3D11DeviceContextVtbl::Draw));

    if (g_OverrideVS)
    {
        Context->VSSetShader(g_OverrideVS, nullptr, 0);
    }

    if (g_OverridePS)
    {
        Context->PSSetShader(g_OverridePS, nullptr, 0);
    }

    if (g_DrawInstanced > 0)
    {
        Context->DrawInstanced(VertexCount, g_DrawInstanced, StartVertexLocation, 0);
        g_DrawInstanced = 0;
        return;
    }

    fn(Context, VertexCount, StartVertexLocation);
}

GM_EXPORT double d3d11_init(char* device, char* context)
{
    g_Device = (ID3D11Device*)device;
    g_Context = (ID3D11DeviceContext*)context;

    g_ContextHookManager.bInitialize((_pdword*)g_Context);
    g_ContextHookManager.dwHookMethod((_dword)Draw, (UINT)ID3D11DeviceContextVtbl::Draw);

    return GM_TRUE;
}

GM_EXPORT char* d3d11_get_error_string()
{
    return g_ErrorString ? g_ErrorString : "";
}


GM_EXPORT double d3d11_texture_set_stage_vs(double index)
{
    UINT startSlot = static_cast<UINT>(index);
    if (startSlot < 0
        || startSlot >= D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT)
    {
        return GM_FALSE;
    }
    ID3D11ShaderResourceView* shaderResourceView;
    g_Context->PSGetShaderResources(0, 1, &shaderResourceView);
    g_Context->VSSetShaderResources(startSlot, 1, &shaderResourceView);
    return GM_TRUE;
}

GM_EXPORT double d3d11_texture_set_stage_ps(double index)
{
    UINT startSlot = static_cast<UINT>(index);
    if (startSlot < 0
        || startSlot >= D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT)
    {
        return GM_FALSE;
    }
    ID3D11ShaderResourceView* shaderResourceView;
    g_Context->PSGetShaderResources(0, 1, &shaderResourceView);
    g_Context->PSSetShaderResources(startSlot, 1, &shaderResourceView);
    return GM_TRUE;
}

GM_EXPORT double d3d11_draw_instanced(double count)
{
    g_DrawInstanced = static_cast<size_t>(count);
    return GM_TRUE;
}
