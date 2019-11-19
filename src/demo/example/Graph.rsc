module demo::example::Graph
import Prelude;
extend Racytoscal;
extend Colors;
import util::Math;

public list[tuple[str name , Racytoscal::Position pos]] getPositions() = [
      <"LT", LT>, <"LC", LC>, <"LB", LB>
    , <"CT", CT>, <"CC", CC>, <"CB", CB>, <"RT", RT>, <"RC", RC>, <"RB", RB>];
    
list[tuple[SVG fig, num strokeWidth]] genBox(list[tuple[SVG fig, num strokeWidth]] inner, str color) {
    num shrink = 0.9;
    num strokeWidth = isEmpty(inner)?40:head(inner).strokeWidth*shrink*(400-head(inner).strokeWidth)/400;
    return [<box(RB, [d.fig|d<-inner], shrink = shrink, style="fill:none;stroke:<color>",
          strokeWidth=strokeWidth), strokeWidth>]; 
    }
     
public App def() {
    str output  = svg(400,400, (genBox([], "red") |genBox(it, e)|str e<-darkColors[0..12]).fig);      
    App ap = app(|project://racytoscal/src/demo/example/Graph.html|, <"attach", output>);  
    return ap; 
    } 