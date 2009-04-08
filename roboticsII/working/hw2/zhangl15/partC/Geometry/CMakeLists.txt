set (GEOMETRY_FILES
hw2-c_ground-zhangl15.pdat
hw2-c_part-zhangl15.pdat
hw2-c_finger-zhangl15.pdat
hw2-c_pedestel1-zhangl15.pdat
hw2-c_pedestel2-zhangl15.pdat
hw2-c_pedestel3-zhangl15.pdat
hw2-c_ball-zhangl15.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
