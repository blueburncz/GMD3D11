#include <RSBuffer.hpp>

#include <cstdint>
#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;

RSBuffer::RSBuffer(ID3D11Buffer* buffer, size_t stride, size_t numElements)
    : Buffer(buffer)
    , Stride(stride)
    , NumElements(numElements)
{
}

RSBuffer::~RSBuffer()
{
    if (Buffer)
    {
        Buffer->Release();
    }
}

SRV* RSBuffer::CreateSRV() const
{
    D3D11_SHADER_RESOURCE_VIEW_DESC srvDesc = {};
    srvDesc.Format = DXGI_FORMAT_UNKNOWN;
    srvDesc.ViewDimension = D3D11_SRV_DIMENSION_BUFFER;
    srvDesc.Buffer.NumElements = NumElements;

    ID3D11ShaderResourceView* srv = nullptr;
    HRESULT hr = g_Device->CreateShaderResourceView(Buffer, &srvDesc, &srv);

    if (FAILED(hr))
    {
        std::cout << "Failed to create SRV for a read-only structured buffer!" << std::endl;
        return nullptr;
    }

    return new SRV(srv);
}

/// @func d3d11_rsbuffer_create(_stride, _numElements)
///
/// @desc Creates a new read-only structured buffer.
///
/// @param {Real} _stride The stride of a single element, in bytes.
/// @param {Real} _numElements The number of elements in the buffer.
///
/// @return {Real} The ID of the created read-only structured buffer or -1 on fail.
GM_EXPORT ty_real d3d11_rsbuffer_create(ty_real _stride, ty_real _numElements)
{
    if (_stride <= 0.0 || _numElements <= 0.0)
    {
        return -1.0;
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
        std::cout << "Failed to create a read-only structured buffer!" << std::endl;
        return -1.0;
    }

    return static_cast<ty_real>((new RSBuffer(buffer, static_cast<size_t>(_stride), static_cast<size_t>(_numElements)))->GetID());
}

/// @func d3d11_rsbuffer_get_size(_rsbuffer)
///
/// @desc Retrieves size of a read-only structured buffer in bytes.
///
/// @param {Real} _rsbuffer The size of the read-only structured buffer in bytes.
GM_EXPORT ty_real d3d11_rsbuffer_get_size(ty_real _rsbuffer)
{
    return RSBuffer::Get(static_cast<size_t>(_rsbuffer))->GetSize();
}

/// @func d3d11_rsbuffer_write_data(_rsbuffer, _data)
///
/// @desc Writes data from a GM buffer into a D3D11 read-only structured buffer.
///
/// @param {Real} _rsbuffer The ID of the read-only structured buffer.
/// @param {Pointer} _data An address of a GM buffer to update the read-only structured buffer from.
GM_EXPORT ty_real d3d11_rsbuffer_write_data(ty_real _rsbuffer, ty_string _data)
{
    g_Context->UpdateSubresource(
        RSBuffer::Get(static_cast<size_t>(_rsbuffer))->GetBuffer(),
        0,
        nullptr,
        (void*)_data,
        0,
        0);
    return GM_TRUE;
}

/// @func d3d11_rsbuffer_exists(_rsbuffer)
///
/// @desc Checks whether a read-only structured buffer exists.
///
/// @param {Real} _rsbuffer The ID of the read-only structured buffer.
///
/// @return {Bool} Returns true if the read-only structured buffer exists.
GM_EXPORT ty_real d3d11_rsbuffer_exists(ty_real _rsbuffer)
{
    return (_rsbuffer >= 0.0 && RSBuffer::Exists(static_cast<size_t>(_rsbuffer))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_rsbuffer_destroy(_rsbuffer)
///
/// @desc Destroys a read-only structured buffer.
///
/// @param {Real} _rsbuffer The ID of the read-only structured buffer to destroy.
GM_EXPORT ty_real d3d11_rsbuffer_destroy(ty_real _rsbuffer)
{
    delete RSBuffer::Get(static_cast<size_t>(_rsbuffer));
    return GM_TRUE;
}

/// @func d3d11_rsbuffer_create_srv(_rsbuffer)
///
/// @desc Creates a shader resource view (SRV) for given read-only structured buffer.
///
/// @param {Real} _rsbuffer The ID of the read-only structured buffer.
///
/// @return {Real} The ID of the created SRV on success or -1 on fail.
GM_EXPORT ty_real d3d11_rsbuffer_create_srv(ty_real _rsbuffer)
{
    if (SRV* srv = RSBuffer::Get(static_cast<size_t>(_rsbuffer))->CreateSRV())
    {
        return static_cast<ty_real>(srv->GetID());
    }
    return -1.0;
}
