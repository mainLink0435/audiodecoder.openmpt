cmake_minimum_required(VERSION 3.10)
project(audiodecoder.openmpt)

# 1. Define the include paths
include_directories(${KODI_INCLUDE_DIR})
include_directories(${OPENMPT_INCLUDE_DIR})

# 2. Identify the source files
set(SOURCES src/OpenMptCodec.cpp)

# 3. Create the shared library
add_library(${PROJECT_NAME} SHARED ${SOURCES})
set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "")

# 4. Explicitly link the OpenMPT library and system math/zlib
# This uses the exact path passed from tasks.json
target_link_libraries(${PROJECT_NAME} ${OPENMPT_LIBRARY} m)

# 5. Set the RPATH so it finds the library in the same folder
set_target_properties(${PROJECT_NAME} PROPERTIES 
                       LINK_FLAGS "-Wl,-rpath,'$ORIGIN'")