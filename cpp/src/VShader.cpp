#include <VShader.hpp>

#include <exports.hpp>
#include <Shader.hpp>
#include <utils.hpp>

#include <iostream>

extern ID3D11Device* gDevice;

extern ID3D11DeviceContext* gContext;

extern char* gErrorString;

extern size_t gShaderID;

ID3D11VertexShader* gOverrideVS = nullptr;

static VShader* CompileVS(char* file, char* entryPoint, char* profile)
{
	ID3DBlob* blob = nullptr;
	LPCWSTR path = ConvertCharArrayToLPCWSTR(file);
	HRESULT hr = CompileShader(path, (LPCSTR)entryPoint, (LPCSTR)profile, &blob);
	delete path;

	if (FAILED(hr))
	{
		std::cout << "Failed compiling VS " << file << "!" << std::endl;
		return nullptr;
	}

	ID3D11VertexShader* vs = nullptr;
	hr = gDevice->CreateVertexShader(blob->GetBufferPointer(), blob->GetBufferSize(), nullptr, &vs);

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
	size_t index = gShaderID++;
	gShaders[index] = shader;
	return (double)index;
}

GM_EXPORT double d3d11_shader_override_vs(double vs)
{
	gOverrideVS = (vs >= 0.0) ? ((VShader*)gShaders[(size_t)vs])->GetShader() : nullptr;
	return GM_TRUE;
}
