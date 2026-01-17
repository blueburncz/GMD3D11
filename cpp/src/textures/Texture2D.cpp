#include <textures/Texture2D.hpp>

#include <views/DSV.hpp>
#include <views/RTV.hpp>
#include <views/SRV.hpp>
#include <views/UAV.hpp>

#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;

Texture2D::Texture2D(ID3D11Texture2D* texture2D)
    : Trackable()
    , Raw(texture2D)
{
}

Texture2D::~Texture2D()
{
    if (Raw)
    {
        Raw->Release();
    }
}

/// @func d3d11_texture2D_create_impl(_buffer, _pSysMem, _memPitch, _memSlicePitch)
///
/// @desc Creates a new 2D texture.
///
/// @param {Pointer} _buffer A pointer to a buffer containing serialized {@link D3D11_TEXTURE2D_DESC}.
/// @param {Pointer} _pSysMem
/// @param {Real} _memPitch
/// @param {Real} _memSlicePitch
///
/// @return {Real} The ID of the created 2D texture or {@link GMD3D11_ID_INVALID} on fail.
GM_EXPORT ty_real d3d11_texture2D_create_impl(ty_string _buffer, ty_string _pSysMem, ty_real _memPitch, ty_real _memSlicePitch)
{
    D3D11_TEXTURE2D_DESC desc = {};
    desc.Width = ReadBuffer<UINT>(_buffer);
    desc.Height = ReadBuffer<UINT>(_buffer);
    desc.MipLevels = ReadBuffer<UINT>(_buffer);
    desc.ArraySize = ReadBuffer<UINT>(_buffer);
    desc.Format = static_cast<DXGI_FORMAT>(ReadBuffer<uint32_t>(_buffer));
    desc.SampleDesc.Count = ReadBuffer<UINT>(_buffer);
    desc.SampleDesc.Quality = ReadBuffer<UINT>(_buffer);
    desc.Usage = static_cast<D3D11_USAGE>(ReadBuffer<uint32_t>(_buffer));
    desc.BindFlags = ReadBuffer<UINT>(_buffer);
    desc.CPUAccessFlags = ReadBuffer<UINT>(_buffer);
    desc.MiscFlags = ReadBuffer<UINT>(_buffer);

    D3D11_SUBRESOURCE_DATA data = {};
    data.pSysMem = _pSysMem;
    data.SysMemPitch = _memPitch;
    data.SysMemSlicePitch = _memSlicePitch;

    ID3D11Texture2D* texture = nullptr;
    HRESULT hr = g_Device->CreateTexture2D(&desc, &data, &texture);

    if (FAILED(hr))
    {
        std::cout << "Failed to create a 2D texture!" << std::endl;
        return GMD3D11_ID_INVALID;
    } 

    return static_cast<ty_real>((new Texture2D(texture))->GetID());
}

