/* THIS FILE IS GENERATED - DO NOT EDIT BY HAND! */

/// @func d3d11_init(_device, _context)
///
/// @desc Initializes the GMD3D11 extension. Must be called first before using any other functions!
///
/// @param {Pointer} _device A pointer to the D3D11 device, retrieved from `os_get_info()`.
/// @param {Pointer} _context A pointer to the D3D11 context, retrieved from `os_get_info()`.
function d3d11_init(_device, _context)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_init", dll_cdecl, ty_real,
		2, ty_string, ty_string);
	return external_call(_fn, _device, _context);
}

/// @func d3d11_get_error_string()
///
/// @desc Retrieves the last error string.
///
/// @return {String} The last error string.
function d3d11_get_error_string()
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_get_error_string", dll_cdecl, ty_string,
		0);
	return external_call(_fn);
}

/// @func d3d11_srv_copy_ps_vs(_src, _dest)
///
/// @desc Copies a shader resource view bound to a given slot in a pixel shader to another slot in a vertex shader.
///
/// @param {Real} _src The slot index in the pixel shader to copy from.
/// @param {Real} _dest The slot index in the verex shader to copy to.
///
/// @return {Bool} Returns `true` on success or `false` otherwise.
function d3d11_srv_copy_ps_vs(_src, _dest)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_srv_copy_ps_vs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _src, _dest);
}

/// @func d3d11_srv_copy_ps_gs(_src, _dest)
///
/// @desc Copies a shader resource view bound to a given slot in a pixel shader to another slot in a geometry shader.
///
/// @param {Real} _src The slot index in the pixel shader to copy from.
/// @param {Real} _dest The slot index in the geometry shader to copy to.
///
/// @return {Bool} Returns `true` on success or `false` otherwise.
function d3d11_srv_copy_ps_gs(_src, _dest)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_srv_copy_ps_gs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _src, _dest);
}

/// @func d3d11_srv_copy_ps_ps(_src, _dest)
///
/// @desc Copies a shader resource view bound to a given slot in a pixel shader to another slot in a pixel shader.
///
/// @param {Real} _src The slot index in the pixel shader to copy from.
/// @param {Real} _dest The slot index in the pixel shader to copy to.
///
/// @return {Bool} Returns `true` on success or `false` otherwise.
function d3d11_srv_copy_ps_ps(_src, _dest)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_srv_copy_ps_ps", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _src, _dest);
}

/// @func d3d11_srv_copy_ps_cs(_src, _dest)
///
/// @desc Copies a shader resource view bound to a given slot in a pixel shader to another slot in a compute shader.
///
/// @param {Real} _src The slot index in the pixel shader to copy from.
/// @param {Real} _dest The slot index in the compute shader to copy to.
///
/// @return {Bool} Returns `true` on success or `false` otherwise.
function d3d11_srv_copy_ps_cs(_src, _dest)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_srv_copy_ps_cs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _src, _dest);
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
/// @return {Real} The size of given type or 0 if the type is not valid.
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

/// @func d3d11_sizeof_aligned(_type, _alignment)
///
/// @desc Retrieves aligned byte size of given type.
///
/// @param {Real} _type The type to get the byte size of.
/// @param {Real} _alignment The required aligned byte size.
///
/// @return {Real} The aligned byte size of given type or 0 if the type is not valid.
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
function d3d11_sizeof_aligned(_type, _alignment)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sizeof_aligned", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _type, _alignment);
}

/// @func d3d11_buffer_copy(_src, _dest)
///
/// @desc Copies data from source to destination buffer.
///
/// @param {Real} _src The ID of the source buffer.
/// @param {Real} _dest The ID of the destination buffer.
function d3d11_buffer_copy(_src, _dest)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_buffer_copy", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _src, _dest);
}

/// @func d3d11_compute_buffer_create(_stride, _numElements)
///
/// @desc Creates a new compute buffer.
///
/// @param {Real} _stride The stride of a single element, in bytes.
/// @param {Real} _numElements The number of elements in the buffer.
///
/// @return {Real} The ID of the created compute buffer or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_compute_buffer_create(_stride, _numElements)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_compute_buffer_create", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _stride, _numElements);
}

