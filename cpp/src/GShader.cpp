#include <GShader.hpp>

#include <Shader.hpp>
#include <utils.hpp>

#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;
extern char* g_ErrorString;

GShader::GShader(ID3DBlob* blob, ID3D11GeometryShader* shader)
    : Shader(blob)
    , Raw(shader)
{
}

GShader::~GShader()
{
    if (Raw)
    {
        Raw->Release();
    }
}

static GShader* CompileGS(char* file, char* entryPoint, char* profile)
{
    ID3DBlob* blob = nullptr;
    LPCWSTR path = ConvertCharArrayToLPCWSTR(file);
    HRESULT hr = CompileShader(path, static_cast<LPCSTR>(entryPoint), static_cast<LPCSTR>(profile), &blob);
    delete path;

    if (FAILED(hr))
    {
        std::cout << "Failed compiling GS " << file << "!" << std::endl;
        return nullptr;
    }

    ID3D11GeometryShader* gs = nullptr;
    hr = g_Device->CreateGeometryShader(blob->GetBufferPointer(), blob->GetBufferSize(), nullptr, &gs);

    if (FAILED(hr))
    {
        std::cout << "Failed creating GS " << file << "!" << std::endl;
        return nullptr;
    }

    std::cout << "Compiled GS " << file << std::endl;

    return new GShader(blob, gs);
}

GM_EXPORT double d3d11_shader_compile_gs(char* file, char* entryPoint, char* profile)
{
    GShader* shader = CompileGS(file, entryPoint, profile);
    if (!shader)
    {
        return -1.0;
    }
    return static_cast<double>(shader->GetID());
}

GM_EXPORT double d3d11_shader_set_gs(double gs)
{
    ID3D11GeometryShader* shader = (gs >= 0.0) ? ((GShader*)Shader::Get(static_cast<size_t>(gs)))->GetShader() : nullptr;
    g_Context->GSSetShader(shader, nullptr, 0);
    return GM_TRUE;
}
