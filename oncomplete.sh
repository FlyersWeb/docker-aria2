#!/bin/bash

# $1 is gid.
# $2 is the number of files.
# $3 is the path of the first file.

DOWNLOAD=/data # no trailing slash!
COMPLETE=/dataComplete # no trailing slash!
SRC=$3

while true; do
  DIR=`dirname "$SRC"`
  if [ $2 == 0 ]; then
    echo `date` INFO "$1" no file to copy.
    exit 0
  fi
  if [ "$DIR" == "$DOWNLOAD" ]; then
    if [ -n "$FUID" ] && [ -n "$FGID" ]; then
      chown $FUID.$FGID -R "$SRC"
    fi
    mv "$SRC" "$COMPLETE"
    echo `date` "INFO " "$3" moved to "$COMPLETE".
    exit $?
  elif [ "$DIR" == "/" -o "$DIR" == "." ]; then
    echo `date` ERROR "$3" not under "$DOWNLOAD".
    exit 1
  else
    SRC=$DIR
  fi
done
