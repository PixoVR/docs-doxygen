#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

# exit on errors
set -e

git clone --recurse-submodules https://github.com/doxygen/doxygen.git
cd doxygen

mkdir build
cd build
cmake -G "Unix Makefiles" ..
#make
make -j

# print version
./bin/doxygen -v

cd $DIR

chmod 755 scripts/* 

