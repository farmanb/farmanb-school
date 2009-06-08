find_package(Qt4)

cmake_dependent_option(BUILD_QT_APP "Build Qt Application?" ON "QT4_FOUND" OFF)
