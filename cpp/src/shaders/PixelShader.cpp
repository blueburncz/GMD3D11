#include <shaders/PixelShader.hpp>

#include <utils.hpp>

#include <d3dcompiler.h>
#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;
extern char* g_ErrorString;

ID3D11PixelShader* g_OverridePS = nullptr;

PixelShader::PixelShader(ID3DBlob* blob, ID3D11PixelShader* shader)
    : Shader(blob)
    , Raw(shader)
{
}

PixelShader::~PixelShader()
{
    if (Raw)
    {
        Raw->Release();
    }
}

static PixelShader* CompilePS(char* file, char* entryPoint, char* profile)
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

    return new PixelShader(blob, ps);
}

/// @func d3d11_shader_compile_ps(_file, _entryPoint, _profile)
///
/// @desc Compiles a pixel shader from file.
///
/// @param {String} _file The path to file to compile.
/// @param {String} _entryPoint The name of the entry point function, e.g. "main".
/// @param {String} _profile The pixel shader profile, e.g. "ps_4_0".
///
/// @return {Real} The ID of the pixel shader pr {@link GMD3D11_ID_INVALID} on fail.
GM_EXPORT ty_real d3d11_shader_compile_ps(ty_string _file, ty_string _entryPoint, ty_string _profile)
{
    if (PixelShader* shader = CompilePS(_file, _entryPoint, _profile))
    {
        return static_cast<ty_real>(shader->GetID());
    }
    return GMD3D11_ID_INVALID;
}

/// @func d3d11_shader_load_ps(_file)
///
/// @desc Loads a compiled pixel shader from a file.
///
/// @param {String} _file The path to the compiled pixel shader.
///
/// @return {Real} The ID of the pixel shader pr {@link GMD3D11_ID_INVALID} on fail.
GM_EXPORT ty_real d3d11_shader_load_ps(ty_string _file)
{
    std::vector<char> bytecode = Shader::LoadBlob(_file);
    if (bytecode.empty())
    {
        std::cout << "Failed loading PS " << _file << "!" << std::endl;
        return GMD3D11_ID_INVALID;
    }

    ID3D11PixelShader* ps = nullptr;
    HRESULT hr = g_Device->CreatePixelShader(bytecode.data(), bytecode.size(), nullptr, &ps);

    if (FAILED(hr))
    {
        std::cout << "Failed creating loaded PS " << _file << "!" << std::endl;
        return GMD3D11_ID_INVALID;
    }

    ID3DBlob* blob = nullptr;
    hr = D3DCreateBlob(bytecode.size(), &blob);

    if (FAILED(hr))
    {
        std::cout << "Failed creating blob for loaded PS " << _file << "!" << std::endl;
        ps->Release();
        return GMD3D11_ID_INVALID;
    }

    memcpy(blob->GetBufferPointer(), bytecode.data(), bytecode.size());

    std::cout << "Loaded PS " << _file << std::endl;

    return static_cast<ty_real>((new PixelShader(blob, ps))->GetID());
}

/// @func d3d11_shader_override_ps(_ps)
///
/// @desc Hooks into `ID3D11DeviceContext::Draw` and replaces the current pixel shader with a custom one.
///
/// @param {Real} _ps The ID of the shader or {@link GMD3D11_ID_INVALID} to disable the override.
GM_EXPORT ty_real d3d11_shader_override_ps(ty_real _ps)
{
    g_OverridePS = (_ps != GMD3D11_ID_INVALID) ? ((PixelShader*)Trackable::Get<Shader>(static_cast<size_t>(_ps)))->GetShader() : nullptr;
    return GM_TRUE;
}
