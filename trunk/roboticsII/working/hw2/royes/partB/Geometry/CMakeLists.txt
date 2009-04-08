set (GEOMETRY_FILES
hw2-b_ground-royes.pdat
hw2-b_part-royes.pdat
hw2-b_finger-royes.pdat
hw2-b_pedestal1-royes.pdat
hw2-b_pedestal2-royes.pdat
hw2-b_pedestal3-royes.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
