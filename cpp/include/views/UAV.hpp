#pragma once

#include <common.hpp>

#include <Trackable.hpp>

#include <d3d11.h>

class UAV final : public Trackable
{
public:
    UAV(ID3D11UnorderedAccessView* uav);

    virtual ~UAV();

    ID3D11UnorderedAccessView* GetUAV() const { return Raw; }

private:
    ID3D11UnorderedAccessView* Raw = nullptr;
};

void UAVDescFromBuffer(D3D11_UNORDERED_ACCESS_VIEW_DESC& desc, char* buffer);
