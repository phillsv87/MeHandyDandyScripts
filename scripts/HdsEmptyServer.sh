#!/bin/bash

name=$1
port=$2

if [ "$name" == "" ]; then
    name='hds-empty-server'
fi


if [ "$port" == "" ]; then
    port='5571'
fi



mkdir -p /tmp/empty-server
cd /tmp/empty-server
touch index.html
serve -s -p $port . &
ngrok http --subdomain $name $port

kill %