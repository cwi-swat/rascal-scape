module demo::pico::Graph
import Prelude;
extend Racytoscal;
import util::Math;
import util::UUID;
import demo::lang::Pico::ControlFlow;
import analysis::graphs::Graph;

map[str, str] key = ();

str _(str id) = key[id];

str getId(CFNode d) {
   if (exit():=d) return "-1";
   if (statement(loc location, _):=d) return "<location.offset>";
   if (choice(loc location, _):=d) return "<location.offset>";
   if (entry(loc location):=d) return "<location.offset>";
   return "wrong";
   }

rel[str, str] controlFlow() {
   str pico = readFile(|project://racytoscal/src/demo/pico/P1.pico|);
   println(pico);
   Graph[CFNode] g = delAnnotationsRec(cflowProgram(pico).graph);
   set[CFNode] c = carrier(g);
   rel[str, str] r = {<getId(d[0]), getId(d[1])>|tuple[CFNode, CFNode] d<-g};
   return r;
   }

// n_("keter", position=<300, 160> ,style = style(label = label("\u05DB\u05EA\u05E8", vAlign = "center")))

list[Ele] show(str group, list[str] names) {
     Ele background = n_(group, style=style(label=label(group, vAlign = "top", marginY=-10), borderColor="darkgrey"));
     key+=(d:uuid().authority|str d<-names);
     list[Ele] nodes = [n_(_(d), style=style(label=label(d, vAlign = "center")), parent=group)|str d<-names];
     list[Ele] elements = nodes+background;
     return elements;
     }

Cytoscape show(str names...) {
      list[Ele] elements = show("group", names);
      Cytoscape cy = cytoscape(
           elements= elements
       ,styles = [<"node", style(borderWidth = "2", borderColor="brown", padding="10")>]
       ,\layout = dagre("compound:true")
       );
     return cy;
     }
     
Cytoscape show(list[str] names...) {
      list[Ele] elements =[];
      for (int i<-[0..size(names)])
           elements+= show("group<i>", names[i]);
      Cytoscape cy = cytoscape(
           elements= elements
       ,styles = [<"node", style(borderWidth = "2", borderColor="brown", padding="10")>]
       ,\layout = dagre("compound:true")
       );
     return cy;
     }
     
 list[Ele] show(str group, rel[str, str] pairs) {
     list[str] car = toList(carrier(pairs));
     list[Ele] nodes = show(group, car);
     list[Ele] edges = [e_(uuid().authority, _(d[0]), _(d[1]))|tuple[str, str] d <-pairs]; 
     return nodes+edges; 
     }
     
Cytoscape show(rel[str, str] names...) {
      list[Ele] elements =[];
      for (int i<-[0..size(names)])
           elements+= show("group<i>", names[i]);
      Cytoscape cy = cytoscape(
           elements= elements
       ,styles = [<"node", style(borderWidth = "2", borderColor="brown", padding="10")>
                  ,<"edge", style(  
                 curveStyle=straight(),lineColor="blue",
                 arrowShape=[
                     ArrowShape::triangle(
                      arrowScale=2
                     ,arrowColor="red", pos = target()
                     )
                     ]
                  )
                  >
           ]
       ,\layout = dagre("compound:true")
       );
     return cy;
     }
    
    
public App def() {
     App ap = app(|project://racytoscal/src/demo/pico/Graph.html|
         , <"cy"
         //, show(["aap","noot","mies"], ["teun","gijs"])
            ,show(controlFlow())
            >
           ,display = true);  
    return ap;
    }
    
public void main() {
    controlFlow();
    }