varying vec3 v_vNormal;
varying vec2 v_vTexCoord;

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

	gl_FragColor.rgb = GammaToLinear(baseColor.rgb) * mix(GammaToLinear(vec3(0.2)), vec3(1.0), NdotL);
	gl_FragColor.a = baseColor.a;

	gl_FragColor.rgb = N * 0.5 + 0.5; //LinearToGamma(gl_FragColor.rgb);
}
