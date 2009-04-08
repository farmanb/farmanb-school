set (GEOMETRY_FILES
hw2-c_ground-royes.pdat
hw2-c_part-royes.pdat
hw2-c_finger-royes.pdat
hw2-c_pedestel1-royes.pdat
hw2-c_pedestel2-royes.pdat
hw2-c_pedestel3-royes.pdat
hw2-c_ball-royes.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
