#!/usr/bin/env pwsh
param(
    [string]$src=$(throw "-src required"),
    [string]$dest
)

if(!$dest){
    $dest=$src.Replace('.gz','').Replace('.tar','')
}

mkdir -p $dest

tar -xvf $src -C $dest
