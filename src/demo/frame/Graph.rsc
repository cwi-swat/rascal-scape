module demo::svg::Graph
import Prelude;
import Racytoscal;
import util::Math;

list[str] colors = ["blue", "coral", "cyan",  "gray", "green","pink","salmon"
     , "seagreen","skyblue", "slategray","steelblue", "yellow"];
     
str pickColor() {
    int d = arbInt(size(colors));
    return "<colors[d]>";
    }
    
str frame(list[str] xAxe, list[str] yAxe, ViewBox viewBox, num step, num fun(num x)) {
    num shrnk = 0.9;
    num shift = (1-shrnk)/2;
    num dx = viewBox.width/size(xAxe), dy = viewBox.height/size(yAxe);
    str r = box(<L1(shift),L1(shift)>
              ,path(
                "<for (num i<-[viewBox.left+dx,viewBox.left+2*dx..viewBox.right]){> M 0 <i> H <_(2*PI())> <}><for (num i<-[PI()/10,2*PI()/10.._(2*PI())]){> M <_(i)> -1 V 1 <}>"
                ,class="path"
                ));
    }
    
public void main() { 
    num f  = 0.90;
    num xy = (1-f)/2;
    str output = svg(800,800 
          ,box(<L1(0),L1(xy)>, text(0.5, 0, "0", class="text-axe") , hshrink=xy, vshrink= f/PI(), class="axe", strokeWidth=0.5, viewBox = <0, -2.5, 1, 5>) 
          ,box(<L1(0), L1(xy+f/PI())>
               , text(1, 11*xy, "0", class="text-axe")
               , text(11, 11*xy, "\u03C0", class="text-axe")
               , text(21, 11*xy, "2\u03C0", class="text-axe")
               , hshrink=1, vshrink= xy, class="axe", strokeWidth=0.5, viewBox = <0, 0, 2*11, 2*11*xy>)                 
         , box(<L1(xy), L1(xy)>
            ,path(
                "<for (num i<-[-0.8,-0.6..1]){> M 0 <i> H <_(2*PI())> <}><for (num i<-[PI()/10,2*PI()/10.._(2*PI())]){> M <_(i)> -1 V 1 <}>"
                ,class="path"
                )
            ,path("M 0, <_(sin(0))> <for (num i<-[PI()/100,2*PI()/100..2*PI()+0.0001]){> L <_(i)>, <_(sin(i))> <}>", class="sin")
         , viewBox = <0, -1, 2*PI(), 2>, hshrink = f, vshrink=f /PI(), class="frame", strokeWidth=0.5)
          )
          ; 
    // println(output);
    str onload(str path) {
         return executeInBrowser(html=[<"attach", output>]);               
    }     
    openBrowser(|project://racytoscal/src/demo/frame/Graph.html|, load=onload); 
    }

    
 