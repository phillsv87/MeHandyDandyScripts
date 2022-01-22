#!/usr/bin/env pwsh

$date1 = Get-Date -Date "01/01/1970"
$date2 = Get-Date
$time=[System.Math]::Round((New-TimeSpan -Start $date1 -End $date2).TotalSeconds)

$randomNames=&"$PSScriptRoot/../resources/RandomNames.ps1"
$rName=$randomNames[$time%$randomNames.Length]

$date=Get-Date -Format "yyyy-MM-dd-"
$name="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Notes/random/$date$rName.md"

$env:TM_PROJECT_UUID='00000000-0000-0000-0000-000000000000'
mate $name