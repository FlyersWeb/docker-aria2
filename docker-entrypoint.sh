#!/bin/bash
set -e

if [ "$1" = 'aria2' ]; then
  exec gosu /usr/bin/aria2c --conf-path="/etc/aria2/aria2.conf"
fi

exec "$@"