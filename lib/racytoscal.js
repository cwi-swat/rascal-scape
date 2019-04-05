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

function fromRascal(s){
	   if (s.length==0) return;
	   console.log(s);
	   var t = JSON.parse(s);
	   var i = 0;
	   for (;i<t.length;i++)
	      cy.elements(t[i].selector).style(t[i].style);
	  }

window.addEventListener("load", function(evt) {
	cy.on('tap', 'node', function(evt){
		 var ele = evt.target;
		 httpGet(fromRascal
		  , "tap/"+ele.id());
	   });

	cy.on('tapstart', 'node', function(evt){
		 var ele = evt.target;
		 httpGet(fromRascal
		  , "tapstart/"+ele.id());
	  });
	cy.on('tapend', 'node', function(evt){
		 var ele = evt.target;
		 httpGet(fromRascal
		  , "tapend/"+ele.id());
	 });
    });