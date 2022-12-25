camera_destroy(camera);
if (surface_exists(depthSurface))
{
	surface_free(depthSurface);
}
vertex_format_delete(terrainVFormat);
if (surface_exists(terrainHeightmap))
{
	surface_free(terrainHeightmap);
}
vertex_delete_buffer(terrainVBuffer);
if (surface_exists(brushSurface))
{
	surface_free(brushSurface);
}
