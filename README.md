# GMD3D11

> D3D11 functions extension for GameMaker

[![License](https://img.shields.io/github/license/blueburncz/GMD3D11)](LICENSE)
[![Discord](https://img.shields.io/discord/298884075585011713?label=Discord)](https://discord.gg/ep2BGPm)

## Features

* Set up to 128 vertex and pixel shader samplers. Compatible with `surface_get_texture` and `sprite_get_texture`!
* Compile shaders from files (optimization level 3).
* Save and load compiled shaders.
* Hook into `ID3D11DeviceContext::Draw` calls to swap out used vertex and pixel shaders with custom ones.
* Geometry shaders.
* Constant buffers.
* Instanced rendering.

## Building the DLL

Requires [CMake](https://cmake.org/) 3.23 at least!

```sh
cd cpp
mkdir build
cd build
cmake ..
cmake --build . --config=Release
Copy-Item -Path ./Release/GMD3D11.dll -Destination ../../datafiles
```

## Links

* [Documentation](https://blueburn.cz/gmd3d11/docs)

## Credits

* <https://github.com/ParinovYT/cVmtHook-x64> - x64 VMT hook
* <https://polyhaven.com/a/rubber_duck_toy> - model used in instanced rendering example
