#pragma once

#include <common.hpp>

#include <Trackable.hpp>

#include <d3d11.h>

class Srv final : public Trackable<Srv>
{
public:
    Srv(ID3D11ShaderResourceView* srv);

    virtual ~Srv();

    ID3D11ShaderResourceView* GetSrv() const { return Raw; }

private:
    ID3D11ShaderResourceView* Raw = nullptr;
};
