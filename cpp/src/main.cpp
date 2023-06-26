#include <d3d11.h>
#include <d3dcompiler.h>
#include <exports.hpp>
#include <iostream>
#include <vector>
#include <VMTHookManager.hpp>
#include <Windows.h>

#pragma comment(lib, "d3d11.lib")
#pragma comment(lib, "d3dcompiler.lib")

extern ID3D11PixelShader* gOverridePS;

extern ID3D11VertexShader* gOverrideVS;

ID3D11Device* gDevice = nullptr;

ID3D11DeviceContext* gContext = nullptr;

VMTHookManager gContextHookManager;

char* gErrorString = nullptr;

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

void __stdcall Draw(ID3D11DeviceContext* Context, UINT VertexCount, UINT StartVertexLocation)
{
	static auto fn = reinterpret_cast<void(__thiscall*)(ID3D11DeviceContext*, UINT, UINT)>(
		gContextHookManager.dwGetMethodAddress((UINT)ID3D11DeviceContextVtbl::Draw));

	if (gOverrideVS)
	{
		Context->VSSetShader(gOverrideVS, nullptr, 0);
	}

	if (gOverridePS)
	{
		Context->PSSetShader(gOverridePS, nullptr, 0);
	}

	fn(Context, VertexCount, StartVertexLocation);
}

GM_EXPORT double d3d11_init(char* device, char* context)
{
	gDevice = (ID3D11Device*)device;
	gContext = (ID3D11DeviceContext*)context;

	gContextHookManager.bInitialize((_pdword*)gContext);
	gContextHookManager.dwHookMethod((_dword)Draw, (UINT)ID3D11DeviceContextVtbl::Draw);

	return GM_TRUE;
}

GM_EXPORT char* d3d11_get_error_string()
{
	return gErrorString ? gErrorString : "";
}
