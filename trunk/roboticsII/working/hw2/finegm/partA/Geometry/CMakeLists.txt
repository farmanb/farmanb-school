set (GEOMETRY_FILES
hw2-a_part-finegm.pdat
hw2-a_finger-finegm.pdat
hw2-a_ground-finegm.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
