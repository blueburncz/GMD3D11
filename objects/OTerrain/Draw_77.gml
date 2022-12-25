var _windowWidth = window_get_width();
var _windowHeight = window_get_height();

if (!surface_exists(depthSurface))
{
	depthSurface = surface_create(_windowWidth, _windowHeight);
}

if (!surface_exists(terrainHeightmap))
{
	terrainHeightmap = surface_create(terrainWidth, terrainHeight);
	surface_set_target(terrainHeightmap);
	draw_clear(c_black);
	shader_set(ShGrayscaleToEnc24);
	draw_sprite(SprTerrain, 0, 0, 0);
	shader_reset();
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
texture_set_stage_vs(_uTexHeightmap, surface_get_texture(terrainHeightmap));
gpu_set_tex_repeat_ext(_uTexHeightmap, false);
shader_set_uniform_f(shader_get_uniform(_shader, "u_vHeightmapTexel"), 1 / terrainWidth, 1 / terrainHeight);
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
	texture_set_stage_vs(_uTexHeightmap, surface_get_texture(terrainHeightmap));
	gpu_set_tex_repeat_ext(_uTexHeightmap, false);
	shader_set_uniform_f(shader_get_uniform(_shader, "u_vHeightmapTexel"), 1 / terrainWidth, 1 / terrainHeight);
	draw_circle_color(_mousePosition[0], _mousePosition[1], brushSize / 2, c_yellow, c_yellow, true);
	shader_reset();
	surface_reset_target();

	// Edit terrain heightmap
	if (mouse_check_button(mb_left))
	{
		if (!surface_exists(brushSurface))
		{
			brushSurface = surface_create(brushSize, brushSize);
		}
		else if (surface_get_width(brushSurface) != brushSize
			|| surface_get_height(brushSurface) != brushSize)
		{
			surface_resize(brushSurface, brushSize, brushSize);
		}

		var _brushX = round(_mousePosition[0] - (brushSize / 2));
		var _brushY = round(_mousePosition[1] - (brushSize / 2));

		surface_set_target(brushSurface);
		var _shader = ShBrushAddEnc24;
		shader_set(_shader);
		var _uTexHeightmap = shader_get_sampler_index(_shader, "u_texHeightmap");
		texture_set_stage(_uTexHeightmap, surface_get_texture(terrainHeightmap));
		gpu_set_tex_repeat_ext(_uTexHeightmap, false);
		gpu_set_tex_filter_ext(_uTexHeightmap, false);
		shader_set_uniform_f(
			shader_get_uniform(_shader, "u_vOffset"),
			_brushX / terrainWidth,
			_brushY / terrainHeight);
		shader_set_uniform_f(
			shader_get_uniform(_shader, "u_vScale"),
			brushSize / terrainWidth,
			brushSize / terrainHeight);
		shader_set_uniform_f(
			shader_get_uniform(_shader, "u_fStrength"),
			brushStrength * (delta_time / 1000000) * (keyboard_check(vk_shift) ? -1 : 1));
		draw_sprite_stretched(brushSprite, 0, 0, 0, brushSize, brushSize);
		shader_reset();
		surface_reset_target();

		surface_set_target(terrainHeightmap);
		draw_surface(brushSurface, _brushX, _brushY);
		surface_reset_target();
	}
}

// Draw the app surface
draw_surface(application_surface, 0, 0);
