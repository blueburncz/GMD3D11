varying vec2 v_vTexCoord;

uniform sampler2D u_texHeightmap;
uniform vec2 u_vOffset;
uniform vec2 u_vScale;
uniform float u_fStrength;

// Source: https://aras-p.info/blog/2009/07/30/encoding-floats-to-rgba-the-final/
vec3 EncodeFloatVec3(float v)
{
	vec3 enc = vec3(1.0, 255.0, 65025.0) * v;
	enc = fract(enc);
	enc -= enc.yzz * vec3(1.0 / 255.0, 1.0 / 255.0, 0.0);
	return enc;
}

// Source: https://aras-p.info/blog/2009/07/30/encoding-floats-to-rgba-the-final/
float DecodeFloatVec3(vec3 v)
{
	return dot(v, vec3(1.0, 1.0 / 255.0, 1.0 / 65025.0));
}

void main()
{
	float height = DecodeFloatVec3(texture2D(u_texHeightmap, u_vOffset + v_vTexCoord * u_vScale).rgb);
	float brush = texture2D(gm_BaseTexture, v_vTexCoord).r * u_fStrength;
	height += brush;
	height = clamp(height, 0.0, 0.9999999);
	gl_FragColor.rgb = EncodeFloatVec3(height);
	gl_FragColor.a = 1.0;
}
