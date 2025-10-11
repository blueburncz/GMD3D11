#pragma once

#include <common.hpp>

#include <SRV.hpp>
#include <Trackable.hpp>
#include <Uav.hpp>

#include <cstdint>
#include <d3d11.h>

/// @brief Read-write structured buffer.
class RWSBuffer final : public Trackable<RWSBuffer>
{
public:
    RWSBuffer(ID3D11Buffer* buffer, size_t stride, size_t numElements);

    virtual ~RWSBuffer();

    ID3D11Buffer* GetBuffer() const { return Buffer; }

    size_t GetSize() const { return Stride * NumElements; }

    UAV* CreateUAV() const;

    SRV* CreateSRV() const;

private:
    ID3D11Buffer* Buffer;
    size_t Stride;
    size_t NumElements;
};
