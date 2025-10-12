#include <buffers/ReadbackBuffer.hpp>

#include <cstring>
#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;

ReadbackBuffer::ReadbackBuffer(ID3D11Buffer* buffer, size_t stride, size_t numElements)
    : Buffer(buffer)
    , Stride(stride)
    , NumElements(numElements)
{
}

ReadbackBuffer::~ReadbackBuffer()
{
}

bool ReadbackBuffer::Map()
{
    if (!Mapped)
    {
        Mapped = SUCCEEDED(g_Context->Map(Raw, 0, D3D11_MAP_READ, 0, &MapData));
        return Mapped;
    }
    return false;
}

bool ReadbackBuffer::Unmap()
{
    if (Mapped)
    {
        g_Context->Unmap(Raw, 0);
        Mapped = false;
        return true;
    }
    return false;
}

/// @func d3d11_readback_buffer_create(_stride, _numElements)
///
/// @desc Creates a new staging buffer.
///
/// @param {Real} _stride The stride of a single element, in bytes.
/// @param {Real} _numElements The number of elements in the buffer.
///
/// @return {Real} The ID of the created staging buffer or {@link GMD3D11_ID_INVALID} on fail.
GM_EXPORT ty_real d3d11_readback_buffer_create(ty_real _stride, ty_real _numElements)
{
    if (_stride <= 0.0 || _numElements <= 0.0)
    {
        return GMD3D11_ID_INVALID;
    }

    UINT size = static_cast<UINT>(_stride) * static_cast<UINT>(_numElements);

    D3D11_BUFFER_DESC sbDesc = {};
    sbDesc.Usage = D3D11_USAGE_STAGING;
    sbDesc.CPUAccessFlags = D3D11_CPU_ACCESS_READ;
    sbDesc.ByteWidth = size;
    sbDesc.StructureByteStride = static_cast<UINT>(_stride);
    sbDesc.MiscFlags = D3D11_RESOURCE_MISC_BUFFER_STRUCTURED;

    ID3D11Buffer* buffer = nullptr;
    HRESULT hr = g_Device->CreateBuffer(&sbDesc, NULL, &buffer);

    if (FAILED(hr))
    {
        std::cout << "Failed to create a staging buffer!" << std::endl;
        return GMD3D11_ID_INVALID;
    }

    return static_cast<ty_real>((new ReadbackBuffer(buffer, static_cast<size_t>(_stride), static_cast<size_t>(_numElements)))->GetID());
}

/// @func d3d11_readback_buffer_get_size(_id)
///
/// @desc Retrieves size of a staging buffer in bytes.
///
/// @param {Real} _id The ID of the staging buffer.
///
/// @return {Real} The size of the staging buffer in bytes.
GM_EXPORT ty_real d3d11_readback_buffer_get_size(ty_real _id)
{
    return Trackable::Get<ReadbackBuffer>(static_cast<size_t>(_id))->GetSize();
}

/// @func d3d11_readback_buffer_is_mapped(_id)
///
/// @desc Checks whether a staging buffer is currently mapped to CPU-accessible memory.
///
/// @param {Real} _id The ID of the staging buffer.
///
/// @return {Bool} Returns `true` if given staging buffer is currently mapped for reading or `false` otherwise.
GM_EXPORT ty_real d3d11_readback_buffer_is_mapped(ty_real _id)
{
    return Trackable::Get<ReadbackBuffer>(static_cast<size_t>(_id))->IsMapped() ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_readback_buffer_map(_id)
///
/// @desc Maps a staging buffer to CPU-accessible memory for reading.
///
/// @param {Real} _id The ID of the staging buffer.
///
/// @return {Bool} Returns `true` on success or `false` otherwise (e.g. the staging buffer was already mapped).
GM_EXPORT ty_real d3d11_readback_buffer_map(ty_real _id)
{
    return Trackable::Get<ReadbackBuffer>(static_cast<size_t>(_id))->Map() ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_readback_buffer_read(_id, _dest)
///
/// @desc Copies data of a mapped staging buffer into a GM buffer, specified by its address.
///
/// @param {Real} _id The ID of the staging buffer.
/// @param {Pointer} _dest The address of the destination buffer.
///
/// @return {Bool} Returns `true` on success or `false` otherwise (e.g. the staging buffer was not mapped).
GM_EXPORT ty_real d3d11_readback_buffer_read(ty_real _id, ty_string _dest)
{
    ReadbackBuffer* stBuffer = Trackable::Get<ReadbackBuffer>(static_cast<size_t>(_id));
    if (stBuffer->IsMapped())
    {
        memcpy(_dest, stBuffer->GetMappedData(), stBuffer->GetSize());
        return GM_TRUE;
    }
    return GM_FALSE;
}

/// @func d3d11_readback_buffer_unmap(_id)
///
/// @desc Unmaps a staging buffer from CPU-accessible memory.
///
/// @param {Real} _id The ID of the staging buffer.
///
/// @return {Bool} Returns `true` on success or `false` otherwise (e.g. the staging buffer was not mapped).
GM_EXPORT ty_real d3d11_readback_buffer_unmap(ty_real _id)
{
    return Trackable::Get<ReadbackBuffer>(static_cast<size_t>(_id))->Unmap() ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_readback_buffer_exists(_id)
///
/// @desc Checks whether a staging buffer exists.
///
/// @param {Real} _id The ID of the staging buffer.
///
/// @return {Bool} Returns `true` if the staging buffer exists.
GM_EXPORT ty_real d3d11_readback_buffer_exists(ty_real _id)
{
    return (_id != GMD3D11_ID_INVALID && Trackable::Exists<ReadbackBuffer>(static_cast<size_t>(_id))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_readback_buffer_destroy(_id)
///
/// @desc Destroys a staging buffer.
///
/// @param {Real} _id The ID of the staging buffer to destroy.
GM_EXPORT ty_real d3d11_readback_buffer_destroy(ty_real _id)
{
    delete Trackable::Get<ReadbackBuffer>(static_cast<size_t>(_id));
    return GM_TRUE;
}
