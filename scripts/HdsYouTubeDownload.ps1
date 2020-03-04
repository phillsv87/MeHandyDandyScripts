#!/usr/local/bin/pwsh
param(
    [string]$url=$(throw "-url required"),
    [string]$out=$(throw "-out required"),
    [switch]$noConvert,
    [switch]$skipDownload
)
$ErrorActionPreference="Stop"

# # youtube-dl install
# # https://github.com/ytdl-org/youtube-dl/
# brew install youtube-dl

$out=[System.IO.Path]::GetFullPath($out)

if($noConvert){
    $down=$out
}else{
    $guid=[System.Guid]::NewGuid().ToString()
    $dir=[System.IO.Path]::GetDirectoryName($out)
    $down="$dir/$guid"
}

if($skipDownload){
    $down=$url
}else{
    youtube-dl -o "$down" "$url"
    if(!$?){throw "youtube-dl failed"}
    $down="$down.mkv"
    if($noConvert){
        return $out
    }
}

ffmpeg -i "$down" -c copy "$out"
if(!$?){
    Write-Host "Converting by coping codec failed. Trying full conversion" -ForegroundColor DarkYellow

    ffmpeg -i "$down" "$out"
    if(!$?){throw "convert failed"}
}
rm $down
return $out