/// @func d3d11_compute_buffer_get_size(_id)
///
/// @desc Retrieves size of a compute buffer in bytes.
///
/// @param {Real} _id The ID of the compute buffer.
///
/// @return {Real} The size of the compute buffer in bytes.
function d3d11_compute_buffer_get_size(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_compute_buffer_get_size", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_compute_buffer_write(_id, _data)
///
/// @desc Writes data from a GM buffer into a D3D11 compute buffer.
///
/// @param {Real} _id The ID of the compute buffer.
/// @param {Pointer} _data An address of a GM buffer to update the compute buffer from.
function d3d11_compute_buffer_write(_id, _data)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_compute_buffer_write", dll_cdecl, ty_real,
		2, ty_real, ty_string);
	return external_call(_fn, _id, _data);
}

/// @func d3d11_compute_buffer_exists(_id)
///
/// @desc Checks whether a compute buffer exists.
///
/// @param {Real} _id The ID of the compute buffer.
///
/// @return {Bool} Returns `true` if the compute buffer exists.
function d3d11_compute_buffer_exists(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_compute_buffer_exists", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_compute_buffer_destroy(_id)
///
/// @desc Destroys a compute buffer.
///
/// @param {Real} _id The ID of the compute buffer to destroy.
function d3d11_compute_buffer_destroy(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_compute_buffer_destroy", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_compute_buffer_create_srv(_id)
///
/// @desc Creates a shader resource view (SRV) for given compute buffer.
///
/// @param {Real} _id The ID of the compute buffer.
///
/// @return {Real} The ID of the created SRV on success or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_compute_buffer_create_srv(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_compute_buffer_create_srv", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_compute_buffer_create_uav(_id)
///
/// @desc Creates an unordered access view (UAV) for given compute buffer.
///
/// @param {Real} _id The ID of the compute buffer.
///
/// @return {Real} The ID of the created UAV on success or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_compute_buffer_create_uav(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_compute_buffer_create_uav", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_constant_buffer_create(_size)
///
/// @desc Creates a new constant buffer.
///
/// @param {Real} _size The size of the buffer, in bytes. Must be a multiple of 16!
///
/// @return {Real} The ID of the created constant buffer or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_constant_buffer_create(_size)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_constant_buffer_create", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _size);
}

/// @func d3d11_constant_buffer_get_size(_id)
///
/// @desc Retrieves size of a constant buffer in bytes.
///
/// @param {Real} _id The ID of the constant buffer.
///
/// @return {Real} The size of the constant buffer in bytes.
function d3d11_constant_buffer_get_size(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_constant_buffer_get_size", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_constant_buffer_write(_id, _data)
///
/// @desc Writes data from a GM buffer into a D3D11 constant buffer.
///
/// @param {Real} _id The ID of the constant buffer.
/// @param {Pointer} _data An address of a GM buffer to update the constant buffer from.
function d3d11_constant_buffer_write(_id, _data)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_constant_buffer_write", dll_cdecl, ty_real,
		2, ty_real, ty_string);
	return external_call(_fn, _id, _data);
}

/// @func d3d11_shader_set_constant_buffer_vs(_slot, _id)
///
/// @desc Binds a constant buffer to a vertex shader.
///
/// @param {Real} _slot The slot to bind the constant buffer to.
/// @param {Real} _id The ID of the constant buffer or {@link GMD3D11_ID_INVALID} to unbind the slot.
function d3d11_shader_set_constant_buffer_vs(_slot, _id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_constant_buffer_vs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _slot, _id);
}

/// @func d3d11_shader_set_constant_buffer_gs(_slot, _id)
///
/// @desc Binds a constant buffer to a geometry shader.
///
/// @param {Real} _slot The slot to bind the constant buffer to.
/// @param {Real} _id The ID of the constant buffer or {@link GMD3D11_ID_INVALID} to unbind the slot.
function d3d11_shader_set_constant_buffer_gs(_slot, _id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_constant_buffer_gs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _slot, _id);
}

