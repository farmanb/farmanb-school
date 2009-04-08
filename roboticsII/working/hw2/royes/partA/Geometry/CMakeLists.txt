set (GEOMETRY_FILES
hw2-a_part-royes.pdat
hw2-a_finger-royes.pdat
hw2-a_ground-royes.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
