#!/usr/bin/env pwsh
param(
    [string]$path='.',
    [switch]$noSort
)

Push-Location $path
try{
    if($noSort){
        du -sh *
    }else{
        du -sh * | sort -rh
    }
}finally{
    Pop-Location
}