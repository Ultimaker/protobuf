#!/bin/sh
#
# This scripts uses CMake to build protobuf with static libraries using MinGW
# W64 targeting Windows x64. It also creates a debian package with cpack. The
# contents of the package are installed under "/usr/x86_64-w64-mingw32".
#

mkdir build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SYSTEM_NAME="Windows" \
    -DCMAKE_FIND_ROOT_PATH=/usr/x86_64-w64-mingw32 \
    -DCMAKE_C_COMPILER=x86_64-w64-mingw32-gcc \
    -DCMAKE_CXX_COMPILER=x86_64-w64-mingw32-g++ \
    -Dprotobuf_BUILD_SHARED_LIBS=OFF \
    -Dprotobuf_BUILD_TESTS=OFF \
    -Dprotobuf_BUILD_EXAMPLES=OFF \
    -Dprotobuf_WITH_ZLIB=OFF \
    ../cmake
make
cpack \
    --config ../cmake/cpack_config_deb_mingw64.cmake \
    -D CPACK_INSTALL_CMAKE_PROJECTS="$(pwd);protobuf;ALL;/"
