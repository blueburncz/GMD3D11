#include "Srv.hpp"

extern ID3D11DeviceContext* g_Context;

Srv::Srv(ID3D11ShaderResourceView* srv)
    : Raw(srv)
{
}

Srv::~Srv()
{
    if (Raw)
    {
        Raw->Release();
    }
}

/// @func d3d11_srv_exists(_srv)
///
/// @desc Checks whether a shader resource view (SRV) exists.
///
/// @param {Real} _srv The ID of the SRV.
///
/// @return {Bool} Returns true if the SRV exists.
GM_EXPORT ty_real d3d11_srv_exists(ty_real _srv)
{
    return (_srv >= 0.0 && Srv::Exists(static_cast<size_t>(_srv))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_srv_destroy(_srv)
///
/// @desc Destroys a shader resource view (SRV).
///
/// @param {Real} _srv The ID of the SRV to destroy.
GM_EXPORT ty_real d3d11_srv_destroy(ty_real _srv)
{
    delete Srv::Get(static_cast<size_t>(_srv));
    return GM_TRUE;
}

/// @func d3d11_shader_set_srv_vs(_slot, _srv)
///
/// @desc Binds a shader resource view (SRV) to a vertex shader.
///
/// @param {Real} _slot The slot to bind the SRV to.
/// @param {Real} _srv The ID of the SRV or -1 to unbind the slot.
///
/// @see d3d11_sbuffer_create_srv
GM_EXPORT ty_real d3d11_shader_set_srv_vs(ty_real _slot, ty_real _srv)
{
    if (_srv >= 0.0)
    {
        ID3D11ShaderResourceView* srv = Srv::Get(static_cast<size_t>(_srv))->GetSrv();
        g_Context->VSSetShaderResources(static_cast<UINT>(_slot), 1, &srv);
    }
    else
    {
        g_Context->VSSetShaderResources(static_cast<UINT>(_slot), 0, nullptr);
    }
    return GM_TRUE;
}

/// @func d3d11_shader_set_srv_gs(_slot, _srv)
///
/// @desc Binds a shader resource view (SRV) to a geometry shader.
///
/// @param {Real} _slot The slot to bind the SRV to.
/// @param {Real} _srv The ID of the SRV or -1 to unbind the slot.
///
/// @see d3d11_sbuffer_create_srv
GM_EXPORT ty_real d3d11_shader_set_srv_gs(ty_real _slot, ty_real _srv)
{
    if (_srv >= 0.0)
    {
        ID3D11ShaderResourceView* srv = Srv::Get(static_cast<size_t>(_srv))->GetSrv();
        g_Context->GSSetShaderResources(static_cast<UINT>(_slot), 1, &srv);
    }
    else
    {
        g_Context->GSSetShaderResources(static_cast<UINT>(_slot), 0, nullptr);
    }
    return GM_TRUE;
}

/// @func d3d11_shader_set_srv_ps(_slot, _srv)
///
/// @desc Binds a shader resource view (SRV) to a pixel shader.
///
/// @param {Real} _slot The slot to bind the SRV to.
/// @param {Real} _srv The ID of the SRV or -1 to unbind the slot.
///
/// @see d3d11_sbuffer_create_srv
GM_EXPORT ty_real d3d11_shader_set_srv_ps(ty_real _slot, ty_real _srv)
{
    if (_srv >= 0.0)
    {
        ID3D11ShaderResourceView* srv = Srv::Get(static_cast<size_t>(_srv))->GetSrv();
        g_Context->PSSetShaderResources(static_cast<UINT>(_slot), 1, &srv);
    }
    else
    {
        g_Context->PSSetShaderResources(static_cast<UINT>(_slot), 0, nullptr);
    }
    return GM_TRUE;
}

/// @func d3d11_shader_set_srv_cs(_slot, _srv)
///
/// @desc Binds a shader resource view (SRV) to a compute shader.
///
/// @param {Real} _slot The slot to bind the SRV to.
/// @param {Real} _srv The ID of the SRV or -1 to unbind the slot.
///
/// @see d3d11_sbuffer_create_srv
GM_EXPORT ty_real d3d11_shader_set_srv_cs(ty_real _slot, ty_real _srv)
{
    if (_srv >= 0.0)
    {
        ID3D11ShaderResourceView* srv = Srv::Get(static_cast<size_t>(_srv))->GetSrv();
        g_Context->CSSetShaderResources(static_cast<UINT>(_slot), 1, &srv);
    }
    else
    {
        g_Context->CSSetShaderResources(static_cast<UINT>(_slot), 0, nullptr);
    }
    return GM_TRUE;
}
