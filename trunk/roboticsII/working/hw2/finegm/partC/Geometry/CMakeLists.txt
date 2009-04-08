set (GEOMETRY_FILES
hw2-c_ground-finegm.pdat
hw2-c_part-finegm.pdat
hw2-c_finger-finegm.pdat
hw2-c_pedestel1-finegm.pdat
hw2-c_pedestel2-finegm.pdat
hw2-c_pedestel3-finegm.pdat
hw2-c_ball-finegm.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
