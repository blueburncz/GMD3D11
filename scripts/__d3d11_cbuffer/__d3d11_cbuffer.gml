/// @func d3d11_cbuffer_update(_cbuffer, _buffer)
///
/// @desc Updates data of a constant buffer.
///
/// @param {Real} _cbuffer The ID of the constant buffer.
/// @param {Id.Buffer} _buffer A buffer with new data.
function d3d11_cbuffer_update(_cbuffer, _buffer)
{
	gml_pragma("forceinline");
	d3d11_cbuffer_write_data(_cbuffer, buffer_get_address(_buffer));
}
