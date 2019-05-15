function data_transfer(){
    // location.reload()
    var perfEntries, curEntry, output;
    perfEntries = performance.getEntriesByType("navigation");
    curEntry = perfEntries[0];
    output  = "name: "+curEntry.name+"; ";
    output += "type: "+curEntry.type+"; ";
    output += "entryType: "+curEntry.entryType+"; ";
    output += "initiatorType: "+curEntry.initiatorType+"; ";
    output += "redirectCount: "+curEntry.redirectCount+"; ";
    output += "startTime: "+curEntry.startTime+"; ";
    output += "unloadEventStart: "+curEntry.unloadEventStart+"; ";
    output += "unloadEventEnd: "+curEntry.unloadEventEnd+"; ";
    output += "redirectStart: "+curEntry.redirectStart+"; ";
    output += "redirectEnd: "+curEntry.redirectEnd+"; ";
    output += "fetchStart: "+curEntry.fetchStart+"; ";
    output += "domainLookupStart: "+curEntry.domainLookupStart+"; ";
    output += "domainLookupEnd: "+curEntry.domainLookupEnd+"; ";
    output += "connectStart: "+curEntry.connectStart+"; ";
    output += "secureConnectionStart: "+curEntry.secureConnectionStart+"; ";
    output += "connectEnd: "+curEntry.connectEnd+"; ";
    output += "requestStart: "+curEntry.requestStart+"; ";
    output += "responseStart: "+curEntry.responseStart+"; ";
    output += "responseEnd: "+curEntry.responseEnd+"; ";
    output += "domInteractive: "+curEntry.domInteractive+"; ";
    output += "domContentLoadedEventStart: "+curEntry.domContentLoadedEventStart+"; ";
    output += "domContentLoadedEventEnd: "+curEntry.domContentLoadedEventEnd+"; ";
    output += "domComplete: "+curEntry.domComplete+"; ";
    output += "loadEventStart: "+curEntry.loadEventStart+"; ";
    output += "loadEventEnd: "+curEntry.loadEventEnd+"; ";
    output += "duration: "+curEntry.duration+"; ";
    backendDuration = "backendDuration: " + String(curEntry.responseStart - curEntry.startTime);
    frontendDuration = "frontendDuration: " + String(curEntry.domComplete - curEntry.responseStart);
    output += backendDuration +"; ";
    output += frontendDuration +"; ";
    // time = curEntry.responseEnd - curEntry.requestStart;


    this.document.getElementById("perf").innerHTML=output;
    return output;
}


function fac(n){
    //this is comment
    if (n<=1){
        return 1;
    }
    else {
        return fac(n-1)*n
    }

}

// data_transfer()