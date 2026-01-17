/// @func D3D11_TEXTURE2D_DESC()
///
/// @desc
function D3D11_TEXTURE2D_DESC() constructor
{
	/// @var {Real}
	Width = 0;

	/// @var {Real}
	Height = 0;

	/// @var {Real}
	MipLevels = 0;

	/// @var {Real}
	ArraySize = 0;

	/// @var {Real}
	Format = DXGI_FORMAT_UNKNOWN;

	/// @var {Real}
	SampleDesc = new D3D11_SAMPLE_DESC();

	/// @var {Real}
	Usage = D3D11_USAGE_DEFAULT;

	/// @var {Real}
	BindFlags = 0;

	/// @var {Real}
	CPUAccessFlags = 0;

	/// @var {Real}
	MiscFlags = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, Width);
		buffer_write(_buffer, buffer_u32, Height);
		buffer_write(_buffer, buffer_u32, MipLevels);
		buffer_write(_buffer, buffer_u32, ArraySize);
		buffer_write(_buffer, buffer_u32, Format);
		buffer_write(_buffer, buffer_u32, SampleDesc.to_buffer(_buffer));
		buffer_write(_buffer, buffer_u32, Usage);
		buffer_write(_buffer, buffer_u32, BindFlags);
		buffer_write(_buffer, buffer_u32, CPUAccessFlags);
		buffer_write(_buffer, buffer_u32, MiscFlags);
	};
}

/// @func d3d11_texture2d_create(_desc[, _data])
///
/// @desc Creates a new 2D texture.
///
/// @param {Struct.D3D11_TEXTURE2D_DESC} _desc A 2D texture descriptor.
/// @param {Struct.D3D11_SUBRESOURCE_DATA, Undefined} [_data] Data to initialize the created texture with or
/// `undefined`.
///
/// @return {Real} The ID of the created 2D texture or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_texture2d_create(_desc, _data = undefined)
{
	gml_pragma("forceinline");
	var _scratchBuffer = d3d11_get_scratch_buffer();
	_desc.to_buffer(_scratchBuffer);
	return d3d11_texture2d_create_impl(
		buffer_get_address(_scratchBuffer),
		(_data != undefined) ? _data.pSysMem : pointer_null,
		(_data != undefined) ? _data.SysMemPitch : 0,
		(_data != undefined) ? _data.SysMemSlicePitch : 0);
}

/// @func d3d11_texture2d_create_dsv(_id[, _desc])
///
/// @desc Creates a depth stencil view (DSV) for a 2D texture.
///
/// @param {Real} _id The ID of the 2D texture to create a DSV for.
/// @param {Struct.D3D11_DEPTH_STENCIL_VIEW_DESC, Undefined} _desc A DSV descriptor or `undefined`.
///
/// @return {Real} The ID of the created DSV or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_texture2d_create_dsv(_id, _desc = undefined)
{
	gml_pragma("forceinline");

	if (_desc == undefined)
	{
		return d3d11_texture2d_create_dsv_impl(_id, pointer_null);
	}

	var _scratchBuffer = d3d11_get_scratch_buffer();
	_desc.to_buffer(_scratchBuffer);
	return d3d11_texture2d_create_dsv_impl(_id, buffer_get_address(_scratchBuffer));
}

/// @func d3d11_texture2d_create_rtv(_id[, _desc])
///
/// @desc Creates a render target view (RTV) for a 2D texture.
///
/// @param {Real} _id The ID of the 2D texture to create an RTV for.
/// @param {Struct.D3D11_RENDER_TARGET_VIEW_DESC, Undefined} _desc An RTV descriptor or `undefined`.
///
/// @return {Real} The ID of the created RTV or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_texture2d_create_rtv(_id, _desc = undefined)
{
	gml_pragma("forceinline");

	if (_desc == undefined)
	{
		return d3d11_texture2d_create_rtv_impl(_id, pointer_null);
	}

	var _scratchBuffer = d3d11_get_scratch_buffer();
	_desc.to_buffer(_scratchBuffer);
	return d3d11_texture2d_create_rtv_impl(_id, buffer_get_address(_scratchBuffer));
}

/// @func d3d11_texture2d_create_srv(_id[, _desc])
///
/// @desc Creates a shader resource view (SRV) for a 2D texture.
///
/// @param {Real} _id The ID of the 2D texture to create an SRV for.
/// @param {Struct.D3D11_SHADER_RESOURCE_VIEW_DESC, Undefined} [_desc] An SRV descriptor or `undefined`.
///
/// @return {Real} The ID of the created SRV or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_texture2d_create_srv(_id, _desc = undefined)
{
	gml_pragma("forceinline");

	if (_desc == undefined)
	{
		return d3d11_texture2d_create_srv_impl(_id, pointer_null);
	}

	var _scratchBuffer = d3d11_get_scratch_buffer();
	_desc.to_buffer(_scratchBuffer);
	return d3d11_texture2d_create_srv_impl(_id, buffer_get_address(_scratchBuffer));
}

/// @func d3d11_texture2d_create_uav(_id[, _desc])
///
/// @desc Creates an unordered access view (UAV) for a 2D texture.
///
/// @param {Real} _id The ID of the 2D texture to create an UAV for.
/// @param {Struct.D3D11_UNORDERED_ACCESS_VIEW_DESC, Undefined} _desc An UAV descriptor or `undefined`.
///
/// @return {Real} The ID of the created UAV or {@link GMD3D11_ID_INVALID} on fail.
function d3d11_texture2d_create_uav(_id, _desc = undefined)
{
	gml_pragma("forceinline");

	if (_desc == undefined)
	{
		return d3d11_texture2d_create_uav_impl(_id, pointer_null);
	}

	var _scratchBuffer = d3d11_get_scratch_buffer();
	_desc.to_buffer(_scratchBuffer);
	return d3d11_texture2d_create_uav_impl(_id, buffer_get_address(_scratchBuffer));
}
