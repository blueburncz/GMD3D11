#include <d3d11.h>
#include <d3dcompiler.h>
#include <exports.hpp>
#include <iostream>
#include <unordered_map>
#include <Windows.h>

#pragma comment(lib, "d3d11.lib")
#pragma comment(lib, "d3dcompiler.lib")

extern ID3D11Device* gDevice;

extern ID3D11DeviceContext* gContext;

extern char* gErrorString;

std::unordered_map<size_t, ID3D11PixelShader*> gPShaders;

size_t gPShaderID = 0;

std::unordered_map<size_t, ID3D11VertexShader*> gVShaders;

size_t gVShaderID = 0;

ID3D11PixelShader* gOverridePS = nullptr;

ID3D11VertexShader* gOverrideVS = nullptr;

// Source: https://learn.microsoft.com/en-us/windows/win32/direct3d11/how-to--compile-a-shader
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
#endif

	const D3D_SHADER_MACRO defines[] = 
	{
		"EXAMPLE_DEFINE", "1",
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
			if (gErrorString)
			{
				delete gErrorString;
			}
			gErrorString = strdup((char*)errorBlob->GetBufferPointer());
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

// Source: https://stackoverflow.com/a/19717944
wchar_t* ConvertCharArrayToLPCWSTR(const char* charArray)
{
	wchar_t* wString = new wchar_t[4096];
	MultiByteToWideChar(CP_ACP, 0, charArray, -1, wString, 4096);
	return wString;
}

GM_EXPORT double d3d11_texture_set_stage_vs(double index)
{
	UINT startSlot = (UINT)index;
	if (startSlot < 0
		|| startSlot >= D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT)
	{
		return GM_FALSE;
	}
	ID3D11ShaderResourceView* shaderResourceView;
	gContext->PSGetShaderResources(0, 1, &shaderResourceView);
	gContext->VSSetShaderResources(startSlot, 1, &shaderResourceView);
	return GM_TRUE;
}

GM_EXPORT double d3d11_texture_set_stage_ps(double index)
{
	UINT startSlot = (UINT)index;
	if (startSlot < 0
		|| startSlot >= D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT)
	{
		return GM_FALSE;
	}
	ID3D11ShaderResourceView* shaderResourceView;
	gContext->PSGetShaderResources(0, 1, &shaderResourceView);
	gContext->PSSetShaderResources(startSlot, 1, &shaderResourceView);
	return GM_TRUE;
}

GM_EXPORT double d3d11_shader_compile_ps(char* file, char* entryPoint, char* profile)
{
	ID3DBlob* blob = nullptr;

	LPCWSTR path = ConvertCharArrayToLPCWSTR(file);

	HRESULT hr = CompileShader(path, (LPCSTR)entryPoint, (LPCSTR)profile, &blob);

	delete path;

	if (FAILED(hr))
	{
		std::cout << "Failed compiling PS " << file << "!" << std::endl;
		return -1.0;
	}

	ID3D11PixelShader* ps = nullptr;
	hr = gDevice->CreatePixelShader(blob->GetBufferPointer(), blob->GetBufferSize(), nullptr, &ps);
	blob->Release();

	if (FAILED(hr))
	{
		std::cout << "Failed creating PS " << file << "!" << std::endl;
		return -1.0;
	}

	size_t index = gPShaderID++;
	gPShaders[index] = ps;

	std::cout << "Compiled PS " << file << std::endl;

	return (double)index;
}

GM_EXPORT double d3d11_shader_compile_vs(char* file, char* entryPoint, char* profile)
{
	ID3DBlob* blob = nullptr;

	LPCWSTR path = ConvertCharArrayToLPCWSTR(file);

	HRESULT hr = CompileShader(path, (LPCSTR)entryPoint, (LPCSTR)profile, &blob);

	delete path;

	if (FAILED(hr))
	{
		std::cout << "Failed compiling VS " << file << "!" << std::endl;
		return -1.0;
	}

	ID3D11VertexShader* vs = nullptr;
	hr = gDevice->CreateVertexShader(blob->GetBufferPointer(), blob->GetBufferSize(), nullptr, &vs);
	blob->Release();

	if (FAILED(hr))
	{
		std::cout << "Failed creating VS " << file << "!" << std::endl;
		return -1.0;
	}

	size_t index = gVShaderID++;
	gVShaders[index] = vs;

	std::cout << "Compiled VS " << file << std::endl;

	return (double)index;
}

GM_EXPORT double d3d11_shader_override_ps(double ps)
{
	gOverridePS = (ps >= 0.0) ? gPShaders[(size_t)ps] : nullptr;
	return GM_TRUE;
}

GM_EXPORT double d3d11_shader_override_vs(double vs)
{
	gOverrideVS = (vs >= 0.0) ? gVShaders[(size_t)vs] : nullptr;
	return GM_TRUE;
}

GM_EXPORT double d3d11_shader_exists_ps(double ps)
{
	return (ps >= 0.0 && gPShaders.find((size_t)ps) != gPShaders.end()) ? GM_TRUE : GM_FALSE;
}

GM_EXPORT double d3d11_shader_exists_vs(double vs)
{
	return (vs >= 0.0 && gVShaders.find((size_t)vs) != gVShaders.end()) ? GM_TRUE : GM_FALSE;
}

GM_EXPORT double d3d11_shader_destroy_ps(double ps)
{
	gPShaders[(size_t)ps]->Release();
	gPShaders.erase((size_t)ps);
	return GM_TRUE;
}

GM_EXPORT double d3d11_shader_destroy_vs(double vs)
{
	gVShaders[(size_t)vs]->Release();
	gVShaders.erase((size_t)vs);
	return GM_TRUE;
}
