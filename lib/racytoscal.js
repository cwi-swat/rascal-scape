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
	if (typeof interval!=='undefined' && interval!=null) clearInterval(interval);
	httpGet(function(v){}, "close");
}

function fromRascal(s){
	   if (s.length==0) return "";
	   console.log(s);
	   var t = JSON.parse(s);
	   var i = 0;
	   if (t.styles!=null)
	   for (;i<t.styles.length;i++)
	      cy.elements(t.styles[i].selector).style(t.styles[i].style);
	   if (t.layout!=null) {
	       var layout = cy.layout({name:t.layout});
	       layout.run();
	       }
	   if (t.table!=null) {
		   for (var k= 0;k<t.table.length;k++) {
		   var attach = document.getElementById(t.table[k].id);	   
		   var table = document.createElement("table");  
		   table.setAttribute("id", t.table[k].tableId);
		   var width = parseInt(t.table[k].width);
		   var height = parseInt(t.table[k].height);
		   for (var i=0;i<height;i++) {
			  var row = document.createElement("tr");
			  for (var j=0;j<width;j++) {
				  var td = document.createElement("td");
				  td.setAttribute("id", t.table[k].cellId+"_"+i+"_"+j);
				  td.setAttribute("class", t.table[k].cellId);
				  row.appendChild(td);
		      }
		   table.appendChild(row);
	       }
		   attach.appendChild(table);
		   }
	   }
	  if (t.css!=null) {
		  for (var i=0;i<t.css.length;i++) {
		    var el = document.getElementById(t.css[i].sel); 
		    if (el!=null)
		        el.style[t.css[i].key] = t.css[i].val;
		  }
	  }
	  if (t.onclick!=null) {
		  for (var i=0;i<t.onclick.length;i++) {
		  var el = document.getElementById(t.onclick[i]); 
		  el.onclick=function(evt){
				 var ele = evt.target;
				 httpGet(fromRascal
				  , "click/"+ele.id);
			   };
		  }
		  }
	  if (t.setInterval!=null) {
		  var mSec = parseInt(t.setInterval);
		  count  = 0;
		  interval = setInterval(function(){httpGet(fromRascal, "timer/"+count); count = count+1;}, mSec);
	  }
	  if (t.clearInterval!=null) {
		  clearInterval(interval);
	  }
	  return t;
	  }

window.addEventListener("load", function(evt) {
	if (typeof cy!=='undefined') {
	cy.on('tap', 'node', function(evt){
		 var ele = evt.target;
		 httpGet(fromRascal
		  , "tap/"+ele.id());
	   });
	
	cy.on('tap', 'edge', function(evt){
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
	 }
     httpGet(fromRascal, "load/core");
	 });
 