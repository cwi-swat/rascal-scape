module demo::colors::Graph
import Prelude;
extend Racytoscal;
extend Colors;
import util::Math;

int ncols = 8;

str onChange(str path) {
    num opacity = toReal(split("/", path)[1]);
    return executeInBrowser(css=[<"ellipse", "fill-opacity","<_(opacity)>">]);
    }

 
SVG cell(str name) = box(CC
            ,box(LT, text(500, 250, name), class="kernel", vshrink=0.5, strokeWidth=0, viewBox=<0,0, 1000, 500>)
            ,box(LB, style="fill:<name>", class="kernel", vshrink=0.5, strokeWidth=0, viewBox=<0,0, 1000, 500>)
                   , class="cell", height=1000, width= 1000, strokeWidth=6, viewBox=<0,0, 1000, 1000>); 
           
public str rows() {
    str output = svg( 2000, 4000, box(LT, [cell(p)|p<-sort(domain(color))]
        ,svgLayout=grid(ncols
         , width=125, height = 125
        )
      , strokeWidth=4, viewBox=<0,0, 1000, 1000>));    
    return output;
    }
    
public str panel() {
    str output = svg( 400, 400
    , ellipse(<C(-0.5*sqrt(3)),C(0.5)>,  rx=1, ry=1, style="fill:red")
    , ellipse(<C(0.5*sqrt(3)),C(0.5)>,  rx=1, ry=1, style="fill:blue")
    , ellipse(<C(0),C(1)>, rx=1, ry=1,  style="fill:yellow")
    , viewBox=<-4,-4, 8, 8>);    
    return output;
    }  
   
 public App def() { 
    App ap = app( |project://racytoscal/src/demo/colors/Graph.html|
    , <"attach", rows()>
     , <"panel", panel()>
    , change=<["slider"], onChange>);
    return ap;
    } 
      
 