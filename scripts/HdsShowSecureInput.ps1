#!/usr/bin/env pwsh

# Shows the process that currently has secure input. The -pidOnly flag can be used to only return the
# pid, this is usefully for scripting. If not proces is found with secure input the command
# exits with a value of 1.

param(
    [int]$delay=0,
    [switch]$pidOnly
)
$ErrorActionPreference="Stop"

if($delay -gt 0){
    sleep $delay
}

#$info=Get-Content -Raw -Path 'tmp.txt' #ioreg -l -w 0 | grep SecureInput
$info=ioreg -l -w 0 | grep SecureInput | Out-String
$matched=$info -match '"kCGSSessionSecureInputPID"\s*=\s*(\d+)'
$spid=$Matches.1

if(!$matched){
    if(!$pidOnly){
        Write-Host 'Secure input process not found' -ForegroundColor DarkYellow
    }
    exit 1
}

if($pidOnly){
    $spid
}else{
    Write-Host "Secure Input PID = $spid" -ForegroundColor DarkGreen

    ps aux | grep "$spid"
}