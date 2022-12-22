attribute vec3 in_Position;
attribute vec4 in_Colour;

varying vec4 v_vColor;

uniform sampler2D u_texHeightmap;

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

void main()
{
	float height = GetHeight(u_texHeightmap, in_Position.xy / 256.0);
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position.xy, height, 1.0);
	v_vColor = in_Colour;
}
