#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

git clone https://github.com/doxygen/doxygen.git
cd doxygen

mkdir build
cd build
cmake -G "Unix Makefiles" ..
make

# print version
#./bin/doxygen -v

chmod 755 scripts/* 

