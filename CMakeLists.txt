cmake_minimum_required(VERSION 3.22)

project(wind)

message("Building with CMake version: ${CMAKE_VERSION}")
message("WASM: ${BUILD_WASM}")
message("Output type: ${OUTPUT_TYPE}")
message(".Net: ${BUILD_DOTNET}")

include(${CMAKE_SOURCE_DIR}/cmake/utils.cmake)

###===================================================================================##

list(APPEND CMAKE_PREFIX_PATH "${CMAKE_BINARY_DIR}")

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

###===================================================================================##

import(executable OFF)
import(compiler ON)
import(dependencies OFF)

###===================================================================================##

import(cpack ON)
