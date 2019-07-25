/**
 * 
 */

function level(node) {var d = parseInt(node.id()); 
        // alert(d);
        return d<26?1:2;
        }

function getData(s) {
	 var r = fromRascal(s);
	 // var r  = JSON.parse(s);
	 var current0  = {'loc':current.loc,'account':current.account
			         ,'interest':current.interest,'amount':current.amount
			         };
	 // alert(current.loc)
	 current.loc  = r.state.loc;
	 current.account = r.state.account;
	 current.lab = r.state.lab;
	 current.amount = r.state.amount;
	 nextStep(current0, current);
}

function getExtraData(s) {
	 var r= fromRascal(s);
	 // var r  = JSON.parse(s);
	 current.interest  = r.state.interest;
	 current.amount = r.state.amount;
	 document.getElementById("account-cell").innerHTML=current.account;
	 document.getElementById("interest-cell").innerHTML=current.interest;
	 document.getElementById("amount-cell").innerHTML=current.amount;
	 document.getElementById("account-table").style.visibility="visible";
	 document.getElementById("buttons").style.visibility="visible";
	 document.getElementById("enter").style.visibility = "hidden";
	 document.getElementById("interest-span").style.visibility="hidden";
}

function choose(to) {return function(evt)
	                    {
	                    var ele = evt.target;
	                    var id = ele.getAttribute("id");
	                    httpGet(getData,"click/"+id+"/"+ to+"/"+current.account+"/"
	                    		 +current.interest+"/"+current.amount);            
	                    };
	                }

function enterAccount(evt)
    {
    var ele = evt.target;
    var id = ele.getAttribute("id");
    var interest = document.getElementById("interest-field").value;
    var amount = document.getElementById("amount-field").value;
    httpGet(getExtraData,"click/"+id+"/"+ "none"+  "/"+current.account+"/"
   		                                + interest+"/"+ amount); 
    };

window.addEventListener("load", function(evt) {
	                   httpGet(getData,"load/init/"+0+"/"+current.account
	                		   + "/"+ current.interest+"/"+ current.amount);
	                   document.getElementById("enter-button").addEventListener("click", enterAccount) ;
                       });

// Create buttons to choose between outgoing states,
function step(id, current0, next) {
	var table =document.createElement("table");
	table.setAttribute("id", "buttons");
	table.setAttribute("class", "buttons");
	var i = 0;
	var len = next.buttons.length;
	var enter = document.getElementById("enter");
	// alert("TestQ:"+current0.loc+":"+len);
	for (;i<len;i++) {
		var tr = document.createElement("tr");
		var td = document.createElement("td");
		var button = document.createElement("button");
		button.setAttribute("id", next.ids[i]);
		button.setAttribute("class", "step-button");
		button.addEventListener("click", choose(next.nods[i]));
		button.innerHTML=next.buttons[i];
		td.appendChild(button);
		tr.appendChild(td);
		table.appendChild(tr);
	}
	if (current.lab=="openAccount"||current.lab=="deposit"||current.lab=="withdraw") {
		if (parseInt(current.account)>0) {  
			enter.style.visibility = "visible";
		   if (current.lab=="openAccount") {
		         document.getElementById("interest-field").focus();
		         document.getElementById("interest-span").style.visibility="visible";
		   }
		   else {
			   document.getElementById("amount-field").focus();
			   document.getElementById("interest-span").style.visibility="hidden";
		       }
		   table.style.visibility="hidden";
	     }	  
      } 
	else
	if (current.lab=="close") {
		document.getElementById("account-table").style.visibility="hidden";		
	}
	else
	if (current.lab=="interest") {
		document.getElementById("amount-cell").innerHTML=current.amount;		
	}
	var root = document.getElementById(id);
	len = root.childNodes.length;
	// alert(len);
	if (len>0) root.removeChild(root.childNodes[0]);
	root.appendChild(table);
}

function nextStep(current0, current) {
	   var src = cy.$('#'+current.loc);
	   var eles = src.neighborhood('edge');
	   var i = 0;
	   var labels = [];
	   var nods= [];
	   //var ids = [];
	   for (;i<eles.length;i++) { 
		  if (!eles[i].source().same(src)) {continue;}
		  var label = eles[i].style("label");
		  var node = eles[i].target().id();
		  labels.push(label);
		  nods.push(node);
		  // ids.push(eles[i].source().id()+"_"+eles[i].target().id());
	      }
	   step("next", current0, {buttons:labels,nods:nods,ids:labels});
	   }