#!/bin/bash

export PROJECT_NAME='Name of project'					# should be short enough to fit on the documentation page
export PROJECT_VERSION=`git tag | tail -n 1`				# the last tagged version
export PROJECT_BRIEF='Documentation for the Xyzproject C++ Library'	# a brief description of the SDK or module
export PROJECT_LOGO='doxygen-custom/defaultIcon.png'			# an icon for the submodule, or 'doxygen-custom/defaultIcon.png'.  Path is relative to `docs-doxygen` folder.
export PROJECT_REPO='https://github.com/PixoVR/somerepo'		# the project repo url, for cloning
export PROJECT_URL='/SomeSDK-Target'					# subfolder used for documentation: 'https://docs.pixovr.com/SomeSDK-Target', like 'ApexSDK-Unreal'
export DEV_PROJECT_URL='../../../../Unreal/SomeSDK-Target/documentation/html/index.html'	# a url for local development, which is used when `docs-root` is publishing on a local system via `DEV=true ./build.sh`
export PROJECT_MAIN_PAGE='../pages/README.md'				# the main home markdown page for the documentation

export DOXYGEN_FILTER='../scripts/XXX_filter.py'			# a script filter for interpreting the code (adds stuff like decorators or macros)
export DOXYGEN_INPUT='../../src "../../Folder With Spaces"'		# a list of input folders for documenting, which is a whitespace-separated list of (optionally) quoted paths.  The Doxyfile will already include "../pages" for you.  Paths are relative to the `docs-doxygen` folder.
export DOXYGEN_STRIP_FROM_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../Path/To/Base" && pwd)"	# the full absolute path to the root folder to be removed during publish.  This is kind of cosmetic but also less confusing.
export DOXYGEN_IGNORE_PREFIX=''						# a class/method prefix to be ignored.  For instance if everything is pApexSDK, mMatrix, etc, the ignore prefix may want to be "p\nm" where the list is a space-separated list of prefixes.

# user variables.  Useful when writing pages that refer to other urls, but don't want to hardcode them in.
export APEX_SERVER_URL='https://apex.pixovr.com'
