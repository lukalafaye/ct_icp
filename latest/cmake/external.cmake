# Define External Dependencies
list(APPEND EXTERNAL_DEPENDENCIES Eigen3::Eigen Ceres::ceres glog::glog
        tsl::robin_map yaml-cpp colormap::colormap tinyply::tinyply)

# Add Viz3D and VTK if required
if (WITH_VIZ3D)
    list(APPEND EXTERNAL_DEPENDENCIES viz3d VTK::FiltersCore)
endif ()

# Check if the dependencies are valid targets
SLAM_CHECK_TARGETS(${EXTERNAL_DEPENDENCIES})

# --- Set the MANUALLY RPATH to link the dependencies to the executable
# Iterate through each external dependency
foreach (target ${EXTERNAL_DEPENDENCIES})
    # Only proceed if the target exists
    if (TARGET ${target})
        # Check if the target is an INTERFACE library using the `get_target_property` method
        get_target_property(target_type ${target} TYPE)
        
        # Proceed only if the target is not INTERFACE
        if (target_type STREQUAL "STATIC_LIBRARY" OR target_type STREQUAL "SHARED_LIBRARY")
            # Get the location of the target (IMPORTED_RELEASE_LOCATION)
            get_target_property(__LOCATION ${target} IMPORTED_RELEASE_LOCATION)

            # Check if the location was found
            if (NOT __LOCATION STREQUAL __LOCATION-NOTFOUND)
                # Extract the parent directory of the location
                get_filename_component(__PARENT_DIR ${__LOCATION} DIRECTORY)
                # Append the parent directory to the RPATH for linking
                set(EXTERNAL_DEPENDENCIES_INSTALL_RPATH ${EXTERNAL_DEPENDENCIES_INSTALL_RPATH}:${__PARENT_DIR})
                message(INFO "Found location for ${target}: ${__LOCATION}")
            endif ()
        endif ()
    endif ()
    # Clear variables for next iteration
    set(__PARENT_DIR "")
    set(__LOCATION "")
endforeach ()

# Append the final RPATH information to the install target
message(INFO " -- [CT-ICP] -- Appending to the INSTALL RPATH the RPATH to the external libraries: \n\t\t[${EXTERNAL_DEPENDENCIES_INSTALL_RPATH}]")

