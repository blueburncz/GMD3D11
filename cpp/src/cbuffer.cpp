#include <cstdint>
#include <d3d11.h>
#include <exports.hpp>
#include <iostream>
#include <vector>

enum class CBufferElementType
{
	Bool,
	Int,
	Uint,
	Float
};

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
		Types.push_back(type);
		Counts.push_back(count);
		return true;
	}

	size_t GetSize() const
	{
		size_t size = 0;

		for (size_t i = 0; i < Types.size(); ++i)
		{
			size_t elementSize = 0;

			switch (Types[i])
			{
			case CBufferElementType::Bool:
				elementSize += sizeof(bool);
				break;

			case CBufferElementType::Int:
				elementSize += sizeof(int32_t);
				break;

			case CBufferElementType::Uint:
				elementSize += sizeof(uint32_t);
				break;

			case CBufferElementType::Float:
				elementSize += sizeof(float);
				break;
			}

			size += elementSize * Counts[i];
		}

		return size;
	}

	ID3D11Buffer* Buffer = nullptr;

private:
	std::vector<CBufferElementType> Types;
	std::vector<uint32_t> Counts;
};

extern ID3D11Device* gDevice;
extern ID3D11DeviceContext* gContext;
std::vector<CBuffer*> gCBuffers;
CBuffer* gCBufferCurrent = nullptr;

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

	size_t index = gCBuffers.size();
	gCBuffers.push_back(gCBufferCurrent);
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

GM_EXPORT double d3d11_cbuffer_update(double cbuffer, char* data)
{
	gContext->UpdateSubresource(
		gCBuffers[(size_t)cbuffer]->Buffer,
		0,
		nullptr,
		(void*)data,
		0,
		0);
	return 1.0;
}

GM_EXPORT double d3d11_shader_set_cbuffer_ps(double slot, double cbuffer)
{
	gContext->PSSetConstantBuffers((UINT)slot, 1, &gCBuffers[(size_t)cbuffer]->Buffer);
	return 1.0;
}

GM_EXPORT double d3d11_shader_set_cbuffer_vs(double slot, double cbuffer)
{
	gContext->VSSetConstantBuffers((UINT)slot, 1, &gCBuffers[(size_t)cbuffer]->Buffer);
	return 1.0;
}

GM_EXPORT double d3d11_cbuffer_destroy(double cbuffer)
{
	delete gCBuffers[(size_t)cbuffer];
	gCBuffers[(size_t)cbuffer] = nullptr;
	return 1.0;
}
