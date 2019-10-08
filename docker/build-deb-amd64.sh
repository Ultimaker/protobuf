#!/bin/sh
#
# This scripts uses CMake to build protobuf with shared libraries targeting
# Linux x64. It also creates a debian package with cpack. The contents of the
# package are installed under "/usr".
#

mkdir build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -Dprotobuf_BUILD_SHARED_LIBS=OFF \
    -Dprotobuf_BUILD_TESTS=OFF \
    -Dprotobuf_BUILD_EXAMPLES=OFF \
    -Dprotobuf_WITH_ZLIB=OFF \
    ../cmake
make
cpack \
    --config ../cmake/cpack_config_deb_amd64.cmake \
    -D CPACK_INSTALL_CMAKE_PROJECTS="$(pwd);protobuf;ALL;/"
