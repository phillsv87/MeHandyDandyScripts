#!/usr/local/bin/pwsh
param(
    [switch]$noCopy
)

function GeneratePassword {

    param(
        [int]$length=30
    )
    
    $chars=( ([byte]65..[byte]90) + ([byte]97..[byte]122) + ([byte]48..[byte]57))

    $buf=[System.Byte[]]::CreateInstance([System.Byte],$length)
    $stream=[System.IO.File]::OpenRead('/dev/urandom')
    $stream.Read($buf,0,$length) | Out-Null

    for($i=0;$i -lt $length;$i++){
        $buf[$i]=$chars[$buf[$i]%$chars.Length]
    }

    return [System.Text.Encoding]::ASCII.GetString($buf)
}

$p = GeneratePassword

if(!$noCopy){
    try{
        Set-Clipboard -Value $p | Out-Null
    }catch{
        &"$PSScriptRoot/HdsSetClipboard.sh" "$p"
    }
}

return $p