attribute vec2 in_Position;
attribute vec2 in_TextureCoord;

varying vec3 v_vNormal;
varying vec2 v_vTexCoord;

uniform sampler2D u_texHeightmap;
uniform vec2 u_vHeightmapTexel;

#define HEIGHT_SCALE 100.0

float GetHeight(sampler2D heightmap, vec2 uv)
{
	return texture2DLod(heightmap, uv, 0.0).r * HEIGHT_SCALE;
}

// Source: https://stackoverflow.com/a/13983431
vec3 GetNormal(sampler2D heightmap, vec2 uv, vec2 texel)
{
	vec3 off = vec3(texel.xy, 0.0);
	float hL = GetHeight(heightmap, uv - off.xz);
	float hR = GetHeight(heightmap, uv + off.xz);
	float hD = GetHeight(heightmap, uv - off.zy);
	float hU = GetHeight(heightmap, uv + off.zy);
	return normalize(vec3(hL - hR, hD - hU, off.x * 2.0 * HEIGHT_SCALE));
}

vec3 GetSmoothNormal(sampler2D heightmap, vec2 uv, vec2 texel)
{
	return (
		  GetNormal(heightmap, uv + vec2(-1.0, -1.0) * texel, texel)
		+ GetNormal(heightmap, uv + vec2( 0.0, -1.0) * texel, texel)
		+ GetNormal(heightmap, uv + vec2( 1.0, -1.0) * texel, texel)
		+ GetNormal(heightmap, uv + vec2(-1.0,  0.0) * texel, texel)
		+ GetNormal(heightmap, uv + vec2( 0.0,  0.0) * texel, texel)
		+ GetNormal(heightmap, uv + vec2( 1.0,  0.0) * texel, texel)
		+ GetNormal(heightmap, uv + vec2(-1.0,  1.0) * texel, texel)
		+ GetNormal(heightmap, uv + vec2( 0.0,  1.0) * texel, texel)
		+ GetNormal(heightmap, uv + vec2( 1.0,  1.0) * texel, texel)
	) / 9.0;
}

void main()
{
	float height = GetHeight(u_texHeightmap, in_TextureCoord);
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position.xy, height, 1.0);
	vec3 normal = GetSmoothNormal(u_texHeightmap, in_TextureCoord, u_vHeightmapTexel);
	v_vNormal = normalize((gm_Matrices[MATRIX_WORLD] * vec4(normal.xyz, 0.0)).xyz);
	v_vTexCoord = in_TextureCoord;
}
