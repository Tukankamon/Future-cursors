#!/usr/bin/env bash
#!/bin/bash

function create {

	BUILD="$PWD"/dist/$COLOR
	OUTPUT="$BUILD"/cursors
	ALIASES="$SRC"/cursorList

	cd "$SRC/svg-$COLOR"
	mkdir -p x1 x1_25 x1_5 x2

	find . -name "*.svg" -type f -exec sh -c 'inkscape -o "x1/${0%.svg}.png" -w 32 -h 32 $0' {} \;
	find . -name "*.svg" -type f -exec sh -c 'inkscape -o "x1_25/${0%.svg}.png" -w 40 -w 40 $0' {} \;
	find . -name "*.svg" -type f -exec sh -c 'inkscape -o "x1_5/${0%.svg}.png" -w 48 -w 48 $0' {} \;
	find . -name "*.svg" -type f -exec sh -c 'inkscape -o "x2/${0%.svg}.png" -w 64 -w 64 $0' {} \;

	# generate cursors

	if [ ! -d "$BUILD" ]; then
		mkdir "$BUILD"
	fi
	if [ ! -d "$OUTPUT" ]; then
		mkdir "$OUTPUT"
	fi

	echo -ne "Generating cursor theme...\\r"
	for CUR in ./../config/*.cursor; do
		BASENAME="$CUR"
		BASENAME="${BASENAME##*/}"
		BASENAME="${BASENAME%.*}"
		
		xcursorgen "$CUR" "$OUTPUT/$BASENAME"
	done
	echo -e "Generating cursor theme... DONE"


    # generate aliases
    cd "$OUTPUT" # dist/$COLOR/cursors

    echo -ne "Generating shortcuts...\\r"
	    while read ALIAS; do
		    FROM="${ALIAS#* }"
		    TO="${ALIAS% *}"

		    if [ -e $TO ]; then
			    continue
		    fi
		    ln -sr "$FROM" "$TO"
	    done < "$ALIASES"

	echo -e "Generating shortcuts... DONE"

	cd "$PWD"

	echo -ne "Generating Theme Index...\\r"
	INDEX="$OUTPUT/../index.theme"
	if [ ! -e "$OUTPUT/../$INDEX" ]; then
		touch "$INDEX"
		echo -e "[Icon Theme]\nName=$THEME\n" > "$INDEX"
	fi
	echo -e "Generating Theme Index... DONE"
}

# Default color
COLOR="cyan"

if [ -n "$1" ]; then
    COLOR="$1"
fi
#
# generate pixmaps from svg source
SRC=$PWD/src
THEME="Future Cursors $COLOR"

# Only one can be created at a time
create "svg-$COLOR"
