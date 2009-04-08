set (GEOMETRY_FILES
hw2-a_part-huntd2.pdat
hw2-a_finger-huntd2.pdat
hw2-a_ground-huntd2.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
