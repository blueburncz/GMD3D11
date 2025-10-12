#include <buffers/ConstantBuffer.hpp>

#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;

ConstantBuffer::ConstantBuffer(ID3D11Buffer* buffer, size_t size)
    : Buffer(buffer)
    , Size(size)
{
}

ConstantBuffer::~ConstantBuffer()
{
}

/// @func d3d11_constant_buffer_create(_size)
///
/// @desc Creates a new constant buffer.
///
/// @param {Real} _size The size of the buffer, in bytes. Must be a multiple of 16!
///
/// @return {Real} The ID of the created constant buffer or {@link GMD3D11_ID_INVALID} on fail.
GM_EXPORT ty_real d3d11_constant_buffer_create(ty_real _size)
{
    size_t size = static_cast<size_t>(_size);

    if (size <= 0 || size != RoundUp(size, 16))
    {
        std::cout << "Failed to create a constant buffer - struct size must be aligned to 16 bytes!" << std::endl;
        return GMD3D11_ID_INVALID;
    }

    CD3D11_BUFFER_DESC cbDesc(size, D3D11_BIND_CONSTANT_BUFFER);
    ID3D11Buffer* buffer = nullptr;
    HRESULT hr = g_Device->CreateBuffer(&cbDesc, NULL, &buffer);

    if (FAILED(hr))
    {
        return GMD3D11_ID_INVALID;
    }

    return static_cast<ty_real>((new ConstantBuffer(buffer, size))->GetID());
}

/// @func d3d11_constant_buffer_get_size(_id)
///
/// @desc Retrieves size of a constant buffer in bytes.
///
/// @param {Real} _id The ID of the constant buffer.
///
/// @return {Real} The size of the constant buffer in bytes.
GM_EXPORT ty_real d3d11_constant_buffer_get_size(ty_real _id)
{
    return Trackable::Get<ConstantBuffer>(static_cast<size_t>(_id))->GetSize();
}

/// @func d3d11_constant_buffer_write(_id, _data)
///
/// @desc Writes data from a GM buffer into a D3D11 constant buffer.
///
/// @param {Real} _id The ID of the constant buffer.
/// @param {Pointer} _data An address of a GM buffer to update the constant buffer from.
GM_EXPORT ty_real d3d11_constant_buffer_write(ty_real _id, ty_string _data)
{
    g_Context->UpdateSubresource(
        Trackable::Get<ConstantBuffer>(static_cast<size_t>(_id))->GetBuffer(),
        0,
        nullptr,
        (void*)_data,
        0,
        0);
    return GM_TRUE;
}

/// @func d3d11_shader_set_constant_buffer_vs(_slot, _id)
///
/// @desc Binds a constant buffer to a vertex shader.
///
/// @param {Real} _slot The slot to bind the constant buffer to.
/// @param {Real} _id The ID of the constant buffer or {@link GMD3D11_ID_INVALID} to unbind the slot.
GM_EXPORT ty_real d3d11_shader_set_constant_buffer_vs(ty_real _slot, ty_real _id)
{
    if (_id != GMD3D11_ID_INVALID)
    {
        ID3D11Buffer* buffer = Trackable::Get<ConstantBuffer>(static_cast<size_t>(_id))->GetBuffer();
        g_Context->VSSetConstantBuffers(static_cast<UINT>(_slot), 1, &buffer);
    }
    else
    {
        g_Context->VSSetConstantBuffers(static_cast<UINT>(_slot), 0, nullptr);
    }
    return GM_TRUE;
}

/// @func d3d11_shader_set_constant_buffer_gs(_slot, _id)
///
/// @desc Binds a constant buffer to a geometry shader.
///
/// @param {Real} _slot The slot to bind the constant buffer to.
/// @param {Real} _id The ID of the constant buffer or {@link GMD3D11_ID_INVALID} to unbind the slot.
GM_EXPORT ty_real d3d11_shader_set_constant_buffer_gs(ty_real _slot, ty_real _id)
{
    if (_id != GMD3D11_ID_INVALID)
    {
        ID3D11Buffer* buffer = Trackable::Get<ConstantBuffer>(static_cast<size_t>(_id))->GetBuffer();
        g_Context->GSSetConstantBuffers(static_cast<UINT>(_slot), 1, &buffer);
    }
    else
    {
        g_Context->GSSetConstantBuffers(static_cast<UINT>(_slot), 0, nullptr);
    }
    return GM_TRUE;
}

/// @func d3d11_shader_set_constant_buffer_ps(_slot, _id)
///
/// @desc Binds a constant buffer to a pixel shader.
///
/// @param {Real} _slot The slot to bind the constant buffer to.
/// @param {Real} _id The ID of the constant buffer or {@link GMD3D11_ID_INVALID} to unbind the slot.
GM_EXPORT ty_real d3d11_shader_set_constant_buffer_ps(ty_real _slot, ty_real _id)
{
    if (_id != GMD3D11_ID_INVALID)
    {
        ID3D11Buffer* buffer = Trackable::Get<ConstantBuffer>(static_cast<size_t>(_id))->GetBuffer();
        g_Context->PSSetConstantBuffers(static_cast<UINT>(_slot), 1, &buffer);
    }
    else
    {
        g_Context->PSSetConstantBuffers(static_cast<UINT>(_slot), 0, nullptr);
    }
    return GM_TRUE;
}

/// @func d3d11_constant_buffer_exists(_id)
///
/// @desc Checks whether a constant buffer exists.
///
/// @param {Real} _id The ID of the constant buffer.
///
/// @return {Bool} Returns `true` if the constant buffer exists.
GM_EXPORT ty_real d3d11_constant_buffer_exists(ty_real _id)
{
    return (_id != GMD3D11_ID_INVALID && Trackable::Exists<ConstantBuffer>(static_cast<size_t>(_id))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_constant_buffer_destroy(_id)
///
/// @desc Destroys a constant buffer.
///
/// @param {Real} _id The ID of the constant buffer to destroy.
GM_EXPORT ty_real d3d11_constant_buffer_destroy(ty_real _id)
{
    delete Trackable::Get<ConstantBuffer>(static_cast<size_t>(_id));
    return GM_TRUE;
}
