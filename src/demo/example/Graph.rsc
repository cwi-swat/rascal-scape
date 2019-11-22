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
          , shrink = shrink, style="fill:none;stroke:none", strokeWidth=strokeWidth0)
          , strokeWidth0>]    
          ; 
    }
    
int sw = 6;
   
SVG mondriaan() = box(LT,
                     box(RB
                        ,box(LT, strokeWidth= sw, shrink=1)
                        ,box(LT, strokeWidth= sw, shrink=1)
                        ,svgLayout=grid(1), strokeWidth= sw, hshrink=0.2, vshrink=0.8
                       , viewbox=<0,0,100, 100> )
                      ,box(LB, vshrink=0.8, strokeWidth= sw, style="fill:red")
                      ,box(RT, hshrink=0.2, strokeWidth= sw, style="fill:blue")
                      ,box(LT
                           ,box(RT, box(LT, hshrink=1.0, strokeWidth= sw)
                           ,box(LT
                                ,box(LT,strokeWidth= sw)
                                ,box(LT,strokeWidth= sw, style="fill:yellow")
                                ,svgLayout=grid(1)
                            )
                           ,svgLayout=grid(2)
                           )
                        )
                     ,svgLayout=grid(2/*, width=100, height=100*/), viewbox=<0,0,100, 100>, strokeWidth= 2,
                     width=100, height=100);
            
    
SVG genBoxes() =  box(LT, [b.fig|b<-(genBox([], "none") |genBox(it, e)|str e<-darkColors[0..7])], strokeWidth= 2, width=100, height=100);

SVG circ() = ellipse(CC, box(CC, vshrink=0.2, hshrink=0.6,  class="mark", strokeWidth=2), strokeWidth=2, rx=50, ry=50, class="circles");

SVG genCircles() = box(LT, /*circ(), circ(), circ()*/ scale(1.0, 1.0, circ()), scale(0.7, 0.7, circ()), scale(0.5, 0.5, circ())
        ,svgLayout=grid(1, width=100, height=100), viewBox=<-60,-60, 120, 120>, strokeWidth=2);
     
public App def() {
    str output  = svg(400, 1200 ,box(LT, mondriaan(),genBoxes(),genCircles(), svgLayout=grid(1, width=400, height= 400
       ),viewBox=<0,0, 300, 300>)
    );      
    App ap = app(|project://racytoscal/src/demo/example/Graph.html|, <"attach", output>);  
    return ap; 
    } 