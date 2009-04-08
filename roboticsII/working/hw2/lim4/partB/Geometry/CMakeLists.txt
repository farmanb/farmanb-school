set (GEOMETRY_FILES
hw2-b_ground-lim4.pdat
hw2-b_part-lim4.pdat
hw2-b_finger-lim4.pdat
hw2-b_pedestal1-lim4.pdat
hw2-b_pedestal2-lim4.pdat
hw2-b_pedestal3-lim4.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
