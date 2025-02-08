#include <Shader.hpp>

#include <d3dcompiler.h>
#include <fstream>

#pragma comment(lib, "d3dcompiler.lib")

extern char* g_ErrorString;

Shader::Shader(ID3DBlob* blob)
    : Blob(blob)
{
}

Shader::~Shader()
{
    if (Blob)
    {
        Blob->Release();
    }
}

bool Shader::SaveBlob(const char* filePath) const
{
    std::ofstream file(filePath, std::ios::binary);

    if (!file)
    {
        return false;
    }

    file.write(static_cast<const char*>(Blob->GetBufferPointer()), Blob->GetBufferSize());

    return !file.fail();
}

std::vector<char> Shader::LoadBlob(const char* filePath)
{
    std::ifstream file(filePath, std::ios::binary | std::ios::ate);

    if (!file)
    {
        return {};
    }

    std::streamsize size = file.tellg();
    file.seekg(0, std::ios::beg);

    std::vector<char> buffer(size);
    if (!file.read(buffer.data(), size))
    {
        return {};
    }

    return buffer;
}

HRESULT CompileShader(_In_ LPCWSTR srcFile, _In_ LPCSTR entryPoint, _In_ LPCSTR profile, _Outptr_ ID3DBlob** blob)
{
    if (!srcFile || !entryPoint || !profile || !blob)
    {
        return E_INVALIDARG;
    }

    *blob = nullptr;

    UINT flags = D3DCOMPILE_ENABLE_STRICTNESS;
#if defined(DEBUG) || defined(_DEBUG)
    flags |= D3DCOMPILE_DEBUG;
#else
    flags |= D3DCOMPILE_OPTIMIZATION_LEVEL3;
#endif

    const D3D_SHADER_MACRO defines[] =
    {
        // "EXAMPLE_DEFINE", "1",
        NULL, NULL
    };

    ID3DBlob* errorBlob = nullptr;
    ID3DBlob* shaderBlob = nullptr;
    HRESULT hr = D3DCompileFromFile(
        srcFile, defines, D3D_COMPILE_STANDARD_FILE_INCLUDE,
        entryPoint, profile,
        flags, 0, &shaderBlob, &errorBlob);

    if (FAILED(hr))
    {
        if (errorBlob)
        {
            if (g_ErrorString)
            {
                delete g_ErrorString;
            }
            g_ErrorString = strdup((char*)errorBlob->GetBufferPointer());
            errorBlob->Release();
        }

        if (shaderBlob)
        {
            shaderBlob->Release();
        }

        return hr;
    }

    *blob = shaderBlob;

    return hr;
}

GM_EXPORT double d3d11_shader_exists(double shader)
{
    return (shader >= 0.0 && Shader::Exists(static_cast<size_t>(shader))) ? GM_TRUE : GM_FALSE;
}

GM_EXPORT double d3d11_shader_destroy(double shader)
{
    delete Shader::Get(static_cast<size_t>(shader));
    return GM_TRUE;
}

GM_EXPORT double d3d11_shader_save(double shader, const char* filePath)
{
    return Shader::Get(static_cast<size_t>(shader))->SaveBlob(filePath) ? GM_TRUE : GM_FALSE;
}
