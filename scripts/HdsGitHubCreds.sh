#!/bin/bash
cd "$(dirname "$0")"

usageStr='Usage: HdsGitHubCreds.sh [set] <username>'

name=$1



if [ "$name" == "" ]; then
    echo $usageStr
    exit 1
fi


if [ "$name" == "set" ]; then

    name=$2
    if [ "$name" == "" ]; then
        echo $usageStr
        exit 1
    fi

    gname="hds_git_token_$name"

    echo "Enter personal access token"
    ./HdsSetGenericPassword.sh $gname
    
fi


gname="hds_git_token_$name"

echo "" | git credential-osxkeychain erase

pass=$(security find-generic-password -s $gname -w)

cat << EOF | git credential-osxkeychain store
protocol=https
host=github.com
username=$name
password=$pass
EOF

cat << EOF > ~/.config/gh/hosts.yml
github.com:
    oauth_token: $pass
    user: $name
    git_protocol: https
EOF

gh auth status

if [ "$?" != "0" ]; then
    echo "Auth status failed. Token may need to be updated. Try running:"
    echo "HdsGitHubCreds.sh set $name"
    exit 1
fi