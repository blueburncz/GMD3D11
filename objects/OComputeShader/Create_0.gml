cs = d3d11_shader_compile_cs("shaders/TestCS.hlsl", "main", "cs_5_0");
assert(d3d11_shader_exists(cs), $"Compute shader compilation failed! {d3d11_get_error_string()}");

var _numElements = 1024;
var _threadsPerGroup = 64;
var _numGroups = (_numElements + _threadsPerGroup - 1) / _threadsPerGroup;

bufferIn = d3d11_rsbuffer_create(d3d11_sizeof(D3D11_FLOAT), _numElements);
assert(d3d11_rsbuffer_exists(bufferIn), $"Could not create bufferIn! {d3d11_get_error_string()}");

var _buffer = buffer_create(d3d11_rsbuffer_get_size(bufferIn), buffer_fixed, 1);
for (var i = 0; i < _numElements; ++i)
{
	buffer_write(_buffer, buffer_f32, i);
}
d3d11_rsbuffer_update(bufferIn, _buffer);
buffer_delete(_buffer);

srv = d3d11_rsbuffer_create_srv(bufferIn);
assert(d3d11_srv_exists(srv), $"Could not create SRV! {d3d11_get_error_string()}");

bufferOut = d3d11_rwsbuffer_create(d3d11_sizeof(D3D11_FLOAT), _numElements);
assert(d3d11_rwsbuffer_exists(bufferOut), $"Could not create bufferOut! {d3d11_get_error_string()}");

uav = d3d11_rwsbuffer_create_uav(bufferOut);
assert(d3d11_uav_exists(srv), $"Could not create UAV! {d3d11_get_error_string()}");

d3d11_shader_set_cs(cs);
d3d11_shader_set_srv_cs(0, srv);
d3d11_shader_set_uav_cs(0, uav);
d3d11_compute_dispatch(_numGroups, 1, 1);
d3d11_shader_set_srv_cs(0, -1);
d3d11_shader_set_uav_cs(0, -1);
d3d11_shader_set_cs(-1);
