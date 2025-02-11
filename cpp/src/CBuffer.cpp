#include <CBuffer.hpp>

#include <cstdint>
#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;

CBuffer::CBuffer(ID3D11Buffer* buffer, size_t size)
    : Buffer(buffer)
    , Size(size)
{
}

CBuffer::~CBuffer()
{
    if (Buffer)
    {
        Buffer->Release();
    }
}

/// @func d3d11_cbuffer_create(_size)
///
/// @desc Creates a new constant buffer.
///
/// @param {Real} _size The size of the buffer, in bytes. Must be a multiple of 16!
///
/// @return {Real} The ID of the created constant buffer or -1 on fail.
///
/// @see d3d11_sizeof16
/// @see d3d11_cbuffer_exists
/// @see d3d11_cbuffer_update
GM_EXPORT ty_real d3d11_cbuffer_create(ty_real _size)
{
    size_t size = static_cast<size_t>(_size);

    if (size <= 0 || size != RoundUp16(size))
    {
        std::cout << "Failed to create a constant buffer - struct size must be aligned to 16 bytes!" << std::endl;
        return -1;
    }

    CD3D11_BUFFER_DESC cbDesc(size, D3D11_BIND_CONSTANT_BUFFER);
    ID3D11Buffer* buffer = nullptr;
    HRESULT hr = g_Device->CreateBuffer(&cbDesc, NULL, &buffer);

    if (FAILED(hr))
    {
        return -1.0;
    }

    return static_cast<ty_real>((new CBuffer(buffer, size))->GetID());
}

/// @func d3d11_cbuffer_get_size(_cbuffer)
///
/// @desc Retrieves size of a constant buffer in bytes.
///
/// @param {Real} _cbuffer The size of the constant buffer in bytes.
GM_EXPORT ty_real d3d11_cbuffer_get_size(ty_real _cbuffer)
{
    return CBuffer::Get(static_cast<size_t>(_cbuffer))->GetSize();
}

/// @func d3d11_cbuffer_write_data(_cbuffer, _data)
///
/// @desc Writes data from a GM buffer into a D3D11 constant buffer.
///
/// @param {Real} _cbuffer The ID of the constant buffer.
/// @param {Pointer} _data An address of a GM buffer to update the constant buffer from.
GM_EXPORT ty_real d3d11_cbuffer_write_data(ty_real _cbuffer, ty_string _data)
{
    g_Context->UpdateSubresource(
        CBuffer::Get(static_cast<size_t>(_cbuffer))->GetBuffer(),
        0,
        nullptr,
        (void*)_data,
        0,
        0);
    return GM_TRUE;
}

/// @func d3d11_shader_set_cbuffer_vs(_slot, _cbuffer)
///
/// @desc Binds a constant buffer to a vertex shader.
///
/// @param {Real} _slot The slot to bind the constant buffer to.
/// @param {Real} _cbuffer The ID of the constant buffer or -1 to unbind the slot.
GM_EXPORT ty_real d3d11_shader_set_cbuffer_vs(ty_real _slot, ty_real _cbuffer)
{
    if (_cbuffer >= 0.0)
    {
        ID3D11Buffer* buffer = CBuffer::Get(static_cast<size_t>(_cbuffer))->GetBuffer();
        g_Context->VSSetConstantBuffers(static_cast<UINT>(_slot), 1, &buffer);
    }
    else
    {
        g_Context->VSSetConstantBuffers(static_cast<UINT>(_slot), 0, nullptr);
    }
    return GM_TRUE;
}

/// @func d3d11_shader_set_cbuffer_gs(_slot, _cbuffer)
///
/// @desc Binds a constant buffer to a geometry shader.
///
/// @param {Real} _slot The slot to bind the constant buffer to.
/// @param {Real} _cbuffer The ID of the constant buffer or -1 to unbind the slot.
GM_EXPORT ty_real d3d11_shader_set_cbuffer_gs(ty_real _slot, ty_real _cbuffer)
{
    if (_cbuffer >= 0.0)
    {
        ID3D11Buffer* buffer = CBuffer::Get(static_cast<size_t>(_cbuffer))->GetBuffer();
        g_Context->GSSetConstantBuffers(static_cast<UINT>(_slot), 1, &buffer);
    }
    else
    {
        g_Context->GSSetConstantBuffers(static_cast<UINT>(_slot), 0, nullptr);
    }
    return GM_TRUE;
}

/// @func d3d11_shader_set_cbuffer_ps(_slot, _cbuffer)
///
/// @desc Binds a constant buffer to a pixel shader.
///
/// @param {Real} _slot The slot to bind the constant buffer to.
/// @param {Real} _cbuffer The ID of the constant buffer or -1 to unbind the slot.
GM_EXPORT ty_real d3d11_shader_set_cbuffer_ps(ty_real _slot, ty_real _cbuffer)
{
    if (_cbuffer >= 0.0)
    {
        ID3D11Buffer* buffer = CBuffer::Get(static_cast<size_t>(_cbuffer))->GetBuffer();
        g_Context->PSSetConstantBuffers(static_cast<UINT>(_slot), 1, &buffer);
    }
    else
    {
        g_Context->PSSetConstantBuffers(static_cast<UINT>(_slot), 0, nullptr);
    }
    return GM_TRUE;
}

/// @func d3d11_cbuffer_exists(_cbuffer)
///
/// @desc Checks whether a constant buffer exists.
///
/// @param {Real} _cbuffer The ID of the constant buffer.
///
/// @return {Bool} Returns true if the constant buffer exists.
GM_EXPORT ty_real d3d11_cbuffer_exists(ty_real _cbuffer)
{
    return (_cbuffer >= 0.0 && CBuffer::Exists(static_cast<size_t>(_cbuffer))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_cbuffer_destroy(_cbuffer)
///
/// @desc Destroys a constant buffer.
///
/// @param {Real} _cbuffer The ID of the constant buffer to destroy.
GM_EXPORT ty_real d3d11_cbuffer_destroy(ty_real _cbuffer)
{
    delete CBuffer::Get(static_cast<size_t>(_cbuffer));
    return GM_TRUE;
}
