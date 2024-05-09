#pragma once

#include <common.hpp>

#include <Shader.hpp>

class VShader final : public Shader
{
public:
    VShader(ID3DBlob* blob, ID3D11VertexShader* shader);

    ~VShader();

    ID3D11VertexShader* GetShader() const { return Raw; }

private:
    ID3D11VertexShader* Raw = nullptr;
};
