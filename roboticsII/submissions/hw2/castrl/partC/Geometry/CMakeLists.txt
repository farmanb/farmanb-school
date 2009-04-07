set (GEOMETRY_FILES
hw2-c_ground.pdat
hw2-c_part.pdat
hw2-c_finger.pdat
hw2-c_pedestel1.pdat
hw2-c_pedestel2.pdat
hw2-c_pedestel3.pdat
hw2-c_ball.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})