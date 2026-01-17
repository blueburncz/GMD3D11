#include <textures/Sampler.hpp>

#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;

Sampler::Sampler(ID3D11SamplerState* samplerState)
    : Trackable()
    , Raw(samplerState)
{
}

Sampler::~Sampler()
{
    if (Raw)
    {
        Raw->Release();
    }
}

void SamplerDescFromBuffer(D3D11_SAMPLER_DESC& desc, char* buffer)
{
    desc.Filter = static_cast<D3D11_FILTER>(ReadBuffer<uint32_t>(buffer));
    desc.AddressU = static_cast<D3D11_TEXTURE_ADDRESS_MODE>(ReadBuffer<uint32_t>(buffer));
    desc.AddressV = static_cast<D3D11_TEXTURE_ADDRESS_MODE>(ReadBuffer<uint32_t>(buffer));
    desc.AddressW = static_cast<D3D11_TEXTURE_ADDRESS_MODE>(ReadBuffer<uint32_t>(buffer));
    desc.MipLODBias = ReadBuffer<float>(buffer);
    desc.MaxAnisotropy = ReadBuffer<UINT>(buffer);
    desc.ComparisonFunc = static_cast<D3D11_COMPARISON_FUNC>(ReadBuffer<uint32_t>(buffer));
    desc.BorderColor[0] = ReadBuffer<float>(buffer);
    desc.BorderColor[1] = ReadBuffer<float>(buffer);
    desc.BorderColor[2] = ReadBuffer<float>(buffer);
    desc.BorderColor[3] = ReadBuffer<float>(buffer);
    desc.MinLOD = ReadBuffer<float>(buffer);
    desc.MaxLOD = ReadBuffer<float>(buffer);
}

/// @func d3d11_sampler_create_impl(_buffer)
///
/// @desc
///
/// @param {Pointer}
///
/// @return {Real}
GM_EXPORT ty_real d3d11_sampler_create_impl(ty_string _buffer)
{
    D3D11_SAMPLER_DESC desc = {};
    SamplerDescFromBuffer(desc, _buffer);

    ID3D11SamplerState* samplerState = nullptr;
    HRESULT hr = g_Device->CreateSamplerState(&desc, &samplerState);

    if (FAILED(hr))
    {
        return GMD3D11_ID_INVALID;
    }

    return static_cast<ty_real>((new Sampler(samplerState))->GetID());
}

/// @func d3d11_sampler_exists(_id)
///
/// @desc Checks whether a sampler state exists.
///
/// @param {Real} _id The ID of the sampler state.
///
/// @return {Bool} Returns `true` if the sampler state exists.
GM_EXPORT ty_real d3d11_sampler_exists(ty_real _id)
{
    return (_id != GMD3D11_ID_INVALID && Trackable::Exists<Sampler>(static_cast<size_t>(_id))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_sampler_destroy(_id)
///
/// @desc Destroys a sampler state.
///
/// @param {Real} _id The ID of the sampler state to destroy.
GM_EXPORT ty_real d3d11_sampler_destroy(ty_real _id)
{
    delete Trackable::Get<Sampler>(static_cast<size_t>(_id));
    return GM_TRUE;
}

/// @func d3d11_sampler_set_vs(_id, _slot)
///
/// @desc
///
/// @param {Real} _id
/// @param {Real} _slot
GM_EXPORT ty_real d3d11_sampler_set_vs(ty_real _id, ty_real _slot)
{
    ID3D11SamplerState* samplerState = nullptr;
    if (Sampler* sampler = Trackable::Get<Sampler>(static_cast<size_t>(_id)))
    {
        samplerState = sampler->GetSamplerState();
    }
    g_Context->VSSetSamplers(static_cast<UINT>(_slot), 1, &samplerState);
    return GM_TRUE;
}

/// @func d3d11_sampler_set_vs(_id, _slot)
///
/// @desc
///
/// @param {Real} _id
/// @param {Real} _slot
GM_EXPORT ty_real d3d11_sampler_set_gs(ty_real _id, ty_real _slot)
{
    ID3D11SamplerState* samplerState = nullptr;
    if (Sampler* sampler = Trackable::Get<Sampler>(static_cast<size_t>(_id)))
    {
        samplerState = sampler->GetSamplerState();
    }
    g_Context->GSSetSamplers(static_cast<UINT>(_slot), 1, &samplerState);
    return GM_TRUE;
}

/// @func d3d11_sampler_set_vs(_id, _slot)
///
/// @desc
///
/// @param {Real} _id
/// @param {Real} _slot
GM_EXPORT ty_real d3d11_sampler_set_ps(ty_real _id, ty_real _slot)
{
    ID3D11SamplerState* samplerState = nullptr;
    if (Sampler* sampler = Trackable::Get<Sampler>(static_cast<size_t>(_id)))
    {
        samplerState = sampler->GetSamplerState();
    }
    g_Context->PSSetSamplers(static_cast<UINT>(_slot), 1, &samplerState);
    return GM_TRUE;
}

/// @func d3d11_sampler_set_vs(_id, _slot)
///
/// @desc
///
/// @param {Real} _id
/// @param {Real} _slot
GM_EXPORT ty_real d3d11_sampler_set_cs(ty_real _id, ty_real _slot)
{
    ID3D11SamplerState* samplerState = nullptr;
    if (Sampler* sampler = Trackable::Get<Sampler>(static_cast<size_t>(_id)))
    {
        samplerState = sampler->GetSamplerState();
    }
    g_Context->CSSetSamplers(static_cast<UINT>(_slot), 1, &samplerState);
    return GM_TRUE;
}
