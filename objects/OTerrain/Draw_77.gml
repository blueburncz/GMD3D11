var _windowWidth = window_get_width();
var _windowHeight = window_get_height();

if (!surface_exists(depthSurface))
{
	depthSurface = surface_create(_windowWidth, _windowHeight);
}

if (!surface_exists(terrainHeight))
{
	terrainHeight = surface_create(TERRAIN_SIZE, TERRAIN_SIZE);
	surface_set_target(terrainHeight);
	draw_sprite(SprTerrain, 0, 0, 0);
	surface_reset_target();
}

gpu_push_state();
gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_cullmode(cull_counterclockwise);

surface_set_target_ext(0, application_surface);
surface_set_target_ext(1, depthSurface);
draw_clear(c_black);

camera_apply(camera);

var _shader = ShTerrain;
shader_set(_shader);
var _uTexHeightmap = shader_get_sampler_index(_shader, "u_texHeightmap");
texture_set_stage(_uTexHeightmap, surface_get_texture(terrainHeight));
gpu_set_tex_repeat_ext(_uTexHeightmap, false);
shader_set_uniform_f(shader_get_uniform(_shader, "u_vHeightmapTexel"), 1 / TERRAIN_SIZE, 1 / TERRAIN_SIZE);
shader_set_uniform_f(shader_get_uniform(_shader, "u_fClipFar"), clipFar);
vertex_submit(terrainVBuffer, pr_trianglelist, -1);
shader_reset();

surface_reset_target();

gpu_pop_state();

if (keyboard_check(vk_space))
{
	// Get 3D mouse position
	var _mouseX = window_mouse_get_x();
	var _mouseY = window_mouse_get_y();
	var _depthPixel = surface_getpixel(depthSurface, _mouseX,  _mouseY);
	var _depthLinear = decode_float_vec3(
		color_get_red(_depthPixel) / 255, color_get_green(_depthPixel) / 255, color_get_blue(_depthPixel) / 255);
	var _depth = _depthLinear * clipFar;
	var _mouseDirection = screen_point_to_vec3(camera_get_view_mat(camera), fov, aspect, _mouseX, _mouseY);
	var _mousePosition = [
		x + _mouseDirection[0] * _depth,
		y + _mouseDirection[1] * _depth,
		z + _mouseDirection[2] * _depth,
	];

	// Draw 3D circle
	surface_set_target(application_surface);
	camera_apply(camera);
	var _shader = ShCursor;
	shader_set(_shader);
	var _uTexHeightmap = shader_get_sampler_index(_shader, "u_texHeightmap");
	texture_set_stage(_uTexHeightmap, surface_get_texture(terrainHeight));
	gpu_set_tex_repeat_ext(_uTexHeightmap, false);
	draw_circle_color(_mousePosition[0], _mousePosition[1], 32, c_yellow, c_yellow, true);
	shader_reset();
	surface_reset_target();

	// Edit terrain heightmap
	if (mouse_check_button(mb_left))
	{
		surface_set_target(terrainHeight);
		//gpu_push_state();
		//gpu_set_blendmode(keyboard_check(vk_shift) ? bm_subtract : bm_add);
		var _alpha = draw_get_alpha();
		draw_set_alpha(delta_time / 1000000);
		var _color = c_white;
		if (keyboard_check(vk_shift))
		{
			_color = make_color_rgb(
				255 - color_get_red(_color),
				255 - color_get_green(_color),
				255 - color_get_blue(_color));
		}
		draw_circle_color(_mousePosition[0], _mousePosition[1], 32, _color, _color, false);
		draw_set_alpha(_alpha);
		//gpu_pop_state();
		surface_reset_target();
	}
}

// Draw the app surface
draw_surface(application_surface, 0, 0);
