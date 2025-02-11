/// @func d3d11_sbuffer_update(_sbuffer, _buffer)
///
/// @desc Updates data of a structured buffer.
///
/// @param {Real} _sbuffer The ID of the structured buffer.
/// @param {Id.Buffer} _buffer A buffer with new data.
function d3d11_sbuffer_update(_sbuffer, _buffer)
{
	gml_pragma("forceinline");
	d3d11_sbuffer_write_data(_sbuffer, buffer_get_address(_buffer));
}
