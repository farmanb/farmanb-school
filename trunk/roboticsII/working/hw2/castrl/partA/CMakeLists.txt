add_subdirectory(Geometry)

## set LIBRARY_OUTPUT_PATH to plugin install dir
set(LIBRARY_OUTPUT_PATH "${CMAKE_BINARY_DIR}/${DVC_INSTALL_PLUGIN_DIR}")

set(APP_NAME HW2App-A-castrl)

set(APP_SRCS
  Factory.cpp
  App.cpp
  GripControl.cpp
  PalmControl.cpp
  )

set(APP_LIBRARIES
  ${DVC_LIBRARY}
  dvcApp
  )


## Configure xml file
configure_file("${CMAKE_CURRENT_SOURCE_DIR}/HW2Scene-A-castrl.xml" "${CMAKE_BINARY_DIR}/${DVC_INSTALL_XML_SCENE_DIR}/HW2Scene-A-castrl.xml" )

## Add this directory to search for headers
include_directories("${CMAKE_SOURCE_DIR}/application/base")
include_directories("${CMAKE_SOURCE_DIR}/simulator/include")

## Import create_plugin macro
include(${CMAKE_SOURCE_DIR}/utils/CreatePluginMacro.cmake)


## Call create_plugin macro
create_plugin(${APP_NAME} "BASE_APP_EXPORTS" APP_SRCS APP_LIBRARIES)

## Install  XML file
install(FILES 
  "${CMAKE_BINARY_DIR}/${DVC_INSTALL_XML_SCENE_DIR}/HW2Scene-A-castrl.xml"
  DESTINATION ${DVC_INSTALL_XML_SCENE_DIR})

