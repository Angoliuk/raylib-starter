set(CMAKE_C_COMPILER "emcc")
set(CMAKE_CXX_COMPILER "em++")

###===================================================================================##

if(BUILD_DOTNET)
  add_custom_command(TARGET ${PROJECT_NAME}
    POST_BUILD
    COMMAND dotnet publish Wind.Web.csproj
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/engine
    COMMENT "Running dotnet publish"
  )
endif()

set_target_properties(${PROJECT_NAME} PROPERTIES
  OUTPUT_NAME "wind"
  SUFFIX ".wasm"
  LINK_FLAGS "-s WASM=1 -s SIDE_MODULE=1 -s EXPORT_ALL=1 -O3 --bind"
  # -s EXPORT_ALL=1
  # -s EXPORTED_FUNCTIONS='[\"_windInitRenderer\", \"_windCreateWindow\"]'
#   windInitRenderer
# windCreateWindow
# windPostInitRenderer
)

###===================================================================================##
