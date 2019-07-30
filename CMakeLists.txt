
cmake_minimum_required(VERSION 3.0)
project(nmssh VERSION 2.3.1)

INCLUDE(FindPkgConfig)

# This function will find and set up a pkg-config based module.
# If a pc-file was found, it will resolve library paths to
# absolute paths. Furthermore, the function will automatically
# fall back to use static libraries in case no dynamic libraries
# were found.
FUNCTION(FIND_PKGLIBRARIES prefix package)
	PKG_CHECK_MODULES(${prefix} ${package})
	IF(NOT ${prefix}_FOUND)
		RETURN()
	ENDIF()

	FOREACH(LIBRARY ${${prefix}_LIBRARIES})
		FIND_LIBRARY(${LIBRARY}_RESOLVED ${LIBRARY} PATHS ${${prefix}_LIBRARY_DIRS})
		IF(${${LIBRARY}_RESOLVED} STREQUAL "${LIBRARY}_RESOLVED-NOTFOUND")
			MESSAGE(FATAL_ERROR "could not resolve ${LIBRARY}")
		ENDIF()
		LIST(APPEND RESOLVED_LIBRARIES ${${LIBRARY}_RESOLVED})
	ENDFOREACH(LIBRARY)

	SET(${prefix}_FOUND 1 PARENT_SCOPE)
	SET(${prefix}_LIBRARIES ${RESOLVED_LIBRARIES} PARENT_SCOPE)
	SET(${prefix}_INCLUDE_DIRS ${${prefix}_INCLUDE_DIRS} PARENT_SCOPE)
	SET(${prefix}_LDFLAGS ${${prefix}_LDFLAGS} PARENT_SCOPE)

	MESSAGE(STATUS "  Resolved libraries: ${RESOLVED_LIBRARIES}")
ENDFUNCTION()

FIND_PKGLIBRARIES(LIBSSH2 libssh2)

if (NOT LIBSSH2_FOUND)
	MESSAGE(STATUS "LIBSSH2 not found. Set CMAKE_PREFIX_PATH if it is installed outside of the default search path.")
ENDIF()

add_subdirectory(NMSSH)

# create Config.cmake
configure_file(config.cmake.in "${CMAKE_BINARY_DIR}/${PROJECT_NAME}Config.cmake" @ONLY)

# create ConfigVersion.cmake
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
	"${CMAKE_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
	VERSION ${PROJECT_VERSION}
	COMPATIBILITY AnyNewerVersion)

# install the *Config.cmake and *ConfigVersion.cmake
install(FILES
	"${CMAKE_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
	"${CMAKE_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
	DESTINATION lib/cmake/${PROJECT_NAME}
)
