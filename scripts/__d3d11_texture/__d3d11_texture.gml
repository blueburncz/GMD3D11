/// @func d3d11_texture_set_stage_vs(_slot, _texture)
///
/// @desc Passes a texture to a vertex shader.
///
/// @param {Id.Sampler} _slot The vertex texture slot index. Must be in range
/// 0..{@link D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT}-1.
/// @param {Pointer.Texture} _texture The texture to pass.
///
/// @return {Real} Returns 1 on success or 0 on fail.
function d3d11_texture_set_stage_vs(_slot, _texture)
{
	gml_pragma("forceinline");
	texture_set_stage(0, _texture);
	return d3d11_texture_copy_vs(_slot);
}

/// @func d3d11_texture_set_stage_gs(_slot, _texture)
///
/// @desc Passes a texture to a geometry shader.
///
/// @param {Id.Sampler} _slot The geometry texture slot index. Must be in range
/// 0..{@link D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT}-1.
/// @param {Pointer.Texture} _texture The texture to pass.
///
/// @return {Real} Returns 1 on success or 0 on fail.
function d3d11_texture_set_stage_gs(_slot, _texture)
{
	gml_pragma("forceinline");
	texture_set_stage(0, _texture);
	return d3d11_texture_copy_gs(_slot);
}

/// @func d3d11_texture_set_stage_ps(_slot, _texture)
///
/// @desc Passes a texture to a pixel shader.
///
/// @param {Id.Sampler} _slot The pixel texture slot index. Must be in range
/// 0..{@link D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT}-1.
/// @param {Pointer.Texture} _texture The texture to pass.
///
/// @return {Real} Returns 1 on success or 0 on fail.
function d3d11_texture_set_stage_ps(_slot, _texture)
{
	gml_pragma("forceinline");
	texture_set_stage(0, _texture);
	return d3d11_texture_copy_ps(_slot);
}
