#pragma once

#include <common.hpp>

#include <shaders/Shader.hpp>

/// @brief Vertex shader.
class VertexShader final : public Shader
{
public:
    VertexShader(ID3DBlob* blob, ID3D11VertexShader* shader);

    virtual ~VertexShader();

    ID3D11VertexShader* GetShader() const { return Raw; }

private:
    ID3D11VertexShader* Raw = nullptr;
};
