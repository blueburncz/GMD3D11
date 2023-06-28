#pragma once 

#include <element.hpp>

#include <cstdint>
#include <d3d11.h>
#include <unordered_map>

extern std::unordered_map<size_t, class CBuffer*> gCBuffers;

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

	bool AddElement(ElementType type, uint32_t count)
	{
		if (count < 1)
		{
			return false;
		}
		Size += GetElementSize(type) * count;
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
