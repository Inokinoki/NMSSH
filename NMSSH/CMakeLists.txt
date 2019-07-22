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

set(nmssh_HEADERS
	${CMAKE_CURRENT_SOURCE_DIR}/NMSSHSession.h
	${CMAKE_CURRENT_SOURCE_DIR}/NMSSHChannel.h
	${CMAKE_CURRENT_SOURCE_DIR}/NMSFTP.h
	${CMAKE_CURRENT_SOURCE_DIR}/NMSFTPFile.h
	${CMAKE_CURRENT_SOURCE_DIR}/NMSSHConfig.h
	${CMAKE_CURRENT_SOURCE_DIR}/NMSSHHostConfig.h
        ${CMAKE_CURRENT_SOURCE_DIR}/Config/NMSSHLogger.h
        ${CMAKE_CURRENT_SOURCE_DIR}/Protocols/NMSSHSessionDelegate.h
	${CMAKE_CURRENT_SOURCE_DIR}/Protocols/NMSSHChannelDelegate.h
)

add_library(nmssh ${nmssh_SRCS})
set_target_properties(nmssh PROPERTIES PUBLIC_HEADER "${nmssh_HEADERS}")

target_include_directories(nmssh PUBLIC 	
	${CMAKE_CURRENT_SOURCE_DIR}
	${CMAKE_CURRENT_SOURCE_DIR}/Config
	${CMAKE_CURRENT_SOURCE_DIR}/Protocols
	${LIBSSH2_INCLUDE_DIRS}
)

target_link_libraries(nmssh ${LIBSSH2_LIBRARIES}
	"-framework CoreFoundation"
	"-framework CoreServices"
	"-framework Foundation"
)

add_definitions(-fobjc-arc)

install(TARGETS nmssh
	ARCHIVE DESTINATION lib
	LIBRARY DESTINATION lib
	PUBLIC_HEADER DESTINATION include
)
