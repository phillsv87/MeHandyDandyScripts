#!/usr/bin/env node
const fs=require('fs').promises;
const Path=require('path');
const JSON5=require('json5');
const commandLineArgs=require('command-line-args');
const {cmd}=require('../js-lib/common')

const exclude=['node_modules','dist',]

/**
 * @type {{package:string,directory:string}}
 */
const {package,directory}=commandLineArgs([

    {name:'package',type:String,alias:'p'},
    {name:'directory',type:String,alias:'d'},
    
]);

async function main()
{
    if(!package){
        throw new Error('--package required');
    }

    const startWithAt=package.startsWith('@');
    const name=(startWithAt?'@':'')+package.split('@')[startWithAt?1:0];

    const cwd=process.cwd();

    try{
        if(directory){
            process.chdir(directory);
        }
        await scanAsync('.',package,name);
    }finally{
        process.chdir(cwd);
    }

}

/**
 * @param {string} path
 * @param {string} package
 * @param {string} name 
 */
async function scanAsync(path,package,name)
{

    const stat=await fs.stat(path);
    if(!stat.isDirectory()){
        return;
    }

    const ignored=await cmd(`git check-ignore '${path}'`,{silent:true,returnCode:true});
    if(ignored==='0'){
        return;
    }

    const files=await fs.readdir(path);
    if(files.includes('package.json')){
        await installAsync(path,package,name);
    }
    for(const f of files){
        await scanAsync(Path.join(path,f),package,name);
    }
}

/**
 * @param {string} dir
 * @param {string} package
 * @param {string} name 
 */
async function installAsync(dir,package,name)
{
    const pkg=JSON5.parse((await fs.readFile(Path.join(dir,'package.json'))).toString());

    const dev=pkg.devDependencies?.[name];
    if(dev || pkg.dependencies?.[name]){
        await cmd(`cd '${dir}' && npm install ${package}${dev?' --save-dev':''}`,{printPrefix:dir})
    }
}

(async ()=>{
    try{
        await main()
    }catch(ex){
        console.error(ex);
        process.exit(1);
    }
})()