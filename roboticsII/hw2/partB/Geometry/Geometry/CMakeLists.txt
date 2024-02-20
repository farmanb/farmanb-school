set (GEOMETRY_FILES
hw2_grip10.pdat
hw2_grip20.pdat
hw2_grip3.pdat
hw2_grip30.pdat
hw2_grip5.pdat
hw2_ground.pdat
hw2_part.pdat
hw2_finger.pdat
hw2_palm.pdat)

foreach(file ${GEOMETRY_FILES})
  configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${file}" "${DVC_DATA_DIR}/Geometry/${file}")
endforeach(file ${GEOMETRY_FILES}})