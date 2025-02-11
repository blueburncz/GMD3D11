#pragma once

#include <common.hpp>

#include <Srv.hpp>
#include <Trackable.hpp>
#include <Uav.hpp>

#include <cstdint>
#include <d3d11.h>

class SBuffer final : public Trackable<SBuffer>
{
public:
    SBuffer(ID3D11Buffer* buffer, size_t stride, size_t numElements);

    virtual ~SBuffer();

    ID3D11Buffer* GetBuffer() const { return Buffer; }

    size_t GetSize() const { return Stride * NumElements; }

    Uav* CreateUav() const;

    Srv* CreateSrv() const;

private:
    ID3D11Buffer* Buffer;
    size_t Stride;
    size_t NumElements;
};
