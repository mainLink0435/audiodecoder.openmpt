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

# 4. Smart Linking Logic
# If we are building for Android, we add 'log' and link statically via the task.json path
if(ANDROID)
    # This tells the NDK to link the C++ library statically
    # It resolves the "missing symbol" error for std::string and other traits
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static-libstdc++")
    
    # We add 'log' for Android system logging and 'm' for math
    target_link_libraries(${PROJECT_NAME} ${OPENMPT_LIBRARY} m log)
else()
    # Standard Linux/CoreELEC logic remains unchanged
    target_link_libraries(${PROJECT_NAME} ${OPENMPT_LIBRARY} m)
    set_target_properties(${PROJECT_NAME} PROPERTIES 
                           LINK_FLAGS "-Wl,-rpath,'$ORIGIN'")
endif()