#pragma once

#include <common.hpp>

#include <shaders/Shader.hpp>

/// @brief Pixel shader.
class PixelShader final : public Shader
{
public:
    PixelShader(ID3DBlob* blob, ID3D11PixelShader* shader);

    virtual ~PixelShader();

    ID3D11PixelShader* GetShader() const { return Raw; }

private:
    ID3D11PixelShader* Raw = nullptr;
};
