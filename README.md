# GMD3D11

> D3D11 functions extension for GameMaker

[![License](https://img.shields.io/github/license/blueburncz/GMD3D11)](LICENSE)
[![Discord](https://img.shields.io/discord/298884075585011713?label=Discord)](https://discord.gg/ep2BGPm)

## Features

* [ ] Shaders
  * [x] Compile from file (optimization level 3)
  * [x] Save and load compiled shaders
  * [x] Vertex texture fetching of native GM textures (`sprite_get_texture()`, `surface_get_texture()`)
  * [x] Hook into `ID3D11DeviceContext::Draw` calls to swap out used vertex and pixel shaders with custom ones
  * [x] Geometry shaders
  * [ ] Tessellation shaders (🛑 TODO)
  * [ ] Compute shaders (🚧 WIP)
* [ ] Buffers
  * [ ] Vertex buffers (🛑 TODO)
  * [ ] Index buffers (🛑 TODO)
  * [x] Constant buffers
  * [x] Structured buffers (with SRV and UAV)
  * [ ] Raw buffers (🛑 TODO)
  * [ ] Staging buffers (🛑 TODO)
* [ ] Textures
  * [ ] Samplers (🛑 TODO)
  * [ ] Texture2D (🛑 TODO)
  * [ ] Texture3D (🛑 TODO)
* [ ] Occlusion queries (🛑 TODO)
* [ ] Timestamps (🛑 TODO)
* [x] `vertex_submit_instanced()`

## Building the DLL

> Requires [CMake](https://cmake.org/) 3.23 at least and [Python 3](https://www.python.org/downloads/)!

Simply run `./build.ps1` from the root directory to build the DLL, copy it into `datafiles` and generate
`__d3d11_generated.gml`.

## Links

* [Documentation](https://blueburn.cz/gmd3d11/docs)

## Credits

* <https://github.com/ParinovYT/cVmtHook-x64> - x64 VMT hook
* <https://polyhaven.com/a/rubber_duck_toy> - model used in instanced rendering example
