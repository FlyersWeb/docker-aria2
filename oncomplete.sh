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
else
  cp -r "$SRC" "$COMPLETE"
  echo `date` INFO "$3" moved to "$COMPLETE".
  if [ -n "$FUID" ] && [ -n "$FGID" ]; then
    chown -R $FUID.$FGID -R "$SRC"
    echo `date` INFO "$3" rights changed.
  fi
fi
exit 0
