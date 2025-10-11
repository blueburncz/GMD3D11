#pragma once

#include <common.hpp>

#include <buffers/Buffer.hpp>

#include <d3d11.h>

/// @brief Staging buffer, for reading GPU data on the CPU.
class STBuffer final : public Buffer
{
public:
    STBuffer(ID3D11Buffer* buffer, size_t stride, size_t numElements);

    virtual ~STBuffer();

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
