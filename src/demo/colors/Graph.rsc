module demo::colors::Graph
import Prelude;
extend Racytoscal;
extend Colors;
import util::Math;

     public list[tuple[str name , Racytoscal::Position pos]] getPositions() = [
      <"LT", LT>, <"LC", LC>, <"LB", LB>
    , <"CT", CT>, <"CC", CC>, <"CB", CB>, <"RT", RT>, <"RC", RC>, <"RB", RB>];
     
str pickColor() {
    int d = arbInt(size(colors));
    return "<colors[d]>";
    }
    
SVG cell(str name) = box(CC
            ,box(LT, text(500, 250, name), class="kernel", vshrink=0.5, strokeWidth=4, viewBox=<0,0, 1000, 1000>)
            ,box(LB, text(500, 250, name), class="kernel", vshrink=0.5, strokeWidth=4, viewBox=<0,0, 1000, 1000>)
                   , class="cell", height=100, width=1000, strokeWidth=6, viewBox=<0,0, 100, 1000>); 
           
public str rows() {
    str output = svg( 1000, 1500, box(LT, [cell(p)|p<-color]
        ,svgLayout=grid(10), viewBox=<0,0, 1000, 1500>));    
    return output;
    } 
/*     
str nesting(list[str] colors, num shrink = 1.0, num strokeWidth = 10) {
     list[SVG] step(list[SVG] aggr, str color, num shrink = 1.0)  {
     return [
         box(RC, aggr, shrink = shrink, strokeWidth=strokeWidth, style="stroke:<color>")
        ,box(LC, aggr, shrink = shrink, strokeWidth=strokeWidth, style="stroke:<color>")
        ];
     }
     
str output = svg( 600, 600, 
       rotate(PI()/4, 
    box(CC
      ,([box(CC, style="stroke:<head(colors)>", shrink = shrink, strokeWidth=strokeWidth)]|step(it, color, shrink = shrink)|color<-tail(colors))
    , width = 400, height = 400, lineWidth=2, class="aap", viewBox=<0,0, 1000, 1000>)
     )
     ,viewBox=<-500, -500, 1000, 1000>
    );
    return output;
    }
 */
   
 
 public App def() { 
    // str output = nesting(take(4, colors), strokeWidth=40, shrink = 0.4);
    str output = rows(); 
    App ap = app( |project://racytoscal/src/demo/colors/Graph.html|, <"attach", output>);
    return ap;
    } 
      
 