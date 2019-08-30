module demo::frame::Graph
import Prelude;
import Racytoscal;
import util::Math;

list[str] colors = ["blue", "coral", "cyan",  "gray", "green","pink","salmon"
     , "seagreen","skyblue", "slategray","steelblue", "yellow"];
     
str pickColor() {
    int d = arbInt(size(colors));
    return "<colors[d]>";
    }
/*    
public void main() {
     num step = 0.1;
     int width =600, height = 600;
     str output = svg(width, height
        ,frame(1, 1/PI(), <"x-axe", ["0","\u03C0/2","\u03C0","3\u03C0/2","2\u03C0"]>
                        ,<"y-axe", ["-1","0","1"]>
                        ,<"sin",[<x, sin(x)>|num x<-[0,step..2*PI()+step]]>
                        ,<"cos",[<x, cos(x)>|num x<-[0,step..2*PI()+step]]>
        , viewBox = <0, -1, 2*PI(), 2>));
     openBrowser(|project://racytoscal/src/demo/frame/Graph.html|, <"attach", output>); 
     }
 */

   
public void main() {
     num step = 0.1;
     int width =1600, height = 800;
     str output = svg(width, height, 
       box(CC, 
          box(LT, frame(1, 1, <"x-axe", ["<i>"|num i<-[0,0.1..1]]>
                        ,<"y-axe", ["<i>"|num i<-[0,0.1..1]]>
                        ,[<"left",[<0, x>, <1-x, 0>]>|num x<-[0,0.01..1]]
                        +
                         [<"right",[<1, x>, <1-x, 1>]>|num x<-[0,0.01..1]]
        , viewBox = <0, 0, 1, 1>, width = width, height = height)
         , ellipse(CC, text(500, 500, "Hallo", class="text"), shrink = 0.3, id="sign", strokeWidth=16
           )
           , strokeWidth = 2
        )
        ,
        box(LT, frame(1, 1/PI(), <"x-axe", ["0","\u03C0/2","\u03C0","3\u03C0/2","2\u03C0"]>
                        ,<"y-axe", ["-1","0","1"]>
                        ,<"sin",[<x, sin(x)>|num x<-[0,step..2*PI()+step]]>
                        ,<"cos",[<x, cos(x)>|num x<-[0,step..2*PI()+step]]>
        , viewBox = <0, -1, 2*PI(), 2>), strokeWidth=2)
        , shrink = 0.8, strokeWidth = 0, svgLayout=grid(2)
        )
        );
     openBrowser(|project://racytoscal/src/demo/frame/Graph.html|, <"attach", output>); 
     }

       