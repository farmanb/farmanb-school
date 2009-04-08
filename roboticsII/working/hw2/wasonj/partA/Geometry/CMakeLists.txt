set (GEOMETRY_FILES
hw2-a_part-wasonj.pdat
hw2-a_finger-wasonj.pdat
hw2-a_ground-wasonj.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})
