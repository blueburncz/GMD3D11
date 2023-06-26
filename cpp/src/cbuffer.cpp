#include <cstdint>
#include <d3d11.h>
#include <exports.hpp>
#include <iostream>
#include <unordered_map>

extern ID3D11Device* gDevice;

extern ID3D11DeviceContext* gContext;

std::unordered_map<size_t, class CBuffer*> gCBuffers;

size_t gCBufferID = 0;

class CBuffer* gCBufferCurrent = nullptr;

enum class CBufferElementType
{
	Bool,
	Int,
	Uint,
	Float
};

static size_t GetCBufferElementSize(CBufferElementType type)
{
	switch (type)
	{
	case CBufferElementType::Bool:
		return sizeof(bool);

	case CBufferElementType::Int:
		return sizeof(int32_t);

	case CBufferElementType::Uint:
		return sizeof(uint32_t);

	case CBufferElementType::Float:
		return sizeof(float);
	
	default:
		return 0;
	}
}

class CBuffer
{
public:
	~CBuffer()
	{
		if (Buffer)
		{
			Buffer->Release();
		}
	}

	bool AddElement(CBufferElementType type, uint32_t count)
	{
		if (count < 1)
		{
			return false;
		}
		Size += GetCBufferElementSize(type) * count;
		return true;
	}

	size_t GetSize() const
	{
		return Size;
	}

	ID3D11Buffer* Buffer = nullptr;

private:
	size_t Size = 0;
};

GM_EXPORT double d3d11_cbuffer_begin()
{
	if (gCBufferCurrent)
	{
		return GM_FALSE;
	}
	gCBufferCurrent = new CBuffer();
	return GM_TRUE;
}

GM_EXPORT double d3d11_cbuffer_end()
{
	if (!gCBufferCurrent)
	{
		return -1.0;
	}

	CD3D11_BUFFER_DESC cbDesc(gCBufferCurrent->GetSize(), D3D11_BIND_CONSTANT_BUFFER);
	HRESULT hr = gDevice->CreateBuffer(&cbDesc, NULL, &gCBufferCurrent->Buffer);

	if (FAILED(hr))
	{
		delete gCBufferCurrent;
		gCBufferCurrent = nullptr;
		return -1.0;
	}

	size_t index = gCBufferID++;
	gCBuffers[index] = gCBufferCurrent;
	gCBufferCurrent = nullptr;

	return (double)index;
}

GM_EXPORT double d3d11_cbuffer_add_bool(double count)
{
	return gCBufferCurrent->AddElement(CBufferElementType::Bool, (uint32_t)count) ? GM_TRUE : GM_FALSE;
}

GM_EXPORT double d3d11_cbuffer_add_int(double count)
{
	return gCBufferCurrent->AddElement(CBufferElementType::Int, (uint32_t)count) ? GM_TRUE : GM_FALSE;
}

GM_EXPORT double d3d11_cbuffer_add_uint(double count)
{
	return gCBufferCurrent->AddElement(CBufferElementType::Uint, (uint32_t)count) ? GM_TRUE : GM_FALSE;
}

GM_EXPORT double d3d11_cbuffer_add_float(double count)
{
	return gCBufferCurrent->AddElement(CBufferElementType::Float, (uint32_t)count) ? GM_TRUE : GM_FALSE;
}

GM_EXPORT double d3d11_cbuffer_get_size(double cbuffer)
{
	return gCBuffers[(size_t)cbuffer]->GetSize();
}

GM_EXPORT double d3d11_cbuffer_update(double cbuffer, char* data)
{
	gContext->UpdateSubresource(
		gCBuffers[(size_t)cbuffer]->Buffer,
		0,
		nullptr,
		(void*)data,
		0,
		0);
	return GM_TRUE;
}

GM_EXPORT double d3d11_shader_set_cbuffer_ps(double slot, double cbuffer)
{
	if (cbuffer >= 0.0)
	{
		gContext->PSSetConstantBuffers((UINT)slot, 1, &gCBuffers[(size_t)cbuffer]->Buffer);
	}
	else
	{
		gContext->PSSetConstantBuffers((UINT)slot, 0, nullptr);
	}
	return GM_TRUE;
}

GM_EXPORT double d3d11_shader_set_cbuffer_vs(double slot, double cbuffer)
{
	if (cbuffer >= 0.0)
	{
		gContext->VSSetConstantBuffers((UINT)slot, 1, &gCBuffers[(size_t)cbuffer]->Buffer);
	}
	else
	{
		gContext->VSSetConstantBuffers((UINT)slot, 0, nullptr);
	}
	return GM_TRUE;
}

GM_EXPORT double d3d11_cbuffer_exists(double cbuffer)
{
	return (cbuffer >= 0.0 && gCBuffers.find((size_t)cbuffer) != gCBuffers.end()) ? GM_TRUE : GM_FALSE;
}

GM_EXPORT double d3d11_cbuffer_destroy(double cbuffer)
{
	delete gCBuffers[(size_t)cbuffer];
	gCBuffers.erase((size_t)cbuffer);
	return GM_TRUE;
}
