#pragma once

#include <common.hpp>

#include <shaders/Shader.hpp>

/// @brief Pixel shader.
class PShader final : public Shader
{
public:
    PShader(ID3DBlob* blob, ID3D11PixelShader* shader);

    virtual ~PShader();

    ID3D11PixelShader* GetShader() const { return Raw; }

private:
    ID3D11PixelShader* Raw = nullptr;
};
