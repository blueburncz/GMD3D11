#include <utils.hpp>

#include <Windows.h>

// Source: https://stackoverflow.com/a/19717944
wchar_t* ConvertCharArrayToLPCWSTR(const char* charArray)
{
    wchar_t* wString = new wchar_t[4096];
    MultiByteToWideChar(CP_ACP, 0, charArray, -1, wString, 4096);
    return wString;
}
