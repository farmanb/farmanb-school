set (GEOMETRY_FILES
hw2-b_ground-zhangl15.pdat
hw2-b_part-zhangl15.pdat
hw2-b_finger-zhangl15.pdat
hw2-b_pedestal1-zhangl15.pdat
hw2-b_pedestal2-zhangl15.pdat
hw2-b_pedestal3-zhangl15.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
