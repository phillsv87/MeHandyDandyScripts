#!/usr/local/bin/pwsh
param(
    $path='.'
)

$script="$PSScriptRoot/../../docker-ls/ls-image-content.sh"
if(!(Test-Path $script)){
    throw "clone the docker-ls project to the parent directoty of the HDS project to continue - git clone https://github.com/phillsv87/docker-ls.git"
}

&"$script" "$path"