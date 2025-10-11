#pragma once 

#include <common.hpp>

#include <Trackable.hpp>

#include <d3d11.h>

/// @brief Buffer base class.
class Buffer : public Trackable
{
public:
    virtual ~Buffer();

    ID3D11Buffer* GetBuffer() const { return Raw; }

    virtual size_t GetSize() const = 0;

    void Copy(Buffer* dest);

protected:
    Buffer(ID3D11Buffer* buffer);

    ID3D11Buffer* Raw = nullptr;
};
