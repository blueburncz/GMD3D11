if (d3d11_shader_exists(ps))
{
	d3d11_shader_destroy(ps);
}

if (d3d11_shader_exists(vs))
{
	d3d11_shader_destroy(vs);
}

if (d3d11_cbuffer_exists(instanceData))
{
	d3d11_cbuffer_destroy(instanceData);
}

camera_destroy(camera);
gpu_pop_state();
draw_set_lighting(false);
