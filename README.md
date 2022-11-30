# GMD3D11
> D3D11 functions extension for GameMaker

[![License](https://img.shields.io/github/license/blueburncz/GMD3D11)](LICENSE)
[![Discord](https://img.shields.io/discord/298884075585011713?label=Discord)](https://discord.gg/ep2BGPm)

## Features
* Setting up to 128 vertex and pixel shader samplers. Compatible with `surface_get_texture` and `sprite_get_texture`!

## Building the DLL
Requires [CMake](https://cmake.org/) 3.23 at least!

```sh
cd cpp
mkdir build
cd build
cmake ../CMakeLists.txt
cmake --build . --config=Release
Copy-Item -Path ./Release/GMD3D11.dll -Destination ../../datafiles
```
## Links
* [Documentation](https://blueburn.cz/gmd3d11/docs)
