function d3d11_cbuffer_begin()
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_begin", dll_cdecl, ty_real,
		0);
	return external_call(_fn);
}

function d3d11_cbuffer_end()
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_end", dll_cdecl, ty_real,
		0);
	return external_call(_fn);
}

function d3d11_cbuffer_add_bool(_count)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_add_bool", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _count);
}

function d3d11_cbuffer_add_int(_count)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_add_int", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _count);
}

function d3d11_cbuffer_add_uint(_count)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_add_uint", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _count);
}

function d3d11_cbuffer_add_float(_count)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_add_float", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _count);
}

function d3d11_cbuffer_get_size(_cbuffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_get_size", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _cbuffer);
}

function d3d11_cbuffer_update(_cbuffer, _buffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_update", dll_cdecl, ty_real,
		2, ty_real, ty_string);
	return external_call(_fn, _cbuffer, buffer_get_address(_buffer));
}

function d3d11_shader_set_cbuffer_ps(_slot, _cbuffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_cbuffer_ps", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _slot, _cbuffer);
}

function d3d11_shader_set_cbuffer_vs(_slot, _cbuffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_shader_set_cbuffer_vs", dll_cdecl, ty_real,
		2, ty_real, ty_real);
	return external_call(_fn, _slot, _cbuffer);
}

function d3d11_cbuffer_exists(_cbuffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_exists", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _cbuffer);
}

function d3d11_cbuffer_destroy(_cbuffer)
{
	gml_pragma("forceinline");
	static _fn = external_define(
		GMD3D11_PATH, "d3d11_cbuffer_destroy", dll_cdecl, ty_real,
		1, ty_real);
	return external_call(_fn, _cbuffer);
}
