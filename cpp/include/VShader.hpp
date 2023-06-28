#pragma once

#include <Shader.hpp>

class VShader : public Shader
{
public:
	VShader(ID3DBlob* blob, ID3D11VertexShader* shader)
		: Raw(shader)
		, Shader(blob)
	{
	}

	~VShader()
	{
		if (Raw)
		{
			Raw->Release();
		}
	}

	ID3D11VertexShader* GetShader() const
	{
		return Raw;
	}

private:
	ID3D11VertexShader* Raw = nullptr;
};
