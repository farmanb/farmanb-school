set (GEOMETRY_FILES
hw2_ground.pdat
hw2-b_part.pdat
hw2-b_finger.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})