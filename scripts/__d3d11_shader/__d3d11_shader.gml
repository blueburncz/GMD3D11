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

/// @func d3d11_shader_compile_ps(_file, _entryPoint, _profile)
///
/// @desc Compiles a pixel shader from file.
///
/// @param {String} _file The path to file to compile.
/// @param {String} _entryPoint The name of the entry point function, e.g. "main".
/// @param {String} _profile The pixel shader profile, e.g. "ps_4_0".
///
/// @return {Real} The ID of the pixel shader or -1 on fail.
///
/// @see d3d11_get_error_string
function d3d11_shader_compile_ps(_file, _entryPoint, _profile)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_compile_ps", dll_cdecl, ty_real,
		3, ty_string, ty_string, ty_string);
	return external_call(_fn, _file, _entryPoint, _profile);
}

/// @func d3d11_shader_compile_vs(_file, _entryPoint, _profile)
///
/// @desc Compiles a vertex shader from file.
///
/// @param {String} _file The path to file to compile.
/// @param {String} _entryPoint The name of the entry point function, e.g. "main".
/// @param {String} _profile The vertex shader profile, e.g. "vs_4_0".
///
/// @return {Real} The ID of the vertex shader or -1 on fail.
///
/// @see d3d11_get_error_string
function d3d11_shader_compile_vs(_file, _entryPoint, _profile)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_compile_vs", dll_cdecl, ty_real,
		3, ty_string, ty_string, ty_string);
	return external_call(_fn, _file, _entryPoint, _profile);
}

/// @func d3d11_shader_override_ps(_ps)
///
/// @desc Hooks into `ID3D11DeviceContext::Draw` and replaces the current pixel
/// shader with a custom one.
///
/// @param {Real} _ps The ID of the shader or -1 to disable the override.
function d3d11_shader_override_ps(_ps)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_override_ps", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _ps);
}

/// @func d3d11_shader_override_vs(_vs)
///
/// @desc Hooks into `ID3D11DeviceContext::Draw` and replaces the current vertex
/// shader with a custom one.
///
/// @param {Real} _vs The ID of the shader or -1 to disable the override.
function d3d11_shader_override_vs(_vs)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_override_vs", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _vs);
}

/// @func d3d11_shader_exists_ps(_ps)
///
/// @desc Checks whether a pixel shader exists.
///
/// @param {Real} _ps The ID of the pixel shader.
///
/// @return {Bool} Returns true if the pixel shader exists.
function d3d11_shader_exists_ps(_ps)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_exists_ps", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _ps);
}

/// @func d3d11_shader_exists_vs(_vs)
///
/// @desc Checks whether a vertex shader exists.
///
/// @param {Real} _ps The ID of the vertex shader.
///
/// @return {Bool} Returns true if the vertex shader exists.
function d3d11_shader_exists_vs(_vs)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_exists_vs", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _vs);
}

/// @func d3d11_shader_destroy_ps(_ps)
///
/// @desc Destroys a pixel shader.
///
/// @param {Real} _ps The ID of the pixel shader to destroy.
function d3d11_shader_destroy_ps(_ps)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_destroy_ps", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _ps);
}

/// @func d3d11_shader_destroy_vs(_vs)
///
/// @desc Destroys a vertex shader.
///
/// @param {Real} _vs The ID of the vertex shader to destroy.
function d3d11_shader_destroy_vs(_vs)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_destroy_vs", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _vs);
}
