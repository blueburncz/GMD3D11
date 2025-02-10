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

/// @func d3d11_shader_exists(_shader)
///
/// @desc Checks whether a shader exists.
///
/// @param {Real} _shader The ID of the shader.
///
/// @return {Bool} Returns true if the shader exists.
GM_EXPORT ty_real d3d11_shader_exists(ty_real _shader)
{
    return (_shader >= 0.0 && Shader::Exists(static_cast<size_t>(_shader))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_shader_destroy(_shader)
///
/// @desc Destroys a shader.
///
/// @param {Real} _shader The ID of the shader to destroy.
GM_EXPORT ty_real d3d11_shader_destroy(ty_real _shader)
{
    delete Shader::Get(static_cast<size_t>(_shader));
    return GM_TRUE;
}

/// @func d3d11_shader_save(_shader, _filePath)
///
/// @desc Saves a compiled shader.
///
/// @param {Real} _shader The ID of the shader to save.
/// @param {String} _filePath The file to save the shader to.
///
/// @return {Bool} Returns `true` on success.
GM_EXPORT ty_real d3d11_shader_save(ty_real _shader, ty_string _filePath)
{
    return Shader::Get(static_cast<size_t>(_shader))->SaveBlob(_filePath) ? GM_TRUE : GM_FALSE;
}
