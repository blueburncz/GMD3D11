#include <buffers/StructuredBuffer.hpp>

#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;

StructuredBuffer::StructuredBuffer(ID3D11Buffer* buffer, size_t stride, size_t numElements)
    : Buffer(buffer)
    , Stride(stride)
    , NumElements(numElements)
{
}

StructuredBuffer::~StructuredBuffer()
{
}

SRV* StructuredBuffer::CreateSRV() const
{
    D3D11_SHADER_RESOURCE_VIEW_DESC srvDesc = {};
    srvDesc.Format = DXGI_FORMAT_UNKNOWN;
    srvDesc.ViewDimension = D3D11_SRV_DIMENSION_BUFFER;
    srvDesc.Buffer.NumElements = NumElements;

    ID3D11ShaderResourceView* srv = nullptr;
    HRESULT hr = g_Device->CreateShaderResourceView(Raw, &srvDesc, &srv);

    if (FAILED(hr))
    {
        std::cout << "Failed to create SRV for a structured buffer!" << std::endl;
        return nullptr;
    }

    return new SRV(srv);
}

/// @func d3d11_structured_buffer_create(_stride, _numElements)
///
/// @desc Creates a new structured buffer.
///
/// @param {Real} _stride The stride of a single element, in bytes.
/// @param {Real} _numElements The number of elements in the buffer.
///
/// @return {Real} The ID of the created structured buffer or {@link GMD3D11_ID_INVALID} on fail.
GM_EXPORT ty_real d3d11_structured_buffer_create(ty_real _stride, ty_real _numElements)
{
    if (_stride <= 0.0 || _numElements <= 0.0)
    {
        return GMD3D11_ID_INVALID;
    }

    UINT size = static_cast<UINT>(_stride) * static_cast<UINT>(_numElements);

    D3D11_BUFFER_DESC sbDesc = {};
    sbDesc.Usage = D3D11_USAGE_DEFAULT;
    sbDesc.BindFlags = D3D11_BIND_SHADER_RESOURCE;
    sbDesc.ByteWidth = size;
    sbDesc.StructureByteStride = static_cast<UINT>(_stride);
    sbDesc.MiscFlags = D3D11_RESOURCE_MISC_BUFFER_STRUCTURED;

    ID3D11Buffer* buffer = nullptr;
    HRESULT hr = g_Device->CreateBuffer(&sbDesc, NULL, &buffer);

    if (FAILED(hr))
    {
        std::cout << "Failed to create a structured buffer!" << std::endl;
        return GMD3D11_ID_INVALID;
    }

    return static_cast<ty_real>((new StructuredBuffer(buffer, static_cast<size_t>(_stride), static_cast<size_t>(_numElements)))->GetID());
}

/// @func d3d11_structured_buffer_get_size(_id)
///
/// @desc Retrieves size of a structured buffer in bytes.
///
/// @param {Real} _id The ID of the structured buffer.
///
/// @return {Real} The size of the structured buffer in bytes.
GM_EXPORT ty_real d3d11_structured_buffer_get_size(ty_real _id)
{
    return Trackable::Get<StructuredBuffer>(static_cast<size_t>(_id))->GetSize();
}

/// @func d3d11_structured_buffer_write_data(_id, _data)
///
/// @desc Writes data from a GM buffer into a D3D11 structured buffer.
///
/// @param {Real} _id The ID of the structured buffer.
/// @param {Pointer} _data An address of a GM buffer to update the structured buffer from.
GM_EXPORT ty_real d3d11_structured_buffer_write_data(ty_real _id, ty_string _data)
{
    g_Context->UpdateSubresource(
        Trackable::Get<StructuredBuffer>(static_cast<size_t>(_id))->GetBuffer(),
        0,
        nullptr,
        (void*)_data,
        0,
        0);
    return GM_TRUE;
}

/// @func d3d11_structured_buffer_exists(_id)
///
/// @desc Checks whether a structured buffer exists.
///
/// @param {Real} _id The ID of the structured buffer.
///
/// @return {Bool} Returns `true` if the structured buffer exists.
GM_EXPORT ty_real d3d11_structured_buffer_exists(ty_real _id)
{
    return (_id != GMD3D11_ID_INVALID && Trackable::Exists<StructuredBuffer>(static_cast<size_t>(_id))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_structured_buffer_destroy(_id)
///
/// @desc Destroys a structured buffer.
///
/// @param {Real} _id The ID of the structured buffer to destroy.
GM_EXPORT ty_real d3d11_structured_buffer_destroy(ty_real _id)
{
    delete Trackable::Get<StructuredBuffer>(static_cast<size_t>(_id));
    return GM_TRUE;
}

/// @func d3d11_structured_buffer_create_srv(_id)
///
/// @desc Creates a shader resource view (SRV) for given structured buffer.
///
/// @param {Real} _id The ID of the structured buffer.
///
/// @return {Real} The ID of the created SRV on success or {@link GMD3D11_ID_INVALID} on fail.
GM_EXPORT ty_real d3d11_structured_buffer_create_srv(ty_real _id)
{
    if (SRV* srv = Trackable::Get<StructuredBuffer>(static_cast<size_t>(_id))->CreateSRV())
    {
        return static_cast<ty_real>(srv->GetID());
    }
    return GMD3D11_ID_INVALID;
}
