#pragma once

#include <common.hpp>

#include <buffers/Buffer.hpp>
#include <views/SRV.hpp>
#include <views/UAV.hpp>

#include <d3d11.h>

/// @brief Read-only structured buffer.
class RSBuffer final : public Buffer
{
public:
    RSBuffer(ID3D11Buffer* buffer, size_t stride, size_t numElements);

    virtual ~RSBuffer();

    size_t GetSize() const { return Stride * NumElements; }

    SRV* CreateSRV() const;

private:
    size_t Stride = 0;
    size_t NumElements = 0;
};
