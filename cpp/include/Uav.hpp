#pragma once

#include <common.hpp>

#include <Trackable.hpp>

#include <d3d11.h>

class Uav final : public Trackable<Uav>
{
public:
    Uav(ID3D11UnorderedAccessView* uav);

    virtual ~Uav();

    ID3D11UnorderedAccessView* GetUav() const { return Raw; }

private:
    ID3D11UnorderedAccessView* Raw = nullptr;
};
