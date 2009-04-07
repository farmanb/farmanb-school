set (GEOMETRY_FILES
hw2-b_ground.pdat
hw2-b_part.pdat
hw2-b_finger.pdat
hw2-b_pedestal1.pdat
hw2-b_pedestal2.pdat
hw2-b_pedestal3.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})