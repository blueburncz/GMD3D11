cmake_minimum_required(VERSION 3.23)

project(GMD3D11)

set(CMAKE_CXX_STANDARD 17)

add_library(GMD3D11 SHARED
    src/buffers/Buffer.cpp
    src/buffers/ComputeBuffer.cpp
    src/buffers/ConstantBuffer.cpp
    src/buffers/ReadbackBuffer.cpp
    src/buffers/StructuredBuffer.cpp

    src/shaders/ComputeShader.cpp
    src/shaders/GeometryShader.cpp
    src/shaders/PixelShader.cpp
    src/shaders/Shader.cpp
    src/shaders/VertexShader.cpp

    src/views/SRV.cpp
    src/views/UAV.cpp

    src/main.cpp
    src/utils.cpp
    )

target_include_directories(GMD3D11 PRIVATE
    include/
    )
