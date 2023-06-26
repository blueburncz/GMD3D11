/// @macro {String} Path to the GMD3D11 dynamic library.
/// Default value is "GMD3D11.dll".
#macro GMD3D11_PATH "GMD3D11.dll"

/// @macro {Bool} Expands to `true` if GMD3D11 is supported on the current
/// platform.
#macro GMD3D11_IS_SUPPORTED (os_type == os_windows)

/// @func d3d11_get_error_string()
///
/// @desc Retrieves the last error message.
///
/// @return {String} The last error message.
function d3d11_get_error_string()
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_get_error_string", dll_cdecl, ty_string,
		0);
	return external_call(_fn);
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
