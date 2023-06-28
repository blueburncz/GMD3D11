#include <PShader.hpp>

#include <exports.hpp>
#include <Shader.hpp>
#include <utils.hpp>

#include <iostream>

extern ID3D11Device* gDevice;

extern ID3D11DeviceContext* gContext;

extern char* gErrorString;

extern size_t gShaderID;

ID3D11PixelShader* gOverridePS = nullptr;

static PShader* CompilePS(char* file, char* entryPoint, char* profile)
{
	ID3DBlob* blob = nullptr;
	LPCWSTR path = ConvertCharArrayToLPCWSTR(file);
	HRESULT hr = CompileShader(path, (LPCSTR)entryPoint, (LPCSTR)profile, &blob);
	delete path;

	if (FAILED(hr))
	{
		std::cout << "Failed compiling PS " << file << "!" << std::endl;
		return nullptr;
	}

	ID3D11PixelShader* ps = nullptr;
	hr = gDevice->CreatePixelShader(blob->GetBufferPointer(), blob->GetBufferSize(), nullptr, &ps);

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
	size_t index = gShaderID++;
	gShaders[index] = shader;
	return (double)index;
}

GM_EXPORT double d3d11_shader_override_ps(double ps)
{
	gOverridePS = (ps >= 0.0) ? ((PShader*)gShaders[(size_t)ps])->GetShader() : nullptr;
	return GM_TRUE;
}
