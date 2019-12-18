module demo::cluster::Graph
import Prelude;
extend Racytoscal;
import util::Math;

// n_("keter", position=<300, 160> ,style = style(label = label("\u05DB\u05EA\u05E8", vAlign = "center")))

list[Ele] show(str group, list[str] names) {
     Ele background = n_(group, style=style(label=label(group, vAlign = "top", marginY=-10), borderColor="darkgrey"));
     list[Ele] nodes = [n_(d, style=style(label=label(d, vAlign = "center")), parent=group)|str d<-names];
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
    
public App def() {
    list[Ele]  nodes = [n_("a", style=style(label=label("A", vAlign = "center")))
                       ,n_("b", style=style(label=label("B", vAlign = "center")), parent="top_group")
                       ,n_("c", style=style(label=label("C", vAlign = "center")), parent="bottom_group")
                       ,n_("d", style=style(label=label("D", vAlign = "center")), parent="bottom_group")
                       ,n_("e", style=style(label=label("E", vAlign = "center")), parent="bottom_group")
                       ,n_("f", style=style(label=label("F", vAlign = "center")), parent="bottom_group")
                       ,n_("g", style=style(label=label("G", vAlign = "center")))
                       ,n_("group", style=style(label=label("Group", vAlign = "top", marginY=-10), textBackgroundColor="#d3d7e8"))
                       ,n_("top_group", style=style(label=label("Top Group", vAlign = "bottom", marginY=10), textBackgroundColor="#ffd47f"), parent="group")
                       ,n_("bottom_group", style=style(label=label("Bottom Group", vAlign = "center"), textBackgroundColor="#5f9488"), parent="group")
                       ];
                       
    list[Ele] edges = [e_("a_b", "a", "bottom_group")
                      ,e_("b_c", "b", "c")
                      ,e_("b_d", "b", "d")
                      ,e_("b_e", "b", "e")
                      ,e_("b_f", "b", "f")
                      ,e_("b_g", "b", "g")
                      ];
    Cytoscape cy = cytoscape(
        elements= nodes+edges
       ,styles = [<"edge", style(  
                 curveStyle=straight(),lineColor="blue",
                 arrowShape=[
                     ArrowShape::triangle(
                      arrowScale=2
                     ,arrowColor="red", pos = target()
                     )
                     ]
                  )
                  >,
                  <"node", style(
                    width = "15px",
                    height= "15px", 
                    // backgroundColor="antiquewhite",
                    shape=NodeShape::ellipse(),
                    //backgroundFill="radial-gradient",
                    //backgroundGradientStopColors="antiquewhite brown",
                    borderWidth = "2", borderColor="brown"
                   ,padding = "10" 
                  )>
                  ]
          ,\layout = dagre("compound:true")
      );   
     App ap = app(|project://racytoscal/src/demo/cluster/Graph.html|, <"cy", show(["aap","noot","mies"], ["teun","gijs"])>
           ,display = true);  
    return ap;
    }