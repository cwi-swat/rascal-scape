module demo::simple::Graph
import Prelude;
import Racytoscal;
import util::Math;

list[str] colors = ["blue", "coral", "cyan",  "gray", "green","pink","salmon"
     , "seagreen","skyblue", "slategray","steelblue", "yellow"];
     
str pickColor() {
    int d = arbInt(size(colors));
    return "<colors[d]>";
    }
    
SVG cell(tuple[Pos, Pos] pos) = box(CC
            ,box(pos, class="kernel", shrink=0.3)
         ,class="cell",shrink=1); 
    
public void main() {
    str output = svg( 800, 800, box(LT, [cell(p)|p<-getPositions()]
        ,svgLayout=grid(3)));    
    openBrowser(|project://racytoscal/src/demo/simple/Graph.html|, <"attach", output>); 
    }   
       
 