/// @func d3d11_texture2d_exists(_id)
///
/// @desc Checks whether a 2D texture exists.
///
/// @param {Real} _id The ID of the 2D texture.
///
/// @return {Bool} Returns `true` if the 2D texture exists.
GM_EXPORT ty_real d3d11_texture2d_exists(ty_real _id)
{
    return (_id != GMD3D11_ID_INVALID && Trackable::Exists<Texture2D>(static_cast<size_t>(_id))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_texture2d_destroy(_id)
///
/// @desc Destroys a 2D texture.
///
/// @param {Real} _id The ID of the 2D texture to destroy.
GM_EXPORT ty_real d3d11_texture2d_destroy(ty_real _id)
{
    delete Trackable::Get<Texture2D>(static_cast<size_t>(_id));
    return GM_TRUE;
}

/// @func d3d11_texture2d_create_dsv_impl(_id, _buffer)
///
/// @desc Creates a depth stencil view (DSV) for a 2D texture.
///
/// @param {Real} _id The ID of the 2D texture to create an DSV for.
/// @param {Pointer} _buffer A pointer to a buffer containing serialized {@link D3D11_DEPTH_STENCIL_VIEW_DESC} or
/// `pointer_null`.
///
/// @return {Real} The ID of the create DSV on success or {@link GMD3D11_ID_INVALID} on fail.
GM_EXPORT ty_real d3d11_texture2d_create_dsv_impl(ty_real _id, ty_string _buffer)
{
    Texture2D* texture = Trackable::Get<Texture2D>(static_cast<size_t>(_id));

    D3D11_DEPTH_STENCIL_VIEW_DESC desc = {};
    if (_buffer != nullptr)
    {
        DSVDescFromBuffer(desc, _buffer);
    }

    ID3D11DepthStencilView* dsv = nullptr;
    HRESULT hr = g_Device->CreateDepthStencilView(texture->GetTexture2D(), (_buffer != nullptr) ? &desc : nullptr, &dsv);
    
    if (FAILED(hr))
    {
        std::cout << "Failed to create a DSV for a 2D texture!" << std::endl;
        return GMD3D11_ID_INVALID;
    }

    return static_cast<ty_real>((new DSV(dsv))->GetID());
}

/// @func d3d11_texture2d_create_rtv_impl(_id, _buffer)
///
/// @desc Creates an render target view (RTV) for a 2D texture.
///
/// @param {Real} _id The ID of the 2D texture to create an RTV for.
/// @param {Pointer} _buffer A pointer to a buffer containing serialized {@link D3D11_RENDER_TARGET_VIEW_DESC} or
/// `pointer_null`.
///
/// @return {Real} The ID of the create RTV on success or {@link GMD3D11_ID_INVALID} on fail.
GM_EXPORT ty_real d3d11_texture2d_create_rtv_impl(ty_real _id, ty_string _buffer)
{
    Texture2D* texture = Trackable::Get<Texture2D>(static_cast<size_t>(_id));

    D3D11_RENDER_TARGET_VIEW_DESC desc = {};
    if (_buffer != nullptr)
    {
        RTVDescFromBuffer(desc, _buffer);
    }

    ID3D11RenderTargetView* rtv = nullptr;
    HRESULT hr = g_Device->CreateRenderTargetView(texture->GetTexture2D(), (_buffer != nullptr) ? &desc : nullptr, &rtv);
    
    if (FAILED(hr))
    {
        std::cout << "Failed to create an RTV for a 2D texture!" << std::endl;
        return GMD3D11_ID_INVALID;
    }

    return static_cast<ty_real>((new RTV(rtv))->GetID());
}

/// @func d3d11_texture2d_create_srv_impl(_id, _buffer)
///
/// @desc Creates a shader resource view (SRV) for a 2D texture.
///
/// @param {Real} _id The ID of the 2D texture to create an SRV for.
/// @param {Pointer} _buffer A pointer to a buffer containing serialized {@link D3D11_SHADER_RESOURCE_VIEW_DESC} or
/// `pointer_null`.
///
/// @return {Real} The ID of the create SRV on success or {@link GMD3D11_ID_INVALID} on fail.
GM_EXPORT ty_real d3d11_texture2d_create_srv_impl(ty_real _id, ty_string _buffer)
{
    Texture2D* texture = Trackable::Get<Texture2D>(static_cast<size_t>(_id));

    D3D11_SHADER_RESOURCE_VIEW_DESC desc = {};
    if (_buffer != nullptr)
    {
        SRVDescFromBuffer(desc, _buffer);
    }

    ID3D11ShaderResourceView* srv = nullptr;
    HRESULT hr = g_Device->CreateShaderResourceView(texture->GetTexture2D(), (_buffer != nullptr) ? &desc : nullptr, &srv);
    
    if (FAILED(hr))
    {
        std::cout << "Failed to create an SRV for a 2D texture!" << std::endl;
        return GMD3D11_ID_INVALID;
    }

    return static_cast<ty_real>((new SRV(srv))->GetID());
}

/// @func d3d11_texture2d_create_uav_impl(_id, _buffer)
///
/// @desc Creates an unordered access view (UAV) for a 2D texture.
///
/// @param {Real} _id The ID of the 2D texture to create an UAV for.
/// @param {Pointer} _buffer A pointer to a buffer containing serialized {@link D3D11_UNORDERED_ACCESS_VIEW_DESC} or
/// `pointer_null`.
///
/// @return {Real} The ID of the create UAV on success or {@link GMD3D11_ID_INVALID} on fail.
GM_EXPORT ty_real d3d11_texture2d_create_uav_impl(ty_real _id, ty_string _buffer)
{
    Texture2D* texture = Trackable::Get<Texture2D>(static_cast<size_t>(_id));

    D3D11_UNORDERED_ACCESS_VIEW_DESC desc = {};
    if (_buffer != nullptr)
    {
        UAVDescFromBuffer(desc, _buffer);
    }

    ID3D11UnorderedAccessView* uav = nullptr;
    HRESULT hr = g_Device->CreateUnorderedAccessView(texture->GetTexture2D(), (_buffer != nullptr) ? &desc : nullptr, &uav);
    
    if (FAILED(hr))
    {
        std::cout << "Failed to create an UAV for a 2D texture!" << std::endl;
        return GMD3D11_ID_INVALID;
    }

    return static_cast<ty_real>((new UAV(uav))->GetID());
}
