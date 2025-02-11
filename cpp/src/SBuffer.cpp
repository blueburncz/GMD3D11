#include <SBuffer.hpp>

#include <cstdint>
#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;

SBuffer::SBuffer(ID3D11Buffer* buffer, size_t stride, size_t numElements)
    : Buffer(buffer)
    , Stride(stride)
    , NumElements(numElements)
{
}

SBuffer::~SBuffer()
{
    if (Buffer)
    {
        Buffer->Release();
    }
}

Srv* SBuffer::CreateSrv() const
{
    D3D11_SHADER_RESOURCE_VIEW_DESC srvDesc = {};
    srvDesc.Format = DXGI_FORMAT_UNKNOWN;
    srvDesc.ViewDimension = D3D11_SRV_DIMENSION_BUFFER;
    srvDesc.Buffer.NumElements = NumElements;

    ID3D11ShaderResourceView* srv = nullptr;
    HRESULT hr = g_Device->CreateShaderResourceView(Buffer, &srvDesc, &srv);

    if (FAILED(hr))
    {
        std::cout << "Failed to create SRV for a structured buffer!" << std::endl;
        return nullptr;
    }

    return new Srv(srv);
}

Uav* SBuffer::CreateUav() const
{
    D3D11_UNORDERED_ACCESS_VIEW_DESC uavDesc = {};
    uavDesc.Format = DXGI_FORMAT_UNKNOWN;
    uavDesc.ViewDimension = D3D11_UAV_DIMENSION_BUFFER;
    uavDesc.Buffer.NumElements = NumElements;
    
    ID3D11UnorderedAccessView* uav = nullptr;
    HRESULT hr = g_Device->CreateUnorderedAccessView(Buffer, &uavDesc, &uav);

    if (FAILED(hr))
    {
        std::cout << "Failed to create UAV for a structured buffer!" << std::endl;
        return nullptr;
    }

    return new Uav(uav);
}

/// @func d3d11_sbuffer_create(_stride, _numElements)
///
/// @desc Creates a new structured buffer.
///
/// @param {Real} _stride The stride of a single element, in bytes.
/// @param {Real} _numElements The number of elements in the buffer.
///
/// @return {Real} The ID of the created structured buffer or -1 on fail.
///
/// @see d3d11_struct_begin
/// @see d3d11_sbuffer_exists
/// @see d3d11_sbuffer_update
GM_EXPORT ty_real d3d11_sbuffer_create(ty_real _stride, ty_real _numElements)
{
    if (_stride <= 0.0 || _numElements <= 0.0)
    {
        return -1.0;
    }

    UINT size = static_cast<UINT>(_stride) * static_cast<UINT>(_numElements);

    D3D11_BUFFER_DESC sbDesc = {};
    sbDesc.Usage = D3D11_USAGE_DEFAULT;
    sbDesc.BindFlags = D3D11_BIND_UNORDERED_ACCESS | D3D11_BIND_SHADER_RESOURCE;
    sbDesc.ByteWidth = size;
    sbDesc.StructureByteStride = static_cast<UINT>(_stride);
    sbDesc.MiscFlags = D3D11_RESOURCE_MISC_BUFFER_STRUCTURED;

    ID3D11Buffer* buffer = nullptr;
    HRESULT hr = g_Device->CreateBuffer(&sbDesc, NULL, &buffer);

    if (FAILED(hr))
    {
        std::cout << "Failed to create a structured buffer!" << std::endl;
        return -1.0;
    }

    return static_cast<ty_real>((new SBuffer(buffer, static_cast<size_t>(_stride), static_cast<size_t>(_numElements)))->GetID());
}

/// @func d3d11_sbuffer_get_size(_sbuffer)
///
/// @desc Retrieves size of a structured buffer in bytes.
///
/// @param {Real} _sbuffer The size of the structured buffer in bytes.
GM_EXPORT ty_real d3d11_sbuffer_get_size(ty_real _sbuffer)
{
    return SBuffer::Get(static_cast<size_t>(_sbuffer))->GetSize();
}

/// @func d3d11_sbuffer_write_data(_sbuffer, _data)
///
/// @desc Writes data from a GM buffer into a D3D11 structured buffer.
///
/// @param {Real} _sbuffer The ID of the structured buffer.
/// @param {Pointer} _data An address of a GM buffer to update the structured buffer from.
GM_EXPORT ty_real d3d11_sbuffer_write_data(ty_real _sbuffer, ty_string _data)
{
    g_Context->UpdateSubresource(
        SBuffer::Get(static_cast<size_t>(_sbuffer))->GetBuffer(),
        0,
        nullptr,
        (void*)_data,
        0,
        0);
    return GM_TRUE;
}

/// @func d3d11_sbuffer_exists(_sbuffer)
///
/// @desc Checks whether a structured buffer exists.
///
/// @param {Real} _sbuffer The ID of the structured buffer.
///
/// @return {Bool} Returns true if the structured buffer exists.
GM_EXPORT ty_real d3d11_sbuffer_exists(ty_real _sbuffer)
{
    return (_sbuffer >= 0.0 && SBuffer::Exists(static_cast<size_t>(_sbuffer))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_sbuffer_destroy(_sbuffer)
///
/// @desc Destroys a structured buffer.
///
/// @param {Real} _sbuffer The ID of the structured buffer to destroy.
GM_EXPORT ty_real d3d11_sbuffer_destroy(ty_real _sbuffer)
{
    delete SBuffer::Get(static_cast<size_t>(_sbuffer));
    return GM_TRUE;
}

/// @func d3d11_sbuffer_create_srv(_sbuffer)
///
/// @desc Creates a shader resource view (SRV) for given structured buffer.
///
/// @param {Real} _sbuffer The ID of the structured buffer.
///
/// @return {Real} The ID of the created SRV on success or -1 on fail.
GM_EXPORT ty_real d3d11_sbuffer_create_srv(ty_real _sbuffer)
{
    if (Srv* srv = SBuffer::Get(static_cast<size_t>(_sbuffer))->CreateSrv())
    {
        return static_cast<ty_real>(srv->GetID());
    }
    return -1.0;
}

/// @func d3d11_sbuffer_create_uav(_sbuffer)
///
/// @desc Creates an unordered access view (UAV) for given structured buffer.
///
/// @param {Real} _sbuffer The ID of the structured buffer.
///
/// @return {Real} The ID of the created UAV on success or -1 on fail.
GM_EXPORT ty_real d3d11_sbuffer_create_uav(ty_real _sbuffer)
{
    if (Uav* uav = SBuffer::Get(static_cast<size_t>(_sbuffer))->CreateUav())
    {
        return static_cast<ty_real>(uav->GetID());
    }
    return -1.0;
}
