#include "Uav.hpp"

extern ID3D11DeviceContext* g_Context;

Uav::Uav(ID3D11UnorderedAccessView* uav)
    : Raw(uav)
{
}

Uav::~Uav()
{
    if (Raw)
    {
        Raw->Release();
    }
}

/// @func d3d11_uav_exists(_uav)
///
/// @desc Checks whether an unordered access view (UAV) exists.
///
/// @param {Real} _uav The ID of the UAV.
///
/// @return {Bool} Returns true if the UAV exists.
GM_EXPORT ty_real d3d11_uav_exists(ty_real _uav)
{
    return (_uav >= 0.0 && Uav::Exists(static_cast<size_t>(_uav))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_uav_destroy(_uav)
///
/// @desc Destroys an unordered access view (UAV).
///
/// @param {Real} _uav The ID of the UAV to destroy.
GM_EXPORT ty_real d3d11_uav_destroy(ty_real _uav)
{
    delete Uav::Get(static_cast<size_t>(_uav));
    return GM_TRUE;
}

/// @func d3d11_shader_set_uav_cs(_slot, _uav)
///
/// @desc Binds an unordered access view (UAV) to a compute shader.
///
/// @param {Real} _slot The slot to bind the UAV to.
/// @param {Real} _uav The ID of the UAV or -1 to unbind the slot.
///
/// @see d3d11_sbuffer_create_uav
GM_EXPORT ty_real d3d11_shader_set_uav_cs(ty_real _slot, ty_real _uav)
{
    if (_uav >= 0.0)
    {
        ID3D11UnorderedAccessView* uav = Uav::Get(static_cast<size_t>(_uav))->GetUav();
        g_Context->CSSetUnorderedAccessViews(static_cast<UINT>(_slot), 1, &uav, nullptr);
    }
    else
    {
        g_Context->CSSetShaderResources(static_cast<UINT>(_slot), 0, nullptr);
    }
    return GM_TRUE;
}
