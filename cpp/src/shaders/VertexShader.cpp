#include <shaders/VertexShader.hpp>

#include <utils.hpp>

#include <d3dcompiler.h>
#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;
extern char* g_ErrorString;

ID3D11VertexShader* g_OverrideVS = nullptr;

VertexShader::VertexShader(ID3DBlob* blob, ID3D11VertexShader* shader)
    : Shader(blob)
    , Raw(shader)
{
}

VertexShader::~VertexShader()
{
    if (Raw)
    {
        Raw->Release();
    }
}

static VertexShader* CompileVS(char* file, char* entryPoint, char* profile)
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

    return new VertexShader(blob, vs);
}

/// @func d3d11_shader_compile_vs(_file, _entryPoint, _profile)
///
/// @desc Compiles a vertex shader from file.
///
/// @param {String} _file The path to file to compile.
/// @param {String} _entryPoint The name of the entry point function, e.g. "main".
/// @param {String} _profile The vertex shader profile, e.g. "vs_4_0".
///
/// @return {Real} The ID of the vertex shader pr {@link GMD3D11_ID_INVALID} on fail.
GM_EXPORT ty_real d3d11_shader_compile_vs(ty_string _file, ty_string _entryPoint, ty_string _profile)
{
    if (VertexShader* shader = CompileVS(_file, _entryPoint, _profile))
    {
        return static_cast<ty_real>(shader->GetID());
    }
    return GMD3D11_ID_INVALID;
}

/// @func d3d11_shader_load_vs(_file)
///
/// @desc Loads a compiled vertex shader from a file.
///
/// @param {String} _file The path to the compiled vertex shader.
///
/// @return {Real} The ID of the vertex shader pr {@link GMD3D11_ID_INVALID} on fail.
GM_EXPORT ty_real d3d11_shader_load_vs(ty_string _file)
{
    std::vector<char> bytecode = Shader::LoadBlob(_file);
    if (bytecode.empty())
    {
        std::cout << "Failed loading VS " << _file << "!" << std::endl;
        return GMD3D11_ID_INVALID;
    }

    ID3D11VertexShader* vs = nullptr;
    HRESULT hr = g_Device->CreateVertexShader(bytecode.data(), bytecode.size(), nullptr, &vs);

    if (FAILED(hr))
    {
        std::cout << "Failed creating loaded VS " << _file << "!" << std::endl;
        return GMD3D11_ID_INVALID;
    }

    ID3DBlob* blob = nullptr;
    hr = D3DCreateBlob(bytecode.size(), &blob);

    if (FAILED(hr))
    {
        std::cout << "Failed creating blob for loaded VS " << _file << "!" << std::endl;
        vs->Release();
        return GMD3D11_ID_INVALID;
    }

    memcpy(blob->GetBufferPointer(), bytecode.data(), bytecode.size());

    std::cout << "Loaded VS " << _file << std::endl;

    return static_cast<ty_real>((new VertexShader(blob, vs))->GetID());
}

/// @func d3d11_shader_override_vs(_vs)
///
/// @desc Hooks into `ID3D11DeviceContext::Draw` and replaces the current vertex shader with a custom one.
///
/// @param {Real} _vs The ID of the shader or {@link GMD3D11_ID_INVALID} to disable the override. The vertex format
/// expected by the shader must be compatible with the overriden shader!
GM_EXPORT ty_real d3d11_shader_override_vs(ty_real _vs)
{
    g_OverrideVS = (_vs != GMD3D11_ID_INVALID) ? ((VertexShader*)Trackable::Get<Shader>(static_cast<size_t>(_vs)))->GetShader() : nullptr;
    return GM_TRUE;
}
