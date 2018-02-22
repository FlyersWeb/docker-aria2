#!/bin/bash

# $1 is gid.
# $2 is the number of files.
# $3 is the path of the first file.

DOWNLOAD=/data # no trailing slash!
COMPLETE=/dataComplete # no trailing slash!
ITEMNB=$2
SRC=$3

DIR=`dirname "$SRC"`
if [ "$ITEMNB" == 0 ]; then
  echo `date` INFO no item SAVED.
elif [ "$DIR" == "$DOWNLOAD" ]; then
  if [ -n "$FUID" ] && [ -n "$FGID" ]; then
    chown $FUID.$FGID -R "$SRC"
  fi
  mv "$SRC" "$COMPLETE"
  echo `date` INFO "$3" moved to "$COMPLETE".
fi
exit 0
