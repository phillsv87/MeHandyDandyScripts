#!/usr/bin/env pwsh

param(
    [string]$src=$(throw '-src required'),
    [string]$dest,
    [int]$crf=28
)

if(!$dest){
    $i=$src.LastIndexOf('.')
    if($i -eq -1){
        throw "-dest required"
    }
    $dest=$src.Substring(0,$i)+'(Compressed)'+$src.Substring($i)
}

Write-Host "$src -> $dest"

ffmpeg -i $src -crf $crf $dest