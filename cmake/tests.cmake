
if(ENABLE_TESTS AND CMAKE_BUILD_TYPE STREQUAL "Debug")
  message("Testing enabled")

  enable_testing()
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --coverage -fprofile-arcs -ftest-coverage")

  add_custom_target(coverage
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_SOURCE_DIR}/tests/coverage
    COMMAND mkdir ${CMAKE_SOURCE_DIR}/tests/coverage
    COMMAND tests
    COMMAND gcovr --root ${CMAKE_SOURCE_DIR} --exclude '.*/tests/.*' --exclude '.*/CMakeFiles/.*' --exclude '.*/build/.*' --html --html-details -o ${CMAKE_SOURCE_DIR}/tests/coverage/index.html
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Generating code coverage report..."
  )

  add_subdirectory(./tests/)
endif()
