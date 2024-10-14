
set(HEADERS
  ./native/include/native/logger.hpp
)

set(SOURCES
  ./native/src/main.cpp
)

add_executable(${PROJECT_NAME} ${HEADERS} ${SOURCES})
target_include_directories(${PROJECT_NAME} PUBLIC ./native/include/)
