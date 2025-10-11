cmake_minimum_required(VERSION 3.23)

project(GMD3D11)

set(CMAKE_CXX_STANDARD 17)

add_library(GMD3D11 SHARED
    src/CBuffer.cpp
    src/CShader.cpp
    src/GShader.cpp
    src/main.cpp
    src/PShader.cpp
    src/RSBuffer.cpp
    src/RWSBuffer.cpp
    src/Shader.cpp
    src/SRV.cpp
    src/UAV.cpp
    src/utils.cpp
    src/VShader.cpp
    )

target_include_directories(GMD3D11 PRIVATE
    include/
    )
