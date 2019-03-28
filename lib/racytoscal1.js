/**
 * 
 */
function httpGet(callback, key)
{
	var currentURL = window.location.href;
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.onreadystatechange = function() { 
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
            callback(xmlHttp.responseText);
    }
    xmlHttp.open("GET", currentURL+key, true); // true for asynchronous 
    xmlHttp.send(null);
}

function handleOnClose() {
	httpGet(function(v){}, "close");
}