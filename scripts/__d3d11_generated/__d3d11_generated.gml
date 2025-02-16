/* THIS FILE IS GENERATED - DO NOT EDIT BY HAND! */

/// @func d3d11_cbuffer_create(_size)
///
/// @desc Creates a new constant buffer.
///
/// @param {Real} _size The size of the buffer, in bytes. Must be a multiple of 16!
///
/// @return {Real} The ID of the created constant buffer or -1 on fail.
///
/// @see d3d11_sizeof16
/// @see d3d11_cbuffer_exists
/// @see d3d11_cbuffer_update
function d3d11_cbuffer_create(_size)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_create", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _size);
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

/// @func d3d11_shader_compile_cs(_file, _entryPoint, _profile)
///
/// @desc Compiles a compute shader from file.
///
/// @param {String} _file The path to file to compile.
/// @param {String} _entryPoint The name of the entry point function, e.g. "main".
/// @param {String} _profile The compute shader profile, e.g. "cs_5_0".
///
/// @return {Real} The ID of the compute shader or -1 on fail.
///
/// @see d3d11_get_error_string
function d3d11_shader_compile_cs(_file, _entryPoint, _profile)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_compile_cs", dll_cdecl, ty_real,
		3, ty_string, ty_string, ty_string);
	return external_call(_fn, _file, _entryPoint, _profile);
}

/// @func d3d11_shader_load_cs(_file)
///
/// @desc Loads a compiled compute shader from a file.
///
/// @param {String} _file The path to the compiled compute shader.
///
/// @return {Real} The ID of the compute shader or -1 on fail.
function d3d11_shader_load_cs(_file)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_load_cs", dll_cdecl, ty_real,
		1, ty_string);
	return external_call(_fn, _file);
}

/// @func d3d11_shader_set_cs(_gs)
///
/// @desc Changes the current compute shader.
///
/// @param {Real} _gs The ID of the shader or -1 to disable the compute stage.
function d3d11_shader_set_cs(_gs)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_cs", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _gs);
}

/// @func d3d11_compute_dispatch(_x, _y, _z)
///
/// @disc Dispatches the current compute shader with given number of workgroups.
///
/// @param {Real} _x Number of workgroups to dispatch in the x direction.
/// @param {Real} _y Number of workgroups to dispatch in the y direction.
/// @param {Real} _z Number of workgroups to dispatch in the z direction.
///
/// @see d3d11_shader_set_cs
/// @see D3D11_CS_DISPATCH_MAX_THREAD_GROUPS_PER_DIMENSION
function d3d11_compute_dispatch(_x, _y, _z)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_compute_dispatch", dll_cdecl, ty_real,
		3, ty_real, ty_real, ty_real);
	return external_call(_fn, _x, _y, _z);
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

/// @func d3d11_sizeof(_type)
///
/// @desc Retrieves size of given type, in bytes.
///
/// @param {Real} _type The type to get the byte-size of. 
///
/// @return {Real} The size of given type or -1 if the type is not valid.
///
/// @see D3D11_BOOL
/// @see D3D11_INT
/// @see D3D11_INT2
/// @see D3D11_INT3
/// @see D3D11_INT4
/// @see D3D11_UINT
/// @see D3D11_UINT2
/// @see D3D11_UINT3
/// @see D3D11_UINT4
/// @see D3D11_FLOAT
/// @see D3D11_FLOAT2
/// @see D3D11_FLOAT3
/// @see D3D11_FLOAT4
/// @see D3D11_FLOAT4X4
function d3d11_sizeof(_type)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sizeof", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _type);
}

/// @func d3d11_sizeof16(_type)
///
/// @desc Retrieves 16 byte-aligned size of given type, in bytes.
///
/// @param {Real} _type The type to get the byte-size of. 
///
/// @return {Real} The 16 byte-aligned size of given type or -1 if the type is not valid.
///
/// @see D3D11_BOOL
/// @see D3D11_INT
/// @see D3D11_INT2
/// @see D3D11_INT3
/// @see D3D11_INT4
/// @see D3D11_UINT
/// @see D3D11_UINT2
/// @see D3D11_UINT3
/// @see D3D11_UINT4
/// @see D3D11_FLOAT
/// @see D3D11_FLOAT2
/// @see D3D11_FLOAT3
/// @see D3D11_FLOAT4
/// @see D3D11_FLOAT4X4
function d3d11_sizeof16(_type)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sizeof16", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _type);
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

/// @func d3d11_sbuffer_create(_stride, _numElements)
///
/// @desc Creates a new structured buffer.
///
/// @param {Real} _stride The stride of a single element, in bytes.
/// @param {Real} _numElements The number of elements in the buffer.
///
/// @return {Real} The ID of the created structured buffer or -1 on fail.
///
/// @see d3d11_struct_begin
/// @see d3d11_sbuffer_exists
/// @see d3d11_sbuffer_update
function d3d11_sbuffer_create(_stride, _numElements)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sbuffer_create", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _stride, _numElements);
}

/// @func d3d11_sbuffer_get_size(_sbuffer)
///
/// @desc Retrieves size of a structured buffer in bytes.
///
/// @param {Real} _sbuffer The size of the structured buffer in bytes.
function d3d11_sbuffer_get_size(_sbuffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sbuffer_get_size", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _sbuffer);
}

