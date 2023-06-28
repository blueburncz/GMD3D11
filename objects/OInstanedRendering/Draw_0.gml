camera_apply(camera);
d3d11_shader_override_vs(vs);
d3d11_shader_override_ps(ps);
d3d11_shader_set_cbuffer_vs(10, instanceData);
vertex_submit_instanced(model, pr_trianglelist, sprite_get_texture(SprRubberDuck, 0), instanceNumber);
d3d11_shader_override_vs(-1);
d3d11_shader_override_ps(-1);
