#include <PShader.hpp>

#include <Shader.hpp>
#include <utils.hpp>

#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;
extern char* g_ErrorString;

ID3D11PixelShader* g_OverridePS = nullptr;

PShader::PShader(ID3DBlob* blob, ID3D11PixelShader* shader)
    : Shader(blob)
    , Raw(shader)
{
}

PShader::~PShader()
{
    if (Raw)
    {
        Raw->Release();
    }
}

static PShader* CompilePS(char* file, char* entryPoint, char* profile)
{
    ID3DBlob* blob = nullptr;
    LPCWSTR path = ConvertCharArrayToLPCWSTR(file);
    HRESULT hr = CompileShader(path, static_cast<LPCSTR>(entryPoint), static_cast<LPCSTR>(profile), &blob);
    delete path;

    if (FAILED(hr))
    {
        std::cout << "Failed compiling PS " << file << "!" << std::endl;
        return nullptr;
    }

    ID3D11PixelShader* ps = nullptr;
    hr = g_Device->CreatePixelShader(blob->GetBufferPointer(), blob->GetBufferSize(), nullptr, &ps);

    if (FAILED(hr))
    {
        std::cout << "Failed creating PS " << file << "!" << std::endl;
        return nullptr;
    }

    std::cout << "Compiled PS " << file << std::endl;

    return new PShader(blob, ps);
}

GM_EXPORT double d3d11_shader_compile_ps(char* file, char* entryPoint, char* profile)
{
    PShader* shader = CompilePS(file, entryPoint, profile);
    if (!shader)
    {
        return -1.0;
    }
    return static_cast<double>(shader->GetID());
}

GM_EXPORT double d3d11_shader_override_ps(double ps)
{
    g_OverridePS = (ps >= 0.0) ? ((PShader*)Shader::Get(static_cast<size_t>(ps)))->GetShader() : nullptr;
    return GM_TRUE;
}
