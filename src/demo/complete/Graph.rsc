module demo::complete::Graph
import Prelude;
import Racytoscal;
import util::Math;

map[str, str] color = ();

str callbackTap(str id) {
    color[id] = (color[id]=="blue"?"red":"blue");
    // println(color[id]);
    Style styl = style(lineColor=color[id]);
    str r = Racytoscal::toString([<"edge#<id>", styl>]);
    return "{\"styles\":<r>}";
    }
    
public void main() {
    int n=5;
    list[Ele]  nodes = [n_("<i>")|int i<-[0..n]];
    list[Ele] edges = [*[e_("<i>_<j>", "<i>", "<j>")|int j<-[0..i]]|int i<-[0..n]];
    color = (s:"blue"|e_(str s, _, _)<-edges);
    str output = genScript("cy", cytoscape(
        elements= nodes+edges
       ,styles = [<"edge", style(  
                 curveStyle=straight(),lineColor="blue"
               )
                  >,
                  <"node", style(
                    width = "15px",
                    height= "15px", 
                    // backgroundColor="antiquewhite",
                    shape=ellipse(),
                    backgroundFill="radial-gradient",
                    backgroundGradientStopColors="antiquewhite brown",
                    borderWidth = 2, borderColor="brown"
                   ,padding = 10 
                  )>
                  ]
          ,\layout = circle("")
        )
      ); 
    openBrowser(|project://racytoscal/src/demo/complete/Graph.html|, output, tap = callbackTap);  
    }