# Changelog 0.1.0
The initial release of GMD3D11. Includes:

* Macro `GMD3D11_PATH`, which is the Path to the GMD3D11 dynamic library. Default value is "GMD3D11.dll".
* Macro `GMD3D11_IS_SUPPORTED`, which expands to `true` if GMD3D11 is supported on the current platform.
* Macro `D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT`, which is the maximum number of slots for shader resources.
* Function `d3d11_texture_set_stage_vs`, which passes a texture to a vertex shader.
* Function `d3d11_texture_set_stage_ps`, which passes a texture to a pixel shader.
* Function `texture_set_stage_vs`, which, if GMD3D11 is supported, uses `d3d11_texture_set_stage_vs`, to pass a texture to a vertex shader, otherwise uses `texture_set_stage` (which should work on OpenGL platforms).
