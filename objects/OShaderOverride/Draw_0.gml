d3d11_shader_override_vs(vs);
d3d11_shader_override_ps(ps);

draw_sprite(SprVTF, 0, 0, 0);
draw_flush();

d3d11_shader_override_vs(-1);
d3d11_shader_override_ps(-1);
