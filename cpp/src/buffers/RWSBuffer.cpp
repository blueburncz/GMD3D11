#include <buffers/RWSBuffer.hpp>

#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;

RWSBuffer::RWSBuffer(ID3D11Buffer* buffer, size_t stride, size_t numElements)
    : Buffer(buffer)
    , Stride(stride)
    , NumElements(numElements)
{
}

RWSBuffer::~RWSBuffer()
{
}

SRV* RWSBuffer::CreateSRV() const
{
    D3D11_SHADER_RESOURCE_VIEW_DESC srvDesc = {};
    srvDesc.Format = DXGI_FORMAT_UNKNOWN;
    srvDesc.ViewDimension = D3D11_SRV_DIMENSION_BUFFER;
    srvDesc.Buffer.NumElements = NumElements;

    ID3D11ShaderResourceView* srv = nullptr;
    HRESULT hr = g_Device->CreateShaderResourceView(Raw, &srvDesc, &srv);

    if (FAILED(hr))
    {
        std::cout << "Failed to create SRV for a read-write structured buffer!" << std::endl;
        return nullptr;
    }

    return new SRV(srv);
}

UAV* RWSBuffer::CreateUAV() const
{
    D3D11_UNORDERED_ACCESS_VIEW_DESC uavDesc = {};
    uavDesc.Format = DXGI_FORMAT_UNKNOWN;
    uavDesc.ViewDimension = D3D11_UAV_DIMENSION_BUFFER;
    uavDesc.Buffer.NumElements = NumElements;
    
    ID3D11UnorderedAccessView* uav = nullptr;
    HRESULT hr = g_Device->CreateUnorderedAccessView(Raw, &uavDesc, &uav);

    if (FAILED(hr))
    {
        std::cout << "Failed to create UAV for a read-write structured buffer!" << std::endl;
        return nullptr;
    }

    return new UAV(uav);
}

/// @func d3d11_rwsbuffer_create(_stride, _numElements)
///
/// @desc Creates a new read-write structured buffer.
///
/// @param {Real} _stride The stride of a single element, in bytes.
/// @param {Real} _numElements The number of elements in the buffer.
///
/// @return {Real} The ID of the created read-write structured buffer or -1 on fail.
GM_EXPORT ty_real d3d11_rwsbuffer_create(ty_real _stride, ty_real _numElements)
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
        std::cout << "Failed to create a read-write structured buffer!" << std::endl;
        return -1.0;
    }

    return static_cast<ty_real>((new RWSBuffer(buffer, static_cast<size_t>(_stride), static_cast<size_t>(_numElements)))->GetID());
}

/// @func d3d11_rwsbuffer_get_size(_rwsbuffer)
///
/// @desc Retrieves size of a read-write structured buffer in bytes.
///
/// @param {Real} _rwsbuffer The ID of the read-write structured buffer.
///
/// @return {Real} The size of the read-write structured buffer in bytes.
GM_EXPORT ty_real d3d11_rwsbuffer_get_size(ty_real _rwsbuffer)
{
    return Trackable::Get<RWSBuffer>(static_cast<size_t>(_rwsbuffer))->GetSize();
}

/// @func d3d11_rwsbuffer_write_data(_rwsbuffer, _data)
///
/// @desc Writes data from a GM buffer into a D3D11 read-write structured buffer.
///
/// @param {Real} _rwsbuffer The ID of the read-write structured buffer.
/// @param {Pointer} _data An address of a GM buffer to update the read-write structured buffer from.
GM_EXPORT ty_real d3d11_rwsbuffer_write_data(ty_real _rwsbuffer, ty_string _data)
{
    g_Context->UpdateSubresource(
        Trackable::Get<RWSBuffer>(static_cast<size_t>(_rwsbuffer))->GetBuffer(),
        0,
        nullptr,
        (void*)_data,
        0,
        0);
    return GM_TRUE;
}

/// @func d3d11_rwsbuffer_exists(_rwsbuffer)
///
/// @desc Checks whether a read-write structured buffer exists.
///
/// @param {Real} _rwsbuffer The ID of the read-write structured buffer.
///
/// @return {Bool} Returns `true` if the read-write structured buffer exists.
GM_EXPORT ty_real d3d11_rwsbuffer_exists(ty_real _rwsbuffer)
{
    return (_rwsbuffer >= 0.0 && Trackable::Exists<RWSBuffer>(static_cast<size_t>(_rwsbuffer))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_rwsbuffer_destroy(_rwsbuffer)
///
/// @desc Destroys a read-write structured buffer.
///
/// @param {Real} _rwsbuffer The ID of the read-write structured buffer to destroy.
GM_EXPORT ty_real d3d11_rwsbuffer_destroy(ty_real _rwsbuffer)
{
    delete Trackable::Get<RWSBuffer>(static_cast<size_t>(_rwsbuffer));
    return GM_TRUE;
}

/// @func d3d11_rwsbuffer_create_srv(_rwsbuffer)
///
/// @desc Creates a shader resource view (SRV) for given read-write structured buffer.
///
/// @param {Real} _rwsbuffer The ID of the read-write structured buffer.
///
/// @return {Real} The ID of the created SRV on success or -1 on fail.
GM_EXPORT ty_real d3d11_rwsbuffer_create_srv(ty_real _rwsbuffer)
{
    if (SRV* srv = Trackable::Get<RWSBuffer>(static_cast<size_t>(_rwsbuffer))->CreateSRV())
    {
        return static_cast<ty_real>(srv->GetID());
    }
    return -1.0;
}

/// @func d3d11_rwsbuffer_create_uav(_rwsbuffer)
///
/// @desc Creates an unordered access view (UAV) for given read-write structured buffer.
///
/// @param {Real} _rwsbuffer The ID of the read-write structured buffer.
///
/// @return {Real} The ID of the created UAV on success or -1 on fail.
GM_EXPORT ty_real d3d11_rwsbuffer_create_uav(ty_real _rwsbuffer)
{
    if (UAV* uav = Trackable::Get<RWSBuffer>(static_cast<size_t>(_rwsbuffer))->CreateUAV())
    {
        return static_cast<ty_real>(uav->GetID());
    }
    return -1.0;
}
