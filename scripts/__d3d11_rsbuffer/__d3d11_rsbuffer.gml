/// @func d3d11_rsbuffer_update(_sbuffer, _buffer)
///
/// @desc Updates data of a read-only structured buffer.
///
/// @param {Real} _sbuffer The ID of the read-only structured buffer.
/// @param {Id.Buffer} _buffer A buffer with new data.
function d3d11_rsbuffer_update(_sbuffer, _buffer)
{
	gml_pragma("forceinline");
	d3d11_rsbuffer_write_data(_sbuffer, buffer_get_address(_buffer));
}
