set(APP_NAME castrl-Part2-app)

set(APP_SRCS
  App.cpp
  App.h
  Factory.cpp
  BatController.h
)

set(APP_LIBRARIES
  ${DVC_LIBRARY}
  dvcApp)

set(LIBRARY_OUTPUT_PATH ${DVC_INSTALL_PLUGIN_DIR})

if (MSVC)
  ## Disable warning:  Conversion from DVC::REAL to GLfloat
  add_definitions("/wd4244")
endif (MSVC)

include_directories("${CMAKE_SOURCE_DIR}/application/base")
include(${CMAKE_SOURCE_DIR}/utils/CreatePluginMacro.cmake)
create_plugin(${APP_NAME} "BASE_APP_EXPORTS" APP_SRCS APP_LIBRARIES)

configure_file("${CMAKE_CURRENT_SOURCE_DIR}/HW1Scene.xml"
"${CMAKE_BINARY_DIR}/share/dvc/xml/scenes/castrl-Part2-scene..xml")

## Install XML file -- CPack uses this.  If this line is not here, CPack won't include the XML
## file in the binary distro.

install(FILES 
  "${CMAKE_BINARY_DIR}/${DVC_INSTALL_XML_SCENE_DIR}/HW1Scene.xml"
  DESTINATION ${DVC_INSTALL_XML_SCENE_DIR})
  
