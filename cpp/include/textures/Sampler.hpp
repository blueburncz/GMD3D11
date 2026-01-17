#pragma once 

#include <common.hpp>

#include <Trackable.hpp>

#include <d3d11.h>

/// @brief Sampler state.
class Sampler : public Trackable
{
public:
    Sampler(ID3D11SamplerState* samplerState);

    virtual ~Sampler();

    ID3D11SamplerState* GetSamplerState() const { return Raw; }

protected:
    ID3D11SamplerState* Raw = nullptr;
};

void SamplerDescFromBuffer(D3D11_SAMPLER_DESC& desc, char* buffer);
