/// @macro {String} Path to the GMD3D11 dynamic library.
/// Default value is "GMD3D11.dll".
#macro GMD3D11_PATH "GMD3D11.dll"

/// @macro {Bool} Expands to `true` if GMD3D11 is supported on the current
/// platform.
#macro GMD3D11_IS_SUPPORTED (os_type == os_windows)

/// @macro {Real} Maximum number of slots for shader resources.
#macro D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT 128

/// @macro {Real} Maximum number of workgroup size in {@link d3d11_compute_dispatch}.
#macro D3D11_CS_DISPATCH_MAX_THREAD_GROUPS_PER_DIMENSION 65535

/// @macro {Real} A boolean value.
/// @see d3d11_struct_add_member
/// @see d3d11_struct_get_member_type
#macro D3D11_BOOL 0

/// @macro {Real} An integer value.
/// @see d3d11_struct_add_member
/// @see d3d11_struct_get_member_type
#macro D3D11_INT 1

/// @macro {Real} A 2D vector of integers.
/// @see d3d11_struct_add_member
/// @see d3d11_struct_get_member_type
#macro D3D11_INT2 2

/// @macro {Real} A 3D vector of integers.
/// @see d3d11_struct_add_member
/// @see d3d11_struct_get_member_type
#macro D3D11_INT3 3

/// @macro {Real} A 4D vector of integers.
/// @see d3d11_struct_add_member
/// @see d3d11_struct_get_member_type
#macro D3D11_INT4 4

/// @macro {Real} An unsigned integer.
/// @see d3d11_struct_add_member
/// @see d3d11_struct_get_member_type
#macro D3D11_UINT 5

/// @macro {Real} A 2D vector of unsigned integers.
/// @see d3d11_struct_add_member
/// @see d3d11_struct_get_member_type
#macro D3D11_UINT2 6

/// @macro {Real} A 3D vector of unsigned integers.
/// @see d3d11_struct_add_member
/// @see d3d11_struct_get_member_type
#macro D3D11_UINT3 7

/// @macro {Real} A 4D vector of unsigned integers.
/// @see d3d11_struct_add_member
/// @see d3d11_struct_get_member_type
#macro D3D11_UINT4 8

/// @macro {Real} A floating-point value.
/// @see d3d11_struct_add_member
/// @see d3d11_struct_get_member_type
#macro D3D11_FLOAT 9

/// @macro {Real} A 2D vector of floats.
/// @see d3d11_struct_add_member
/// @see d3d11_struct_get_member_type
#macro D3D11_FLOAT2 10

/// @macro {Real} A 3D vector of floats.
/// @see d3d11_struct_add_member
/// @see d3d11_struct_get_member_type
#macro D3D11_FLOAT3 11

/// @macro {Real} A 4D vector of floats.
/// @see d3d11_struct_add_member
/// @see d3d11_struct_get_member_type
#macro D3D11_FLOAT4 12

/// @macro {Real} A 4x4 matrix of floats.
/// @see d3d11_struct_add_member
/// @see d3d11_struct_get_member_type
#macro D3D11_FLOAT4X4 13

/// @func texture_set_stage_vs(_slot, _texture)
///
/// @desc If GMD3D11 is supported, then uses {@link d3d11_texture_set_stage_vs} to pass a texture to a vertex shader,
/// otherwise uses `texture_set_stage` (which should work on OpenGL platforms).
///
/// @param {Id.Sampler} _slot The vertex texture slot index. Must be in range 0..7.
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

/// @func vertex_submit_instanced(_vbuff, _prim, _texture, _count)
///
/// @desc Draws multiple instances of a vertex buffer.
///
/// @param {Id.VertexBuffer} _vbuff The vertex buffer to submit.
/// @param {Constant.PrimitiveType} _prim The primitive type.
/// @param {Pointer.Texture} _texture The texture to use.
/// @param {Real} _count The number of instances to draw.
function vertex_submit_instanced(_vbuff, _prim, _texture, _count)
{
	gml_pragma("forceinline");
	if (!d3d11_draw_instanced(_count))
	{
		return false;
	}
	vertex_submit(_vbuff, _prim, _texture);
	return true;
}

if (GMD3D11_IS_SUPPORTED)
{
	var _init = external_define(
		GMD3D11_PATH, "d3d11_init", dll_cdecl, ty_real, 2, ty_string, ty_string);
	var _osInfo = os_get_info();
	var _device = _osInfo[? "video_d3d11_device"];
	var _context = _osInfo[? "video_d3d11_context"];
	external_call(_init, _device, _context);
}
