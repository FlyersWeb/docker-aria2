#!/bin/bash

# $1 is gid.
# $2 is the number of files.
# $3 is the path of the first file.

DOWNLOAD=/data # no trailing slash!
COMPLETE=/dataComplete # no trailing slash!
ITEMNB=$2
SRC=$3

if [ "$ITEMNB" == 0 ]; then
  echo `date` INFO no item SAVED.
  exit 0
fi

while true; do
  DIR=`dirname "$SRC"`
  echo `date` DIR is "$DIR" and SRC is "$SRC"
  if [ "$DIR" == "$DOWNLOAD" ]; then
    if [ -n "$FUID" ] && [ -n "$FGID" ]; then
      chown -Rf $FUID.$FGID -R "$SRC"
      echo `date` INFO "$SRC" rights changed.
    fi
    mv -f "$SRC" "$COMPLETE"
    echo `date` INFO "$SRC" moved to "$COMPLETE".
    exit $?
  else
    SRC=$DIR
  fi
done
exit 0
