set (GEOMETRY_FILES
hw2-b_ground-huntd2.pdat
hw2-b_part-huntd2.pdat
hw2-b_finger-huntd2.pdat
hw2-b_pedestal1-huntd2.pdat
hw2-b_pedestal2-huntd2.pdat
hw2-b_pedestal3-huntd2.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
