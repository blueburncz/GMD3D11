#include <VMTHookManager.hpp>

#include <d3d11.h>
#include <d3dcompiler.h>
#include <DirectXMath.h>
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

/// @func d3d11_init(_device, _context)
///
/// @desc Initializes the GMD3D11 extension. Must be called first before using any other functions!
///
/// @param {Pointer} _device A pointer to the D3D11 device, retrieved from `os_get_info()`.
/// @param {Pointer} _context A pointer to the D3D11 context, retrieved from `os_get_info()`.
GM_EXPORT ty_real d3d11_init(ty_string _device, ty_string _context)
{
    g_Device = (ID3D11Device*)_device;
    g_Context = (ID3D11DeviceContext*)_context;

    g_ContextHookManager.bInitialize((_pdword*)g_Context);
    g_ContextHookManager.dwHookMethod((_dword)Draw, (UINT)ID3D11DeviceContextVtbl::Draw);

    return GM_TRUE;
}

/// @func d3d11_get_error_string()
///
/// @desc Retrieves the last error string.
///
/// @return {String} The last error string.
GM_EXPORT ty_string d3d11_get_error_string()
{
    return g_ErrorString ? g_ErrorString : "";
}

/// @func d3d11_srv_copy_ps_vs(_src, _dest)
///
/// @desc Copies a shader resource view bound to a given slot in a pixel shader to another slot in a vertex shader.
///
/// @param {Real} _src The slot index in the pixel shader to copy from.
/// @param {Real} _dest The slot index in the verex shader to copy to.
///
/// @return {Bool} Returns `true` on success or `false` otherwise.
GM_EXPORT ty_real d3d11_srv_copy_ps_vs(ty_real _src, ty_real _dest)
{
    UINT src = static_cast<UINT>(_src);
    UINT dest = static_cast<UINT>(_dest);
    if ((src < 0 || src >= D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT)
        || (dest < 0 || dest >= D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT))
    {
        return GM_FALSE;
    }
    ID3D11ShaderResourceView* shaderResourceView;
    g_Context->PSGetShaderResources(src, 1, &shaderResourceView);
    g_Context->VSSetShaderResources(dest, 1, &shaderResourceView);
    return GM_TRUE;
}

/// @func d3d11_srv_copy_ps_gs(_src, _dest)
///
/// @desc Copies a shader resource view bound to a given slot in a pixel shader to another slot in a geometry shader.
///
/// @param {Real} _src The slot index in the pixel shader to copy from.
/// @param {Real} _dest The slot index in the geometry shader to copy to.
///
/// @return {Bool} Returns `true` on success or `false` otherwise.
GM_EXPORT ty_real d3d11_srv_copy_ps_gs(ty_real _src, ty_real _dest)
{
    UINT src = static_cast<UINT>(_src);
    UINT dest = static_cast<UINT>(_dest);
    if ((src < 0 || src >= D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT)
        || (dest < 0 || dest >= D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT))
    {
        return GM_FALSE;
    }
    ID3D11ShaderResourceView* shaderResourceView;
    g_Context->PSGetShaderResources(src, 1, &shaderResourceView);
    g_Context->GSSetShaderResources(dest, 1, &shaderResourceView);
    return GM_TRUE;
}

/// @func d3d11_srv_copy_ps_ps(_src, _dest)
///
/// @desc Copies a shader resource view bound to a given slot in a pixel shader to another slot in a pixel shader.
///
/// @param {Real} _src The slot index in the pixel shader to copy from.
/// @param {Real} _dest The slot index in the pixel shader to copy to.
///
/// @return {Bool} Returns `true` on success or `false` otherwise.
GM_EXPORT ty_real d3d11_srv_copy_ps_ps(ty_real _src, ty_real _dest)
{
    UINT src = static_cast<UINT>(_src);
    UINT dest = static_cast<UINT>(_dest);
    if ((src < 0 || src >= D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT)
        || (dest < 0 || dest >= D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT))
    {
        return GM_FALSE;
    }
    ID3D11ShaderResourceView* shaderResourceView;
    g_Context->PSGetShaderResources(src, 1, &shaderResourceView);
    g_Context->PSSetShaderResources(dest, 1, &shaderResourceView);
    return GM_TRUE;
}

