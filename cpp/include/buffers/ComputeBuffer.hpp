#pragma once

#include <common.hpp>

#include <buffers/Buffer.hpp>
#include <views/SRV.hpp>
#include <views/UAV.hpp>

#include <d3d11.h>

/// @brief Read-write structured buffer.
class ComputeBuffer final : public Buffer
{
public:
    ComputeBuffer(ID3D11Buffer* buffer, size_t stride, size_t numElements);

    virtual ~ComputeBuffer();

    size_t GetSize() const { return Stride * NumElements; }

    UAV* CreateUAV() const;

    SRV* CreateSRV() const;

private:
    size_t Stride = 0;
    size_t NumElements = 0;
};
