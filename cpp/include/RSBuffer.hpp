#pragma once

#include <common.hpp>

#include <SRV.hpp>
#include <Trackable.hpp>
#include <Uav.hpp>

#include <cstdint>
#include <d3d11.h>

/// @brief Read-only structured buffer.
class RSBuffer final : public Trackable<RSBuffer>
{
public:
    RSBuffer(ID3D11Buffer* buffer, size_t stride, size_t numElements);

    virtual ~RSBuffer();

    ID3D11Buffer* GetBuffer() const { return Buffer; }

    size_t GetSize() const { return Stride * NumElements; }

    SRV* CreateSRV() const;

private:
    ID3D11Buffer* Buffer;
    size_t Stride;
    size_t NumElements;
};
