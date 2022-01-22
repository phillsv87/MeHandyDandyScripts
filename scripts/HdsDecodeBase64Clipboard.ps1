#!/usr/bin/env pwsh
$ErrorActionPreference="Stop"

[string]$content=pbpaste -Prefer txt

function decode{
    param(
        $text
    )
    $b =[Convert]::FromBase64String($text)
    return [System.Text.Encoding]::UTF8.GetString($b)
}
if($content.Contains(" ")){

    $lines=$content.Split(" ")
    $content=""
    foreach($line in $lines){
        $line=$line.Trim();
        if($line -ne ""){
            $content+=decode -text $line
        }
        $content+="`n"
    }

}else{
    $content = decode -text $content
}

try{
    Set-Clipboard -Value $content
}catch{
    &"$PSScriptRoot/HdsSetClipboard.sh" "$content"
}