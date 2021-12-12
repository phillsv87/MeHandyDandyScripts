#!/usr/local/bin/pwsh

param(
    [string]$source
)

$ErrorActionPreference="Stop"

[string]$content=''
[bool]$clipboard=$false

if($source){
    $content=Get-Content -Raw -Path $source
    $clipboard=$false
}else{
    $content=Get-Clipboard -Raw
    $clipboard=$true
}

$content=$content.Replace('$','\$');

$lines=$content.Split("`n");
for($i=0;$i -lt $lines.Length;$i++){
    $lines[$i]=$lines[$i].Trim("`r")
}

$obj=[ordered]@{
    __SNIPPET__NAME__=[ordered]@{
        scope="";
        prefix="";
        description="";
        body=$lines;
    }
}

$content=($obj | ConvertTo-Json).ToString().Trim().TrimStart('{').TrimEnd('}')

if($clipboard){
    Set-Clipboard $content
    Write-Host 'Snippent copied to clipboard'
}else{
    Write-Host $content
}
