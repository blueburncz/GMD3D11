#pragma once

#include <common.hpp>

#include <Trackable.hpp>

#include <d3d11.h>

class SRV final : public Trackable
{
public:
    SRV(ID3D11ShaderResourceView* srv);

    virtual ~SRV();

    ID3D11ShaderResourceView* GetSRV() const { return Raw; }

private:
    ID3D11ShaderResourceView* Raw = nullptr;
};
