set(CPACK_GENERATOR "ZIP")
set(CPACK_PACKAGE_FILE_NAME "wind-wasm")

install(TARGETS wind LIBRARY DESTINATION .)

file(GLOB_RECURSE CONAN_FILES "conan-deploy/web/full_deploy/host/**/*.a")
foreach(conan_file ${CONAN_FILES})
  message(${conan_file})
  install(FILES ${conan_file} DESTINATION .)
endforeach()

install(
  DIRECTORY "engine/bin/Release/web/net8.0/publish"
  DESTINATION .
  FILES_MATCHING
    PATTERN "*.wasm"
    PATTERN "*.html"
    PATTERN "*.js"
    PATTERN "*.css"
    PATTERN "*.json"
)

include(CPack)
