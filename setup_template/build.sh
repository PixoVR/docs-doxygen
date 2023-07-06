#!/bin/bash

# cd into the doxygen directory (so we know where everything else is)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/docs-doxygen

# get the env into this shell
source ../env.sh

# clear out any previous build
rm -rf ../html

# actually do the build
doxygen Doxyfile


