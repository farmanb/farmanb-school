set (GEOMETRY_FILES
hw2-b_ground-castrl.pdat
hw2-b_part-castrl.pdat
hw2-b_finger-castrl.pdat
hw2-b_pedestal1-castrl.pdat
hw2-b_pedestal2-castrl.pdat
hw2-b_pedestal3-castrl.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
