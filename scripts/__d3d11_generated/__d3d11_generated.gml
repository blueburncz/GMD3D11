/* THIS FILE IS GENERATED - DO NOT EDIT BY HAND! */

/// @func d3d11_cbuffer_create(_struct, _count)
///
/// @desc Creates a new constant buffer.
///
/// @param {Real} _struct A struct that defines data stored in the constant buffer.
/// @param {Real} _count 
///
/// @return {Real} The ID of the created constant buffer or -1 on fail.
///
/// @see d3d11_struct_begin
/// @see d3d11_cbuffer_exists
/// @see d3d11_cbuffer_update
function d3d11_cbuffer_create(_struct, _count)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_create", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _struct, _count);
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

/// @func d3d11_cbuffer_write_data(_cbuffer, _data)
///
/// @desc Writes data from a GM buffer into a D3D11 constant buffer.
///
/// @param {Real} _cbuffer The ID of the constant buffer.
/// @param {Pointer} _data An address of a GM buffer to update the constant buffer from.
function d3d11_cbuffer_write_data(_cbuffer, _data)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_write_data", dll_cdecl, ty_real,
		2, ty_real, ty_string);
	return external_call(_fn, _cbuffer, _data);
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

/// @func d3d11_shader_compile_gs(_file, _entryPoint, _profile)
///
/// @desc Compiles a geometry shader from file.
///
/// @param {String} _file The path to file to compile.
/// @param {String} _entryPoint The name of the entry point function, e.g. "main".
/// @param {String} _profile The geometry shader profile, e.g. "gs_4_0".
///
/// @return {Real} The ID of the geometry shader or -1 on fail.
///
/// @see d3d11_get_error_string
function d3d11_shader_compile_gs(_file, _entryPoint, _profile)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_compile_gs", dll_cdecl, ty_real,
		3, ty_string, ty_string, ty_string);
	return external_call(_fn, _file, _entryPoint, _profile);
}

/// @func d3d11_shader_load_gs(_file)
///
/// @desc Loads a compiled geometry shader from a file.
///
/// @param {String} _file The path to the compiled geometry shader.
///
/// @return {Real} The ID of the geometry shader or -1 on fail.
function d3d11_shader_load_gs(_file)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_load_gs", dll_cdecl, ty_real,
		1, ty_string);
	return external_call(_fn, _file);
}

/// @func d3d11_shader_set_gs(_gs)
///
/// @desc Changes the current geometry shader.
///
/// @param {Real} _gs The ID of the shader or -1 to disable the geometry stage.
function d3d11_shader_set_gs(_gs)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_gs", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _gs);
}

function d3d11_init(_device, _context)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_init", dll_cdecl, ty_real,
		2, ty_string, ty_string);
	return external_call(_fn, _device, _context);
}

function d3d11_get_error_string()
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_get_error_string", dll_cdecl, ty_string,
		0);
	return external_call(_fn);
}

function d3d11_texture_copy_vs(_index)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_texture_copy_vs", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _index);
}

function d3d11_texture_copy_gs(_index)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_texture_copy_gs", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _index);
}

function d3d11_texture_copy_ps(_index)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_texture_copy_ps", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _index);
}

/// @func d3d11_draw_instanced(_count)
///
/// @desc Configures the number of instances to draw the next time a vertex buffer is submitted. After that the number
/// is reset back to 0!
///
/// @param {Real} _count Number of instances to draw. Use 0 to disable instanced rendering.
function d3d11_draw_instanced(_count)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_draw_instanced", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _count);
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

/// @func d3d11_shader_load_ps(_file)
///
/// @desc Loads a compiled pixel shader from a file.
///
/// @param {String} _file The path to the compiled pixel shader.
///
/// @return {Real} The ID of the pixel shader or -1 on fail.
function d3d11_shader_load_ps(_file)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_load_ps", dll_cdecl, ty_real,
		1, ty_string);
	return external_call(_fn, _file);
}

/// @func d3d11_shader_override_ps(_ps)
///
/// @desc Hooks into `ID3D11DeviceContext::Draw` and replaces the current pixel shader with a custom one.
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

/// @func d3d11_shader_exists(_shader)
///
/// @desc Checks whether a shader exists.
///
/// @param {Real} _shader The ID of the shader.
///
/// @return {Bool} Returns true if the shader exists.
function d3d11_shader_exists(_shader)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_exists", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _shader);
}

/// @func d3d11_shader_destroy(_shader)
///
/// @desc Destroys a shader.
///
/// @param {Real} _shader The ID of the shader to destroy.
function d3d11_shader_destroy(_shader)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_destroy", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _shader);
}

/// @func d3d11_shader_save(_shader, _filePath)
///
/// @desc Saves a compiled shader.
///
/// @param {Real} _shader The ID of the shader to save.
/// @param {String} _filePath The file to save the shader to.
///
/// @return {Bool} Returns `true` on success.
function d3d11_shader_save(_shader, _filePath)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_save", dll_cdecl, ty_real,
		2, ty_real, ty_string);
	return external_call(_fn, _shader, _filePath);
}

/// @func d3d11_struct_begin()
///
/// @desc Start building a struct.
///
/// @see d3d11_struct_end
function d3d11_struct_begin()
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_struct_begin", dll_cdecl, ty_real,
		0);
	return external_call(_fn);
}