/// @func d3d11_shader_set_constant_buffer_ps(_slot, _id)
///
/// @desc Binds a constant buffer to a pixel shader.
///
/// @param {Real} _slot The slot to bind the constant buffer to.
/// @param {Real} _id The ID of the constant buffer or {@link GMD3D11_ID_INVALID} to unbind the slot.
function d3d11_shader_set_constant_buffer_ps(_slot, _id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_constant_buffer_ps", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _slot, _id);
}

/// @func d3d11_shader_set_constant_buffer_cs(_slot, _id)
///
/// @desc Binds a constant buffer to a compute shader.
///
/// @param {Real} _slot The slot to bind the constant buffer to.
/// @param {Real} _id The ID of the constant buffer or {@link GMD3D11_ID_INVALID} to unbind the slot.
function d3d11_shader_set_constant_buffer_cs(_slot, _id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_constant_buffer_cs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _slot, _id);
}

/// @func d3d11_constant_buffer_exists(_id)
///
/// @desc Checks whether a constant buffer exists.
///
/// @param {Real} _id The ID of the constant buffer.
///
/// @return {Bool} Returns `true` if the constant buffer exists.
function d3d11_constant_buffer_exists(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_constant_buffer_exists", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_constant_buffer_destroy(_id)
///
/// @desc Destroys a constant buffer.
///
/// @param {Real} _id The ID of the constant buffer to destroy.
function d3d11_constant_buffer_destroy(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_constant_buffer_destroy", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_readback_buffer_create(_stride, _numElements)
///
/// @desc Creates a new staging buffer.
///
/// @param {Real} _stride The stride of a single element, in bytes.
/// @param {Real} _numElements The number of elements in the buffer.
///
/// @return {Real} The ID of the created staging buffer or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_readback_buffer_create(_stride, _numElements)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_readback_buffer_create", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _stride, _numElements);
}

/// @func d3d11_readback_buffer_get_size(_id)
///
/// @desc Retrieves size of a staging buffer in bytes.
///
/// @param {Real} _id The ID of the staging buffer.
///
/// @return {Real} The size of the staging buffer in bytes.
function d3d11_readback_buffer_get_size(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_readback_buffer_get_size", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_readback_buffer_is_mapped(_id)
///
/// @desc Checks whether a staging buffer is currently mapped to CPU-accessible memory.
///
/// @param {Real} _id The ID of the staging buffer.
///
/// @return {Bool} Returns `true` if given staging buffer is currently mapped for reading or `false` otherwise.
function d3d11_readback_buffer_is_mapped(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_readback_buffer_is_mapped", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_readback_buffer_map(_id)
///
/// @desc Maps a staging buffer to CPU-accessible memory for reading.
///
/// @param {Real} _id The ID of the staging buffer.
///
/// @return {Bool} Returns `true` on success or `false` otherwise (e.g. the staging buffer was already mapped).
function d3d11_readback_buffer_map(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_readback_buffer_map", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_readback_buffer_read(_id, _dest)
///
/// @desc Copies data of a mapped staging buffer into a GM buffer, specified by its address.
///
/// @param {Real} _id The ID of the staging buffer.
/// @param {Pointer} _dest The address of the destination buffer.
///
/// @return {Bool} Returns `true` on success or `false` otherwise (e.g. the staging buffer was not mapped).
function d3d11_readback_buffer_read(_id, _dest)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_readback_buffer_read", dll_cdecl, ty_real,
		2, ty_real, ty_string);
	return external_call(_fn, _id, _dest);
}

/// @func d3d11_readback_buffer_unmap(_id)
///
/// @desc Unmaps a staging buffer from CPU-accessible memory.
///
/// @param {Real} _id The ID of the staging buffer.
///
/// @return {Bool} Returns `true` on success or `false` otherwise (e.g. the staging buffer was not mapped).
function d3d11_readback_buffer_unmap(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_readback_buffer_unmap", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_readback_buffer_exists(_id)
///
/// @desc Checks whether a staging buffer exists.
///
/// @param {Real} _id The ID of the staging buffer.
///
/// @return {Bool} Returns `true` if the staging buffer exists.
function d3d11_readback_buffer_exists(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_readback_buffer_exists", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_readback_buffer_destroy(_id)
///
/// @desc Destroys a staging buffer.
///
/// @param {Real} _id The ID of the staging buffer to destroy.
function d3d11_readback_buffer_destroy(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_readback_buffer_destroy", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_structured_buffer_create(_stride, _numElements)
///
/// @desc Creates a new structured buffer.
///
/// @param {Real} _stride The stride of a single element, in bytes.
/// @param {Real} _numElements The number of elements in the buffer.
///
/// @return {Real} The ID of the created structured buffer or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_structured_buffer_create(_stride, _numElements)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_structured_buffer_create", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _stride, _numElements);
}

/// @func d3d11_structured_buffer_get_size(_id)
///
/// @desc Retrieves size of a structured buffer in bytes.
///
/// @param {Real} _id The ID of the structured buffer.
///
/// @return {Real} The size of the structured buffer in bytes.
function d3d11_structured_buffer_get_size(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_structured_buffer_get_size", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_structured_buffer_write(_id, _data)
///
/// @desc Writes data from a GM buffer into a D3D11 structured buffer.
///
/// @param {Real} _id The ID of the structured buffer.
/// @param {Pointer} _data An address of a GM buffer to update the structured buffer from.
function d3d11_structured_buffer_write(_id, _data)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_structured_buffer_write", dll_cdecl, ty_real,
		2, ty_real, ty_string);
	return external_call(_fn, _id, _data);
}

/// @func d3d11_structured_buffer_exists(_id)
///
/// @desc Checks whether a structured buffer exists.
///
/// @param {Real} _id The ID of the structured buffer.
///
/// @return {Bool} Returns `true` if the structured buffer exists.
function d3d11_structured_buffer_exists(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_structured_buffer_exists", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_structured_buffer_destroy(_id)
///
/// @desc Destroys a structured buffer.
///
/// @param {Real} _id The ID of the structured buffer to destroy.
function d3d11_structured_buffer_destroy(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_structured_buffer_destroy", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_structured_buffer_create_srv(_id)
///
/// @desc Creates a shader resource view (SRV) for given structured buffer.
///
/// @param {Real} _id The ID of the structured buffer.
///
/// @return {Real} The ID of the created SRV on success or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_structured_buffer_create_srv(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_structured_buffer_create_srv", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_shader_compile_cs(_file, _entryPoint, _profile)
///
/// @desc Compiles a compute shader from file.
///
/// @param {String} _file The path to file to compile.
/// @param {String} _entryPoint The name of the entry point function, e.g. "main".
/// @param {String} _profile The compute shader profile, e.g. "cs_5_0".
///
/// @return {Real} The ID of the compute shader or {@link GMD3D11_ID_INVALID} on fail.
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
/// @return {Real} The ID of the compute shader pr {@link GMD3D11_ID_INVALID} on fail.
function d3d11_shader_load_cs(_file)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_load_cs", dll_cdecl, ty_real,
		1, ty_string);
	return external_call(_fn, _file);
}

/// @func d3d11_shader_set_cs(_cs)
///
/// @desc Changes the current compute shader.
///
/// @param {Real} _cs The ID of the shader or {@link GMD3D11_ID_INVALID} to disable the compute stage.
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
function d3d11_compute_dispatch(_x, _y, _z)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_compute_dispatch", dll_cdecl, ty_real,
		3, ty_real, ty_real, ty_real);
	return external_call(_fn, _x, _y, _z);
}

/// @func d3d11_compute_dispatch_indirect(_buffer, _offset)
///
/// @desc Dispatches the current compute shader, reading the number of workgroups to be dispatched from the specified
/// buffer. The dispatch arguments in the buffer must contain three UINT values representing the X, Y, and Z workgroup
/// dimensions.
///
/// @param {Real} _buffer The ID of the buffer that contains the dispatch arguments.
/// @param {Real} _offset The byte offset from the start of the buffer to the location of the dispatch arguments. Must
/// be aligned to 4 bytes.
function d3d11_compute_dispatch_indirect(_buffer, _offset)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_compute_dispatch_indirect", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _buffer, _offset);
}

