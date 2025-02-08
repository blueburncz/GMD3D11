#pragma once

#include <common.hpp>

#include <Trackable.hpp>

#include <d3d11.h>
#include <vector>

class Shader : public Trackable<Shader>
{
public:
    Shader(ID3DBlob* blob);

    virtual ~Shader();

    ID3DBlob* GetBlob() const { return Blob; }

    bool SaveBlob(const char* filePath) const;

    static std::vector<char> LoadBlob(const char* filePath);

private:
    ID3DBlob* Blob = nullptr;
};

// Source: https://learn.microsoft.com/en-us/windows/win32/direct3d11/how-to--compile-a-shader
HRESULT CompileShader(_In_ LPCWSTR srcFile, _In_ LPCSTR entryPoint, _In_ LPCSTR profile, _Outptr_ ID3DBlob** blob);
