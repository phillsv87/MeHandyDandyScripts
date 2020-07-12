#!/usr/local/bin/pwsh
param(
    [double]$low=0.1,
    [double]$high=1,
    [double]$value=-1,
    [string]$display
)
$ErrorActionPreference="Stop"

if($value -ne -1){
    if($display){
        brightness -d $display $value
    }else{
        brightness $value
    }
    return
}

$lh="low"

$valuePath="$PSScriptRoot/../tmp/brightness.txt"
if(Test-Path $valuePath){
    $lh=(Get-Content -Path $valuePath -Raw).Trim()
    Write-Host "Brightness currently $lh"
}



if($lh -eq "low"){
    Write-Host "Set Brightness high - $high"
    if($display){
        brightness -d $display $high
    }else{
        brightness $high
    }
    Set-Content -Path $valuePath -Value "high"
}else{
    Write-Host "Set Brightness low - $low"
    if($display){
        brightness -d $display $low
    }else{
        brightness $low
    }
    Set-Content -Path $valuePath -Value "low"
}