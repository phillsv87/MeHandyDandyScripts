#!/usr/local/bin/pwsh
param(
    $name=$(throw "-name required")
)
$ErrorActionPreference="Stop"


mkdir $name
if(!$?){throw "mkdir failed"}

cd $name
if(!$?){throw "cd failed"}

echo '/node_modules' > '.gitignore'
echo '/dist' >> '.gitignore'

cp -v -r "$PSScriptRoot/../resources/HdsInitTypescriptProject/" ./
if(!$?){throw "copy template files failed"}

$package=Get-Content -Path package.json -Raw
$package=$package.Replace('__PACKAGE_NAME__',$name)
Set-Content -Path package.json -Value $package

npm install
if(!$?){throw "npm install failed"}

npm i --save-dev typescript ts-node nodemon
if(!$?){throw "npm install dev deps failed"}

code .
