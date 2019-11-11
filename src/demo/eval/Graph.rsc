module demo::eval::Graph
import Prelude;
extend Racytoscal;
extend Colors;
import util::Math;
import util::Eval;

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
        ), width=1000, height = f*1000, strokeWidth=4, viewBox=<0,0, 1000, 1000>));    
    return output;
    } 
    
str action(str s) {
   println(s);
   list[str] v = split("/", s); 
   str expr = v[-1];
   println(eval(expr+";"));
   return expr;
   }
   
 public App def() { 
    str output = rows(); 
    App ap = app( |project://racytoscal/src/demo/eval/Graph.html|
      ,change= <["enter-field"], action>);
    return ap;
    }
/* 
.Examples

[source,rascal-shell]
----
import util::Eval;
eval("2 * 3;");
eval(["X = 2 * 3;", "X + 5;"]);
---- 
*/   
public void main() {
    println(eval("2+3;"));
    }
      
 