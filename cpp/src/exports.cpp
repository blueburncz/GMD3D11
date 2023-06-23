#include <d3d11.h>
#include <iostream>
#include <Windows.h>
#include <VMTHookManager.hpp>

#define GM_EXPORT extern "C" __declspec(dllexport)

ID3D11Device* gDevice = nullptr;
ID3D11DeviceContext* gContext = nullptr;
VMTHookManager gContextHookManager;

void __stdcall Draw(ID3D11DeviceContext* Context, UINT VertexCount, UINT StartVertexLocation)
{
	static auto fn = reinterpret_cast<void(__thiscall*)(ID3D11DeviceContext*, UINT, UINT)>(gContextHookManager.dwGetMethodAddress(13));
	std::cout << "Hook!" << std::endl;
	fn(Context, VertexCount, StartVertexLocation);
}

GM_EXPORT double d3d11_init(char* device, char* context)
{
	gDevice = (ID3D11Device*)device;
	gContext = (ID3D11DeviceContext*)context;

	gContextHookManager.bInitialize((_pdword*)gContext);
	gContextHookManager.dwHookMethod((_dword)Draw, 13);

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
