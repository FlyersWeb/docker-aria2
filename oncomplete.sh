#!/bin/bash

# $1 is gid.
# $2 is the number of files.
# $3 is the path of the first file.

DOWNLOAD=/data # no trailing slash!
COMPLETE=/dataComplete # no trailing slash!
SRC=$3

while true; do
  DIR=`dirname "$SRC"`
  if [ "$DIR" == "$DOWNLOAD" ]; then
    echo `date` "INFO " "$3" moved to "$COMPLETE".
    if [ -n "$FUID" ] && [ -n "$FGID" ]; then
      chown $FUID.$FGID -R "$SRC"
    fi
    mv "$SRC" "$COMPLETE"
    exit $?
  elif [ "$DIR" == "/" -o "$DIR" == "." ]; then
    echo `date` ERROR "$3" not under "$DOWNLOAD".
    exit 1
  else
    SRC=$DIR
  fi
done
