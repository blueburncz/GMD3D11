#include <d3d11.h>

#define GM_EXPORT extern "C" __declspec (dllexport)

ID3D11Device* gDevice;

ID3D11DeviceContext* gContext;

GM_EXPORT double d3d11_init(void* device, void* context)
{
	gDevice = (ID3D11Device*)device;
	gContext = (ID3D11DeviceContext*)context;
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
