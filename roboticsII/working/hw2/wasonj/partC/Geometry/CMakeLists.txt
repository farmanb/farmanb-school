set (GEOMETRY_FILES
hw2-c_ground-wasonj.pdat
hw2-c_part-wasonj.pdat
hw2-c_finger-wasonj.pdat
hw2-c_pedestel1-wasonj.pdat
hw2-c_pedestel2-wasonj.pdat
hw2-c_pedestel3-wasonj.pdat
hw2-c_ball-wasonj.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
