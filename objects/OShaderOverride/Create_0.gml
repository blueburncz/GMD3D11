vs = d3d11_shader_compile_vs(working_directory + "vs.hlsl", "main", "vs_4_0");

if (vs == -1)
{
	show_error(d3d11_get_error_string(), true);
}

ps = d3d11_shader_compile_ps(working_directory + "ps.hlsl", "main", "ps_4_0");

if (ps == -1)
{
	show_error(d3d11_get_error_string(), true);
}

d3d11_cbuffer_begin();
d3d11_cbuffer_add_float(4);
cbuffer = d3d11_cbuffer_end();

if (cbuffer == -1)
{
	show_error("Could not create cbuffer!", true);
}

var _buffer = buffer_create(buffer_sizeof(buffer_f32) * 4, buffer_fixed, 1);
buffer_write(_buffer, buffer_f32, 1.0);
buffer_write(_buffer, buffer_f32, 0.0);
buffer_write(_buffer, buffer_f32, 0.0);
buffer_write(_buffer, buffer_f32, 1.0);

d3d11_cbuffer_update(cbuffer, _buffer);

buffer_delete(_buffer);
