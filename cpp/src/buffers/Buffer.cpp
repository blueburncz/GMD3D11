#include <buffers/Buffer.hpp>

#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;

Buffer::Buffer(ID3D11Buffer* buffer)
    : Trackable()
    , Raw(buffer)
{
}

Buffer::~Buffer()
{
    if (Raw)
    {
        Raw->Release();
    }
}

void Buffer::Copy(Buffer* dest)
{
    g_Context->CopyResource(dest->Raw, Raw);
}

/// @func d3d11_buffer_copy(_src, _dest)
///
/// @desc Copies data from source to destination buffer.
///
/// @param {Real} _src The ID of the source buffer.
/// @param {Real} _dest The ID of the destination buffer.
GM_EXPORT ty_real d3d11_buffer_copy(ty_real _src, ty_real _dest)
{
    Trackable::Get<Buffer>(_src)->Copy(Trackable::Get<Buffer>(_dest));
    return GM_TRUE;
}
