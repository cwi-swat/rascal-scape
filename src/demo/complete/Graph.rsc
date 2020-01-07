module demo::complete::Graph
import Prelude;
import Rascalscape;
import Cytoscape;
import util::Math;

public App def() {
    int n=5;
    list[Ele]  nodes = [n_("<i>")|int i<-[0..n]];
    list[Ele] edges = [*[e_("<i>_<j>", "<i>", "<j>")|int j<-[0..i]]|int i<-[0..n]];
    map[str, str] color = (s:"blue"|e_(str s, _, _)<-edges);
    str callbackTap(str id) {
        if (size(id)==1) return "";
        color[id] = (color[id]=="blue"?"red":"blue");
        // println(color[id]);
        Style styl = style(lineColor=color[id]);
        return update(styles=[<"edge#<id>", styl>]);
        }
    Cytoscape cy = cytoscape(
        elements= nodes+edges
       ,styles = [<"edge", style(  
                 curveStyle=straight(),lineColor="blue"
                  )
                  >,
                  <"node", style(
                    width = "15px",
                    height= "15px", 
                    // backgroundColor="antiquewhite",
                    shape=NodeShape::ellipse(),
                    backgroundFill="radial-gradient",
                    backgroundGradientStopColors="antiquewhite brown",
                    borderWidth = "2", borderColor="brown"
                   ,padding = "10" 
                  )>
                  ]
          ,\layout = circle("")
      );   
     App ap = app(|project://<project>/src/demo/complete/Graph.html|, <"cy", cy>
           ,display = true, tap = callbackTap);  
    return ap;
    }