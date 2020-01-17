module demo::simple::Graph
import Prelude;
import Rascalscape;
import util::Math;

import Content;

     
public list[tuple[str name , Rascalscape::Position pos]] getPositions() = 
    [ <"LT", LT>, <"LC", LC>, <"LB", LB>
    , <"CT", CT>, <"CC", CC>, <"CB", CB>
    , <"RT", RT>, <"RC", RC>, <"RB", RB>
    ];
    
SVG cell(tuple[str name, Rascalscape::Position pos] p) = box(CC
            ,box(p.pos, text(500, 500, p.name), class="kernel" , shrink=0.4, strokeWidth=40)
         ,class="cell", strokeWidth=60); 
           
public str rows() {
    str output = svg( 2000, 2000
        ,box(LT, [cell(p)|p<-getPositions()]
               , svgLayout=grid(5, width=200, height=200)
               , viewBox=<0,0, 1000, 1000>
             )
         );    
    return output;
    } 
   
 public App def() { 
    str output = rows(); 
    App ap = app( |project://<project>/src/demo/simple/Graph.html|, <"attach", output>);
    return ap;
    } 
      
      
public Content show() { 
    str output = rows(); 
    Content ap = show("lib", |project://<project>/src/demo/simple/Graph.html|, <"attach", output>);
    return ap;
}      
 