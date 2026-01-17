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

void UAVDescFromBuffer(D3D11_UNORDERED_ACCESS_VIEW_DESC& desc, char* buffer)
{
    desc = {};
    desc.Format = static_cast<DXGI_FORMAT>(ReadBuffer<uint32_t>(buffer));
    desc.ViewDimension = static_cast<D3D11_UAV_DIMENSION>(ReadBuffer<uint32_t>(buffer));

    switch (desc.ViewDimension)
    {
        case D3D11_UAV_DIMENSION_UNKNOWN:
            break;

        case D3D11_UAV_DIMENSION_BUFFER:
            desc.Buffer.FirstElement = ReadBuffer<UINT>(buffer);
            desc.Buffer.NumElements = ReadBuffer<UINT>(buffer);
            desc.Buffer.Flags = ReadBuffer<UINT>(buffer);
            break;

        case D3D11_UAV_DIMENSION_TEXTURE1D:
            desc.Texture1D.MipSlice = ReadBuffer<UINT>(buffer);
            break;

        case D3D11_UAV_DIMENSION_TEXTURE1DARRAY:
            desc.Texture1DArray.MipSlice = ReadBuffer<UINT>(buffer);
            desc.Texture1DArray.FirstArraySlice = ReadBuffer<UINT>(buffer);
            desc.Texture1DArray.ArraySize = ReadBuffer<UINT>(buffer);
            break;

        case D3D11_UAV_DIMENSION_TEXTURE2D:
            desc.Texture2D.MipSlice = ReadBuffer<UINT>(buffer);
            break;

        case D3D11_UAV_DIMENSION_TEXTURE2DARRAY:
            desc.Texture2DArray.MipSlice = ReadBuffer<UINT>(buffer);
            desc.Texture2DArray.FirstArraySlice = ReadBuffer<UINT>(buffer);
            desc.Texture2DArray.ArraySize = ReadBuffer<UINT>(buffer);
            break;

        case D3D11_UAV_DIMENSION_TEXTURE3D:
            desc.Texture3D.MipSlice = ReadBuffer<UINT>(buffer);
            desc.Texture3D.FirstWSlice = ReadBuffer<UINT>(buffer);
            desc.Texture3D.WSize = ReadBuffer<UINT>(buffer);
            break;
        
        default:
            break;
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
    ID3D11UnorderedAccessView* uav = nullptr;
    if (_uav != GMD3D11_ID_INVALID)
    {
        uav = Trackable::Get<UAV>(static_cast<size_t>(_uav))->GetUAV();
    }
    g_Context->CSSetUnorderedAccessViews(static_cast<UINT>(_slot), 1, &uav, nullptr);
    return GM_TRUE;
}
