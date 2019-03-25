/**
 * 
 */

cy.nodes().style({
    'overlay-color':'red',
    'overlay-opacity':0,
    'text-opacity':'0',
    'font-size':'40pt'
     });  
cy.on('tapstart', 'node', function(evt){
	 var ele = evt.target;
	 ele.style({'text-background-opacity':'1'
	            ,'text-background-color':'lightgrey'
	            ,'text-background-padding':'10'
	            ,'text-opacity':'1'
	            ,'color':'black'}
	          );
     });
cy.on('tapend', 'node', function(evt){
	 var ele = evt.target;
	 ele.style({'text-background-opacity':'0'
	           ,'text-opacity':'0'
	           ,'color':'red'}
              );
     });

