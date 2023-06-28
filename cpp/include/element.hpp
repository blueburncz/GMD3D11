#pragma once

enum class ElementType
{
	Bool,
	Int,
	Uint,
	Float
};

size_t GetElementSize(ElementType type);
