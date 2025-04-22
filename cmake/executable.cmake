
set(HEADERS
  ./game/include/game/utils.hpp
)

set(SOURCES
  ./game/src/main.cpp
)

add_executable(${PROJECT_NAME} ${HEADERS} ${SOURCES})
target_include_directories(${PROJECT_NAME} PUBLIC ./game/include/)


set(ASSET_DIR "${CMAKE_CURRENT_SOURCE_DIR}/game/assets")

file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/assets")

file(GLOB ASSETS "${ASSET_DIR}/*")
foreach(asset ${ASSETS})
    get_filename_component(asset_name ${asset} NAME)  # Get only the file name
    configure_file(${asset} "${CMAKE_CURRENT_BINARY_DIR}/assets/${asset_name}" COPYONLY)
endforeach()
