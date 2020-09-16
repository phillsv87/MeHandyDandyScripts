#!/usr/local/bin/pwsh
param(
    [switch]$noCopy,
    [switch]$noBase64
)

$p = ([char[]]([char]65..[char]90) + ([char[]]([char]97..[char]122)) + 0..9 | Sort-Object {Get-Random})[0..30] -join ''

Write-Host $p

if(!$noBase64){
    $b = [System.Text.Encoding]::UTF8.GetBytes($p)
    $p =[Convert]::ToBase64String($b).Trim("=")
}

if(!$noCopy){
    try{
        Set-Clipboard -Value $p
    }catch{
        &"$PSScriptRoot/HdsSetClipboard.sh" "$p"
    }
}

return $p