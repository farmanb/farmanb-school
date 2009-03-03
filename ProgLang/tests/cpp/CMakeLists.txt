project(TEST)

INCLUDE(CPack)

cmake_minimum_required(VERSION 2.4)

if(COMMAND cmake_policy)
  cmake_policy(SET CMP0003 NEW)
endif(COMMAND cmake_policy)

set(TEST_INSTALL_BIN_DIR bin)

set(EXECUTABLE_OUTPUT_PATH "${CMAKE_BINARY_DIR}/${TEST_INSTALL_BIN_DIR}")

add_subdirectory(src)