#!/usr/bin/env pwsh
param(
    [string]$src=$(throw "-src required")
)
$ErrorActionPreference="Stop"
$dir=$src.Replace('.','_')+'_'
pkgutil --expand "$src" "$dir"
if($?){
    Write-Host "Expanded to $dir"  -ForegroundColor Cyan
}else{
    mv $src $dir
    if($?){
        Write-Host "Renamed $src to $dir" -ForegroundColor Cyan
    }else{
        throw "Failed to rename $src to $dir"
    }

}

cd "$dir"
if(Test-Path "Payload"){
    tar xvf Payload
    if($?){
        Write-Host "Extracted Payload" -ForegroundColor DarkGreen
    }else{
        throw "Extract Payload failed"
    }
}else{
    Write-Host "No Payload found. Check for sub packages" -ForegroundColor DarkYellow
}