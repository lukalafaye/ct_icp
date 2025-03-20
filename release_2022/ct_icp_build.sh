#!/bin/bash

BUILD_TYPE=$1
GENERATOR=$2
WITH_PYTHON_BINDING=$3
WITH_VIZ=$4

if [ -z "$BUILD_TYPE" ]
then
	BUILD_TYPE="Release"
fi

if [ -z "$GENERATOR" ]
then
	GENERATOR="Unix Makefiles"
fi

if [ -z "$WITH_PYTHON_BINDING" ]
then
	WITH_PYTHON_BINDING=ON
fi

if [ -z "$WITH_VIZ" ]
then
	WITH_VIZ=ON
fi


sudo apt-get install libxcursor-dev
sudo apt-get install libxinerama-dev
sudo apt-get install libxi-dev
sudo apt-get install libgtest-dev
sudo apt install libstdc++-7-dev
sudo apt install libomp5 libomp-dev
sudo apt-get install clang-9
sudo apt install libgflags-dev libunwind-dev

# Setting variables
SRC_DIR=$(pwd)
EXT_SRC_DIR="${SRC_DIR}/external"
BUILD_DIR="${SRC_DIR}/cmake-build-${BUILD_TYPE}"
EXT_BUILD_DIR=$BUILD_DIR/external
CC=gcc-9 CXX=g++-9

mkdir $BUILD_DIR
mkdir $EXT_BUILD_DIR


check_status_code() {
   if [ $1 -ne 0 ]
   then
	echo "[CT_ICP] Failure. Exiting."
	exit 1
   fi
}

echo "[CT_ICP] -- [EXTERNAL DEPENDENCIES] -- Generating the cmake project"
cd ${EXT_BUILD_DIR}
cmake -G "$GENERATOR" -S $EXT_SRC_DIR -DCMAKE_BUILD_TYPE=${BUILD_TYPE} -DWITH_VIZ3D=$WITH_VIZ
check_status_code $?

echo "[CT_ICP] -- [EXTERNAL DEPENDENCIES] -- building CMake Project"
cmake --build . --config $BUILD_TYPE
check_status_code $?



echo "[CT_ICP] -- [MAIN PROJECT] -- Generating the cmake project"
cd $BUILD_DIR
cmake -G "$GENERATOR" -S $SRC_DIR -DCMAKE_BUILD_TYPE=${BUILD_TYPE}  -DWITH_VIZ3D=$WITH_VIZ -DWITH_PYTHON_BINDING=${WITH_PYTHON_BINDING}
check_status_code $?

echo "[CT_ICP] -- [MAIN PROJECT] -- Building the CMake Project"
cmake --build . --config $BUILD_TYPE --target install --parallel 6
check_status_code $?

