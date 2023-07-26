#!/bin/bash

INFILE=$1

if [[ "$INFILE" == "" ]]; then
	exit 0
fi

FILENAME=`basename $INFILE`
PAGENAME=`echo $FILENAME | perl -pe "s/[^\w]/_/"`
TITLE="Unknown File"

if [[ "$INFILE" =~ ^.*\.uplugin$ ]]; then

	TITLE="The .uplugin File"

elif [[ "$INFILE" =~ ^.*\.uproject$ ]]; then

	TITLE="The .uroject File"

else
	cat $INFILE && exit 0
fi

#echo "\\page $PAGENAME $TITLE"
echo "\\page $PAGENAME $FILENAME"
#echo "## $FILENAME"
echo "\\code{.xml}"
cat $INFILE
echo "\\endcode"

