var _shader = ShVTF;
shader_set(_shader);
texture_set_stage_vs(
	shader_get_sampler_index(_shader, "u_texA"),
	sprite_get_texture(SprVTF, 0));
vertex_submit(VBuffer, pr_trianglelist, -1);
shader_reset();
