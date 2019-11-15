/**
 * 
 */

var cy = {};
var chart = {};
var attach = {};

function httpGet(callback, key, sync)
{
	var currentURL = window.location.href;
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.onreadystatechange = function() { 
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
            callback(xmlHttp.responseText);
    }
    if (typeof sync==='undefined') sync = true;
    xmlHttp.open("GET", currentURL+key, sync); // true for asynchronous 
    xmlHttp.send(null);
}


/*
  var wsUri = "ws://localhost:9095";
  var output;

  function init()
  {
    output = document.getElementById("output");
    testWebSocket();
    doSend("init");
  }

  function testWebSocket()
  {
    websocket = new WebSocket(wsUri);
    websocket.onopen = function(evt) { onOpen(evt) };
    websocket.onclose = function(evt) { onClose(evt) };
    websocket.onmessage = function(evt) { onMessage(evt) };
    websocket.onerror = function(evt) { onError(evt) };
  }
  

  function onOpen(evt)
  {
	  writeToScreen('<span style="color: blue;">OPEN:</span> ');
  }

  function onClose(evt)
  {
	  writeToScreen('<span style="color: blue;">CLOSE:</span> ');
  }

  
  function onMessage(evt)
  {
	var s = evt.data.split("/");
	var key = s[0];
	var arg = s[1];
	switch (key) {
	    case "click": clickCallback(arg); break;
	    case "keypress": keypressCallback(arg); break;
	    case "close": break;
	    case "tap":;
	    case "tapstart:; 
	    case "tapend": fromRascal(arg); break;
	    case "load": if (arg=="core") {fromRascal(arg);} break;
	    case "init": eval(arg); break;
	}
  }

  function onError(evt)
  {
    writeToScreen('<span style="color: red;">ERROR:</span> ' + evt.data);
  }

  function doSend(message)
  {
    writeToScreen("SENT: " + message);
    websocket.send(message);
  }

  function writeToScreen(message)
  {
    var pre = document.createElement("p");
    pre.style.wordWrap = "break-word";
    pre.innerHTML = message;
    output.appendChild(pre);
  }

 // window.addEventListener("load", init, false);

function httpGet(callback, key, sync) {
	 doSend(key);
}
*/

function handleOnClose() {
	if (typeof interval!=='undefined' && interval!=null) clearInterval(interval);
	httpGet(function(v){}, "close");	
	return "Bye";
}

function addHandlerClick(event, widget, sync, callback) {
	 // alert(widget);
	  var el = document.getElementById(widget); 
	  el["on"+event]=function(evt){
			 var ele = evt.target;
			 httpGet(callback
			  , event+"/"+ele.id, sync);
		   };
	  }

function addHandlerValue(event, widget, sync, callback) {
  var el = document.getElementById(widget); 
  el["on"+event]=function(evt){
		 var ele = evt.target;	
		 httpGet(callback
		  , event+"/"+ele.id+"/"+encodeURIComponent(ele.value), sync);
		 // alert(event+"/"+ele.id+"/"+encodeURIComponent(ele.value));
	     if (ele.type=="text") ele.value="";
	   };
  }

function addHandlerKeypress(event, widget, sync, callback) {
	  var el = document.getElementById(widget); 
	  el["on"+event]=function(evt){
			var char = evt.which || evt.keyCode;
			var ele = evt.target;
		    httpGet(callback
				  , event+"/"+ele.id+"/"+String.fromCharCode(char), sync);
		};
	  }

