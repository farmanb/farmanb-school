project(TEST)

#Throw in CPack to generate packages
INCLUDE(CPack)

#Set minimum CMake version required
cmake_minimum_required(VERSION 2.4)

#Set CMake 2.6 policy
if(COMMAND cmake_policy)
  cmake_policy(SET CMP0003 NEW)
endif(COMMAND cmake_policy)

#Enable DepententOption macro
include(CMakeDependentOption)

#Set various variables
set(TEST_INSTALL_BIN_DIR bin)

set(EXECUTABLE_OUTPUT_PATH "${CMAKE_BINARY_DIR}/${TEST_INSTALL_BIN_DIR}")

include (${CMAKE_SOURCE_DIR}/utils/ConfigureQt.cmake)

if(BUILD_QT_APP)
  add_subdirectory(qt)
endif(BUILD_QT_APP)
add_subdirectory(src)