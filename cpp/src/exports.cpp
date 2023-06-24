#include <d3d11.h>
#include <d3dcompiler.h>
#include <iostream>
#include <Windows.h>
#include <VMTHookManager.hpp>
#include <vector>

#pragma comment(lib, "d3d11.lib")
#pragma comment(lib, "d3dcompiler.lib")

#define GM_EXPORT extern "C" __declspec(dllexport)

ID3D11Device* gDevice = nullptr;
ID3D11DeviceContext* gContext = nullptr;
VMTHookManager gContextHookManager;
std::vector<ID3D11PixelShader*> gShadersPS;
ID3D11PixelShader* gShaderOverridePS = nullptr;

// Source: https://learn.microsoft.com/en-us/windows/win32/direct3d11/how-to--compile-a-shader
HRESULT CompileShader( _In_ LPCWSTR srcFile, _In_ LPCSTR entryPoint, _In_ LPCSTR profile, _Outptr_ ID3DBlob** blob )
{
	if ( !srcFile || !entryPoint || !profile || !blob )
	   return E_INVALIDARG;

	*blob = nullptr;

	UINT flags = D3DCOMPILE_ENABLE_STRICTNESS;
#if defined( DEBUG ) || defined( _DEBUG )
	flags |= D3DCOMPILE_DEBUG;
#endif

	const D3D_SHADER_MACRO defines[] = 
	{
		"EXAMPLE_DEFINE", "1",
		NULL, NULL
	};

	ID3DBlob* shaderBlob = nullptr;
	ID3DBlob* errorBlob = nullptr;
	HRESULT hr = D3DCompileFromFile( srcFile, defines, D3D_COMPILE_STANDARD_FILE_INCLUDE,
									 entryPoint, profile,
									 flags, 0, &shaderBlob, &errorBlob );
	if ( FAILED(hr) )
	{
		if ( errorBlob )
		{
			std::cout << "ERROR: " << (char*)errorBlob->GetBufferPointer() << std::endl;
			errorBlob->Release();
		}

		if ( shaderBlob )
			shaderBlob->Release();

		return hr;
	}

	*blob = shaderBlob;

	return hr;
}

enum class ID3D11DeviceContextVtbl
{
	VSSetConstantBuffers = 7,
	PSSetShaderResources,
	PSSetShader,
	PSSetSamplers,
	VSSetShader,
	DrawIndexed,
	Draw,
};

void __stdcall PSSetShader(ID3D11DeviceContext* Context, ID3D11PixelShader* pPixelShader, ID3D11ClassInstance* const* ppClassInstances, UINT NumClassInstances)
{
	static auto fn = reinterpret_cast<void(__thiscall*)(ID3D11DeviceContext*, ID3D11PixelShader*, ID3D11ClassInstance* const*, UINT)>(
		gContextHookManager.dwGetMethodAddress((UINT)ID3D11DeviceContextVtbl::PSSetShader));
	if (gShaderOverridePS != nullptr)
	{
		pPixelShader = gShaderOverridePS;
	}
	fn(Context, pPixelShader, ppClassInstances, NumClassInstances);
}

void __stdcall Draw(ID3D11DeviceContext* Context, UINT VertexCount, UINT StartVertexLocation)
{
	static auto fn = reinterpret_cast<void(__thiscall*)(ID3D11DeviceContext*, UINT, UINT)>(
		gContextHookManager.dwGetMethodAddress((UINT)ID3D11DeviceContextVtbl::Draw));
	fn(Context, VertexCount, StartVertexLocation);
}

GM_EXPORT double d3d11_init(char* device, char* context)
{
	gDevice = (ID3D11Device*)device;
	gContext = (ID3D11DeviceContext*)context;

	gContextHookManager.bInitialize((_pdword*)gContext);
	gContextHookManager.dwHookMethod((_dword)PSSetShader, (UINT)ID3D11DeviceContextVtbl::PSSetShader);
	// gContextHookManager.dwHookMethod((_dword)Draw, (UINT)ID3D11DeviceContextVtbl::Draw);

	return 1.0;
}

GM_EXPORT double d3d11_texture_set_stage_vs(double index)
{
	UINT startSlot = (UINT)index;
	if (startSlot < 0
		|| startSlot >= D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT)
	{
		return 0.0;
	}
	ID3D11ShaderResourceView* shaderResourceView;
	gContext->PSGetShaderResources(0, 1, &shaderResourceView);
	gContext->VSSetShaderResources(startSlot, 1, &shaderResourceView);
	return 1.0;
}

GM_EXPORT double d3d11_texture_set_stage_ps(double index)
{
	UINT startSlot = (UINT)index;
	if (startSlot < 0
		|| startSlot >= D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT)
	{
		return 0.0;
	}
	ID3D11ShaderResourceView* shaderResourceView;
	gContext->PSGetShaderResources(0, 1, &shaderResourceView);
	gContext->PSSetShaderResources(startSlot, 1, &shaderResourceView);
	return 1.0;
}

wchar_t* ConvertCharArrayToLPCWSTR(const char* charArray)
{
    wchar_t* wString = new wchar_t[4096];
    MultiByteToWideChar(CP_ACP, 0, charArray, -1, wString, 4096);
    return wString;
}

GM_EXPORT double d3d11_shader_compile_ps(char* file, char* entryPoint, char* profile)
{
	ID3DBlob* blob = nullptr;

	LPCWSTR path = ConvertCharArrayToLPCWSTR(file);

	HRESULT hr = CompileShader(path, (LPCSTR)entryPoint, (LPCSTR)profile, &blob);

	delete path;

	if (FAILED(hr))
	{
		std::cout << "Failed compiling PS shader " << file << "!" << std::endl;
		return -1.0;
	}

	ID3D11PixelShader* ps = nullptr;
	hr = gDevice->CreatePixelShader(blob->GetBufferPointer(), blob->GetBufferSize(), nullptr, &ps);
	blob->Release();

	if (FAILED(hr))
	{
		std::cout << "Failed creating PS shader " << file << "!" << std::endl;
		return -1.0;
	}

	size_t index = gShadersPS.size();
	gShadersPS.push_back(ps);

	std::cout << "Compiled PS shader " << file << std::endl;

	return (double)index;
}

GM_EXPORT double d3d11_shader_override_ps(double ps)
{
	gShaderOverridePS = (ps >= 0.0) ? gShadersPS[(size_t)ps] : nullptr;
	return 1.0;
}
