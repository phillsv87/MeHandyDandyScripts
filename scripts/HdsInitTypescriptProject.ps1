#!/usr/bin/env pwsh
param(
    [string]$name=$(throw "-name required"),
    [string]$type=$(throw "-type required"),
    [string]$path
)
$ErrorActionPreference="Stop"

$fullName=$name
$name=$name.Split('/')[-1]

if(!$path){
    $path=$name
}

if($path -ne "." -And (Test-Path $path)){
    throw "$path already exists"
}

$templateDir="$PSScriptRoot/../resources/HdsInitTypescriptProjects";
$templatePath="$templateDir/$type/"
$templateConfigPath="$templateDir/$type.json"

if(!(Test-Path $templatePath)){
    echo 'Templates:'
    ls -l "$templateDir"
    throw "template type ($type) does not exist"
}

$config=Get-Content -Path $templateConfigPath -Raw | ConvertFrom-Json

$remotes=git remote -v | Join-String
$remotes -match 'https://\S+' | Out-Null
$repoUrl=$Matches.0



if($path -ne "."){
    mkdir -p $path
    if(!$?){throw "mkdir failed"}
}

cd $path
if(!$?){throw "cd failed"}

$repoDir=(git rev-parse --show-prefix | Join-String).Trim()
if($repoDir -eq ""){
    $repoDir="."
}

echo '/node_modules' > '.gitignore'
echo '/dist' >> '.gitignore'

cp -v -r $templatePath ./
if(!$?){throw "copy template files failed"}

mv index.ts "$name-index.ts"
if(!$?){throw "move index failed"}

$package=Get-Content -Path package.json -Raw
$package=$package.Replace('__PACKAGE_NAME__',$fullName)
$package=$package.Replace('__NAME__',$name)
$package=$package.Replace('__BIN_NAME__',$name.Replace('-cli',''))
$package=$package.Replace('__REPO_URL__',$repoUrl)
$package=$package.Replace('__REPO_DIR__',$repoDir)
Set-Content -Path package.json -Value $package

npm install
if(!$?){throw "npm install failed"}

if($config.devDependencies.Length){
    $deps=$config.devDependencies | Join-String -Separator " "
    Invoke-Expression "npm install $deps --save-dev"
    if(!$?){throw "npm install dev-deps failed"}
}
if($config.dependencies.Length){
    $deps=$config.dependencies | Join-String -Separator " "
    Invoke-Expression "npm install $deps"
    if(!$?){throw "npm install deps failed"}
}
