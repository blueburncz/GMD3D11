/// @func d3d11_set_render_targets(_rtv, _dsv)
///
/// @desc
///
/// @param {Real, Array<Real>} _rtv
/// @param {Real} _dsv
///
/// @see D3D11_SIMULTANEOUS_RENDER_TARGET_COUNT
function d3d11_set_render_targets(_rtv, _dsv)
{
	gml_pragma("forceinline");
	var _scratchBuffer = d3d11_get_scratch_buffer();

	// Write RTVs
	if (is_array(_rtv))
	{
		var _numRtvs = array_length(_rtv);

		if (_numRtvs > D3D11_SIMULTANEOUS_RENDER_TARGET_COUNT)
		{
			show_error("Invalid number of render targets!", true);
		}

		buffer_write(_scratchBuffer, buffer_u32, _numRtvs);
		for (var i = 0; i < _numRtvs; ++i)
		{
			buffer_write(_scratchBuffer, buffer_u64, _rtv[i]);
		}
	}
	else
	{
		buffer_write(_scratchBuffer, buffer_u32, 1);
		buffer_write(_scratchBuffer, buffer_u64, _rtv);
	}

	// Write DSV
	buffer_write(_scratchBuffer, buffer_u64, _dsv);

	// Call
	d3d11_set_render_targets_impl(buffer_get_address(_scratchBuffer));
}

/// @func d3d11_reset_render_targets()
///
/// @desc
function d3d11_reset_render_targets()
{
	gml_pragma("forceinline");
	var _scratchBuffer = d3d11_get_scratch_buffer();

	// Write RTVs
	buffer_write(_scratchBuffer, buffer_u32, D3D11_SIMULTANEOUS_RENDER_TARGET_COUNT);
	for (var i = 0; i < D3D11_SIMULTANEOUS_RENDER_TARGET_COUNT; ++i)
	{
		buffer_write(_scratchBuffer, buffer_u64, GMD3D11_ID_INVALID);
	}

	// Write DSVs
	buffer_write(_scratchBuffer, buffer_u64, GMD3D11_ID_INVALID);

	// Call
	d3d11_set_render_targets_impl(buffer_get_address(_scratchBuffer));
}
