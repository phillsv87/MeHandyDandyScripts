#!/bin/bash

pname=$1

read value

if [ "$pname" == "" ]; then
    echo "arg 1 must be password name"
    exit 1
fi

if [ "$value" == "" ]; then
    echo "Password should be supplied to to stdin"
    exit 1
fi

cat <<EOF | security -i > /dev/null 2>&1
delete-generic-password -a ${USER} -s $pname
add-generic-password -a ${USER} -s $pname -w '$value'
EOF

