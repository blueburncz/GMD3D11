#pragma once

#include <common.hpp>

#include <Shader.hpp>

class GShader final : public Shader
{
public:
    GShader(ID3DBlob* blob, ID3D11GeometryShader* shader);

    virtual ~GShader();

    ID3D11GeometryShader* GetShader() const { return Raw; }

private:
    ID3D11GeometryShader* Raw = nullptr;
};
