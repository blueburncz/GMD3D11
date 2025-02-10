#pragma once 

#include <common.hpp>

#include <Struct.hpp>
// #include <Trackable.hpp>

#include <cstdint>
#include <d3d11.h>

class CBuffer final : public Trackable<CBuffer>
{
public:
    CBuffer(ID3D11Buffer* buffer, size_t size) : Buffer(buffer), Size(size) {}

    virtual ~CBuffer();

    ID3D11Buffer* GetBuffer() const { return Buffer; }

    size_t GetSize() const { return Size; }

private:
    ID3D11Buffer* Buffer = nullptr;
    size_t Size = 0;
};
