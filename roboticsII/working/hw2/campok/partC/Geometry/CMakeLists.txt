set (GEOMETRY_FILES
hw2-c_ground-campok.pdat
hw2-c_part-campok.pdat
hw2-c_finger-campok.pdat
hw2-c_pedestel1-campok.pdat
hw2-c_pedestel2-campok.pdat
hw2-c_pedestel3-campok.pdat
hw2-c_ball-campok.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
