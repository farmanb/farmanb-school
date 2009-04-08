set (GEOMETRY_FILES
hw2-a_part-campok.pdat
hw2-a_finger-campok.pdat
hw2-a_ground-campok.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
