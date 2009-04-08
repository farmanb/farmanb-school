set (GEOMETRY_FILES
hw2-a_part-zhangl15.pdat
hw2-a_finger-zhangl15.pdat
hw2-a_ground-zhangl15.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
