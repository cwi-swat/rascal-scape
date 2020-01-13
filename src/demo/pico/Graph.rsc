module demo::pico::Graph
import Prelude;
import Rascalscape;
import Cytoscape;
import util::Math;
import util::UUID;
import demo::lang::Pico::ControlFlow;
import demo::lang::Pico::Abstract;
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
   
str getText(CFNode d, str pico) {
   if (exit():=d) return "";
   if (exit():=d) return "";
   if (entry(_):=d) return "";
   if (statement(loc location, _):=d) return "<substring(pico, location.offset, location.offset+location.length)>";
   if (choice(loc location, _):=d)    return "<substring(pico, location.offset, location.offset+location.length)>";
   return "wrong";
   }

rel[tuple[str, str], tuple[str, str]] controlFlow() {
   str pico = readFile(|project://<project>/src/demo/pico/P1.pico|);
   // println(pico);
   Graph[CFNode] g = delAnnotationsRec(cflowProgram(pico).graph);
   rel[tuple[str, str], tuple[str, str]] r = {<<getId(d[0]), getText(d[0], pico)>, <getId(d[1]), getText(d[1], pico)>>|tuple[CFNode, CFNode] d<-g};
   return r;
   }

list[Ele] show(str group, list[tuple[str, str]] names) {
     Ele background = n_(group, style=style(label=label(group, vAlign = "top", marginY=-10), borderColor="darkgrey"));
     key+=(d[0]:uuid().authority|tuple[str, str] d<-names);
     list[Ele] nodes = [n_(_(d[0]), style=style(label=label(d[1], vAlign = "center"), shape=roundRectangle(), width="100px", backgroundColor="snow")
     , parent=group)|tuple[str, str] d<-names];
     list[Ele] elements = nodes+background;
     return elements;
     }

Cytoscape show(tuple[str, str] names...) {
      list[Ele] elements = show("group", names);
      Cytoscape cy = cytoscape(
           elements= elements
       ,styles = [<"node", style(borderWidth = "2", borderColor="brown", padding="10")>]
       ,\layout = dagre("compound:true")
       );
     return cy;
     }
     
Cytoscape show(list[tuple[str, str]] names...) {
      list[Ele] elements =[];
      for (int i<-[0..size(names)])
           elements+= show("group<i>", names[i]);
      Cytoscape cy = cytoscape(
           elements= elements
       ,styles = [<"node", style(borderWidth = "4", borderColor="brown", padding="10")>]
       ,\layout = dagre("compound:true")
       );
     return cy;
     }
     
 list[Ele] show(str group, rel[tuple[str, str], tuple[str, str]] pairs) {
     list[tuple[str, str]] car = toList(carrier(pairs));
     list[Ele] nodes = show(group, car);
     list[Ele] edges = [e_(uuid().authority, _(d[0][0]), _(d[1][0])
           ,style=style(label=label(d[1][1]), textBackgroundColor="lightgrey", textBackgroundOpacity=1))
                 |tuple[tuple[str, str], tuple[str, str]] d <-pairs]; 
     return nodes+edges; 
     }
     
Cytoscape show(rel[tuple[str, str], tuple[str, str]] names...) {
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
     App ap = app(|project://<project>/src/demo/pico/Graph.html|
         , <"cy"
            ,show(controlFlow())
            >
           ,display = true, click=<["aap"], callbackClick>);  
    return ap;
    }
    
bool edgeLabel = true;
    
str callbackEdge(str id) {
    //println(id);
    Style styl1 = style(textBackgroundOpacity=0, textOpacity=0);
    Style styl2 = style(textBackgroundOpacity=1, textOpacity=1, textBackgroundColor="lightgrey");
    return update(styles=[<"edge", styl2>, <"node", styl1>]);
    }
    
str callbackNode(str id) {
    //  println(id);
    Style styl1 = style(textBackgroundOpacity=0, textOpacity=0);
    Style styl2 = style(textBackgroundOpacity=1, textOpacity=1, textBackgroundColor="white");
    return update(styles=[<"node", styl2>, <"edge", styl1>]);
    }
    
 str callbackClick(str id) {
    str r = edgeLabel?callbackEdge(id):callbackNode(id);
    edgeLabel= !edgeLabel;
    return r;
    }
    
public void main() {
    controlFlow();
    }