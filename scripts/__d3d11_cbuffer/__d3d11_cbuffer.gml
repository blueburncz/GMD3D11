/// @func d3d11_cbuffer_begin()
///
/// @desc Starts building a constant buffer.
///
/// @see d3d11_cbuffer_end
function d3d11_cbuffer_begin()
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_begin", dll_cdecl, ty_real,
		0);
	return external_call(_fn);
}

/// @func d3d11_cbuffer_end()
///
/// @desc Finishes building a constant buffer.
///
/// @return {Real} The ID of the created constant buffer or -1 on fail.
///
/// @see d3d11_cbuffer_exists
/// @see d3d11_cbuffer_update
function d3d11_cbuffer_end()
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_end", dll_cdecl, ty_real,
		0);
	return external_call(_fn);
}

/// @func d3d11_cbuffer_add_bool(_count)
///
/// @desc Adds a bool into a constant buffer that is currently being built.
///
/// @param {Real} _count Number of bools to add into the constant buffer.
///
/// @see d3d11_cbuffer_begin
function d3d11_cbuffer_add_bool(_count)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_add_bool", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _count);
}

/// @func d3d11_cbuffer_add_int(_count)
///
/// @desc Adds an int into a constant buffer that is currently being built.
///
/// @param {Real} _count Number of ints to add into the constant buffer.
///
/// @see d3d11_cbuffer_begin
function d3d11_cbuffer_add_int(_count)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_add_int", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _count);
}

/// @func d3d11_cbuffer_add_uint(_count)
///
/// @desc Adds an uint into a constant buffer that is currently being built.
///
/// @param {Real} _count Number of uints to add into the constant buffer.
///
/// @see d3d11_cbuffer_begin
function d3d11_cbuffer_add_uint(_count)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_add_uint", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _count);
}

/// @func d3d11_cbuffer_add_float(_count)
///
/// @desc Adds a float into a constant buffer that is currently being built.
///
/// @param {Real} _count Number of floats to add into the constant buffer.
///
/// @see d3d11_cbuffer_begin
function d3d11_cbuffer_add_float(_count)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_add_float", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _count);
}

/// @func d3d11_cbuffer_get_size(_cbuffer)
///
/// @desc Retrieves size of a constant buffer in bytes.
///
/// @param {Real} _cbuffer The size of the constant buffer in bytes.
function d3d11_cbuffer_get_size(_cbuffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_get_size", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _cbuffer);
}

/// @func d3d11_cbuffer_update(_cbuffer, _buffer)
///
/// @desc Updates data of a constant buffer.
///
/// @param {Real} _cbuffer The ID of the constant buffer.
/// @param {Id.Buffer} _buffer A buffer with new data.
function d3d11_cbuffer_update(_cbuffer, _buffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_update", dll_cdecl, ty_real,
		2, ty_real, ty_string);
	return external_call(_fn, _cbuffer, buffer_get_address(_buffer));
}

/// @func d3d11_shader_set_cbuffer_vs(_slot, _cbuffer)
///
/// @desc Binds a constant buffer to a vertex shader.
///
/// @param {Real} _slot The slot to bind the constant buffer to.
/// @param {Real} _cbuffer The ID of the constant buffer or -1 to unbind the slot.
function d3d11_shader_set_cbuffer_vs(_slot, _cbuffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_cbuffer_vs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _slot, _cbuffer);
}

/// @func d3d11_shader_set_cbuffer_gs(_slot, _cbuffer)
///
/// @desc Binds a constant buffer to a geometry shader.
///
/// @param {Real} _slot The slot to bind the constant buffer to.
/// @param {Real} _cbuffer The ID of the constant buffer or -1 to unbind the slot.
function d3d11_shader_set_cbuffer_gs(_slot, _cbuffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_cbuffer_gs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _slot, _cbuffer);
}

/// @func d3d11_shader_set_cbuffer_ps(_slot, _cbuffer)
///
/// @desc Binds a constant buffer to a pixel shader.
///
/// @param {Real} _slot The slot to bind the constant buffer to.
/// @param {Real} _cbuffer The ID of the constant buffer or -1 to unbind the slot.
function d3d11_shader_set_cbuffer_ps(_slot, _cbuffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_cbuffer_ps", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _slot, _cbuffer);
}

/// @func d3d11_cbuffer_exists(_cbuffer)
///
/// @desc Checks whether a constant buffer exists.
///
/// @param {Real} _cbuffer The ID of the constant buffer.
///
/// @return {Bool} Returns true if the constant buffer exists.
function d3d11_cbuffer_exists(_cbuffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_exists", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _cbuffer);
}

/// @func d3d11_cbuffer_destroy(_cbuffer)
///
/// @desc Destroys a constant buffer.
///
/// @param {Real} _cbuffer The ID of the constant buffer to destroy.
function d3d11_cbuffer_destroy(_cbuffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_destroy", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _cbuffer);
}
