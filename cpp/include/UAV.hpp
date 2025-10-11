#pragma once

#include <common.hpp>

#include <Trackable.hpp>

#include <d3d11.h>

class UAV final : public Trackable<UAV>
{
public:
    UAV(ID3D11UnorderedAccessView* uav);

    virtual ~UAV();

    ID3D11UnorderedAccessView* GetUAV() const { return Raw; }

private:
    ID3D11UnorderedAccessView* Raw = nullptr;
};
