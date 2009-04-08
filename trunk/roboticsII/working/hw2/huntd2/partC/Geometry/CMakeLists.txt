set (GEOMETRY_FILES
hw2-c_ground-huntd2.pdat
hw2-c_part-huntd2.pdat
hw2-c_finger-huntd2.pdat
hw2-c_pedestel1-huntd2.pdat
hw2-c_pedestel2-huntd2.pdat
hw2-c_pedestel3-huntd2.pdat
hw2-c_ball-huntd2.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
