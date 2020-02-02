#!/usr/local/bin/pwsh
param(
    [string]$name
)

if(!$name){
    $name="Tmp-"+(New-Guid).ToString()
}

$tmpDir="$PSScriptRoot/../../TmpProjects"
if(!(Test-Path $tmpDir)){
    New-Item -ItemType 'Directory' -Path $tmpDir
}

$path="$tmpDir/$name"

if(Test-Path $path){
    throw "Project already exists"
}

Push-Location $tmpDir
try{

    dotnet new console --name "$name"
    if(!$?){throw "dotnet new failed"}

    code "$name"

}finally{
    Pop-Location
}