#!/usr/bin/env node

const {v4}=require('uuid');

console.log(v4());

if(process.argv.includes('-copy')){
    setClipboard(id);
}