/// @func d3d11_shader_compile_gs(_file, _entryPoint, _profile)
///
/// @desc Compiles a geometry shader from file.
///
/// @param {String} _file The path to file to compile.
/// @param {String} _entryPoint The name of the entry point function, e.g. "main".
/// @param {String} _profile The geometry shader profile, e.g. "gs_4_0".
///
/// @return {Real} The ID of the geometry shader pr {@link GMD3D11_ID_INVALID} on fail.
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
/// @return {Real} The ID of the geometry shader pr {@link GMD3D11_ID_INVALID} on fail.
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
/// @param {Real} _gs The ID of the shader or {@link GMD3D11_ID_INVALID} to disable the geometry stage.
function d3d11_shader_set_gs(_gs)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_gs", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _gs);
}

/// @func d3d11_shader_compile_ps(_file, _entryPoint, _profile)
///
/// @desc Compiles a pixel shader from file.
///
/// @param {String} _file The path to file to compile.
/// @param {String} _entryPoint The name of the entry point function, e.g. "main".
/// @param {String} _profile The pixel shader profile, e.g. "ps_4_0".
///
/// @return {Real} The ID of the pixel shader pr {@link GMD3D11_ID_INVALID} on fail.
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
/// @return {Real} The ID of the pixel shader pr {@link GMD3D11_ID_INVALID} on fail.
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
/// @param {Real} _ps The ID of the shader or {@link GMD3D11_ID_INVALID} to disable the override.
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
/// @return {Bool} Returns `true` if the shader exists.
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

