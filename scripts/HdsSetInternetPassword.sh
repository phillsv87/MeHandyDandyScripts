#!/bin/bash

type=$1

domain=$2

username=$3


read value

if [ "$type" == "" ]; then
    echo "arg 1 must be type (git,... )"
    exit 1
fi

if [ "$domain" == "" ]; then
    echo "arg 2 must be a domain"
    exit 1
fi

if [ "$username" == "" ]; then
    echo "arg 3 must be a username"
    exit 1
fi

if [ "$value" == "" ]; then
    echo "Password should be supplied to to stdin"
    exit 1
fi

if [ "$type" == "git" ]; then
    type='/Library/Developer/CommandLineTools/usr/libexec/git-core/git-credential-osxkeychain'
else
    echo "Invalid type $type"
    exit 1
fi

#git-credential-osxkeychain
cat <<EOF | security -i > /dev/null 2>&1
delete-internet-password -a $username -s $domain
add-internet-password -a $username -s $domain -r http -T '/usr/bin/security' -T '$type' -w  '$value'
EOF

