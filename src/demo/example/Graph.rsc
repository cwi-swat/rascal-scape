module demo::example::Graph
import Prelude;
extend Rascalscape;
extend Colors;
import util::Math;
import Content;

public list[tuple[str name , Rascalscape::Position pos]] getPositions() = [
      <"LT", LT>, <"LC", LC>, <"LB", LB>
    , <"CT", CT>, <"CC", CC>, <"CB", CB>, <"RT", RT>, <"RC", RC>, <"RB", RB>];
    
SVG vennDiagram() = box(LT, ellipse(LT, vshrink = 0.5, hshrink=0.8, strokeWidth=0, style="fill:red", class="venn")
                          , ellipse(RT, vshrink = 0.5, hshrink= 0.8, strokeWidth=0, style="fill:green", class="venn")
                          , ellipse(CC, vshrink = 0.8, hshrink= 0.5, strokeWidth=0, style="fill:blue", class="venn")
                          , width=100, height=100, viewBox=<0,0, 100, 100>);

   
SVG mondriaan() = box(LT,
                     vcat(RB
                        ,box(LT, strokeWidth= sw, shrink=1)
                        ,box(LT, strokeWidth= sw, shrink=1)
                         strokeWidth= sw, hshrink=0.3, vshrink=0.8
                       , viewBox=<0,0,100, 100> )
                      ,box(LB, vshrink=0.5, strokeWidth= sw, style="fill:red")
                      ,box(RT, hshrink=0.5, strokeWidth= sw, style="fill:blue")
                      ,hcat(LT,
                           box(RT, box(LT, hshrink=1.0, strokeWidth= sw)
                           ,vcat(LT, 
                                box(LT,strokeWidth= sw), box(LT,strokeWidth= sw, style="fill:yellow"))
                           )
                        )
                     ,svgLayout=grid(2/*, width=100, height=100*/), viewbox=<0,0,100, 100>, strokeWidth= 2,
                     width=60, height=100);

num dim = 100;
                     
list[tuple[SVG fig, num strokeWidth]] genBox(list[tuple[SVG fig, num strokeWidth]] inner, str color, bool adjust) {
    num lw = 15;
    num shrink = 0.9;
    if (!adjust)  lw = lw*shrink*(dim-lw)/dim;    
    Position position = RB;
    num strokeWidth = isEmpty(inner)?lw:head(inner).strokeWidth;
    num strokeWidth0 = adjust?strokeWidth*shrink*(dim-strokeWidth)/dim:strokeWidth;  
    return [<box(position, [d.fig|d<-inner]
            +box(position, style="fill:none;stroke:<color>", hshrink =0.7, vshrink=1.0, strokeWidth=strokeWidth)         
          , shrink = shrink, style="fill:none;stroke:none", strokeWidth=strokeWidth0)
          , strokeWidth0>]    
          ; 
    }
    
int sw = 4;
            
SVG genBoxes(bool adjust) =  box(LT, [b.fig|b<-(genBox([], "red", adjust) |genBox(it, e, adjust)|str e<-darkColors[0..3])], strokeWidth= 2, width=100, height=100);

SVG circ() = ellipse(CC, box(CC, vshrink=0.2, hshrink=0.6,  class="mark", strokeWidth=2), strokeWidth=2, rx=50, ry=50, class="circles");

SVG genCircles() = scale(0.5, 0.5, box(LT,  scale(1.0, 1.0, circ()), scale(0.7, 0.7, circ()), scale(0.5, 0.5, circ())
        ,svgLayout=grid(1, width=100, height=100), viewBox=<-60,-60, 120, 120>, strokeWidth=2));
     

str output()  = svg(400, 2000 ,box(LT, vennDiagram(), mondriaan(),genBoxes(true),genBoxes(false), genCircles(), svgLayout=grid(1, width=300, height= 300
       ),viewBox=<0,0, 150, 150>)
    );
    
public App def() {      
    App ap = app(|project://<project>/src/demo/example/Graph.html|, <"attach", output()>);  
    return ap; 
    } 
    
public Content example() {  
    return show(|project://<project>/src/demo/example/Graph.html| 
           ,<"attach", output()>
          );
    }    