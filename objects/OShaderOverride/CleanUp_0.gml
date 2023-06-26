if (d3d11_shader_exists_ps(ps))
{
	d3d11_shader_destroy_ps(ps);
}

if (d3d11_shader_exists_vs(vs))
{
	d3d11_shader_destroy_vs(vs);
}

if (d3d11_cbuffer_exists(cbuffer))
{
	d3d11_cbuffer_destroy(cbuffer);
}
