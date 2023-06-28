#include <Shader.hpp>

#include <exports.hpp>

#include <d3dcompiler.h>

#pragma comment(lib, "d3dcompiler.lib")

extern char* gErrorString;

std::unordered_map<size_t, Shader*> gShaders;

size_t gShaderID = 0;

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

GM_EXPORT double d3d11_shader_exists(double shader)
{
	return (shader >= 0.0 && gShaders.find((size_t)shader) != gShaders.end()) ? GM_TRUE : GM_FALSE;
}

GM_EXPORT double d3d11_shader_destroy(double shader)
{
	delete gShaders[(size_t)shader];
	gShaders.erase((size_t)shader);
	return GM_TRUE;
}
