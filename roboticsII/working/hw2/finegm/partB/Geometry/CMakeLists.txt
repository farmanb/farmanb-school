set (GEOMETRY_FILES
hw2-b_ground-finegm.pdat
hw2-b_part-finegm.pdat
hw2-b_finger-finegm.pdat
hw2-b_pedestal1-finegm.pdat
hw2-b_pedestal2-finegm.pdat
hw2-b_pedestal3-finegm.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
