d3d11_shader_override_vs(vs);
d3d11_shader_set_gs(gs);
d3d11_shader_override_ps(ps);
vertex_submit(vbuffer, pr_trianglelist, -1);
d3d11_shader_override_vs(GMD3D11_ID_INVALID);
d3d11_shader_set_gs(GMD3D11_ID_INVALID);
d3d11_shader_override_ps(GMD3D11_ID_INVALID);
