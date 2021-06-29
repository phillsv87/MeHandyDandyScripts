#!/usr/local/bin/pwsh
param(
    [switch]$copy
)
$ErrorActionPreference="Stop"

$code=@"
using System;

namespace NblWebCommon
{
    public static class StringUid
    {
        private static readonly char[] UidChars=new char[]{
            'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V',
            'W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r',
            's','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9'
        };

        // source - https://github.com/firebase/firebase-js-sdk/blob/6abd6484730971e2390b2b9acbb61800852fb350/packages/firestore/src/util/misc.ts#L36
        public static string NewUid()
        {
            var rand=new Random();
            var uid=new char[20];
            for(int i=0;i<20;i++){
                uid[i]=UidChars[rand.Next(UidChars.Length)];
            }
            return new string(uid);
        }
    }
}
"@

Add-Type -TypeDefinition $code -Language CSharp	
$uid=Invoke-Expression "[NblWebCommon.StringUid]::NewUid()"
$uid

if($copy){
    &"$PSScriptRoot/HdsSetClipboard.sh" $uid
}