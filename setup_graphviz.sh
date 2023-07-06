#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

# exit on errors
set -e

#wget https://gitlab.com/api/v4/projects/4207231/packages/generic/graphviz-releases/8.0.5/graphviz-8.0.5.tar.gz
#tar -zxf graphviz-8.0.5.tar.gz

git clone --recurse-submodules https://github.com/graphviz/graphviz.git

cd graphviz
./configure
make -j 8
make install

cd $DIR

# cleanup
rm -rv graphviz

dot -V


