#include <shaders/CShader.hpp>

#include <buffers/Buffer.hpp>
#include <utils.hpp>

#include <d3dcompiler.h>
#include <iostream>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;
extern char* g_ErrorString;

CShader::CShader(ID3DBlob* blob, ID3D11ComputeShader* shader)
    : Shader(blob)
    , Raw(shader)
{
}

CShader::~CShader()
{
    if (Raw)
    {
        Raw->Release();
    }
}

static CShader* CompileCS(char* file, char* entryPoint, char* profile)
{
    ID3DBlob* blob = nullptr;
    LPCWSTR path = ConvertCharArrayToLPCWSTR(file);
    HRESULT hr = CompileShader(path, static_cast<LPCSTR>(entryPoint), static_cast<LPCSTR>(profile), &blob);
    delete path;

    if (FAILED(hr))
    {
        std::cout << "Failed compiling CS " << file << "!" << std::endl;
        return nullptr;
    }

    ID3D11ComputeShader* gs = nullptr;
    hr = g_Device->CreateComputeShader(blob->GetBufferPointer(), blob->GetBufferSize(), nullptr, &gs);

    if (FAILED(hr))
    {
        std::cout << "Failed creating CS " << file << "!" << std::endl;
        return nullptr;
    }

    std::cout << "Compiled CS " << file << std::endl;

    return new CShader(blob, gs);
}

/// @func d3d11_shader_compile_cs(_file, _entryPoint, _profile)
///
/// @desc Compiles a compute shader from file.
///
/// @param {String} _file The path to file to compile.
/// @param {String} _entryPoint The name of the entry point function, e.g. "main".
/// @param {String} _profile The compute shader profile, e.g. "cs_5_0".
///
/// @return {Real} The ID of the compute shader or -1 on fail.
GM_EXPORT ty_real d3d11_shader_compile_cs(ty_string _file, ty_string _entryPoint, ty_string _profile)
{
    CShader* shader = CompileCS(_file, _entryPoint, _profile);
    if (!shader)
    {
        return -1.0;
    }
    return static_cast<ty_real>(shader->GetID());
}

/// @func d3d11_shader_load_cs(_file)
///
/// @desc Loads a compiled compute shader from a file.
///
/// @param {String} _file The path to the compiled compute shader.
///
/// @return {Real} The ID of the compute shader or -1 on fail.
GM_EXPORT ty_real d3d11_shader_load_cs(ty_string _file)
{
    std::vector<char> bytecode = Shader::LoadBlob(_file);
    if (bytecode.empty())
    {
        std::cout << "Failed loading CS " << _file << "!" << std::endl;
        return -1.0;
    }

    ID3D11ComputeShader* cs = nullptr;
    HRESULT hr = g_Device->CreateComputeShader(bytecode.data(), bytecode.size(), nullptr, &cs);

    if (FAILED(hr))
    {
        std::cout << "Failed creating loaded CS " << _file << "!" << std::endl;
        return -1.0;
    }

    ID3DBlob* blob = nullptr;
    hr = D3DCreateBlob(bytecode.size(), &blob);

    if (FAILED(hr))
    {
        std::cout << "Failed creating blob for loaded CS " << _file << "!" << std::endl;
        cs->Release();
        return -1.0;
    }

    memcpy(blob->GetBufferPointer(), bytecode.data(), bytecode.size());

    std::cout << "Loaded CS " << _file << std::endl;

    return static_cast<ty_real>((new CShader(blob, cs))->GetID());
}

/// @func d3d11_shader_set_cs(_cs)
///
/// @desc Changes the current compute shader.
///
/// @param {Real} _cs The ID of the shader or -1 to disable the compute stage.
GM_EXPORT ty_real d3d11_shader_set_cs(ty_real _gs)
{
    ID3D11ComputeShader* shader = (_gs >= 0.0) ? ((CShader*)Trackable::Get<Shader>(static_cast<size_t>(_gs)))->GetShader() : nullptr;
    g_Context->CSSetShader(shader, nullptr, 0);
    return GM_TRUE;
}

/// @func d3d11_compute_dispatch(_x, _y, _z)
///
/// @disc Dispatches the current compute shader with given number of workgroups.
///
/// @param {Real} _x Number of workgroups to dispatch in the x direction.
/// @param {Real} _y Number of workgroups to dispatch in the y direction.
/// @param {Real} _z Number of workgroups to dispatch in the z direction.
GM_EXPORT ty_real d3d11_compute_dispatch(ty_real _x, ty_real _y, ty_real _z)
{
    g_Context->Dispatch(static_cast<UINT>(_x), static_cast<UINT>(_y), static_cast<UINT>(_z));
    return GM_TRUE;
}

/// @func d3d11_compute_dispatch_indirect(_buffer, _offset)
///
/// @desc Dispatches the current compute shader, reading the number of workgroups to be dispatched from the specified
/// buffer. The dispatch arguments in the buffer must contain three UINT values representing the X, Y, and Z workgroup
/// dimensions.
///
/// @param {Real} _buffer The ID of the buffer that contains the dispatch arguments.
/// @param {Real} _offset The byte offset from the start of the buffer to the location of the dispatch arguments. Must
/// be aligned to 4 bytes.
GM_EXPORT ty_real d3d11_compute_dispatch_indirect(ty_real _buffer, ty_real _offset)
{
    g_Context->DispatchIndirect(Trackable::Get<Buffer>(static_cast<size_t>(_buffer))->GetBuffer(), static_cast<UINT>(_offset));
    return GM_TRUE;
}
