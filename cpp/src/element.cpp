#include <element.hpp>

#include <cstdint>

size_t GetElementSize(ElementType type)
{
	switch (type)
	{
	case ElementType::Bool:
		return sizeof(bool);

	case ElementType::Int:
		return sizeof(int32_t);

	case ElementType::Uint:
		return sizeof(uint32_t);

	case ElementType::Float:
		return sizeof(float);
	
	default:
		return 0;
	}
}
