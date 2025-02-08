if (d3d11_shader_exists(vs))
{
	d3d11_shader_destroy(vs);
}

if (d3d11_shader_exists(gs))
{
	d3d11_shader_destroy(gs);
}

if (d3d11_shader_exists(ps))
{
	d3d11_shader_destroy(ps);
}

vertex_format_delete(vformat);
vertex_delete_buffer(vbuffer);
