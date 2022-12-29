attribute vec2 in_Position;
attribute float in_Index;
attribute vec2 in_TextureCoord;

varying vec3 v_vNormal;
varying vec2 v_vTexCoord;
varying float v_fDepth;

uniform sampler2D u_texHeightmap;
uniform vec2 u_vHeightmapTexel;

#define HEIGHT_SCALE 100.0

// Source: https://aras-p.info/blog/2009/07/30/encoding-floats-to-rgba-the-final/
float DecodeFloatVec3(vec3 v)
{
	return dot(v, vec3(1.0, 1.0 / 255.0, 1.0 / 65025.0));
}

float GetHeight(sampler2D heightmap, vec2 uv)
{
	return DecodeFloatVec3(texture2DLod(heightmap, uv, 0.0).rgb) * HEIGHT_SCALE;
}

vec3 GetNormal(int index, sampler2D heightmap, vec2 uv, vec2 texel)
{
	vec2 uv0, uv1, uv2;

	// 0        p1
	// |\       | \
	// | \      |  \
	// 2--1     p0--p2
	if (index == 0)
	{
		uv1 = uv + vec2(0.0, 0.0) * texel;
		uv0 = uv + vec2(0.0, 1.0) * texel;
		uv2 = uv + vec2(1.0, 1.0) * texel;
	}
	else if (index == 1)
	{
		uv2 = uv + vec2(0.0, 0.0) * texel;
		uv0 = uv + vec2(-1.0, 0.0) * texel;
		uv1 = uv + vec2(-1.0, -1.0) * texel;
	}
	else if (index == 2)
	{
		uv0 = uv + vec2(0.0, 0.0) * texel;
		uv1 = uv + vec2(0.0, -1.0) * texel;
		uv2 = uv + vec2(1.0, 0.0) * texel;
	}
	// 3--4     p2--p0
	//  \ |      \  |
	//   \|       \ |
	//    5        p1
	else if (index == 3)
	{
		uv2 = uv + vec2(0.0, 0.0) * texel;
		uv0 = uv + vec2(1.0, 0.0) * texel;
		uv1 = uv + vec2(1.0, 1.0) * texel;
	}
	else if (index == 4)
	{
		uv0 = uv + vec2(0.0, 0.0) * texel;
		uv1 = uv + vec2(0.0, 1.0) * texel;
		uv2 = uv + vec2(-1.0, 0.0) * texel;
	}
	else if (index == 5)
	{
		uv1 = uv + vec2(0.0, 0.0) * texel;
		uv0 = uv + vec2(0.0, -1.0) * texel;
		uv2 = uv + vec2(-1.0, -1.0) * texel;
	}

	vec3 p0 = vec3(uv0.xy / texel, GetHeight(heightmap, uv0));
	vec3 p1 = vec3(uv1.xy / texel, GetHeight(heightmap, uv1));
	vec3 p2 = vec3(uv2.xy / texel, GetHeight(heightmap, uv2));

	vec3 a = p1 - p0;
	vec3 b = p2 - p0;

	return normalize(cross(a, b));
}

vec3 GetSmoothNormal(int index, sampler2D heightmap, vec2 uv, vec2 texel)
{
	return normalize((
		  GetNormal(0, heightmap, uv, texel)
		+ GetNormal(1, heightmap, uv, texel)
		+ GetNormal(2, heightmap, uv, texel)
		+ GetNormal(3, heightmap, uv, texel)
		+ GetNormal(4, heightmap, uv, texel)
		+ GetNormal(5, heightmap, uv, texel)
	) / 6.0);
}

vec3 GetBlurredNormal(int index, sampler2D heightmap, vec2 uv, vec2 texel)
{
	vec3 normal = vec3(0.0);
	float samples = 0.0;
	for (float i = -1.0; i <= 1.0; ++i)
	{
		for (float j = -1.0; j <= 1.0; ++j)
		{
			normal += GetSmoothNormal(0, heightmap, uv + vec2(i, j) * texel, texel);
			++samples;
		}
	}
	return normalize(normal / samples);
}

void main()
{
	float height = GetHeight(u_texHeightmap, in_TextureCoord);
	vec4 position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position.xy, height, 1.0);
	gl_Position = position;
	vec3 normal = GetBlurredNormal(int(in_Index), u_texHeightmap, in_TextureCoord, u_vHeightmapTexel);
	v_vNormal = normalize((gm_Matrices[MATRIX_WORLD] * vec4(normal.xyz, 0.0)).xyz);
	v_vTexCoord = in_TextureCoord;
	v_fDepth = position.z;
}
