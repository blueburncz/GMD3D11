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

GM_EXPORT double d3d11_texture_set_stage_vertex(double index)
{
	ID3D11ShaderResourceView* shaderResourceView;
	gContext->PSGetShaderResources(0, 1, &shaderResourceView);
	gContext->VSSetShaderResources((UINT)index, 1, &shaderResourceView);
	return 1.0;
}

