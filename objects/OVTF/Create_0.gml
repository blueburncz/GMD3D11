vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_texcoord();
VFormat = vertex_format_end();

var _width = sprite_get_width(SprVTF);
var _height = sprite_get_height(SprVTF);

VBuffer = vertex_create_buffer();
vertex_begin(VBuffer, VFormat);
for (var i = _width - 1; i >= 0; --i)
{
	for (var j = _height - 1; j >= 0; --j)
	{
		vertex_position_3d(VBuffer, i, j, 0);         vertex_texcoord(VBuffer, i / _width, j / _height);
		vertex_position_3d(VBuffer, i + 1, j, 0);     vertex_texcoord(VBuffer, (i + 1) / _width, j / _height);
		vertex_position_3d(VBuffer, i + 1, j + 1, 0); vertex_texcoord(VBuffer, (i + 1) / _width, (j + 1) / _height);

		vertex_position_3d(VBuffer, i, j, 0);         vertex_texcoord(VBuffer, i / _width, j / _height);
		vertex_position_3d(VBuffer, i + 1, j + 1, 0); vertex_texcoord(VBuffer, (i + 1) / _width, (j + 1) / _height);
		vertex_position_3d(VBuffer, i, j + 1, 0);     vertex_texcoord(VBuffer, i / _width, (j + 1) / _height);
	}
}
vertex_end(VBuffer);
