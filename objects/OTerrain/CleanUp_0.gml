camera_destroy(camera);
vertex_format_delete(terrainVFormat);
if (surface_exists(terrainHeight))
{
	surface_free(terrainHeight);
}
vertex_delete_buffer(terrainVBuffer);
