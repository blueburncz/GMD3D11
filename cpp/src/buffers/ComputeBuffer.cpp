#include <buffers/ComputeBuffer.hpp>

#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;

ComputeBuffer::ComputeBuffer(ID3D11Buffer* buffer, size_t stride, size_t numElements)
    : Buffer(buffer)
    , Stride(stride)
    , NumElements(numElements)
{
}

ComputeBuffer::~ComputeBuffer()
{
}

SRV* ComputeBuffer::CreateSRV() const
{
    D3D11_SHADER_RESOURCE_VIEW_DESC srvDesc = {};
    srvDesc.Format = DXGI_FORMAT_UNKNOWN;
    srvDesc.ViewDimension = D3D11_SRV_DIMENSION_BUFFER;
    srvDesc.Buffer.NumElements = NumElements;

    ID3D11ShaderResourceView* srv = nullptr;
    HRESULT hr = g_Device->CreateShaderResourceView(Raw, &srvDesc, &srv);

    if (FAILED(hr))
    {
        std::cout << "Failed to create SRV for a compute buffer!" << std::endl;
        return nullptr;
    }

    return new SRV(srv);
}

UAV* ComputeBuffer::CreateUAV() const
{
    D3D11_UNORDERED_ACCESS_VIEW_DESC uavDesc = {};
    uavDesc.Format = DXGI_FORMAT_UNKNOWN;
    uavDesc.ViewDimension = D3D11_UAV_DIMENSION_BUFFER;
    uavDesc.Buffer.NumElements = NumElements;
    
    ID3D11UnorderedAccessView* uav = nullptr;
    HRESULT hr = g_Device->CreateUnorderedAccessView(Raw, &uavDesc, &uav);

    if (FAILED(hr))
    {
        std::cout << "Failed to create UAV for a compute buffer!" << std::endl;
        return nullptr;
    }

    return new UAV(uav);
}

/// @func d3d11_compute_buffer_create(_stride, _numElements)
///
/// @desc Creates a new compute buffer.
///
/// @param {Real} _stride The stride of a single element, in bytes.
/// @param {Real} _numElements The number of elements in the buffer.
///
/// @return {Real} The ID of the created compute buffer or {@link GMD3D11_ID_INVALID} on fail.
GM_EXPORT ty_real d3d11_compute_buffer_create(ty_real _stride, ty_real _numElements)
{
    if (_stride <= 0.0 || _numElements <= 0.0)
    {
        return GMD3D11_ID_INVALID;
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
        std::cout << "Failed to create a compute buffer!" << std::endl;
        return GMD3D11_ID_INVALID;
    }

    return static_cast<ty_real>((new ComputeBuffer(buffer, static_cast<size_t>(_stride), static_cast<size_t>(_numElements)))->GetID());
}

/// @func d3d11_compute_buffer_get_size(_id)
///
/// @desc Retrieves size of a compute buffer in bytes.
///
/// @param {Real} _id The ID of the compute buffer.
///
/// @return {Real} The size of the compute buffer in bytes.
GM_EXPORT ty_real d3d11_compute_buffer_get_size(ty_real _id)
{
    return Trackable::Get<ComputeBuffer>(static_cast<size_t>(_id))->GetSize();
}

/// @func d3d11_compute_buffer_write_data(_id, _data)
///
/// @desc Writes data from a GM buffer into a D3D11 compute buffer.
///
/// @param {Real} _id The ID of the compute buffer.
/// @param {Pointer} _data An address of a GM buffer to update the compute buffer from.
GM_EXPORT ty_real d3d11_compute_buffer_write_data(ty_real _id, ty_string _data)
{
    g_Context->UpdateSubresource(
        Trackable::Get<ComputeBuffer>(static_cast<size_t>(_id))->GetBuffer(),
        0,
        nullptr,
        (void*)_data,
        0,
        0);
    return GM_TRUE;
}

/// @func d3d11_compute_buffer_exists(_id)
///
/// @desc Checks whether a compute buffer exists.
///
/// @param {Real} _id The ID of the compute buffer.
///
/// @return {Bool} Returns `true` if the compute buffer exists.
GM_EXPORT ty_real d3d11_compute_buffer_exists(ty_real _id)
{
    return (_id != GMD3D11_ID_INVALID && Trackable::Exists<ComputeBuffer>(static_cast<size_t>(_id))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_compute_buffer_destroy(_id)
///
/// @desc Destroys a compute buffer.
///
/// @param {Real} _id The ID of the compute buffer to destroy.
GM_EXPORT ty_real d3d11_compute_buffer_destroy(ty_real _id)
{
    delete Trackable::Get<ComputeBuffer>(static_cast<size_t>(_id));
    return GM_TRUE;
}

/// @func d3d11_compute_buffer_create_srv(_id)
///
/// @desc Creates a shader resource view (SRV) for given compute buffer.
///
/// @param {Real} _id The ID of the compute buffer.
///
/// @return {Real} The ID of the created SRV on success or {@link GMD3D11_ID_INVALID} on fail.
GM_EXPORT ty_real d3d11_compute_buffer_create_srv(ty_real _id)
{
    if (SRV* srv = Trackable::Get<ComputeBuffer>(static_cast<size_t>(_id))->CreateSRV())
    {
        return static_cast<ty_real>(srv->GetID());
    }
    return GMD3D11_ID_INVALID;
}

/// @func d3d11_compute_buffer_create_uav(_id)
///
/// @desc Creates an unordered access view (UAV) for given compute buffer.
///
/// @param {Real} _id The ID of the compute buffer.
///
/// @return {Real} The ID of the created UAV on success or {@link GMD3D11_ID_INVALID} on fail.
GM_EXPORT ty_real d3d11_compute_buffer_create_uav(ty_real _id)
{
    if (UAV* uav = Trackable::Get<ComputeBuffer>(static_cast<size_t>(_id))->CreateUAV())
    {
        return static_cast<ty_real>(uav->GetID());
    }
    return GMD3D11_ID_INVALID;
}
