#!/bin/bash

PORT=$1

if [ "$PORT" == "" ]; then
    echo 'first arg must be a port number'
    exit 1
fi

result=$(sudo lsof -i -P | grep LISTEN | grep $1)

lPid=$(echo $result | tr -s ' ' "\n" | sed -n '2p')

echo "PID=$lPid"
echo $result

sudo lsof -p $lPid | grep cwd