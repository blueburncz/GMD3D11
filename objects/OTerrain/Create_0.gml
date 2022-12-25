show_debug_overlay(true);
application_surface_enable(true);
application_surface_draw_enable(false);

z = 256;
direction = -45;
directionUp = -45;
mouseLastX = 0;
mouseLastY = 0;

var _windowWidth = window_get_width();
var _windowHeight = window_get_height();

camera = camera_create();
fov = 60;
aspect = _windowWidth / _windowHeight;
clipNear = 1;
clipFar = 8192;
camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(
	-fov, -aspect, clipNear, clipFar));

depthSurface = noone;

vertex_format_begin();
vertex_format_add_position();
vertex_format_add_texcoord();
terrainVFormat = vertex_format_end();

terrainHeightmap = noone;
terrainWidth = sprite_get_width(SprTerrain);
terrainHeight = sprite_get_height(SprTerrain);

terrainVBuffer = vertex_create_buffer();

vertex_begin(terrainVBuffer, terrainVFormat);
for (var i = 0; i < terrainWidth; ++i)
{
	for (var j = 0; j < terrainHeight; ++j)
	{
		// a--b
		// |\ |
		// | \|
		// d--c
		var _a1 = i,     _a2 = j,     _au = _a1 / terrainWidth, _av = _a2 / terrainHeight;
		var _b1 = i + 1, _b2 = j,     _bu = _b1 / terrainWidth, _bv = _b2 / terrainHeight;
		var _c1 = i + 1, _c2 = j + 1, _cu = _c1 / terrainWidth, _cv = _c2 / terrainHeight;
		var _d1 = i,     _d2 = j + 1, _du = _d1 / terrainWidth, _dv = _d2 / terrainHeight;

		vertex_position(terrainVBuffer, _a1, _a2); vertex_texcoord(terrainVBuffer, _au, _av);
		vertex_position(terrainVBuffer, _c1, _c2); vertex_texcoord(terrainVBuffer, _cu, _cv);
		vertex_position(terrainVBuffer, _d1, _d2); vertex_texcoord(terrainVBuffer, _du, _dv);

		vertex_position(terrainVBuffer, _a1, _a2); vertex_texcoord(terrainVBuffer, _au, _av);
		vertex_position(terrainVBuffer, _b1, _b2); vertex_texcoord(terrainVBuffer, _bu, _bv);
		vertex_position(terrainVBuffer, _c1, _c2); vertex_texcoord(terrainVBuffer, _cu, _cv);
	}
}
vertex_end(terrainVBuffer);
vertex_freeze(terrainVBuffer);

brushSprite = SprBrush;
brushSize = 64;
brushStrength = 1;
brushSurface = noone;
