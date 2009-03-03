set(APP_EXE_NAME test)

set(SRCS
  main.cpp)

set(HEADERS
  )

add_executable(${APP_EXE_NAME} ${SRCS} ${HEADERS})

install(TARGETS ${APP_EXE_NAME} 
  DESTINATION ${TEST_INSTALL_BIN_DIR})