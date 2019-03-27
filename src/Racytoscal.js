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

cy.nodes().style({
    'overlay-color':'red',
    'overlay-opacity':0,
    'text-opacity':'0',
    'font-size':'40pt'
     }); 

/*
cy.on('tapstart', 'node', function(evt){
	 var ele = evt.target;
	 var s = '{"selector":"node#'+ele.id()+'", "style":{"text-background-opacity":"1","text-background-color":"lightgrey","text-background-padding":"10","text-opacity":1,"color":"black","label":"'+ele.id()+'"}}';
	 var t = JSON.parse(s);
	 // console.log(JSON.stringify(t));	 
	 cy.elements(t.selector).style(t.style);
     });
cy.on('tapend', 'node', function(evt){
	 var ele = evt.target;
	 console.log("tapend");
	 ele.style({'text-background-opacity':'0'
	           ,'text-opacity':'0'
	           ,'color':'red'}
              );
     });
*/


cy.on('tap', 'node', function(evt){
	 var ele = evt.target;
	 httpGet(function(s){
	   console.log(s);
	   var t = JSON.parse(s);
	   cy.elements(t.selector).style(t.style)
	  }
	  , "tap/"+ele.id());
     });

cy.on('tapstart', 'node', function(evt){
	 var ele = evt.target;
	 httpGet(function(s){
	   console.log(s);
	   var t = JSON.parse(s);
	   cy.elements(t.selector).style(t.style)
	  }
	  , "tapstart/"+ele.id());
    });
cy.on('tapend', 'node', function(evt){
	 var ele = evt.target;
	 httpGet(function(s){
	   console.log(s);
	   var t = JSON.parse(s);
	   cy.elements(t.selector).style(t.style)
	  }
	  , "tapend/"+ele.id());
   });
/*
cy.on('tapend', 'node', function(evt){
	 var ele = evt.target;
	 ele.style({'text-background-opacity':'0'
	           ,'text-opacity':'0'
	           ,'color':'red'}
              );
     });
 */
