set (GEOMETRY_FILES
hw2-b_ground-klappa2.pdat
hw2-b_part-klappa2.pdat
hw2-b_finger-klappa2.pdat
hw2-b_pedestal1-klappa2.pdat
hw2-b_pedestal2-klappa2.pdat
hw2-b_pedestal3-klappa2.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
