
set(HEADERS
  ./game/include/game/logger.hpp
)

set(SOURCES
  ./game/src/main.cpp
)

add_executable(${PROJECT_NAME} ${HEADERS} ${SOURCES})
target_include_directories(${PROJECT_NAME} PUBLIC ./game/include/)
