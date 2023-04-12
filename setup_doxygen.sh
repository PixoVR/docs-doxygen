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
make
#make -j		# unstable on some configurations!

#ln -s $PWD/bin/doxygen /usr/local/bin/doxygen
cp bin/doxygen /usr/local/bin/doxygen

cd $DIR

# delete build folder
rm -rf doxygen

echo "Doxygen version: `doxygen -v`"

# because windows fileshares don't always keep permissions
chmod 755 scripts/* 

# nginx
#cp nginx.conf /etc/nginx/		# copied in docs-doxygen/Dockerfile.  Don't copy it here.
#rm /etc/nginx/conf.d/default.conf	# done in Dockerfile

