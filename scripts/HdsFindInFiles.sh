#!/bin/bash
set -e

TXT=$1
EXT=$2

if [ "$EXT" == "" ]; then
    grep -r --exclude-dir "node_modules" $TXT .
else
    grep -r --include $EXT --exclude-dir "node_modules" $TXT .
fi

