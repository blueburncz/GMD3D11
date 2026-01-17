#pragma once

#include <common.hpp>

#include <Trackable.hpp>

#include <d3d11.h>

class DSV final : public Trackable
{
public:
    DSV(ID3D11DepthStencilView* dsv);

    virtual ~DSV();

    ID3D11DepthStencilView* GetDSV() const { return Raw; }

private:
    ID3D11DepthStencilView* Raw = nullptr;
};

void DSVDescFromBuffer(D3D11_DEPTH_STENCIL_VIEW_DESC& desc, char* buffer);
