#pragma once

#include <common.hpp>

#include <Trackable.hpp>

#include <d3d11.h>

class RTV final : public Trackable
{
public:
    RTV(ID3D11RenderTargetView* rtv);

    virtual ~RTV();

    ID3D11RenderTargetView* GetRTV() const { return Raw; }

private:
    ID3D11RenderTargetView* Raw = nullptr;
};

void RTVDescFromBuffer(D3D11_RENDER_TARGET_VIEW_DESC& desc, char* buffer);
