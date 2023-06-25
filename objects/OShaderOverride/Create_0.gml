vs = d3d11_shader_compile_vs(working_directory + "vs.hlsl", "main", "vs_4_0");

if (vs == -1)
{
	show_error(d3d11_get_error(), true);
}

ps = d3d11_shader_compile_ps(working_directory + "ps.hlsl", "main", "ps_4_0");

if (ps == -1)
{
	show_error(d3d11_get_error(), true);
}
