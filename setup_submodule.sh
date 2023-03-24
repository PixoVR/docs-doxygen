#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

prefix() {
	cat - | perl -pe "s/^(.+)$/   \1/"
}

echo "Copying build.sh..."
cp -v setup_template/build.sh ../ | prefix
echo

echo "Copying env.sh... You must modify/update this file for your implementation."
cp -v setup_template/env_template.sh ../env.sh | prefix
echo

echo "Copying docker folder..."
cp -rv setup_template/docker ../ | prefix
echo

echo "Creating examples folder..."
cp -rv setup_template/examples ../ | prefix
echo

echo "Creating pages folder..."
cp -rv setup_template/pages ../ | prefix
echo

echo "Softlinking existing markdown files into pages... "
find ../.. -maxdepth 1 -name "*md" -exec ln -sv {} ../pages/ \; 2>&1 | prefix
echo


