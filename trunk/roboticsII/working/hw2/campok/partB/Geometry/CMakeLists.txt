set (GEOMETRY_FILES
hw2-b_ground-campok.pdat
hw2-b_part-campok.pdat
hw2-b_finger-campok.pdat
hw2-b_pedestal1-campok.pdat
hw2-b_pedestal2-campok.pdat
hw2-b_pedestal3-campok.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
