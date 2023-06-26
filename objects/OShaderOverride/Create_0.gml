vs = d3d11_shader_compile_vs(working_directory + "shaders/PassthroughVS.hlsl", "main", "vs_4_0");

if (!d3d11_shader_exists_vs(vs))
{
	show_error(d3d11_get_error_string(), true);
}

ps = d3d11_shader_compile_ps(working_directory + "shaders/CBufferTestPS.hlsl", "main", "ps_4_0");

if (!d3d11_shader_exists_ps(ps))
{
	show_error(d3d11_get_error_string(), true);
}

d3d11_cbuffer_begin();
d3d11_cbuffer_add_float(4);
cbuffer = d3d11_cbuffer_end();

if (!d3d11_cbuffer_exists(cbuffer))
{
	show_error("Could not create cbuffer!", true);
}

var _buffer = buffer_create(d3d11_cbuffer_get_size(cbuffer), buffer_fixed, 1);
buffer_write(_buffer, buffer_f32, 1.0);
buffer_write(_buffer, buffer_f32, 0.0);
buffer_write(_buffer, buffer_f32, 0.0);
buffer_write(_buffer, buffer_f32, 1.0);

d3d11_cbuffer_update(cbuffer, _buffer);

buffer_delete(_buffer);
