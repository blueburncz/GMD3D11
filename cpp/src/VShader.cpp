#include <VShader.hpp>

#include <Shader.hpp>
#include <utils.hpp>

#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;
extern char* g_ErrorString;

ID3D11VertexShader* g_OverrideVS = nullptr;

VShader::VShader(ID3DBlob* blob, ID3D11VertexShader* shader)
    : Shader(blob)
    , Raw(shader)
{
}

VShader::~VShader()
{
    if (Raw)
    {
        Raw->Release();
    }
}

static VShader* CompileVS(char* file, char* entryPoint, char* profile)
{
    ID3DBlob* blob = nullptr;
    LPCWSTR path = ConvertCharArrayToLPCWSTR(file);
    HRESULT hr = CompileShader(path, static_cast<LPCSTR>(entryPoint), static_cast<LPCSTR>(profile), &blob);
    delete path;

    if (FAILED(hr))
    {
        std::cout << "Failed compiling VS " << file << "!" << std::endl;
        return nullptr;
    }

    ID3D11VertexShader* vs = nullptr;
    hr = g_Device->CreateVertexShader(blob->GetBufferPointer(), blob->GetBufferSize(), nullptr, &vs);

    if (FAILED(hr))
    {
        std::cout << "Failed creating VS " << file << "!" << std::endl;
        return nullptr;
    }

    std::cout << "Compiled VS " << file << std::endl;

    return new VShader(blob, vs);
}

GM_EXPORT double d3d11_shader_compile_vs(char* file, char* entryPoint, char* profile)
{
    VShader* shader = CompileVS(file, entryPoint, profile);
    if (!shader)
    {
        return -1.0;
    }
    return static_cast<double>(shader->GetID());
}

GM_EXPORT double d3d11_shader_override_vs(double vs)
{
    g_OverrideVS = (vs >= 0.0) ? ((VShader*)Shader::Get(static_cast<size_t>(vs)))->GetShader() : nullptr;
    return GM_TRUE;
}
