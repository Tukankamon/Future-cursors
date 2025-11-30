#!/bin/bash

ROOT_UID=0
DEST_DIR=
COLOR="cyan" # Default color

if [ -n "$1" ]; then
    COLOR="$1"
fi

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/usr/share/icons"
else
  DEST_DIR="$HOME/.local/share/icons"
fi

if [ -d "$DEST_DIR/Future-cursors" ]; then
  rm -r "$DEST_DIR/Future-cursors"
fi

cp -pr dist/$COLOR $DEST_DIR/Future-cursors

echo "Finished..."