function fromRascal(s){
	   if (s.length==0) return "";
	   if (typeof clickCallback==='undefined') clickCallback = fromRascal;
	   if (typeof changeCallback==='undefined') changeCallback = fromRascal;
	   if (typeof keypressCallback==='undefined') keypressCallback = fromRascal;
	   if (typeof timerCallback==='undefined') timerCallback = function(){httpGet(fromRascal, "timer/"+count); count = count+1;};
	   console.log(s);
	   var t = JSON.parse(s);
	   var i = 0;
	   // console.log(t.styles.length);
	   if (t.styles!=null)
	   for (;i<t.styles.length;i++) {
		  //console.log(t.styles[i].style);
		  //console.log(t.styles[i].selector);
	      for (var x in cy) cy[x].elements(t.styles[i].selector).style(t.styles[i].style);
	   }
	   if (t.layout!=null) {
	         var layout = cy[t.layout[0]].layout({name:t.layout[1]});
	         layout.run();
	       }
	   if (t.html!=null) {
		   for (var k=0;k<t.html.length;k++) {
			   var attach = document.getElementById(t.html[k].attach);
			   var content = t.html[k].content;
			   attach.innerHTML=content;
		   }	   
	   }
	   if (t.table!=null) {
		   for (var k= 0;k<t.table.length;k++) {
		   var attach = document.getElementById(t.table[k].attach);	   
		   var table = document.createElement("table");  
		   table.setAttribute("id", t.table[k].tableId);
		   var width = parseInt(t.table[k].width);
		   var height = parseInt(t.table[k].height);
		   for (var i=0;i<height;i++) {
			  var row = document.createElement("tr");
			  for (var j=0;j<width;j++) {
				  var td = document.createElement("td");
				  td.setAttribute("id", ""+(i*width+j)+t.table[k].cellId);
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
		    else {
		    	el = document.getElementsByClassName(t.css[i].sel);
		    	if (el!=null && el.length>0)
		    	   for (var j=0;j<el.length;j++) el[j].style[t.css[i].key] = t.css[i].val;
		    	   else {
		    		  el = document.getElementsByTagName(t.css[i].sel);
			    	  if (el!=null && el.length>0)
			    	   for (var j=0;j<el.length;j++) el[j].style[t.css[i].key] = t.css[i].val;
			    	}		
		    	}
		    }
	  }
	  if (t.transform!=null) {
		  for (var i=0;i<t.transform.length;i++) {
		    var el = document.getElementById(t.transform[i].sel); 
		    if (el!=null)
		    	el.setAttribute("transform", t.transform[i].val)
		  }
	  }
	  if (t.onclick!=null) {
		  var sync =  true;
		  if (typeof t.sync!=='undefined' && t.sync!=null) t.sync=="true";
		  for (var i=0;i<t.onclick.length;i++) {
			  addHandlerClick("click", t.onclick[i], sync, clickCallback); 
		  }
	  }
	  if (t.onchange!=null) {
		  var sync =  true;
		  if (typeof t.sync!=='undefined' && t.sync!=null) sync = (t.sync=="true");
		  for (var i=0;i<t.onchange.length;i++) {
		      addHandlerValue("change", t.onchange[i], sync, changeCallback); 
		      }
		  }
	  if (t.onkeypress!=null) {
		  var sync =  true;
		  if (typeof t.sync!=='undefined' && t.sync!=null) sync = (t.sync=="true");
		  for (var i=0;i<t.onkeypress.length;i++) {
		      addHandlerKeypress("keypress",t.onkeypress[i], sync, keypressCallback);
		  }
		  }
	  if (t.setInterval!=null) {
		  mSec = parseInt(t.setInterval);
		  count  = 0;
		  if ((typeof runningInterval =='undefined') || runningInterval==null || !runningInterval) {
		      interval = setInterval(timerCallback, mSec);
		      runningInterval = true;
		  }
	  }
	  if (t.clearInterval!=null) {
		  clearInterval(interval);
		  runningInterval = false;
	  }
	  return t;
	  }

window.addEventListener("load", function(evt) {
	if (typeof cy!=='undefined') {
   for (var x in cy) {
	cy[x].on('tap', 'node', function(evt){
		 var ele = evt.target;
		 httpGet(fromRascal
		  , "tap/"+ele.id());
	   });
	
	 cy[x].on('tap', 'edge', function(evt){
		 var ele = evt.target;
		 httpGet(fromRascal
		  , "tap/"+ele.id());
	   });

	 cy[x].on('tapstart', 'node', function(evt){
		 var ele = evt.target;
		 httpGet(fromRascal
		  , "tapstart/"+ele.id());
	  });
	 cy[x].on('tapend', 'node', function(evt){
		 var ele = evt.target;
		 httpGet(fromRascal
		  , "tapend/"+ele.id());
	 });
      }
	 }
     httpGet(fromRascal, "load/core");
	 });


function walkThroughCardConfiguration( obj ) {
    var keys = Object.keys( obj ); // get all own property names of the object

    keys.forEach( function ( key ) {
        var value = obj[ key ]; // get property value
        // if the property value is an object...
        if ( value && typeof value === 'object' ) { 
        	var keys = Object.keys(value);
        	if (keys.length==2 && (keys[0]=="body"||keys[1]=="body")) {
        		 obj[key]= new Function(value.arguments, value.body);
        	} else 
                 obj[key] = walkThroughCardConfiguration(value ); 
        }
    });
    return obj;
}

// walkTheObject( this );  start with the global object
 