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

GM_EXPORT ty_real d3d11_init(ty_string _device, ty_string _context)
{
    g_Device = (ID3D11Device*)_device;
    g_Context = (ID3D11DeviceContext*)_context;

    g_ContextHookManager.bInitialize((_pdword*)g_Context);
    g_ContextHookManager.dwHookMethod((_dword)Draw, (UINT)ID3D11DeviceContextVtbl::Draw);

    return GM_TRUE;
}

GM_EXPORT ty_string d3d11_get_error_string()
{
    return g_ErrorString ? g_ErrorString : "";
}

GM_EXPORT ty_real d3d11_texture_copy_vs(ty_real _index)
{
    UINT startSlot = static_cast<UINT>(_index);
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

GM_EXPORT ty_real d3d11_texture_copy_gs(ty_real _index)
{
    UINT startSlot = static_cast<UINT>(_index);
    if (startSlot < 0
        || startSlot >= D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT)
    {
        return GM_FALSE;
    }
    ID3D11ShaderResourceView* shaderResourceView;
    g_Context->PSGetShaderResources(0, 1, &shaderResourceView);
    g_Context->GSSetShaderResources(startSlot, 1, &shaderResourceView);
    return GM_TRUE;
}

GM_EXPORT ty_real d3d11_texture_copy_ps(ty_real _index)
{
    UINT startSlot = static_cast<UINT>(_index);
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

/// @func d3d11_draw_instanced(_count)
///
/// @desc Configures the number of instances to draw the next time a vertex buffer is submitted. After that the number
/// is reset back to 0!
///
/// @param {Real} _count Number of instances to draw. Use 0 to disable instanced rendering.
GM_EXPORT ty_real d3d11_draw_instanced(ty_real _count)
{
    g_DrawInstanced = static_cast<size_t>(_count);
    return GM_TRUE;
}
