const {exec}=require('child_process');

exports.setClipboard=function setClipboard(data) {
    var proc = require('child_process').spawn('pbcopy'); 
    proc.stdin.write(data); proc.stdin.end();
}

exports.delayAsync=function delayAsync(ms)
{
    return new Promise((r)=>{
        setTimeout(()=>{
            r();
        },ms)
    })
}

exports.aryRemove=function aryRemove(item, ary)
{
    const i=ary.indexOf(item);
    if(i!==-1){
        ary.splice(i,1);
        return true;
    }else{
        return false;
    }
}

/**
 * Executes a shell command a returns the stdout or exit code if options.returnCode is true
 * @param {string} cmd 
 * @param {{silent:boolean,ignoreErrors:boolean,returnCode:boolean,printPrefix:string}} options
 * @returns {Promise<string>}
 */
exports.cmd=function cmd(cmd,options={})
{
    return new Promise((r,j)=>{
        const printPrefix=options.printPrefix?options.printPrefix+' ':'';
        if(!options.silent){
            console.info(printPrefix+'_> '+cmd);
        }
        exec(cmd,(error,stdout,stderr)=>{
            if(!options.silent){
                if(stdout){
                    console.info(printPrefix+' > '+stdout);
                }
                if(stderr){
                    console.warn(printPrefix+'!> '+stderr);
                }
            }
            if(options.returnCode){
                r(error?.code?.toString()||'0');
            }
            if(error){
                if(options.ignoreErrors){
                    r('');
                }else{
                    j(error);
                }
            }else{
                r(stdout?.trim()||'');
            }
        })
    })
}