#pragma once

#include <d3d11.h>
#include <unordered_map>

extern std::unordered_map<size_t, class Shader*> gShaders;

class Shader
{
public:
	Shader(ID3DBlob* blob)
		: Blob(blob)
	{
	}

	virtual ~Shader()
	{
		if (Blob)
		{
			Blob->Release();
		}
	}

	ID3DBlob* GetBlob() const
	{
		return Blob;
	}

private:
	ID3DBlob* Blob = nullptr;
};

// Source: https://learn.microsoft.com/en-us/windows/win32/direct3d11/how-to--compile-a-shader
HRESULT CompileShader(_In_ LPCWSTR srcFile, _In_ LPCSTR entryPoint, _In_ LPCSTR profile, _Outptr_ ID3DBlob** blob);
