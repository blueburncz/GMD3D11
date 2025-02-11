#pragma once

#include <common.hpp>

#include <Shader.hpp>

class CShader final : public Shader
{
public:
    CShader(ID3DBlob* blob, ID3D11ComputeShader* shader);

    virtual ~CShader();

    ID3D11ComputeShader* GetShader() const { return Raw; }

private:
    ID3D11ComputeShader* Raw = nullptr;
};
