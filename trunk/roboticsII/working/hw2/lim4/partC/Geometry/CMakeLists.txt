set (GEOMETRY_FILES
hw2-c_ground-lim4.pdat
hw2-c_part-lim4.pdat
hw2-c_finger-lim4.pdat
hw2-c_pedestel1-lim4.pdat
hw2-c_pedestel2-lim4.pdat
hw2-c_pedestel3-lim4.pdat
hw2-c_ball-lim4.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
