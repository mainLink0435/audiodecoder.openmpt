cmake_minimum_required(VERSION 3.5)
project(audiodecoder.openmpt)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_SOURCE_DIR})

find_package(Kodi REQUIRED)
find_package(ZLIB REQUIRED)

get_filename_component(STATIC_LIBOPENMPT_PATH "${PROJECT_SOURCE_DIR}/../openmpt" ABSOLUTE)

include_directories(${ZLIB_INCLUDE_DIR}
                    ${KODI_INCLUDE_DIR}/..
                    ${STATIC_LIBOPENMPT_PATH}
                    ${STATIC_LIBOPENMPT_PATH}/libopenmpt
                    ${STATIC_LIBOPENMPT_PATH}/include)

set(OPENMPT_SOURCES src/OpenMptCodec.cpp)
set(OPENMPT_HEADERS src/OpenMptCodec.h)

# Detect architecture for linking the right libraries
if(CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64")
    set(LIB_ARCH "aarch64-linux-gnu")
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64")
    set(LIB_ARCH "x86_64-linux-gnu")
else()
    set(LIB_ARCH "${CMAKE_SYSTEM_PROCESSOR}-linux-gnu")
endif()

set(DEPLIBS ${STATIC_LIBOPENMPT_PATH}/bin/libopenmpt.a ${ZLIB_LIBRARIES} -lmpg123 /usr/lib/${LIB_ARCH}/libogg.a /usr/lib/${LIB_ARCH}/libvorbis.a /usr/lib/${LIB_ARCH}/libvorbisfile.a -lstdc++ -lm)

# Set RPATH so the .so can find bundled libraries in the addon directory
set(CMAKE_BUILD_RPATH_USE_ORIGIN ON)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH ON)

build_addon(audiodecoder.openmpt OPENMPT DEPLIBS)

include(CPack)
