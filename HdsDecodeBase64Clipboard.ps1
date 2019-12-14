#!/usr/local/bin/pwsh
$content=pbpaste -Prefer txt

$b =[Convert]::FromBase64String($content)
$content = [System.Text.Encoding]::UTF8.GetString($b)

try{
    Set-Clipboard -Value $content
}catch{
    &"$PSScriptRoot/HdsSetClipboard.sh" "$content"
}