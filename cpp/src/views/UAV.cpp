#include <views/UAV.hpp>

extern ID3D11DeviceContext* g_Context;

UAV::UAV(ID3D11UnorderedAccessView* uav)
    : Trackable()
    , Raw(uav)
{
}

UAV::~UAV()
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
/// @return {Bool} Returns `true` if the UAV exists.
GM_EXPORT ty_real d3d11_uav_exists(ty_real _uav)
{
    return (_uav != GMD3D11_ID_INVALID && Trackable::Exists<UAV>(static_cast<size_t>(_uav))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_uav_destroy(_uav)
///
/// @desc Destroys an unordered access view (UAV).
///
/// @param {Real} _uav The ID of the UAV to destroy.
GM_EXPORT ty_real d3d11_uav_destroy(ty_real _uav)
{
    delete Trackable::Get<UAV>(static_cast<size_t>(_uav));
    return GM_TRUE;
}

/// @func d3d11_shader_set_uav_cs(_slot, _uav)
///
/// @desc Binds an unordered access view (UAV) to a compute shader.
///
/// @param {Real} _slot The slot to bind the UAV to.
/// @param {Real} _uav The ID of the UAV or {@link GMD3D11_ID_INVALID} to unbind the slot.
GM_EXPORT ty_real d3d11_shader_set_uav_cs(ty_real _slot, ty_real _uav)
{
    if (_uav != GMD3D11_ID_INVALID)
    {
        ID3D11UnorderedAccessView* uav = Trackable::Get<UAV>(static_cast<size_t>(_uav))->GetUAV();
        g_Context->CSSetUnorderedAccessViews(static_cast<UINT>(_slot), 1, &uav, nullptr);
    }
    else
    {
        g_Context->CSSetShaderResources(static_cast<UINT>(_slot), 0, nullptr);
    }
    return GM_TRUE;
}
