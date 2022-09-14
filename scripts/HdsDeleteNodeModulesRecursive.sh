#!/bin/bash
set -e

find . -name node_modules -exec echo "delete {}" \; -exec rm -rf "{}" \;