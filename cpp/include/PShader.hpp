#pragma once

#include <Shader.hpp>

class PShader : public Shader
{
public:
	PShader(ID3DBlob* blob, ID3D11PixelShader* shader)
		: Raw(shader)
		, Shader(blob)
	{
	}

	~PShader()
	{
		if (Raw)
		{
			Raw->Release();
		}
	}

	ID3D11PixelShader* GetShader() const
	{
		return Raw;
	}

private:
	ID3D11PixelShader* Raw = nullptr;
};
