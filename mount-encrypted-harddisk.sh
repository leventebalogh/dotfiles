#!/bin/bash

VOLUME_PATH=$1
ENCFS="/usr/local/bin/encfs"
ENCDIR="$VOLUME_PATH/Private"
DECDIR="$HOME/PrivateHarddisk"

security find-generic-password -ga encfs 2>&1 >/dev/null | cut -d'"' -f2 | "$ENCFS" -S "$ENCDIR" "$DECDIR"
