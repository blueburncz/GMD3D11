#pragma once 

#include <common.hpp>

#include <Trackable.hpp>

#include <d3d11.h>

/// @brief 2D texture.
class Texture2D : public Trackable
{
public:
    Texture2D(ID3D11Texture2D* texture2D);

    virtual ~Texture2D();

    ID3D11Texture2D* GetTexture2D() const { return Raw; }

protected:
    ID3D11Texture2D* Raw = nullptr;
};
