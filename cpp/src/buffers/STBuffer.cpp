#include <buffers/STBuffer.hpp>

#include <cstring>
#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;

STBuffer::STBuffer(ID3D11Buffer* buffer, size_t stride, size_t numElements)
    : Buffer(buffer)
    , Stride(stride)
    , NumElements(numElements)
{
}

STBuffer::~STBuffer()
{
}

bool STBuffer::Map()
{
    if (!Mapped)
    {
        Mapped = SUCCEEDED(g_Context->Map(Raw, 0, D3D11_MAP_READ, 0, &MapData));
        return Mapped;
    }
    return false;
}

bool STBuffer::Unmap()
{
    if (Mapped)
    {
        g_Context->Unmap(Raw, 0);
        Mapped = false;
        return true;
    }
    return false;
}

/// @func d3d11_stbuffer_create(_stride, _numElements)
///
/// @desc Creates a new staging buffer.
///
/// @param {Real} _stride The stride of a single element, in bytes.
/// @param {Real} _numElements The number of elements in the buffer.
///
/// @return {Real} The ID of the created staging buffer or -1 on fail.
GM_EXPORT ty_real d3d11_stbuffer_create(ty_real _stride, ty_real _numElements)
{
    if (_stride <= 0.0 || _numElements <= 0.0)
    {
        return -1.0;
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
        return -1.0;
    }

    return static_cast<ty_real>((new STBuffer(buffer, static_cast<size_t>(_stride), static_cast<size_t>(_numElements)))->GetID());
}

/// @func d3d11_stbuffer_get_size(_stbuffer)
///
/// @desc Retrieves size of a staging buffer in bytes.
///
/// @param {Real} _stbuffer The ID of the staging buffer.
///
/// @return {Real} The size of the staging buffer in bytes.
GM_EXPORT ty_real d3d11_stbuffer_get_size(ty_real _stbuffer)
{
    return Trackable::Get<STBuffer>(static_cast<size_t>(_stbuffer))->GetSize();
}

/// @func d3d11_stbuffer_is_mapped(_stbuffer)
///
/// @desc Checks whether a staging buffer is currently mapped to CPU-accessible memory.
///
/// @param {Real} _stbuffer The ID of the staging buffer.
///
/// @return {Bool} Returns true if given staging buffer is currently mapped for reading or false otherwise.
GM_EXPORT ty_real d3d11_stbuffer_is_mapped(ty_real _stbuffer)
{
    return Trackable::Get<STBuffer>(static_cast<size_t>(_stbuffer))->IsMapped() ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_stbuffer_map(_stbuffer)
///
/// @desc Maps a staging buffer to CPU-accessible memory for reading.
///
/// @param {Real} _stbuffer The ID of the staging buffer.
///
/// @return {Bool} Returns true on success or false otherwise (e.g. the staging buffer was already mapped).
GM_EXPORT ty_real d3d11_stbuffer_map(ty_real _stbuffer)
{
    return Trackable::Get<STBuffer>(static_cast<size_t>(_stbuffer))->Map() ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_stbuffer_read_data(_stbuffer, _dest)
///
/// @desc Copies data of a mapped staging buffer into a GM buffer, specified by its address.
///
/// @param {Real} _stbuffer The ID of the staging buffer.
/// @param {Pointer} _dest The address of the destination buffer.
///
/// @return {Bool} Returns true on success or false otherwise (e.g. the staging buffer was not mapped).
GM_EXPORT ty_real d3d11_stbuffer_read_data(ty_real _stbuffer, ty_string _dest)
{
    STBuffer* stBuffer = Trackable::Get<STBuffer>(static_cast<size_t>(_stbuffer));
    if (stBuffer->IsMapped())
    {
        memcpy(_dest, stBuffer->GetMappedData(), stBuffer->GetSize());
        return GM_TRUE;
    }
    return GM_FALSE;
}

/// @func d3d11_stbuffer_unmap(_stbuffer)
///
/// @desc Unmaps a staging buffer from CPU-accessible memory.
///
/// @param {Real} _stbuffer The ID of the staging buffer.
///
/// @return {Bool} Returns true on success or false otherwise (e.g. the staging buffer was not mapped).
GM_EXPORT ty_real d3d11_stbuffer_unmap(ty_real _stbuffer)
{
    return Trackable::Get<STBuffer>(static_cast<size_t>(_stbuffer))->Unmap() ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_stbuffer_exists(_stbuffer)
///
/// @desc Checks whether a staging buffer exists.
///
/// @param {Real} _stbuffer The ID of the staging buffer.
///
/// @return {Bool} Returns true if the staging buffer exists.
GM_EXPORT ty_real d3d11_stbuffer_exists(ty_real _stbuffer)
{
    return (_stbuffer >= 0.0 && Trackable::Exists<STBuffer>(static_cast<size_t>(_stbuffer))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_stbuffer_destroy(_stbuffer)
///
/// @desc Destroys a staging buffer.
///
/// @param {Real} _stbuffer The ID of the staging buffer to destroy.
GM_EXPORT ty_real d3d11_stbuffer_destroy(ty_real _stbuffer)
{
    delete Trackable::Get<STBuffer>(static_cast<size_t>(_stbuffer));
    return GM_TRUE;
}
