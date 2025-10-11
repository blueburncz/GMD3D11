#include <GShader.hpp>

#include <Shader.hpp>
#include <utils.hpp>

#include <d3dcompiler.h>
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

/// @func d3d11_shader_compile_gs(_file, _entryPoint, _profile)
///
/// @desc Compiles a geometry shader from file.
///
/// @param {String} _file The path to file to compile.
/// @param {String} _entryPoint The name of the entry point function, e.g. "main".
/// @param {String} _profile The geometry shader profile, e.g. "gs_4_0".
///
/// @return {Real} The ID of the geometry shader or -1 on fail.
GM_EXPORT ty_real d3d11_shader_compile_gs(ty_string _file, ty_string _entryPoint, ty_string _profile)
{
    GShader* shader = CompileGS(_file, _entryPoint, _profile);
    if (!shader)
    {
        return -1.0;
    }
    return static_cast<ty_real>(shader->GetID());
}

/// @func d3d11_shader_load_gs(_file)
///
/// @desc Loads a compiled geometry shader from a file.
///
/// @param {String} _file The path to the compiled geometry shader.
///
/// @return {Real} The ID of the geometry shader or -1 on fail.
GM_EXPORT ty_real d3d11_shader_load_gs(ty_string _file)
{
    std::vector<char> bytecode = Shader::LoadBlob(_file);
    if (bytecode.empty())
    {
        std::cout << "Failed loading GS " << _file << "!" << std::endl;
        return -1.0;
    }

    ID3D11GeometryShader* gs = nullptr;
    HRESULT hr = g_Device->CreateGeometryShader(bytecode.data(), bytecode.size(), nullptr, &gs);

    if (FAILED(hr))
    {
        std::cout << "Failed creating loaded GS " << _file << "!" << std::endl;
        return -1.0;
    }

    ID3DBlob* blob = nullptr;
    hr = D3DCreateBlob(bytecode.size(), &blob);

    if (FAILED(hr))
    {
        std::cout << "Failed creating blob for loaded GS " << _file << "!" << std::endl;
        gs->Release();
        return -1.0;
    }

    memcpy(blob->GetBufferPointer(), bytecode.data(), bytecode.size());

    std::cout << "Loaded GS " << _file << std::endl;

    return static_cast<ty_real>((new GShader(blob, gs))->GetID());
}

/// @func d3d11_shader_set_gs(_gs)
///
/// @desc Changes the current geometry shader.
///
/// @param {Real} _gs The ID of the shader or -1 to disable the geometry stage.
GM_EXPORT ty_real d3d11_shader_set_gs(ty_real _gs)
{
    ID3D11GeometryShader* shader = (_gs >= 0.0) ? ((GShader*)Shader::Get(static_cast<size_t>(_gs)))->GetShader() : nullptr;
    g_Context->GSSetShader(shader, nullptr, 0);
    return GM_TRUE;
}
