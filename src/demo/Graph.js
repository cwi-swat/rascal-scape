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
	 ele.style({'text-background-opacity':'1'});
	 ele.style({'text-background-color':'lightgrey'});
	 ele.style({'text-background-padding':'10'});
	 ele.style({'text-opacity':'1'});
	 ele.style({'color':'black'});
     });
cy.on('tapend', 'node', function(evt){
	 var ele = evt.target;
	 ele.style({'text-background-opacity':'0'});
	 ele.style({'text-opacity':'0'});
	 ele.style({'color':'red'});
    });