/// @func d3d11_shader_compile_vs(_file, _entryPoint, _profile)
///
/// @desc Compiles a vertex shader from file.
///
/// @param {String} _file The path to file to compile.
/// @param {String} _entryPoint The name of the entry point function, e.g. "main".
/// @param {String} _profile The vertex shader profile, e.g. "vs_4_0".
///
/// @return {Real} The ID of the vertex shader pr {@link GMD3D11_ID_INVALID} on fail.
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
/// @return {Real} The ID of the vertex shader pr {@link GMD3D11_ID_INVALID} on fail.
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
/// @param {Real} _vs The ID of the shader or {@link GMD3D11_ID_INVALID} to disable the override. The vertex format
/// expected by the shader must be compatible with the overriden shader!
function d3d11_shader_override_vs(_vs)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_override_vs", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _vs);
}

/// @func d3d11_sampler_create_impl(_buffer)
///
/// @desc
///
/// @param {Pointer}
///
/// @return {Real}
function d3d11_sampler_create_impl(_buffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sampler_create_impl", dll_cdecl, ty_real,
		1, ty_string);
	return external_call(_fn, _buffer);
}

/// @func d3d11_sampler_exists(_id)
///
/// @desc Checks whether a sampler state exists.
///
/// @param {Real} _id The ID of the sampler state.
///
/// @return {Bool} Returns `true` if the sampler state exists.
function d3d11_sampler_exists(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sampler_exists", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_sampler_destroy(_id)
///
/// @desc Destroys a sampler state.
///
/// @param {Real} _id The ID of the sampler state to destroy.
function d3d11_sampler_destroy(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sampler_destroy", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_sampler_set_vs(_id, _slot)
///
/// @desc
///
/// @param {Real} _id
/// @param {Real} _slot
function d3d11_sampler_set_vs(_id, _slot)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sampler_set_vs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _id, _slot);
}

/// @func d3d11_sampler_set_vs(_id, _slot)
///
/// @desc
///
/// @param {Real} _id
/// @param {Real} _slot
function d3d11_sampler_set_gs(_id, _slot)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sampler_set_gs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _id, _slot);
}

/// @func d3d11_sampler_set_vs(_id, _slot)
///
/// @desc
///
/// @param {Real} _id
/// @param {Real} _slot
function d3d11_sampler_set_ps(_id, _slot)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sampler_set_ps", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _id, _slot);
}

/// @func d3d11_sampler_set_vs(_id, _slot)
///
/// @desc
///
/// @param {Real} _id
/// @param {Real} _slot
function d3d11_sampler_set_cs(_id, _slot)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_sampler_set_cs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _id, _slot);
}

