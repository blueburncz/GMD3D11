#include <views/SRV.hpp>

extern ID3D11DeviceContext* g_Context;

SRV::SRV(ID3D11ShaderResourceView* srv)
    : Trackable()
    , Raw(srv)
{
}

SRV::~SRV()
{
    if (Raw)
    {
        Raw->Release();
    }
}

void SRVDescFromBuffer(D3D11_SHADER_RESOURCE_VIEW_DESC& desc, char* buffer)
{
    desc = {};
    desc.Format = static_cast<DXGI_FORMAT>(ReadBuffer<uint32_t>(buffer));
    desc.ViewDimension = static_cast<D3D11_SRV_DIMENSION>(ReadBuffer<uint32_t>(buffer));

    switch (desc.ViewDimension)
    {
        case D3D_SRV_DIMENSION_UNKNOWN:
            break;

        case D3D_SRV_DIMENSION_BUFFER:
            desc.Buffer.FirstElement = ReadBuffer<UINT>(buffer);
            desc.Buffer.ElementOffset = ReadBuffer<UINT>(buffer);
            break;

        case D3D_SRV_DIMENSION_TEXTURE1D:
            desc.Texture1D.MostDetailedMip = ReadBuffer<UINT>(buffer);
            desc.Texture1D.MipLevels = ReadBuffer<UINT>(buffer);
            break;

        case D3D_SRV_DIMENSION_TEXTURE1DARRAY:
            desc.Texture1DArray.MostDetailedMip = ReadBuffer<UINT>(buffer);
            desc.Texture1DArray.MipLevels = ReadBuffer<UINT>(buffer);
            desc.Texture1DArray.FirstArraySlice = ReadBuffer<UINT>(buffer);
            desc.Texture1DArray.ArraySize = ReadBuffer<UINT>(buffer);
            break;

        case D3D_SRV_DIMENSION_TEXTURE2D:
            desc.Texture2D.MostDetailedMip = ReadBuffer<UINT>(buffer);
            desc.Texture2D.MipLevels = ReadBuffer<UINT>(buffer);
            break;

        case D3D_SRV_DIMENSION_TEXTURE2DARRAY:
            desc.Texture2DArray.MostDetailedMip = ReadBuffer<UINT>(buffer);
            desc.Texture2DArray.MipLevels = ReadBuffer<UINT>(buffer);
            desc.Texture2DArray.FirstArraySlice = ReadBuffer<UINT>(buffer);
            desc.Texture2DArray.ArraySize = ReadBuffer<UINT>(buffer);
            break;

        case D3D_SRV_DIMENSION_TEXTURE2DMS:
            break;

        case D3D_SRV_DIMENSION_TEXTURE2DMSARRAY:
            desc.Texture2DMSArray.FirstArraySlice = ReadBuffer<UINT>(buffer);
            desc.Texture2DMSArray.ArraySize = ReadBuffer<UINT>(buffer);
            break;

        case D3D_SRV_DIMENSION_TEXTURE3D:
            desc.Texture3D.MostDetailedMip = ReadBuffer<UINT>(buffer);
            desc.Texture3D.MipLevels = ReadBuffer<UINT>(buffer);
            break;

        case D3D_SRV_DIMENSION_TEXTURECUBE:
            desc.TextureCube.MostDetailedMip = ReadBuffer<UINT>(buffer);
            desc.TextureCube.MipLevels = ReadBuffer<UINT>(buffer);
            break;

        case D3D_SRV_DIMENSION_TEXTURECUBEARRAY:
            desc.TextureCubeArray.MostDetailedMip = ReadBuffer<UINT>(buffer);
            desc.TextureCubeArray.MipLevels = ReadBuffer<UINT>(buffer);
            desc.TextureCubeArray.First2DArrayFace = ReadBuffer<UINT>(buffer);
            desc.TextureCubeArray.NumCubes = ReadBuffer<UINT>(buffer);
            break;

        case D3D_SRV_DIMENSION_BUFFEREX:
            desc.BufferEx.FirstElement = ReadBuffer<UINT>(buffer);
            desc.BufferEx.NumElements = ReadBuffer<UINT>(buffer);
            desc.BufferEx.Flags = ReadBuffer<UINT>(buffer);
            break;

        default:
            break;
    }
}

