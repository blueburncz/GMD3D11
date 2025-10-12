#pragma once

#include <common.hpp>

#include <shaders/Shader.hpp>

/// @brief Geometry shader.
class GeometryShader final : public Shader
{
public:
    GeometryShader(ID3DBlob* blob, ID3D11GeometryShader* shader);

    virtual ~GeometryShader();

    ID3D11GeometryShader* GetShader() const { return Raw; }

private:
    ID3D11GeometryShader* Raw = nullptr;
};
