#pragma once

#include <common.hpp>

#include <buffers/Buffer.hpp>

#include <d3d11.h>

/// @brief Staging buffer, for reading GPU data on the CPU.
class ReadbackBuffer final : public Buffer
{
public:
    ReadbackBuffer(ID3D11Buffer* buffer, size_t stride, size_t numElements);

    virtual ~ReadbackBuffer();

    size_t GetSize() const { return Stride * NumElements; }

    bool IsMapped() const { return Mapped; }

    bool Map();

    void* GetMappedData() const { return MapData.pData; }

    bool Unmap();

private:
    size_t Stride = 0;
    size_t NumElements = 0;
    D3D11_MAPPED_SUBRESOURCE MapData{};
    bool Mapped = false;
};
