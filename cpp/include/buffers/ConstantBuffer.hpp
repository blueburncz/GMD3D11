#pragma once 

#include <common.hpp>

#include <buffers/Buffer.hpp>

#include <d3d11.h>

/// @brief Constant buffer.
class ConstantBuffer final : public Buffer
{
public:
    ConstantBuffer(ID3D11Buffer* buffer, size_t size);

    virtual ~ConstantBuffer();

    size_t GetSize() const { return Size; }

private:
    size_t Size = 0;
};
