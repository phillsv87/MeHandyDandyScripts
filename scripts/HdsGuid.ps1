#!/usr/bin/env pwsh
param(
    [switch]$copy
)
$ErrorActionPreference="Stop"

$guid=[System.Guid]::NewGuid().ToString()
Write-Host $guid

if($copy){
    &"$PSScriptRoot/HdsSetClipboard.sh" $guid
}