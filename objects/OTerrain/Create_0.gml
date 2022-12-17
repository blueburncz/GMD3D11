z = 256;
direction = -45;
directionUp = -45;
mouseLastX = 0;
mouseLastY = 0;

camera = camera_create();
camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(
	-60, -window_get_width() / window_get_height(), 1, 8192));

vertex_format_begin();
vertex_format_add_position();
vertex_format_add_texcoord();
terrainVFormat = vertex_format_end();

#macro TERRAIN_SIZE 256

terrainHeight = noone;

terrainVBuffer = vertex_create_buffer();

vertex_begin(terrainVBuffer, terrainVFormat);
for (var i = 0; i < TERRAIN_SIZE; ++i)
{
	for (var j = 0; j < TERRAIN_SIZE; ++j)
	{
		// a--b
		// |\ |
		// | \|
		// d--c
		var _a1 = i,     _a2 = j,     _au = _a1 / TERRAIN_SIZE, _av = _a2 / TERRAIN_SIZE;
		var _b1 = i + 1, _b2 = j,     _bu = _b1 / TERRAIN_SIZE, _bv = _b2 / TERRAIN_SIZE;
		var _c1 = i + 1, _c2 = j + 1, _cu = _c1 / TERRAIN_SIZE, _cv = _c2 / TERRAIN_SIZE;
		var _d1 = i,     _d2 = j + 1, _du = _d1 / TERRAIN_SIZE, _dv = _d2 / TERRAIN_SIZE;

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
