#include <views/RTV.hpp>

extern ID3D11DeviceContext* g_Context;

RTV::RTV(ID3D11RenderTargetView* rtv)
    : Trackable()
    , Raw(rtv)
{
}

RTV::~RTV()
{
    if (Raw)
    {
        Raw->Release();
    }
}

void RTVDescFromBuffer(D3D11_RENDER_TARGET_VIEW_DESC& desc, char* buffer)
{
    desc = {};
    desc.Format = static_cast<DXGI_FORMAT>(ReadBuffer<uint32_t>(buffer));
    desc.ViewDimension = static_cast<D3D11_RTV_DIMENSION>(ReadBuffer<uint32_t>(buffer));

    switch (desc.ViewDimension)
    {
        case D3D11_RTV_DIMENSION_UNKNOWN:
            break;

        case D3D11_RTV_DIMENSION_BUFFER:
            desc.Buffer.FirstElement = ReadBuffer<UINT>(buffer);
            desc.Buffer.ElementOffset = ReadBuffer<UINT>(buffer);
            break;

        case D3D11_RTV_DIMENSION_TEXTURE1D:
            desc.Texture1D.MipSlice = ReadBuffer<UINT>(buffer);
            break;

        case D3D11_RTV_DIMENSION_TEXTURE1DARRAY:
            desc.Texture1DArray.MipSlice = ReadBuffer<UINT>(buffer);
            desc.Texture1DArray.FirstArraySlice = ReadBuffer<UINT>(buffer);
            desc.Texture1DArray.ArraySize = ReadBuffer<UINT>(buffer);
            break;

        case D3D11_RTV_DIMENSION_TEXTURE2D:
            desc.Texture2D.MipSlice = ReadBuffer<UINT>(buffer);
            break;

        case D3D11_RTV_DIMENSION_TEXTURE2DARRAY:
            desc.Texture2DArray.MipSlice = ReadBuffer<UINT>(buffer);
            desc.Texture2DArray.FirstArraySlice = ReadBuffer<UINT>(buffer);
            desc.Texture2DArray.ArraySize = ReadBuffer<UINT>(buffer);
            break;

        case D3D11_RTV_DIMENSION_TEXTURE2DMS:
            break;

        case D3D11_RTV_DIMENSION_TEXTURE2DMSARRAY:
            desc.Texture2DMSArray.FirstArraySlice = ReadBuffer<UINT>(buffer);
            desc.Texture2DMSArray.ArraySize = ReadBuffer<UINT>(buffer);
            break;

        case D3D11_RTV_DIMENSION_TEXTURE3D:
            desc.Texture3D.MipSlice = ReadBuffer<UINT>(buffer);
            desc.Texture3D.FirstWSlice = ReadBuffer<UINT>(buffer);
            desc.Texture3D.WSize = ReadBuffer<UINT>(buffer);
            break;

        default:
            break;
    }
}

/// @func d3d11_rtv_exists(_rtv)
///
/// @desc Checks whether an render target view (RTV) exists.
///
/// @param {Real} _rtv The ID of the RTV.
///
/// @return {Bool} Returns `true` if the RTV exists.
GM_EXPORT ty_real d3d11_rtv_exists(ty_real _rtv)
{
    return (_rtv != GMD3D11_ID_INVALID && Trackable::Exists<RTV>(static_cast<size_t>(_rtv))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_rtv_destroy(_rtv)
///
/// @desc Destroys an render target view (RTV).
///
/// @param {Real} _rtv The ID of the RTV to destroy.
GM_EXPORT ty_real d3d11_rtv_destroy(ty_real _rtv)
{
    delete Trackable::Get<RTV>(static_cast<size_t>(_rtv));
    return GM_TRUE;
}

/// @func d3d11_rtv_clear(_rtv, _r, _g, _b, _a)
///
/// @desc Clears a render target view to given color.
///
/// @param {Real} _rtv The ID of the RTV to clear.
/// @param {Real} _r The value of the red channel.
/// @param {Real} _g The value of the green channel.
/// @param {Real} _b The value of the blue channel.
/// @param {Real} _a The value of the alpha channel.
GM_EXPORT ty_real d3d11_rtv_clear(ty_real _rtv, ty_real _r, ty_real _g, ty_real _b, ty_real _a)
{
    float color[4] = {
        static_cast<float>(_r),
        static_cast<float>(_g),
        static_cast<float>(_b),
        static_cast<float>(_a)
    };
    g_Context->ClearRenderTargetView(Trackable::Get<RTV>(static_cast<size_t>(_rtv))->GetRTV(), color);
    return GM_TRUE;
}

/// @func d3d11_set_render_targets_impl(_buffer)
///
/// @desc
///
/// @param {Pointer} _buffer
GM_EXPORT ty_real d3d11_set_render_targets_impl(ty_string _buffer)
{
    ID3D11RenderTargetView* rtvs[D3D11_SIMULTANEOUS_RENDER_TARGET_COUNT];
    for (uint32_t i = 0; i < D3D11_SIMULTANEOUS_RENDER_TARGET_COUNT; ++i)
    {
        rtvs[i] = nullptr;
    }
    ID3D11DepthStencilView* dsv = nullptr;

    uint32_t numRtvs = ReadBuffer<uint32_t>(_buffer);
    for (uint32_t i = 0; i < numRtvs; ++i)
    {
        uint64_t id = ReadBuffer<uint64_t>(_buffer);
        if (RTV* rtv = Trackable::Get<RTV>(id))
        {
            rtvs[i] = rtv->GetRTV();
        }
    }

    g_Context->OMSetRenderTargets(numRtvs, rtvs, nullptr);

    return GM_TRUE;
}
