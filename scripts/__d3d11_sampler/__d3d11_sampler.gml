/// @func d3d11_sampler_create(_desc)
///
/// @desc Creates a new sampler state.
///
/// @param {Struct.D3D11_SAMPLER_DESC} _desc A sampler state descriptor.
///
/// @return {Real} The ID of the created sampler state or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_sampler_create(_desc)
{
	gml_pragma("forceinline");
	var _scratchBuffer = d3d11_get_scratch_buffer();
	_desc.to_buffer(_scratchBuffer);
	return d3d11_sampler_create_impl(buffer_get_address(_scratchBuffer));
}