/// @func d3d11_srv_exists(_srv)
///
/// @desc Checks whether a shader resource view (SRV) exists.
///
/// @param {Real} _srv The ID of the SRV.
///
/// @return {Bool} Returns `true` if the SRV exists.
GM_EXPORT ty_real d3d11_srv_exists(ty_real _srv)
{
    return (_srv != GMD3D11_ID_INVALID && Trackable::Exists<SRV>(static_cast<size_t>(_srv))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_srv_destroy(_srv)
///
/// @desc Destroys a shader resource view (SRV).
///
/// @param {Real} _srv The ID of the SRV to destroy.
GM_EXPORT ty_real d3d11_srv_destroy(ty_real _srv)
{
    delete Trackable::Get<SRV>(static_cast<size_t>(_srv));
    return GM_TRUE;
}

/// @func d3d11_srv_generate_mips(_srv)
///
/// @desc Generates texture mips using given shader resource view (SRV).
///
/// @param {Real} _srv The ID of the SRV.
GM_EXPORT ty_real d3d11_srv_generate_mips(ty_real _srv)
{
    ID3D11ShaderResourceView* srv = Trackable::Get<SRV>(static_cast<size_t>(_srv))->GetSRV();
    g_Context->GenerateMips(srv);
    return GM_TRUE;
}

/// @func d3d11_shader_set_srv_vs(_slot, _srv)
///
/// @desc Binds a shader resource view (SRV) to a vertex shader.
///
/// @param {Real} _slot The slot to bind the SRV to.
/// @param {Real} _srv The ID of the SRV or {@link GMD3D11_ID_INVALID} to unbind the slot.
GM_EXPORT ty_real d3d11_shader_set_srv_vs(ty_real _slot, ty_real _srv)
{
    ID3D11ShaderResourceView* srv = nullptr;
    if (_srv != GMD3D11_ID_INVALID)
    {
        srv = Trackable::Get<SRV>(static_cast<size_t>(_srv))->GetSRV();
    }
    g_Context->VSSetShaderResources(static_cast<UINT>(_slot), 1, &srv);
    return GM_TRUE;
}

/// @func d3d11_shader_set_srv_gs(_slot, _srv)
///
/// @desc Binds a shader resource view (SRV) to a geometry shader.
///
/// @param {Real} _slot The slot to bind the SRV to.
/// @param {Real} _srv The ID of the SRV or {@link GMD3D11_ID_INVALID} to unbind the slot.
GM_EXPORT ty_real d3d11_shader_set_srv_gs(ty_real _slot, ty_real _srv)
{
    ID3D11ShaderResourceView* srv = nullptr;
    if (_srv != GMD3D11_ID_INVALID)
    {
        srv = Trackable::Get<SRV>(static_cast<size_t>(_srv))->GetSRV();
    }
    g_Context->GSSetShaderResources(static_cast<UINT>(_slot), 1, &srv);
    return GM_TRUE;
}

/// @func d3d11_shader_set_srv_ps(_slot, _srv)
///
/// @desc Binds a shader resource view (SRV) to a pixel shader.
///
/// @param {Real} _slot The slot to bind the SRV to.
/// @param {Real} _srv The ID of the SRV or {@link GMD3D11_ID_INVALID} to unbind the slot.
GM_EXPORT ty_real d3d11_shader_set_srv_ps(ty_real _slot, ty_real _srv)
{
    ID3D11ShaderResourceView* srv = nullptr;
    if (_srv != GMD3D11_ID_INVALID)
    {
        srv = Trackable::Get<SRV>(static_cast<size_t>(_srv))->GetSRV();
    }
    g_Context->PSSetShaderResources(static_cast<UINT>(_slot), 1, &srv);
    return GM_TRUE;
}

/// @func d3d11_shader_set_srv_cs(_slot, _srv)
///
/// @desc Binds a shader resource view (SRV) to a compute shader.
///
/// @param {Real} _slot The slot to bind the SRV to.
/// @param {Real} _srv The ID of the SRV or {@link GMD3D11_ID_INVALID} to unbind the slot.
GM_EXPORT ty_real d3d11_shader_set_srv_cs(ty_real _slot, ty_real _srv)
{
    ID3D11ShaderResourceView* srv = nullptr;
    if (_srv != GMD3D11_ID_INVALID)
    {
        srv = Trackable::Get<SRV>(static_cast<size_t>(_srv))->GetSRV();
    }
    g_Context->CSSetShaderResources(static_cast<UINT>(_slot), 1, &srv);
    return GM_TRUE;
}