/// @func d3d11_texture2D_create_impl(_buffer, _pSysMem, _memPitch, _memSlicePitch)
///
/// @desc Creates a new 2D texture.
///
/// @param {Pointer} _buffer A pointer to a buffer containing serialized {@link D3D11_TEXTURE2D_DESC}.
/// @param {Pointer} _pSysMem
/// @param {Real} _memPitch
/// @param {Real} _memSlicePitch
///
/// @return {Real} The ID of the created 2D texture or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_texture2D_create_impl(_buffer, _pSysMem, _memPitch, _memSlicePitch)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_texture2D_create_impl", dll_cdecl, ty_real,
		4, ty_string, ty_string, ty_real, ty_real);
	return external_call(_fn, _buffer, _pSysMem, _memPitch, _memSlicePitch);
}

/// @func d3d11_texture2d_exists(_id)
///
/// @desc Checks whether a 2D texture exists.
///
/// @param {Real} _id The ID of the 2D texture.
///
/// @return {Bool} Returns `true` if the 2D texture exists.
function d3d11_texture2d_exists(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_texture2d_exists", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_texture2d_destroy(_id)
///
/// @desc Destroys a 2D texture.
///
/// @param {Real} _id The ID of the 2D texture to destroy.
function d3d11_texture2d_destroy(_id)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_texture2d_destroy", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _id);
}

/// @func d3d11_texture2d_create_dsv_impl(_id, _buffer)
///
/// @desc Creates a depth stencil view (DSV) for a 2D texture.
///
/// @param {Real} _id The ID of the 2D texture to create an DSV for.
/// @param {Pointer} _buffer A pointer to a buffer containing serialized {@link D3D11_DEPTH_STENCIL_VIEW_DESC} or
/// `pointer_null`.
///
/// @return {Real} The ID of the create DSV on success or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_texture2d_create_dsv_impl(_id, _buffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_texture2d_create_dsv_impl", dll_cdecl, ty_real,
		2, ty_real, ty_string);
	return external_call(_fn, _id, _buffer);
}

/// @func d3d11_texture2d_create_rtv_impl(_id, _buffer)
///
/// @desc Creates an render target view (RTV) for a 2D texture.
///
/// @param {Real} _id The ID of the 2D texture to create an RTV for.
/// @param {Pointer} _buffer A pointer to a buffer containing serialized {@link D3D11_RENDER_TARGET_VIEW_DESC} or
/// `pointer_null`.
///
/// @return {Real} The ID of the create RTV on success or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_texture2d_create_rtv_impl(_id, _buffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_texture2d_create_rtv_impl", dll_cdecl, ty_real,
		2, ty_real, ty_string);
	return external_call(_fn, _id, _buffer);
}

/// @func d3d11_texture2d_create_srv_impl(_id, _buffer)
///
/// @desc Creates a shader resource view (SRV) for a 2D texture.
///
/// @param {Real} _id The ID of the 2D texture to create an SRV for.
/// @param {Pointer} _buffer A pointer to a buffer containing serialized {@link D3D11_SHADER_RESOURCE_VIEW_DESC} or
/// `pointer_null`.
///
/// @return {Real} The ID of the create SRV on success or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_texture2d_create_srv_impl(_id, _buffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_texture2d_create_srv_impl", dll_cdecl, ty_real,
		2, ty_real, ty_string);
	return external_call(_fn, _id, _buffer);
}

/// @func d3d11_texture2d_create_uav_impl(_id, _buffer)
///
/// @desc Creates an unordered access view (UAV) for a 2D texture.
///
/// @param {Real} _id The ID of the 2D texture to create an UAV for.
/// @param {Pointer} _buffer A pointer to a buffer containing serialized {@link D3D11_UNORDERED_ACCESS_VIEW_DESC} or
/// `pointer_null`.
///
/// @return {Real} The ID of the create UAV on success or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_texture2d_create_uav_impl(_id, _buffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_texture2d_create_uav_impl", dll_cdecl, ty_real,
		2, ty_real, ty_string);
	return external_call(_fn, _id, _buffer);
}

/// @func d3d11_dsv_exists(_dsv)
///
/// @desc Checks whether an depth stencil view (DSV) exists.
///
/// @param {Real} _dsv The ID of the DSV.
///
/// @return {Bool} Returns `true` if the DSV exists.
function d3d11_dsv_exists(_dsv)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_dsv_exists", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _dsv);
}

