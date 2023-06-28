#include <exports.hpp>
#include <VMTHookManager.hpp>

#include <d3d11.h>
#include <d3dcompiler.h>
#include <iostream>
#include <vector>
#include <Windows.h>

#pragma comment(lib, "d3d11.lib")

extern ID3D11PixelShader* gOverridePS;

extern ID3D11VertexShader* gOverrideVS;

extern ID3D11InputLayout* gOverrideInputLayout;

ID3D11Device* gDevice = nullptr;

ID3D11DeviceContext* gContext = nullptr;

VMTHookManager gContextHookManager;

char* gErrorString = nullptr;

size_t gDrawInstanced = 0;

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

	if (gDrawInstanced > 0)
	{
		Context->DrawInstanced(VertexCount, gDrawInstanced, StartVertexLocation, 0);
		gDrawInstanced = 0;
		return;
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

GM_EXPORT double d3d11_draw_instanced(double count)
{
	gDrawInstanced = (size_t)count;
	return GM_TRUE;
}
