#pragma once

#include <cstdint>
#include <string>

#define GM_EXPORT extern "C" __declspec(dllexport)
#define GM_TRUE 1.0
#define GM_FALSE 0.0

#define GMD3D11_ID_INVALID -1.0

typedef char* ty_string;
typedef double ty_real;

static inline size_t RoundUp(size_t value, size_t alignment)
{
    return ((value + (alignment - 1)) & ~(alignment - 1));
}

template<typename T>
T ReadBuffer(char*& buffer)
{
    if constexpr (std::is_same_v<T, std::string>)
    {
        std::string str(buffer);
        buffer += str.size() + 1;
        return str;
    }
    else
    {
        T value;
        memcpy(&value, buffer, sizeof(T));
        buffer += sizeof(T);
        return value;
    }
}
