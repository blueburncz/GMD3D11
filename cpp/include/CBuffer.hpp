#pragma once 

#include <common.hpp>

#include <Trackable.hpp>

#include <cstdint>
#include <d3d11.h>

class CBuffer final : public Trackable<CBuffer>
{
public:
    enum class Element
    {
        Bool = 0,
        Int,
        Uint,
        Float,
        SIZE
    };

    ~CBuffer();

    bool AddElement(Element type, uint32_t count);

    size_t GetSize() const { return Size; }

    ID3D11Buffer* Buffer = nullptr;

private:
    size_t Size = 0;
};
