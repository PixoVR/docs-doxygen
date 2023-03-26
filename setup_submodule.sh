#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

prefix() {
	cat - | perl -pe "s/^(.+)$/   \1/"
}

if [ -f "../.gitignore" ]; then
	echo "Skipping existing .gitignore..."
else
	echo "Copying .gitignore..."
	cp -v setup_template/.gitignore ../ | prefix

if [ -f "../build.sh" ]; then
	echo "Skipping existing build.sh..."
else
	echo "Copying build.sh..."
	cp -v setup_template/build.sh ../ | prefix
fi

if [ -f "../env.sh" ]; then
	echo "Skipping existing env.sh..."
else
	echo "Copying env.sh... You must modify/update this file for your implementation."
	cp -v setup_template/env_template.sh ../env.sh | prefix
fi

if [ -d "../docker" ]; then
	echo "Skipping existing docker/ folder..."
else
	echo "Copying docker folder..."
	cp -rv setup_template/docker ../ | prefix
fi

if [ -d "../examples" ]; then
	echo "Skipping existing examples/ folder..."
else
	echo "Creating examples folder..."
	cp -rv setup_template/examples ../ | prefix
fi

if [ -d "../pages" ]; then
	echo "Skipping existing pages/ folder..."
else
	echo "Creating pages folder..."
	cp -rv setup_template/pages ../ | prefix
	echo

	echo "Softlinking existing markdown files into pages... "
	find ../.. -maxdepth 1 -name "*md" -exec ln -sv {} ../pages/ \; 2>&1 | prefix
fi



