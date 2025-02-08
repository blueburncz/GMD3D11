d3d11_shader_override_vs(vs);
d3d11_shader_set_gs(gs);
d3d11_shader_override_ps(ps);
vertex_submit(vbuffer, pr_trianglelist, -1);
d3d11_shader_override_vs(-1);
d3d11_shader_set_gs(-1);
d3d11_shader_override_ps(-1);
