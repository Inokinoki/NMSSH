project(nmssh)

set(nmssh_SRCS
	NMSFTP.m
	NMSFTPFile.m
	NMSSHChannel.m
	NMSSHConfig.m
	NMSSHHostConfig.m
	NMSSHSession.m
	${CMAKE_CURRENT_SOURCE_DIR}/Config/socket_helper.m
	${CMAKE_CURRENT_SOURCE_DIR}/Config/NMSSHLogger.m
)

add_library(nmssh ${nmssh_SRCS})

target_include_directories(nmssh PUBLIC 	
	${CMAKE_CURRENT_SOURCE_DIR}
	${CMAKE_CURRENT_SOURCE_DIR}/Config
	${CMAKE_CURRENT_SOURCE_DIR}/Protocols
	${LIBSSH2_INCLUDE_DIRS}
)

target_link_libraries(nmssh ${LIBSSH2_LIBRARIES})