/// @func d3d11_dsv_destroy(_dsv)
///
/// @desc Destroys an depth stencil view (DSV).
///
/// @param {Real} _dsv The ID of the DSV to destroy.
function d3d11_dsv_destroy(_dsv)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_dsv_destroy", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _dsv);
}

/// @func d3d11_dsv_clear(_dsv, _r, _g, _b, _a)
///
/// @desc Clears a depth stencil view.
///
/// @param {Real} _dsv The ID of the DSV to clear.
/// @param {Real} _clearFlags Bitwise `OR` between {@link D3D11_CLEAR_DEPTH} and/or {@link D3D11_CLEAR_STENCIL}, depending
/// which ones should be cleared.
/// @param {Real} _depth The depth value to clear the DSV with.
/// @param {Real} _stencil The stencil value to clear the DSV with.
function d3d11_dsv_clear(_dsv, _clearFlags, _depth, _stencil)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_dsv_clear", dll_cdecl, ty_real,
		4, ty_real, ty_real, ty_real, ty_real);
	return external_call(_fn, _dsv, _clearFlags, _depth, _stencil);
}

/// @func d3d11_rtv_exists(_rtv)
///
/// @desc Checks whether an render target view (RTV) exists.
///
/// @param {Real} _rtv The ID of the RTV.
///
/// @return {Bool} Returns `true` if the RTV exists.
function d3d11_rtv_exists(_rtv)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_rtv_exists", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _rtv);
}

/// @func d3d11_rtv_destroy(_rtv)
///
/// @desc Destroys an render target view (RTV).
///
/// @param {Real} _rtv The ID of the RTV to destroy.
function d3d11_rtv_destroy(_rtv)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_rtv_destroy", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _rtv);
}

/// @func d3d11_rtv_clear(_rtv, _r, _g, _b, _a)
///
/// @desc Clears a render target view to given color.
///
/// @param {Real} _rtv The ID of the RTV to clear.
/// @param {Real} _r The value of the red channel.
/// @param {Real} _g The value of the green channel.
/// @param {Real} _b The value of the blue channel.
/// @param {Real} _a The value of the alpha channel.
function d3d11_rtv_clear(_rtv, _r, _g, _b, _a)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_rtv_clear", dll_cdecl, ty_real,
		5, ty_real, ty_real, ty_real, ty_real, ty_real);
	return external_call(_fn, _rtv, _r, _g, _b, _a);
}

/// @func d3d11_set_render_targets_impl(_buffer)
///
/// @desc
///
/// @param {Pointer} _buffer
function d3d11_set_render_targets_impl(_buffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_set_render_targets_impl", dll_cdecl, ty_real,
		1, ty_string);
	return external_call(_fn, _buffer);
}

/// @func d3d11_srv_exists(_srv)
///
/// @desc Checks whether a shader resource view (SRV) exists.
///
/// @param {Real} _srv The ID of the SRV.
///
/// @return {Bool} Returns `true` if the SRV exists.
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

/// @func d3d11_srv_generate_mips(_srv)
///
/// @desc Generates texture mips using given shader resource view (SRV).
///
/// @param {Real} _srv The ID of the SRV.
function d3d11_srv_generate_mips(_srv)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_srv_generate_mips", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _srv);
}

/// @func d3d11_shader_set_srv_vs(_slot, _srv)
///
/// @desc Binds a shader resource view (SRV) to a vertex shader.
///
/// @param {Real} _slot The slot to bind the SRV to.
/// @param {Real} _srv The ID of the SRV or {@link GMD3D11_ID_INVALID} to unbind the slot.
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
/// @param {Real} _srv The ID of the SRV or {@link GMD3D11_ID_INVALID} to unbind the slot.
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
/// @param {Real} _srv The ID of the SRV or {@link GMD3D11_ID_INVALID} to unbind the slot.
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
/// @param {Real} _srv The ID of the SRV or {@link GMD3D11_ID_INVALID} to unbind the slot.
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
/// @return {Bool} Returns `true` if the UAV exists.
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
/// @param {Real} _uav The ID of the UAV or {@link GMD3D11_ID_INVALID} to unbind the slot.
function d3d11_shader_set_uav_cs(_slot, _uav)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_uav_cs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _slot, _uav);
}
