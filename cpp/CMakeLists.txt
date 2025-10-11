cmake_minimum_required(VERSION 3.23)

project(GMD3D11)

set(CMAKE_CXX_STANDARD 17)

add_library(GMD3D11 SHARED
    src/buffers/Buffer.cpp
    src/buffers/CBuffer.cpp
    src/buffers/RSBuffer.cpp
    src/buffers/RWSBuffer.cpp
    src/buffers/STBuffer.cpp

    src/shaders/CShader.cpp
    src/shaders/GShader.cpp
    src/shaders/PShader.cpp
    src/shaders/Shader.cpp
    src/shaders/VShader.cpp

    src/views/SRV.cpp
    src/views/UAV.cpp

    src/main.cpp
    src/utils.cpp
    )

target_include_directories(GMD3D11 PRIVATE
    include/
    )
