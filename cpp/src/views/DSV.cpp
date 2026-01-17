#include <views/DSV.hpp>

extern ID3D11DeviceContext* g_Context;

DSV::DSV(ID3D11DepthStencilView* dsv)
    : Trackable()
    , Raw(dsv)
{
}

DSV::~DSV()
{
    if (Raw)
    {
        Raw->Release();
    }
}

void DSVDescFromBuffer(D3D11_DEPTH_STENCIL_VIEW_DESC& desc, char* buffer)
{
    desc = {};
    desc.Format = static_cast<DXGI_FORMAT>(ReadBuffer<uint32_t>(buffer));
    desc.ViewDimension = static_cast<D3D11_DSV_DIMENSION>(ReadBuffer<uint32_t>(buffer));
    desc.Flags = ReadBuffer<UINT>(buffer);

    switch (desc.ViewDimension)
    {
        case D3D11_DSV_DIMENSION_UNKNOWN:
            break;

        case D3D11_DSV_DIMENSION_TEXTURE1D:
            desc.Texture1D.MipSlice = ReadBuffer<UINT>(buffer);
            break;

        case D3D11_DSV_DIMENSION_TEXTURE1DARRAY:
            desc.Texture1DArray.MipSlice = ReadBuffer<UINT>(buffer);
            desc.Texture1DArray.FirstArraySlice = ReadBuffer<UINT>(buffer);
            desc.Texture1DArray.ArraySize = ReadBuffer<UINT>(buffer);
            break;

        case D3D11_DSV_DIMENSION_TEXTURE2D:
            desc.Texture2D.MipSlice = ReadBuffer<UINT>(buffer);
            break;

        case D3D11_DSV_DIMENSION_TEXTURE2DARRAY:
            desc.Texture2DArray.MipSlice = ReadBuffer<UINT>(buffer);
            desc.Texture2DArray.FirstArraySlice = ReadBuffer<UINT>(buffer);
            desc.Texture2DArray.ArraySize = ReadBuffer<UINT>(buffer);
            break;

        case D3D11_DSV_DIMENSION_TEXTURE2DMS:
            break;

        case D3D11_DSV_DIMENSION_TEXTURE2DMSARRAY:
            desc.Texture2DMSArray.FirstArraySlice = ReadBuffer<UINT>(buffer);
            desc.Texture2DMSArray.ArraySize = ReadBuffer<UINT>(buffer);
            break;

        default:
            break;
    }
}

/// @func d3d11_dsv_exists(_dsv)
///
/// @desc Checks whether an depth stencil view (DSV) exists.
///
/// @param {Real} _dsv The ID of the DSV.
///
/// @return {Bool} Returns `true` if the DSV exists.
GM_EXPORT ty_real d3d11_dsv_exists(ty_real _dsv)
{
    return (_dsv != GMD3D11_ID_INVALID && Trackable::Exists<DSV>(static_cast<size_t>(_dsv))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_dsv_destroy(_dsv)
///
/// @desc Destroys an depth stencil view (DSV).
///
/// @param {Real} _dsv The ID of the DSV to destroy.
GM_EXPORT ty_real d3d11_dsv_destroy(ty_real _dsv)
{
    delete Trackable::Get<DSV>(static_cast<size_t>(_dsv));
    return GM_TRUE;
}

/// @func d3d11_dsv_clear(_dsv, _r, _g, _b, _a)
///
/// @desc Clears a depth stencil view.
///
/// @param {Real} _dsv The ID of the DSV to clear.
/// @param {Real} _clearFlags Bitwise `OR` between {@link D3D11_CLEAR_DEPTH} and/or {@link D3D11_CLEAR_STENCIL}, depending
/// which ones should be cleared.
/// @param {Real} _depth The depth value to clear the DSV with.
/// @param {Real} _stencil The stencil value to clear the DSV with.
GM_EXPORT ty_real d3d11_dsv_clear(ty_real _dsv, ty_real _clearFlags, ty_real _depth, ty_real _stencil)
{
    g_Context->ClearDepthStencilView(
        Trackable::Get<DSV>(static_cast<size_t>(_dsv))->GetDSV(),
        static_cast<UINT>(_clearFlags),
        static_cast<FLOAT>(_depth),
        static_cast<UINT8>(_stencil));
    return GM_TRUE;
}
