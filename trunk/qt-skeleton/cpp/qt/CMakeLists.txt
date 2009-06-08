include_directories(${CMAKE_CURRENT_BINARY_DIR})
INCLUDE(${QT_USE_FILE})

set(APP_EXE_NAME
  prog)

set (SRCS
  Main.cpp
  MainWindow.cpp
)

set (MOC_HDRS
  MainWindow.h
)

set (HEADERS
  ${MOC_HDRS}
  )

QT4_WRAP_CPP(MOC_SRCS ${MOC_HDRS})

#Compile & Link to Qt Libs
add_executable(${APP_EXE_NAME} ${EXE_BUILD_TYPE} ${SRCS} ${MOC_SRCS} ${HEADERS})
target_link_libraries(${APP_EXE_NAME} ${QT_LIBRARIES})