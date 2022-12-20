varying vec3 v_vNormal;
varying vec2 v_vTexCoord;
varying float v_fDepth;

uniform float u_fClipFar;

// Source: https://aras-p.info/blog/2009/07/30/encoding-floats-to-rgba-the-final/
vec3 EncodeFloatVec3(float v)
{
	vec3 enc = vec3(1.0, 255.0, 65025.0) * v;
	enc = fract(enc);
	enc -= enc.yzz * vec3(1.0 / 255.0, 1.0 / 255.0, 0.0);
	return enc;
}

vec3 GammaToLinear(vec3 color)
{
	return pow(color, vec3(2.2));
}

vec3 LinearToGamma(vec3 color)
{
	return pow(color, vec3(1.0 / 2.2));
}

void main()
{
	vec4 baseColor = texture2D(gm_BaseTexture, v_vTexCoord);

	vec3 sunDirection = vec3(-1.0, -1.0, -1.0);
	vec3 L = normalize(-sunDirection);
	vec3 N = normalize(v_vNormal);
	float NdotL = max(dot(N, L), 0.0);

	gl_FragData[0].rgb = LinearToGamma(
		GammaToLinear(baseColor.rgb) * mix(GammaToLinear(vec3(0.2)), vec3(1.0), NdotL));
	gl_FragData[0].a = baseColor.a;

	gl_FragData[1].rgb = EncodeFloatVec3(v_fDepth / u_fClipFar);
	gl_FragData[1].a = 1.0;
}