/// @func d3d11_sbuffer_write_data(_sbuffer, _data)
///
/// @desc Writes data from a GM buffer into a D3D11 structured buffer.
///
/// @param {Real} _sbuffer The ID of the structured buffer.
/// @param {Pointer} _data An address of a GM buffer to update the structured buffer from.
function d3d11_sbuffer_write_data(_sbuffer, _data)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sbuffer_write_data", dll_cdecl, ty_real,
		2, ty_real, ty_string);
	return external_call(_fn, _sbuffer, _data);
}

/// @func d3d11_sbuffer_exists(_sbuffer)
///
/// @desc Checks whether a structured buffer exists.
///
/// @param {Real} _sbuffer The ID of the structured buffer.
///
/// @return {Bool} Returns true if the structured buffer exists.
function d3d11_sbuffer_exists(_sbuffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sbuffer_exists", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _sbuffer);
}

/// @func d3d11_sbuffer_destroy(_sbuffer)
///
/// @desc Destroys a structured buffer.
///
/// @param {Real} _sbuffer The ID of the structured buffer to destroy.
function d3d11_sbuffer_destroy(_sbuffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sbuffer_destroy", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _sbuffer);
}

/// @func d3d11_sbuffer_create_srv(_sbuffer)
///
/// @desc Creates a shader resource view (SRV) for given structured buffer.
///
/// @param {Real} _sbuffer The ID of the structured buffer.
///
/// @return {Real} The ID of the created SRV on success or -1 on fail.
function d3d11_sbuffer_create_srv(_sbuffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sbuffer_create_srv", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _sbuffer);
}

/// @func d3d11_sbuffer_create_uav(_sbuffer)
///
/// @desc Creates an unordered access view (UAV) for given structured buffer.
///
/// @param {Real} _sbuffer The ID of the structured buffer.
///
/// @return {Real} The ID of the created UAV on success or -1 on fail.
function d3d11_sbuffer_create_uav(_sbuffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sbuffer_create_uav", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _sbuffer);
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

/// @func d3d11_srv_exists(_srv)
///
/// @desc Checks whether a shader resource view (SRV) exists.
///
/// @param {Real} _srv The ID of the SRV.
///
/// @return {Bool} Returns true if the SRV exists.
function d3d11_srv_exists(_srv)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_srv_exists", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _srv);
}

/// @func d3d11_srv_destroy(_srv)
///
/// @desc Destroys a shader resource view (SRV).
///
/// @param {Real} _srv The ID of the SRV to destroy.
function d3d11_srv_destroy(_srv)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_srv_destroy", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _srv);
}

/// @func d3d11_shader_set_srv_vs(_slot, _srv)
///
/// @desc Binds a shader resource view (SRV) to a vertex shader.
///
/// @param {Real} _slot The slot to bind the SRV to.
/// @param {Real} _srv The ID of the SRV or -1 to unbind the slot.
///
/// @see d3d11_sbuffer_create_srv
function d3d11_shader_set_srv_vs(_slot, _srv)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_srv_vs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _slot, _srv);
}

/// @func d3d11_shader_set_srv_gs(_slot, _srv)
///
/// @desc Binds a shader resource view (SRV) to a geometry shader.
///
/// @param {Real} _slot The slot to bind the SRV to.
/// @param {Real} _srv The ID of the SRV or -1 to unbind the slot.
///
/// @see d3d11_sbuffer_create_srv
function d3d11_shader_set_srv_gs(_slot, _srv)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_srv_gs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _slot, _srv);
}

/// @func d3d11_shader_set_srv_ps(_slot, _srv)
///
/// @desc Binds a shader resource view (SRV) to a pixel shader.
///
/// @param {Real} _slot The slot to bind the SRV to.
/// @param {Real} _srv The ID of the SRV or -1 to unbind the slot.
///
/// @see d3d11_sbuffer_create_srv
function d3d11_shader_set_srv_ps(_slot, _srv)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_srv_ps", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _slot, _srv);
}

/// @func d3d11_shader_set_srv_cs(_slot, _srv)
///
/// @desc Binds a shader resource view (SRV) to a compute shader.
///
/// @param {Real} _slot The slot to bind the SRV to.
/// @param {Real} _srv The ID of the SRV or -1 to unbind the slot.
///
/// @see d3d11_sbuffer_create_srv
function d3d11_shader_set_srv_cs(_slot, _srv)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_srv_cs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _slot, _srv);
}

/// @func d3d11_uav_exists(_uav)
///
/// @desc Checks whether an unordered access view (UAV) exists.
///
/// @param {Real} _uav The ID of the UAV.
///
/// @return {Bool} Returns true if the UAV exists.
function d3d11_uav_exists(_uav)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_uav_exists", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _uav);
}

/// @func d3d11_uav_destroy(_uav)
///
/// @desc Destroys an unordered access view (UAV).
///
/// @param {Real} _uav The ID of the UAV to destroy.
function d3d11_uav_destroy(_uav)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_uav_destroy", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _uav);
}

/// @func d3d11_shader_set_uav_cs(_slot, _uav)
///
/// @desc Binds an unordered access view (UAV) to a compute shader.
///
/// @param {Real} _slot The slot to bind the UAV to.
/// @param {Real} _uav The ID of the UAV or -1 to unbind the slot.
///
/// @see d3d11_sbuffer_create_uav
function d3d11_shader_set_uav_cs(_slot, _uav)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_uav_cs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _slot, _uav);
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
