gpu_push_state();
gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
draw_set_lighting(true);

model = vertex_buffer_load("rubber_duck_toy_1k.bin", vertex_format_pnuc);
vertex_freeze(model);

vs = d3d11_shader_compile_vs(working_directory + "shaders/TestVS.hlsl", "main", "vs_4_0");
assert(d3d11_shader_exists(vs), $"Vertex shader compilation failed! {d3d11_get_error_string()}");

ps = d3d11_shader_compile_ps(working_directory + "shaders/TestPS.hlsl", "main", "ps_4_0");
assert(d3d11_shader_exists(ps), $"Pixel shader compilation failed! {d3d11_get_error_string()}");

instanceNumber = 2000;

// Instance position could be just float3, but cbuffer size must be divisible by 16!
instanceData = d3d11_cbuffer_create(d3d11_sizeof16(D3D11_FLOAT4) * instanceNumber);
assert(d3d11_cbuffer_exists(instanceData), $"Could not create instanceData! {d3d11_get_error_string()}");

var _buffer = buffer_create(d3d11_cbuffer_get_size(instanceData), buffer_fixed, 1);
repeat (instanceNumber)
{
	buffer_write(_buffer, buffer_f32, random(128));
	buffer_write(_buffer, buffer_f32, random(128));
	buffer_write(_buffer, buffer_f32, random(128));
	buffer_write(_buffer, buffer_f32, 0.0);
}
d3d11_cbuffer_write_data(instanceData, buffer_get_address(_buffer));
buffer_delete(_buffer);

camera = camera_create();
camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(
	-70, -window_get_width() / window_get_height(), 0.1, 10000));
z = 0;
directionUp = 0;
mouseLastX = 0;
mouseLastY = 0;

show_debug_message($"Instance count:            {instanceNumber}");
show_debug_message($"Vertex count per instance: {vertex_get_number(model)}");
show_debug_message($"Vertex count total:        {vertex_get_number(model) * instanceNumber}");
