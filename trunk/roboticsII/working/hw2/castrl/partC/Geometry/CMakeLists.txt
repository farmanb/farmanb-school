set (GEOMETRY_FILES
hw2-c_ground-castrl.pdat
hw2-c_part-castrl.pdat
hw2-c_finger-castrl.pdat
hw2-c_pedestel1-castrl.pdat
hw2-c_pedestel2-castrl.pdat
hw2-c_pedestel3-castrl.pdat
hw2-c_ball-castrl.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
