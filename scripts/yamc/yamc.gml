/// @macro {Id.VertexFormat} A vertex format with 3D position, normal, texcoord
/// and color, in this exact order. Do not delete!
///
/// @example
/// Following code loads a model from a file "model.bin", using the default
/// vertex format.
/// ```gml
/// model = vertex_buffer_load("model.bin", vertex_format_pnuc);
/// ```
///
/// @see vertex_buffer_load
#macro vertex_format_pnuc __vertex_format_pnuc()

/// @ignore
function __vertex_format_pnuc()
{
	static _vformat = undefined;
	if (_vformat == undefined)
	{
		vertex_format_begin();
		vertex_format_add_position_3d();
		vertex_format_add_normal();
		vertex_format_add_texcoord();
		vertex_format_add_color();
		_vformat = vertex_format_end();
	}
	return _vformat;
}

/// @macro {Id.VertexFormat} Vertex format with 3D position, normal, texcoord,
/// color and tangent vector with bitangent sign (float4), in this exact order.
/// Do not delete!
///
/// @example
/// Following code loads a model from a file "model.bin", using the TBN
/// vertex format.
/// ```gml
/// model = vertex_buffer_load("model.bin", vertex_format_pnuct);
/// ```
///
/// @see vertex_buffer_load
#macro vertex_format_pnuct __vertex_format_pnuct()

/// @ignore
function __vertex_format_pnuct()
{
	static _vformat = undefined;
	if (_vformat == undefined)
	{
		vertex_format_begin();
		vertex_format_add_position_3d();
		vertex_format_add_normal();
		vertex_format_add_texcoord();
		vertex_format_add_color();
		vertex_format_add_custom(vertex_type_float4, vertex_usage_texcoord);
		_vformat = vertex_format_end();
	}
	return _vformat;
}

/// @func vertex_buffer_load(_filename, _vformat)
///
/// @desc Loads a vertex buffer from a file.
///
/// @param {String} _filename The file to load the buffer from.
/// @param {Id.VertexFormat} _vformat The vertex format of the buffer.
///
/// @return {Id.VertexBuffer} The loaded vertex buffer.
///
/// @example
/// Following code loads a model from file "model.bin" in the Create event
/// using the default vertex format, then draws it at the Draw event at the
/// instances x, y, z position and rotated around the Z axis by its direction
/// and finally frees the model from memory in the Clean Up event.
/// ```gml
/// /// @desc Create event
/// model = vertex_buffer_load("model.bin", vertex_format_pnuc);
///
/// /// @desc Draw event
/// matrix_set(matrix_world, matrix_build(x, y, z, 0, 0, direction, 1, 1, 1));
/// vertex_submit(model, pr_trianglelist, sprite_get_texture(SprModel, 0));
/// matrix_set(matrix_world, matrix_build_identity());
///
/// /// @desc Clean Up event
/// vertex_delete_buffer(model);
/// ```
///
/// @see vertex_format_pnuc
function vertex_buffer_load(_filename, _vformat)
{
	gml_pragma("forceinline");
	var _buffer = buffer_load(_filename);
	var _vbuffer = vertex_create_buffer_from_buffer(_buffer, _vformat);
	buffer_delete(_buffer);
	return _vbuffer;
}
