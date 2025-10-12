cs = d3d11_shader_compile_cs("shaders/TestCS.hlsl", "main", "cs_5_0");
assert(d3d11_shader_exists(cs), $"Compute shader compilation failed! {d3d11_get_error_string()}");

var _numElements = 32;
var _threadsPerGroup = 64;
var _numGroups = (_numElements + _threadsPerGroup - 1) / _threadsPerGroup;

bufferIn = d3d11_structured_buffer_create(d3d11_sizeof(D3D11_FLOAT), _numElements);
assert(d3d11_structured_buffer_exists(bufferIn), $"Could not create bufferIn! {d3d11_get_error_string()}");

var _tempBuffer = buffer_create(d3d11_structured_buffer_get_size(bufferIn), buffer_fixed, 1);
for (var i = 1; i <= _numElements; ++i)
{
	buffer_write(_tempBuffer, buffer_f32, i);
}
d3d11_structured_buffer_write_data(bufferIn, buffer_get_address(_tempBuffer));

srv = d3d11_structured_buffer_create_srv(bufferIn);
assert(d3d11_srv_exists(srv), $"Could not create SRV! {d3d11_get_error_string()}");

bufferOut = d3d11_compute_buffer_create(d3d11_sizeof(D3D11_FLOAT), _numElements);
assert(d3d11_compute_buffer_exists(bufferOut), $"Could not create bufferOut! {d3d11_get_error_string()}");

uav = d3d11_compute_buffer_create_uav(bufferOut);
assert(d3d11_uav_exists(uav), $"Could not create UAV! {d3d11_get_error_string()}");

stagingBuffer = d3d11_readback_buffer_create(d3d11_sizeof(D3D11_FLOAT), _numElements);
assert(d3d11_readback_buffer_exists(stagingBuffer), $"Could not create stagingBuffer! {d3d11_get_error_string()}");

d3d11_shader_set_cs(cs);
d3d11_shader_set_srv_cs(0, srv);
d3d11_shader_set_uav_cs(0, uav);
d3d11_compute_dispatch(_numGroups, 1, 1);
d3d11_shader_set_srv_cs(0, GMD3D11_ID_INVALID);
d3d11_shader_set_uav_cs(0, GMD3D11_ID_INVALID);
d3d11_shader_set_cs(GMD3D11_ID_INVALID);

d3d11_buffer_copy(bufferOut, stagingBuffer);
assert(d3d11_readback_buffer_map(stagingBuffer), $"Failed to map stagingBuffer! {d3d11_get_error_string()}");
assert(d3d11_readback_buffer_is_mapped(stagingBuffer));
d3d11_readback_buffer_read_data(stagingBuffer, buffer_get_address(_tempBuffer));
assert(d3d11_readback_buffer_unmap(stagingBuffer), $"Failed to unmap stagingBuffer! {d3d11_get_error_string()}");

buffer_seek(_tempBuffer, buffer_seek_start, 0);
var _text = "[ ";
for (var i = 0; i < _numElements; ++i)
{
	_text += string(buffer_read(_tempBuffer, buffer_f32)) + ", ";
}
_text += "]";
show_debug_message(_text);

buffer_delete(_tempBuffer);
