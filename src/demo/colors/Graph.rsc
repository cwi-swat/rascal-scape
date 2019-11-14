module demo::colors::Graph
import Prelude;
extend Racytoscal;
extend Colors;
import util::Math;

int ncols = 8;

num nrows = ceil(size(color)/ncols);

num f = nrows/ncols;
 
SVG cell(str name) = box(CC
            ,box(LT, text(500, 250, name), class="kernel", vshrink=0.5, strokeWidth=0, viewBox=<0,0, 1000, 500>)
            ,box(LB, style="fill:<name>", class="kernel", vshrink=0.5, strokeWidth=0, viewBox=<0,0, 1000, 500>)
                   , class="cell", height=1000, width= 1000, strokeWidth=6, viewBox=<0,0, 1000, 1000>); 
           
public str rows() {
    str output = svg( 2000, 4000, box(LT, [cell(p)|p<-sort(domain(color))]
        ,svgLayout=grid(ncols
        // , width=125, height = 125
        )
       , width=1000, height = f*1000
      , strokeWidth=4, viewBox=<0,0, 1000, 1000>));    
    return output;
    } 
   
 public App def() { 
    str output = rows(); 
    App ap = app( |project://racytoscal/src/demo/colors/Graph.html|, <"attach", output>);
    return ap;
    } 
      
 