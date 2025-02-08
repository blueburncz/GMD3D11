#include <CBuffer.hpp>

#include <cstdint>

extern ID3D11Device* g_Device;
extern ID3D11DeviceContext* g_Context;

static CBuffer* g_CBufferCurrent = nullptr;

CBuffer::~CBuffer()
{
    if (Buffer)
    {
        Buffer->Release();
    }
}

bool CBuffer::AddElement(CBuffer::Element type, uint32_t count)
{
    if (count < 1)
    {
        return false;
    }

    size_t elementSize = 0;

    switch (type)
    {
    case Element::Bool:
        elementSize = sizeof(bool);
        break;

    case Element::Int:
        elementSize = sizeof(int32_t);
        break;

    case Element::Uint:
        elementSize = sizeof(uint32_t);
        break;

    case Element::Float:
        elementSize = sizeof(float);
        break;

    default:
        break;
    }

    Size += elementSize * count;

    return true;
}

GM_EXPORT double d3d11_cbuffer_begin()
{
    if (g_CBufferCurrent)
    {
        return GM_FALSE;
    }
    g_CBufferCurrent = new CBuffer();
    return GM_TRUE;
}

GM_EXPORT double d3d11_cbuffer_end()
{
    if (!g_CBufferCurrent)
    {
        return -1.0;
    }

    CD3D11_BUFFER_DESC cbDesc(g_CBufferCurrent->GetSize(), D3D11_BIND_CONSTANT_BUFFER);
    HRESULT hr = g_Device->CreateBuffer(&cbDesc, NULL, &g_CBufferCurrent->Buffer);

    if (FAILED(hr))
    {
        delete g_CBufferCurrent;
        g_CBufferCurrent = nullptr;
        return -1.0;
    }

    size_t id = g_CBufferCurrent->GetID();
    g_CBufferCurrent = nullptr;
    return static_cast<double>(id);
}

GM_EXPORT double d3d11_cbuffer_add_bool(double count)
{
    return g_CBufferCurrent->AddElement(CBuffer::Element::Bool, static_cast<uint32_t>(count)) ? GM_TRUE : GM_FALSE;
}

GM_EXPORT double d3d11_cbuffer_add_int(double count)
{
    return g_CBufferCurrent->AddElement(CBuffer::Element::Int, static_cast<uint32_t>(count)) ? GM_TRUE : GM_FALSE;
}

GM_EXPORT double d3d11_cbuffer_add_uint(double count)
{
    return g_CBufferCurrent->AddElement(CBuffer::Element::Uint, static_cast<uint32_t>(count)) ? GM_TRUE : GM_FALSE;
}

GM_EXPORT double d3d11_cbuffer_add_float(double count)
{
    return g_CBufferCurrent->AddElement(CBuffer::Element::Float, static_cast<uint32_t>(count)) ? GM_TRUE : GM_FALSE;
}

GM_EXPORT double d3d11_cbuffer_get_size(double cbuffer)
{
    return CBuffer::Get(static_cast<size_t>(cbuffer))->GetSize();
}

GM_EXPORT double d3d11_cbuffer_update(double cbuffer, char* data)
{
    g_Context->UpdateSubresource(
        CBuffer::Get(static_cast<size_t>(cbuffer))->Buffer,
        0,
        nullptr,
        (void*)data,
        0,
        0);
    return GM_TRUE;
}

GM_EXPORT double d3d11_shader_set_cbuffer_vs(double slot, double cbuffer)
{
    if (cbuffer >= 0.0)
    {
        g_Context->VSSetConstantBuffers(static_cast<UINT>(slot), 1, &CBuffer::Get(static_cast<size_t>(cbuffer))->Buffer);
    }
    else
    {
        g_Context->VSSetConstantBuffers(static_cast<UINT>(slot), 0, nullptr);
    }
    return GM_TRUE;
}

GM_EXPORT double d3d11_shader_set_cbuffer_gs(double slot, double cbuffer)
{
    if (cbuffer >= 0.0)
    {
        g_Context->GSSetConstantBuffers(static_cast<UINT>(slot), 1, &CBuffer::Get(static_cast<size_t>(cbuffer))->Buffer);
    }
    else
    {
        g_Context->GSSetConstantBuffers(static_cast<UINT>(slot), 0, nullptr);
    }
    return GM_TRUE;
}

GM_EXPORT double d3d11_shader_set_cbuffer_ps(double slot, double cbuffer)
{
    if (cbuffer >= 0.0)
    {
        g_Context->PSSetConstantBuffers(static_cast<UINT>(slot), 1, &CBuffer::Get(static_cast<size_t>(cbuffer))->Buffer);
    }
    else
    {
        g_Context->PSSetConstantBuffers(static_cast<UINT>(slot), 0, nullptr);
    }
    return GM_TRUE;
}

GM_EXPORT double d3d11_cbuffer_exists(double cbuffer)
{
    return (cbuffer >= 0.0 && CBuffer::Exists(static_cast<size_t>(cbuffer))) ? GM_TRUE : GM_FALSE;
}

GM_EXPORT double d3d11_cbuffer_destroy(double cbuffer)
{
    delete CBuffer::Get(static_cast<size_t>(cbuffer));
    return GM_TRUE;
}
