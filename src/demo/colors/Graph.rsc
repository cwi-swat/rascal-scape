module demo::colors::Graph
import Prelude;
extend Racytoscal;
extend Colors;
import util::Math;

int ncols = 8;
int marg = 0;

num nrows = ceil(size(color)/ncols);

num f = nrows/ncols;
     public list[tuple[str name , Racytoscal::Position pos]] getPositions() = [
      <"LT", LT>, <"LC", LC>, <"LB", LB>
    , <"CT", CT>, <"CC", CC>, <"CB", CB>, <"RT", RT>, <"RC", RC>, <"RB", RB>];
     
str pickColor() {
    int d = arbInt(size(colors));
    return "<colors[d]>";
    }
    
SVG cell(str name) = box(CC
            ,box(LT, text(500, 250, name), class="kernel", vshrink=0.5, strokeWidth=0, viewBox=<0,0, 1000, 500>)
            ,box(LB, style="fill:<name>", class="kernel", vshrink=0.5, strokeWidth=0, viewBox=<0,0, 1000, 500>)
                   , class="cell", height=1000, width= 1000, strokeWidth=0, viewBox=<0,0, 1000, 1000>); 
           
public str rows() {
    println(f);
    str output = svg( 2000, 4000, box(LT, [cell(p)|p<-sort(domain(color))]
        ,svgLayout=grid(ncols
        // , preserveAspectRatio="none"
        ), width=1000+500, height = f*(1000+500), strokeWidth=4, viewBox=<0,0, 1000, 1000>), viewBox=<0,0, 2000, 4000>);    
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
      
 