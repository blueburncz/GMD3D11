if (!surface_exists(terrainHeight))
{
	terrainHeight = surface_create(TERRAIN_SIZE, TERRAIN_SIZE);
	surface_set_target(terrainHeight);
	draw_sprite(SprTerrain, 0, 0, 0);
	surface_reset_target();
}

camera_apply(camera);

var _shader = ShTerrain;

gpu_push_state();
gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_cullmode(cull_counterclockwise);

shader_set(_shader);
texture_set_stage(shader_get_sampler_index(_shader, "u_texHeightmap"), surface_get_texture(terrainHeight));
shader_set_uniform_f(shader_get_uniform(_shader, "u_vHeightmapTexel"), 1 / TERRAIN_SIZE, 1 / TERRAIN_SIZE);
vertex_submit(terrainVBuffer, pr_trianglelist, -1);
shader_reset();

gpu_pop_state();
