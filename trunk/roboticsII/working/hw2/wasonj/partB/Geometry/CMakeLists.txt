set (GEOMETRY_FILES
hw2-b_ground-wasonj.pdat
hw2-b_part-wasonj.pdat
hw2-b_finger-wasonj.pdat
hw2-b_pedestal1-wasonj.pdat
hw2-b_pedestal2-wasonj.pdat
hw2-b_pedestal3-wasonj.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
