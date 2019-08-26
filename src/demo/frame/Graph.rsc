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
    
list[SVG] graph(ViewBox viewBox, tuple[str \class, lrel[num x, num y] d] graphs...) {
    list[SVG] r = [];
    for (tuple[str \class, lrel[num x, num y] d] graph<-graphs) {
          r+=path(
          "M <_(graph.d[0].x)> <_(-graph.d[0].y)> 
          '<for (tuple[num x, num y] g <-tail(graph.d)){> L <_(g.x)> <_(-g.y)> <}>"
               ,class=graph.class
                );
    }
    return r;
  }
    
str frame(num hshrink, num vshrink, tuple[str \class, list[str] d] xAxe, tuple[str \class, list[str] d] yAxe
    , tuple[str \class, lrel[num x, num y] d] graphs... ,ViewBox viewBox =<0, 0, 100, 100>) {
    num shrnk = 0.9;
    num shift = (1-shrnk)/2;
    num dx = viewBox.width/(size(xAxe.d)-1), dy = viewBox.height/(size(yAxe.d)-1);
    num width = 800, height = 800;
    yAxe.d = reverse(yAxe.d);
    ViewBox  viewBoxXaxe = <-width*shift, 0, width*(hshrink*shrnk+2*shift), shift*height>,
             viewBoxYaxe = <0, -height*shift, shift*width, height*(vshrink*shrnk+2*shift)>;  
    num dxX = (width*hshrink*shrnk)/(size(xAxe.d)-1), 
        dyY = (height*vshrink*shrnk)/(size(yAxe.d)-1);            
    str r = svg(width, height, box(<L1(shift),L1(shift)>
             ,[path(
                "<for (num i<-[viewBox.y+dy,viewBox.y+2*dy..viewBox.y+viewBox.height-dy/2]){> M <_(viewBox.x)> <_(i)> H <_(viewBox.x+viewBox.width)> <}>"
                ,class=xAxe.class) 
              ,path(
                "<for (num i<-[viewBox.x+dx,viewBox.x+2*dx..viewBox.x+viewBox.width-dx/2]){> M <_(i)> <_(viewBox.y)> V <_(viewBox.y+viewBox.height)> <}>"
               ,class=yAxe.class
                )]
               +graph(viewBox, graphs)
                ,hshrink=hshrink*shrnk, vshrink = vshrink*shrnk, viewBox= viewBox)
              ,box(<L1(0), L1(0)>,
                   [text(viewBoxYaxe.width/2, y, yAxe.d[i], class=yAxe.class)
                     | int i <-[0..size(yAxe.d)], num y := (i*dyY)]             
                   , vshrink=vshrink*shrnk+2*shift, hshrink = shift, class=yAxe.class
                   , viewBox=viewBoxYaxe)
              ,box(<L1(0), L1(vshrink*shrnk+shift)>
                    , [text(x, viewBoxXaxe.height/2, xAxe.d[i], class=xAxe.class)
                    | int i<-[0..size(xAxe.d)], num x := i*dxX]
                   , vshrink= shift, hshrink = hshrink*(shrnk+2*shift), class=xAxe.class
                    , viewBox=viewBoxXaxe)
                );
    return r;
    }
    
public void main() {
     num step = 0.1;
     str output = frame(1, 1/PI(), <"x-axe", ["0","\u03C0","2\u03C0"]>
                        ,<"y-axe", ["-1","0","1"]>
                        ,<"sin",[<x, sin(x)>|num x<-[0,step..2*PI()+step]]>
                        ,<"cos",[<x, cos(x)>|num x<-[0,step..2*PI()+step]]>
        , viewBox = <0, -1, 2*PI(), 2> );
     openBrowser(|project://racytoscal/src/demo/frame/Graph.html|, <"attach", output>); 
     }

       