/// @func d3d11_struct_end()
///
/// @desc Finishes building a struct.
///
/// @return {Real} The ID of the created struct or -1 on fail.
///
/// @see d3d11_struct_exists
function d3d11_struct_end()
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_struct_end", dll_cdecl, ty_real,
		0);
	return external_call(_fn);
}

/// @func d3d11_struct_add_member(_type)
///
/// @desc Adds a member to a struct that is currently being built.
///
/// @param {Real} _type The type of the member to add.
///
/// @see d3d11_struct_begin
function d3d11_struct_add_member(_type)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_struct_add_member", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _type);
}

/// @func d3d11_struct_exists(_struct)
///
/// @desc Checks whether a struct with given ID exists.
///
/// @return {Bool} Returns 1 if the struct exists or 0 otherwise.
function d3d11_struct_exists(_struct)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_struct_exists", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _struct);
}

/// @func d3d11_struct_destroy(_struct)
///
/// @desc Destroys a struct with given ID.
///
/// @param {Real} _struct The ID of the struct to destroy.
function d3d11_struct_destroy(_struct)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_struct_destroy", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _struct);
}

/// @func d3d11_struct_get_member_count(_struct)
///
/// @desc Retrieves the number of member that a struct has.
///
/// @param {Real} _struct The ID of the struct.
///
/// @return {Real} The number of members that the struct has.
function d3d11_struct_get_member_count(_struct)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_struct_get_member_count", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _struct);
}

/// @func d3d11_struct_get_member_type(_struct, _index)
///
/// @desc Retrieves the type of a struct member with given index.
///
/// @param {Real} _struct The ID of the struct.
/// @param {Real} _index The index of the struct member.
///
/// @return {Real} The type of the member on success of -1 on fail.
function d3d11_struct_get_member_type(_struct, _index)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_struct_get_member_type", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _struct, _index);
}

/// @func d3d11_struct_get_member_offset(_struct, _index)
///
/// @desc Retrieves an offset of a member with given index within a struct.
///
/// @param {Real} _struct The ID of the struct.
/// @param {Real} _index The index of the member. Use values in range 0..{@link d3d11_struct_get_member_count}-1.
///
/// @return {Real} The member's offset or -1 if given struct does not have a member with given index.
function d3d11_struct_get_member_offset(_struct, _index)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_struct_get_member_offset", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _struct, _index);
}

/// @func d3d11_struct_get_member_offset16(_struct, _index)
///
/// @desc Retrieves 16 byte-aligned offset of a member with given index within a struct.
///
/// @param {Real} _struct The ID of the struct.
/// @param {Real} _index The index of the member. Use values in range 0..{@link d3d11_struct_get_member_count}-1.
///
/// @return {Real} The member's offset aligned to 16 bytes or -1 if given struct does not have a member with given index.
function d3d11_struct_get_member_offset16(_struct, _index)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_struct_get_member_offset16", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _struct, _index);
}

/// @func d3d11_struct_get_member_size(_struct, _index)
///
/// @desc Retrieves size (in bytes) of a member with given index within a struct.
///
/// @param {Real} _struct The ID of the struct.
/// @param {Real} _index The index of the member. Use values in range 0..{@link d3d11_struct_get_member_count}-1.
///
/// @return {Real} The member's size (in bytes) or -1 if given struct does not have a member with given index.
function d3d11_struct_get_member_size(_struct, _index)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_struct_get_member_size", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _struct, _index);
}

/// @func d3d11_struct_get_member_size(_struct, _index)
///
/// @desc Retrieves 16 byte-aligned size of a member with given index within a struct.
///
/// @param {Real} _struct The ID of the struct.
/// @param {Real} _index The index of the member. Use values in range 0..{@link d3d11_struct_get_member_count}-1.
///
/// @return {Real} The member's size aligned to 16 bytes or -1 if given struct does not have a member with given index.
function d3d11_struct_get_member_size16(_struct, _index)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_struct_get_member_size16", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _struct, _index);
}

/// @func d3d11_struct_get_size(_struct)
///
/// @desc Retrieves size (in bytes) of a struct.
///
/// @param {Real} _struct The ID of the struct.
///
/// @return {Real} The struct's size in bytes.
function d3d11_struct_get_size(_struct)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_struct_get_size", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _struct);
}

/// @func d3d11_struct_get_size16(_struct)
///
/// @desc Retrieves 16 byte-aligned size of a struct.
///
/// @param {Real} _struct The ID of the struct.
///
/// @return {Real} The struct's size aligned to 16 bytes.
function d3d11_struct_get_size16(_struct)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_struct_get_size16", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _struct);
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

/// @func d3d11_shader_load_vs(_file)
///
/// @desc Loads a compiled vertex shader from a file.
///
/// @param {String} _file The path to the compiled vertex shader.
///
/// @return {Real} The ID of the vertex shader or -1 on fail.
function d3d11_shader_load_vs(_file)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_load_vs", dll_cdecl, ty_real,
		1, ty_string);
	return external_call(_fn, _file);
}

/// @func d3d11_shader_override_vs(_vs)
///
/// @desc Hooks into `ID3D11DeviceContext::Draw` and replaces the current vertex shader with a custom one.
///
/// @param {Real} _vs The ID of the shader or -1 to disable the override. The vertex format expected by the shader must
/// be compatible with the overriden shader!
function d3d11_shader_override_vs(_vs)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_override_vs", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _vs);
}
