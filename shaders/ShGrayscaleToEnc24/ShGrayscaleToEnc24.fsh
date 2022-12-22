varying vec2 v_vTexCoord;

// Source: https://aras-p.info/blog/2009/07/30/encoding-floats-to-rgba-the-final/
vec3 EncodeFloatVec3(float v)
{
	vec3 enc = vec3(1.0, 255.0, 65025.0) * v;
	enc = fract(enc);
	enc -= enc.yzz * vec3(1.0 / 255.0, 1.0 / 255.0, 0.0);
	return enc;
}

void main()
{
	gl_FragColor.rgb = EncodeFloatVec3(texture2D(gm_BaseTexture, v_vTexCoord).r);
	gl_FragColor.a = 1.0;
}
