#pragma once

#include <common.hpp>

#include <buffers/Buffer.hpp>
#include <views/SRV.hpp>
#include <views/UAV.hpp>

#include <d3d11.h>

/// @brief Read-only structured buffer.
class StructuredBuffer final : public Buffer
{
public:
    StructuredBuffer(ID3D11Buffer* buffer, size_t stride, size_t numElements);

    virtual ~StructuredBuffer();

    size_t GetSize() const { return Stride * NumElements; }

    SRV* CreateSRV() const;

private:
    size_t Stride = 0;
    size_t NumElements = 0;
};
