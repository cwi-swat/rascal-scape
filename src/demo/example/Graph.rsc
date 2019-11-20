module demo::example::Graph
import Prelude;
extend Racytoscal;
extend Colors;
import util::Math;

num dim = 400;

public list[tuple[str name , Racytoscal::Position pos]] getPositions() = [
      <"LT", LT>, <"LC", LC>, <"LB", LB>
    , <"CT", CT>, <"CC", CC>, <"CB", CB>, <"RT", RT>, <"RC", RC>, <"RB", RB>];
    
list[tuple[SVG fig, num strokeWidth]] genBox(list[tuple[SVG fig, num strokeWidth]] inner, str color) {
    num lw = 30; 
    num shrink = 0.9;  
    Position position = RB;
    num strokeWidth = isEmpty(inner)?lw:head(inner).strokeWidth;
    num strokeWidth0 = isEmpty(inner)?lw:strokeWidth*shrink*(dim-strokeWidth)/dim;  
    return [<box(position, [
                 d.fig  
             |d<-inner]
             +box(position, style="fill:none;stroke:<color>", hshrink =0.7, vshrink=1.0, strokeWidth=strokeWidth)         
          , shrink = shrink, style="fill:none", strokeWidth=strokeWidth0)
          , strokeWidth0>]    
          ; 
    }
    
SVG genBoxes() = (genBox([], "none") |genBox(it, e)|str e<-darkColors[0..7]).fig;

SVG circ() = ellipse(CC, box(CC, vshrink=0.2, hschrink=0.8,  class="mark", strokeWidth=2), strokeWidth=2, rx=50, ry=50, class="circles");

SVG genCircles() = box(LT, /*circ(), circ(), circ()*/ scale(1.0, 1.0, circ()), scale(0.7, 0.7, circ()), scale(0.5, 0.5, circ())
        ,svgLayout=grid(1, width=100, height=100), viewBox=<-60,-60, 120, 120>, strokeWidth=2);
     
public App def() {
    str output  = svg(dim,dim,genCircles()// ,genBoxes()
    );      
    App ap = app(|project://racytoscal/src/demo/example/Graph.html|, <"attach", output>);  
    return ap; 
    } 