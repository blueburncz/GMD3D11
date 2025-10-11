vs = d3d11_shader_compile_vs("shaders/PassthroughVS.hlsl", "main", "vs_4_0");
assert(d3d11_shader_exists(vs), $"Vertex shader compilation failed! {d3d11_get_error_string()}");

gs = d3d11_shader_compile_gs("shaders/PassthroughGS.hlsl", "main", "gs_4_0");
assert(d3d11_shader_exists(gs), $"Geometry shader compilation failed!  {d3d11_get_error_string()}");

ps = d3d11_shader_compile_ps("shaders/PassthroughPS.hlsl", "main", "ps_4_0");
assert(d3d11_shader_exists(ps), $"Pixel shader compilation failed! {d3d11_get_error_string()}");

vertex_format_begin();
vertex_format_add_position_3d();
//vertex_format_add_normal();
vertex_format_add_color();
vertex_format_add_texcoord();
vformat = vertex_format_end();

vbuffer = vertex_create_buffer();
vertex_begin(vbuffer, vformat);

vertex_position_3d(vbuffer, 0, 0, 0);
//vertex_format_add_normal(vbuffer, 0, 0, 1);
vertex_color(vbuffer, c_red, 1);
vertex_texcoord(vbuffer, 0, 0);

vertex_position_3d(vbuffer, room_width, 0, 0);
//vertex_format_add_normal(vbuffer, 0, 0, 1);
vertex_color(vbuffer, c_lime, 1);
vertex_texcoord(vbuffer, 0, 0);

vertex_position_3d(vbuffer, room_width / 2, room_height, 0);
//vertex_format_add_normal(vbuffer, 0, 0, 1);
vertex_color(vbuffer, c_blue, 1);
vertex_texcoord(vbuffer, 0, 0);

vertex_end(vbuffer);
vertex_freeze(vbuffer);
