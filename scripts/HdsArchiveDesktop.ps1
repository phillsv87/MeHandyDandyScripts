#!/usr/bin/env pwsh
$ErrorActionPreference="Stop"

$name=[System.DateTime]::Now.ToString('yyyy-MM-dd')

$dest="$Env:HOME/docs/desktop-archive/$name"

mkdir -p $dest

mv ~/Desktop/* $dest/

Write-Host "Dekstop files moved to $dest" -ForegroundColor DarkGreen