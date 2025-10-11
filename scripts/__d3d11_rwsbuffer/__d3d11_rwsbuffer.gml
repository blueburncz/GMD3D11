/// @func d3d11_rwsbuffer_update(_sbuffer, _buffer)
///
/// @desc Updates data of a read-write structured buffer.
///
/// @param {Real} _sbuffer The ID of the read-write structured buffer.
/// @param {Id.Buffer} _buffer A buffer with new data.
function d3d11_rwsbuffer_update(_sbuffer, _buffer)
{
	gml_pragma("forceinline");
	d3d11_rwsbuffer_write_data(_sbuffer, buffer_get_address(_buffer));
}
