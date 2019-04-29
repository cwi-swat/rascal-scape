/**
 * 
 */

function level(node) {var d = parseInt(node.id()); 
        // alert(d);
        return d<26?1:2;
        }

function choose(to) {return function(evt)
	                    {
	                    var ele = evt.target;
	                    var id = ele.getAttribute("id");
	                    httpGet(fromRascal,"click/"+id+"/"+ to);
	                    nextStep(to);
	                    };
	                }

window.addEventListener("load", function(evt) {
	                   httpGet(fromRascal,"load/init/"+current);
	                   nextStep(current);
                       });

// Create buttons to choose between outgoing states,
function step(id, next) {
	var table =document.createElement("table");
	table.setAttribute("class", "buttons");
	var i = 0;
	var len = next.buttons.length;
	for (;i<len;i++) {
		var tr = document.createElement("tr");
		var td = document.createElement("td");
		var button = document.createElement("button");
		button.setAttribute("id", "button_"+next.ids[i]);
		button.addEventListener("click", choose(next.nods[i]));
		button.innerHTML=next.buttons[i];
		td.appendChild(button);
		tr.appendChild(td);
		table.appendChild(tr);
	}
	var root = document.getElementById(id);
	len = root.childNodes.length;
	// alert(len);
	if (len>0) root.removeChild(root.childNodes[0]);
	root.appendChild(table);
}

function nextStep(current) {
	   var src = cy.$('#'+current);
	   var eles = src.neighborhood('edge');
	   var i = 0;
	   var labels = [];
	   var nods= [];
	   var ids = [];
	   for (;i<eles.length;i++) { 
		  if (!eles[i].source().same(src)) {continue;}
		  var label = eles[i].style("label");
		  var node = eles[i].target().id();
		  labels.push(label);
		  nods.push(node);
		  ids.push(eles[i].source().id()+"_"+eles[i].target().id());
	      }
	   step("next", {buttons:labels,nods:nods,ids:ids});
	   }