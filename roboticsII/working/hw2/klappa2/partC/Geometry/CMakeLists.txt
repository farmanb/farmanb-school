set (GEOMETRY_FILES
hw2-c_ground-klappa2.pdat
hw2-c_part-klappa2.pdat
hw2-c_finger-klappa2.pdat
hw2-c_pedestel1-klappa2.pdat
hw2-c_pedestel2-klappa2.pdat
hw2-c_pedestel3-klappa2.pdat
hw2-c_ball-klappa2.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