/// @func d3d11_srv_copy_ps_cs(_src, _dest)
///
/// @desc Copies a shader resource view bound to a given slot in a pixel shader to another slot in a compute shader.
///
/// @param {Real} _src The slot index in the pixel shader to copy from.
/// @param {Real} _dest The slot index in the compute shader to copy to.
///
/// @return {Bool} Returns `true` on success or `false` otherwise.
GM_EXPORT ty_real d3d11_srv_copy_ps_cs(ty_real _src, ty_real _dest)
{
    UINT src = static_cast<UINT>(_src);
    UINT dest = static_cast<UINT>(_dest);
    if ((src < 0 || src >= D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT)
        || (dest < 0 || dest >= D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT))
    {
        return GM_FALSE;
    }
    ID3D11ShaderResourceView* shaderResourceView;
    g_Context->PSGetShaderResources(src, 1, &shaderResourceView);
    g_Context->CSSetShaderResources(dest, 1, &shaderResourceView);
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

enum class EType : uint32_t
{
    Bool = 0,
    Int,
    Int2,
    Int3,
    Int4,
    Uint,
    Uint2,
    Uint3,
    Uint4,
    Float,
    Float2,
    Float3,
    Float4,
    Float4x4,
    SIZE
};

/// @func d3d11_sizeof(_type)
///
/// @desc Retrieves size of given type, in bytes.
///
/// @param {Real} _type The type to get the byte-size of.
///
/// @return {Real} The size of given type or 0 if the type is not valid.
///
/// @see D3D11_BOOL
/// @see D3D11_INT
/// @see D3D11_INT2
/// @see D3D11_INT3
/// @see D3D11_INT4
/// @see D3D11_UINT
/// @see D3D11_UINT2
/// @see D3D11_UINT3
/// @see D3D11_UINT4
/// @see D3D11_FLOAT
/// @see D3D11_FLOAT2
/// @see D3D11_FLOAT3
/// @see D3D11_FLOAT4
/// @see D3D11_FLOAT4X4
GM_EXPORT ty_real d3d11_sizeof(ty_real _type)
{
    if (_type < 0.0 || _type >= static_cast<ty_real>(EType::SIZE))
    {
        return 0.0;
    }

    switch (static_cast<EType>(_type))
    {
    case EType::Bool:
        return sizeof(bool);

    case EType::Int:
        return sizeof(int32_t);

    case EType::Int2:
        return sizeof(DirectX::XMINT2);

    case EType::Int3:
        return sizeof(DirectX::XMINT3);

    case EType::Int4:
        return sizeof(DirectX::XMINT4);

    case EType::Uint:
        return sizeof(uint32_t);

    case EType::Uint2:
        return sizeof(DirectX::XMUINT2);

    case EType::Uint3:
        return sizeof(DirectX::XMUINT3);

    case EType::Uint4:
        return sizeof(DirectX::XMUINT4);

    case EType::Float:
        return sizeof(float);

    case EType::Float2:
        return sizeof(DirectX::XMFLOAT2);

    case EType::Float3:
        return sizeof(DirectX::XMFLOAT3);

    case EType::Float4:
        return sizeof(DirectX::XMFLOAT4);

    case EType::Float4x4:
        return sizeof(DirectX::XMFLOAT4X4);

    default:
        return 0.0;
    }
}

/// @func d3d11_sizeof_aligned(_type, _alignment)
///
/// @desc Retrieves aligned byte size of given type.
///
/// @param {Real} _type The type to get the byte size of.
/// @param {Real} _alignment The required aligned byte size.
///
/// @return {Real} The aligned byte size of given type or 0 if the type is not valid.
///
/// @see D3D11_BOOL
/// @see D3D11_INT
/// @see D3D11_INT2
/// @see D3D11_INT3
/// @see D3D11_INT4
/// @see D3D11_UINT
/// @see D3D11_UINT2
/// @see D3D11_UINT3
/// @see D3D11_UINT4
/// @see D3D11_FLOAT
/// @see D3D11_FLOAT2
/// @see D3D11_FLOAT3
/// @see D3D11_FLOAT4
/// @see D3D11_FLOAT4X4
GM_EXPORT ty_real d3d11_sizeof_aligned(ty_real _type, ty_real _alignment)
{
    if (_type < 0.0 || _type >= static_cast<ty_real>(EType::SIZE))
    {
        return 0.0;
    }
    return static_cast<ty_real>(RoundUp(static_cast<size_t>(d3d11_sizeof(_type)), static_cast<size_t>(_alignment)));
}
