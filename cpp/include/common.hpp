#pragma once

#include <cstdint>

#define GM_EXPORT extern "C" __declspec(dllexport)
#define GM_TRUE 1.0
#define GM_FALSE 0.0

typedef char* ty_string;
typedef double ty_real;

static inline size_t RoundUp16(size_t value)
{
    return ((value + 15) & ~static_cast<size_t>(15));
}
