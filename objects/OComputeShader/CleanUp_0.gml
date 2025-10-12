if (d3d11_shader_exists(cs))
{
	d3d11_shader_destroy(cs);
}

if (d3d11_structured_buffer_exists(bufferIn))
{
	d3d11_structured_buffer_destroy(bufferIn);
}

if (d3d11_srv_exists(srv))
{
	d3d11_srv_destroy(srv);
}

if (d3d11_compute_buffer_exists(bufferOut))
{
	d3d11_compute_buffer_destroy(bufferOut);
}

if (d3d11_uav_exists(uav))
{
	d3d11_uav_destroy(uav);
}

if (d3d11_readback_buffer_exists(stagingBuffer))
{
	d3d11_readback_buffer_destroy(stagingBuffer);
}
