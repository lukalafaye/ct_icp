macro(SLAM_COMPILER_FLAGS)
    # Compilation / Build Setup
    if (NOT CMAKE_BUILD_TYPE)
        set(CMAKE_BUILD_TYPE Release)
    endif ()
    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
    set(CMAKE_POSITION_INDEPENDENT_CODE ON)
endmacro(SLAM_COMPILER_FLAGS)