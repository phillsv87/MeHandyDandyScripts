#!/usr/local/bin/pwsh
$content=pbpaste -Prefer txt

$b = [System.Text.Encoding]::UTF8.GetBytes($content)
$content =[Convert]::ToBase64String($b)

try{
    Set-Clipboard -Value $content
}catch{
    &"$PSScriptRoot/HdsSetClipboard.sh" "$content"
}