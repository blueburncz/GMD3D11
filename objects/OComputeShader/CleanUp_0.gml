if (d3d11_shader_exists(cs))
{
	d3d11_shader_destroy(cs);
}

if (d3d11_rsbuffer_exists(bufferIn))
{
	d3d11_rsbuffer_destroy(bufferIn);
}

if (d3d11_srv_exists(srv))
{
	d3d11_srv_destroy(srv);
}

if (d3d11_rwsbuffer_exists(bufferOut))
{
	d3d11_rwsbuffer_destroy(bufferOut);
}

if (d3d11_uav_exists(uav))
{
	d3d11_uav_destroy(uav);
}

if (d3d11_stbuffer_exists(stagingBuffer))
{
	d3d11_stbuffer_destroy(stagingBuffer);
}
