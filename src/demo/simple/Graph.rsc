module demo::simple::Graph
import Prelude;
extend Racytoscal;
import util::Math;

list[str] colors = ["blue", "coral", "cyan",  "gray", "green","pink","salmon"
     , "seagreen","skyblue", "slategray","steelblue", "yellow"];
     
public list[tuple[str name , Racytoscal::Position pos]] getPositions() = [
      <"LT", LT>, <"LC", LC>, <"LB", LB>
    , <"CT", CT>, <"CC", CC>, <"CB", CB>, <"RT", RT>, <"RC", RC>, <"RB", RB>];
     
str pickColor() {
    int d = arbInt(size(colors));
    return "<colors[d]>";
    }
    
SVG cell(tuple[str name, Racytoscal::Position pos] p) = box(CC
            ,box(p.pos, text(500, 500, p.name), class="kernel", shrink=0.4, strokeWidth=40)
         ,class="cell",shrink=1, strokeWidth=60); 
           
public str rows() {
    str output = svg( 600, 600, box(LT, [cell(p)|p<-getPositions()]
        ,svgLayout=grid(5)));    
    return output;
    } 
     
str nesting(list[str] colors, num shrink = 1.0, num strokeWidth = 10) {
     list[SVG] step(list[SVG] aggr, str color, num shrink = 1.0)  {
     return [
         box(RC, aggr, shrink = shrink, strokeWidth=strokeWidth, style="stroke:<color>")
        ,box(LC, aggr, shrink = shrink, strokeWidth=strokeWidth, style="stroke:<color>")
        ];
     }
     
    str output = svg( 600, 600, 
    ([box(CC, style="stroke:<head(colors)>", shrink = shrink, strokeWidth=strokeWidth)]|step(it, color, shrink = shrink)|color<-tail(colors))
    ,viewBox=<0, 0, 1000, 1000>);
    return output;
    }
   
 
 public App def() { 
    // str output = nesting(take(4, colors), strokeWidth=40, shrink = 0.4);
    str output = rows(); 
    App ap = app( |project://racytoscal/src/demo/simple/Graph.html|, <"attach", output>);
    return ap;
    } 
      
 