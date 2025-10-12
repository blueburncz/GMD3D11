camera_apply(camera);
d3d11_shader_override_vs(vs);
d3d11_shader_override_ps(ps);
d3d11_shader_set_constant_buffer_vs(10, instanceData);
vertex_submit_instanced(model, pr_trianglelist, sprite_get_texture(SprRubberDuck, 0), instanceNumber);
d3d11_shader_override_vs(GMD3D11_ID_INVALID);
d3d11_shader_override_ps(GMD3D11_ID_INVALID);
