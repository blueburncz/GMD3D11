/// @macro {Real} Maximum number of slots for shader resources.
#macro D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT 128

/// @func d3d11_texture_set_stage_vs(_slot, _texture)
///
/// @desc Passes a texture to a vertex shader.
///
/// @param {Real} _slot The vertex texture slot index. Must be in range
/// 0..{@link D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT}-1.
/// @param {Pointer.Texture} _texture The texture to pass.
///
/// @return {Real} Returns 1 on success or 0 on fail.
function d3d11_texture_set_stage_vs(_slot, _texture)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_texture_set_stage_vs", dll_cdecl, ty_real,
		1, ty_real);
	texture_set_stage(0, _texture);
	return external_call(_fn, _slot);
}

/// @func texture_set_stage_vs(_slot, _texture)
///
/// @desc If GMD3D11 is supported, then uses {@link d3d11_texture_set_stage_vs}
/// to pass a texture to a vertex shader, otherwise uses `texture_set_stage`
/// (which should work on OpenGL platforms).
///
/// @param {Real} _slot The vertex texture slot index. Must be in range 0..7.
/// @param {Pointer.Texture} _texture The texture to pass.
///
/// @see GMD3D11_IS_SUPPORTED
function texture_set_stage_vs(_slot, _texture)
{
	gml_pragma("forceinline");
	if (GMD3D11_IS_SUPPORTED)
	{
		d3d11_texture_set_stage_vs(_slot, _texture);
		return;
	}
	texture_set_stage(_slot, _texture);
}

/// @func d3d11_texture_set_stage_ps(_slot, _texture)
///
/// @desc Passes a texture to a pixel shader.
///
/// @param {Real} _slot The pixel texture slot index. Must be in range
/// 0..{@link D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT}-1.
/// @param {Pointer.Texture} _texture The texture to pass.
///
/// @return {Real} Returns 1 on success or 0 on fail.
function d3d11_texture_set_stage_ps(_slot, _texture)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_texture_set_stage_ps", dll_cdecl, ty_real,
		1, ty_real);
	texture_set_stage(0, _texture);
	return external_call(_fn, _slot);
}

function d3d11_shader_compile_ps(_file, _entryPoint, _profile)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_compile_ps", dll_cdecl, ty_real,
		3, ty_string, ty_string, ty_string);
	return external_call(_fn, _file, _entryPoint, _profile);
}

function d3d11_shader_compile_vs(_file, _entryPoint, _profile)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_compile_vs", dll_cdecl, ty_real,
		3, ty_string, ty_string, ty_string);
	return external_call(_fn, _file, _entryPoint, _profile);
}

function d3d11_shader_override_ps(_ps)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_override_ps", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _ps);
}

function d3d11_shader_override_vs(_vs)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_override_vs", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _vs);
}

function d3d11_shader_exists_ps(_ps)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_exists_ps", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _ps);
}

function d3d11_shader_exists_vs(_vs)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_exists_vs", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _vs);
}

function d3d11_shader_destroy_ps(_ps)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_destroy_ps", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _ps);
}

function d3d11_shader_destroy_vs(_vs)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_destroy_vs", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _vs);
}
