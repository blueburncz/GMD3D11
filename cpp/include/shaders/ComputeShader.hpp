#pragma once

#include <common.hpp>

#include <shaders/Shader.hpp>

/// @brief Compute shader.
class ComputeShader final : public Shader
{
public:
    ComputeShader(ID3DBlob* blob, ID3D11ComputeShader* shader);

    virtual ~ComputeShader();

    ID3D11ComputeShader* GetShader() const { return Raw; }

private:
    ID3D11ComputeShader* Raw = nullptr;
};
