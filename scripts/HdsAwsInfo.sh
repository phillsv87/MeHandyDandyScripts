#!/bin/bash
set -e

if [ "$1" == "" ]; then
    aws sts get-caller-identity
else
    aws sts get-caller-identity --profile "$1"
fi