attribute vec2 in_Position;
attribute vec2 in_TextureCoord;

varying vec3 v_vNormal;
varying vec2 v_vTexCoord;

uniform sampler2D u_texHeightmap;
uniform float u_fHeightmapTexel;

#define HEIGHT_SCALE 100.0

float GetHeight(vec2 uv)
{
	return texture2DLod(u_texHeightmap, uv, 0.0).r * HEIGHT_SCALE;
}

// Source: https://stackoverflow.com/a/13983431
vec3 GetNormal(vec2 uv)
{
	vec3 off = vec3(u_fHeightmapTexel, u_fHeightmapTexel, 0.0);
	float hL = GetHeight(uv - off.xz);
	float hR = GetHeight(uv + off.xz);
	float hD = GetHeight(uv - off.zy);
	float hU = GetHeight(uv + off.zy);
	return normalize(vec3(hL - hR, hD - hU, off.x * 2.0 * HEIGHT_SCALE));
}

void main()
{
	float height = GetHeight(in_TextureCoord);

	vec3 off = vec3(u_fHeightmapTexel, u_fHeightmapTexel, 0.0);
	vec3 normal = (
		  GetNormal(in_TextureCoord + vec2(-1.0, -1.0) * u_fHeightmapTexel)
		+ GetNormal(in_TextureCoord + vec2( 0.0, -1.0) * u_fHeightmapTexel)
		+ GetNormal(in_TextureCoord + vec2( 1.0, -1.0) * u_fHeightmapTexel)
		+ GetNormal(in_TextureCoord + vec2(-1.0,  0.0) * u_fHeightmapTexel)
		+ GetNormal(in_TextureCoord + vec2( 0.0,  0.0) * u_fHeightmapTexel)
		+ GetNormal(in_TextureCoord + vec2( 1.0,  0.0) * u_fHeightmapTexel)
		+ GetNormal(in_TextureCoord + vec2(-1.0,  1.0) * u_fHeightmapTexel)
		+ GetNormal(in_TextureCoord + vec2( 0.0,  1.0) * u_fHeightmapTexel)
		+ GetNormal(in_TextureCoord + vec2( 1.0,  1.0) * u_fHeightmapTexel)
	)
	/ 9.0
	;

	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position.xy, height, 1.0);
	v_vNormal = (gm_Matrices[MATRIX_WORLD] * vec4(normal.xyz, 0.0)).xyz;
	v_vTexCoord = in_TextureCoord;
}
