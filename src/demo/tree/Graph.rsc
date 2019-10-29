module demo::tree::Graph
import Racytoscal;
import Prelude;

public App def() {
    lrel[str, str] rl  = [
     <"brown","brown_green">,<"brown","brown_grey">,<"brown","brown_black">         
    ,<"brown_grey","brown_grey_blue">,<"brown_grey","brown_grey_red">
    ,<"brown_black","brown_black_orange">
    ];
    println([split("_", i)[-1]|str i<-dup(carrier(rl))]);
    list[Ele] edges = [e_("<a[0]><a[1]>", a[0], a[1])|a<-rl];
    list[Ele]  nodes = 
         [n_(i
              ,style=style(
                 borderColor=split("_", i)[-1]
                 ,color=split("_", i)[-1]
                 ,label=label(split("_", i)[-1] ,vAlign="center")
                ))
            |str i<-dup(carrier(rl))
         ];
    Cytoscape cy = cytoscape(elements= nodes+edges
       ,styles = [<"edge", style(  
                    curveStyle=taxi(taxiDirection=downward()),
                    arrowShape=[
                      ArrowShape::triangle(
                         arrowScale=2, arrowColor="red", pos = target())
                      ]
                      ,lineColor="blue"
                      )
                   >
                  ,<"node", style(
                     width = "15px"
                    ,height= "15px" 
                    ,backgroundColor="antiquewhite"
                    ,shape=NodeShape::ellipse()
                    ,borderWidth = "2" // , borderColor="brown"
                    ,padding = "10" 
                    ,fontSize= "8pt"
                    ,textOpacity=1
                  )>
                  ]
          ,\layout = dagre("")
        ); 
    return app(|project://racytoscal/src/demo/tree/Graph.html|, <"cy", cy>);  
    }