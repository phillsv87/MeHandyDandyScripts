#!/usr/bin/env node

const {setClipboard}=require('../js-lib/common');

/**
 * Creates a new unique Id
 * @see https://github.com/firebase/firebase-js-sdk/blob/6abd6484730971e2390b2b9acbb61800852fb350/packages/firestore/src/util/misc.ts
 */
function newId() {
    // Alphanumeric characters
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let autoId = '';
    for (let i = 0; i < 20; i++) {
        autoId += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return autoId;
}

const id=newId();

console.log(id);

if(process.argv.includes('-copy')){
    setClipboard(id);
}