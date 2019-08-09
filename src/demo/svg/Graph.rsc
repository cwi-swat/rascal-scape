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
    
public void frame() { 
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
    openBrowser(|project://racytoscal/src/demo/svg/Graph.html|, load=onload); 
    }

    
public void tst() { 
    str styl = "fill:beige; stroke:red";
    
    str output = svg(800,800      
         , box(LT
                  ,[ellipse(pos , ellipse(pos, shrink=0.5, class="inner-tst")
                     // , height=30, width=30
                     , shrink=0.3
                     , class = "tst", padding=pct(<0, 0, 0, 0>)
                    )|pos<-getPositions()]
                 
                    , style=styl, viewBox = <0, 0, 200, 200>
                        , hshrink = 1.0, vshrink=1.0
                       // , width = 70, height = 70
                       , id="frame", strokeWidth=4)
          )
          ; 
    str onload(str path) {
         return executeInBrowser(html=[<"attach", output>]);               
    }     
    openBrowser(|project://racytoscal/src/demo/svg/Graph.html|, load=onload); 
    }


public void short() { 
    str styl = "fill:beige; stroke:red";
    str output = svg(800,800
         , htmlObject(LT, centerText(
                                       "Zie haar lonken in het leven"
                                       ,"Kijk haar spelen met de wind"
                                       ,"Prikkels die haar gloed me geven"
                                       ,"Houd me voor haar stekels blind"
                                    )                     
         , vshrink = 0.3, hshrink = 0.6, class="aap", style=styl)
             
         , box(LC, text(10, 10, "Ik weet niet waarop ik wachtte",    class="text")
                 , text(10, 20, "Toen die avond in de stad",    class="text")
                 , text(10, 30, "Ik naar huis liep en ik zag je",    class="text")
                    , style=styl, viewBox = <0, 0, 100, 50>, hshrink = 0.6, vshrink=0.3, style=styl)
          , box(LB, text(10, 10, "Roos tussen het vuil en nat",    class="text")
                 , text(10, 20, "Ongebroken mooi, je lachte wat",    class="text")
                 , style=styl, viewBox = <0, 0, 50, 50>, hshrink = 0.3, vshrink=0.3, style=styl)
          )
          ; 
    // openBrowser(|project://racytoscal/src/demo/svg/Graph.html|, genScript("attach", output));
    str onload(str path) {
         return executeInBrowser(html=[<"attach", output>]);               
    }     
    openBrowser(|project://racytoscal/src/demo/svg/Graph.html|, load=onload); 
    }

public void main() {
    int lw  = 4;
    int x = 20, y = 20, width = 40, height = 30;
    str output = svg(600, 600, <0, 0, 100, 100>,
     rect(L(0),L(0), 100, 100, 2, "fill:antiquewhite; stroke:cyan"
       ,inner=[
        ellipse(L(0),L(0), width, height, lw, "fill:beige; stroke:red"
         ,inner=[rect(C(50),C(50), 90, 90, 4, "fill:yellow; stroke:blue" )]
        )    
       ,rect(R(100),L(0), width, height, lw/2, "fill:beige; stroke:red")
       ,rect(L(0),R(100), width, height, lw/2, "fill:beige; stroke:red") 
       ,rect(R(100),R(100), width, height, lw/2, "fill:beige; stroke:red"
         ,inner=[rect(R(100),R(100), 80, 80, 8, "fill:yellow; stroke:blue"
           , inner = [rect(R(100),R(100), 70, 70, 8, "fill:yellow; stroke:grey")] )]
         )
       ,rect(C(50),C(50), width, height, lw, "fill:beige; stroke:red") 
      ])   
    );
    // println(output);
    //str output = svg(400, 400, <0, 0, 100, 100>,
    //     "\<rect width=<width> height=<height> x=<x> y = <y>
    //     ' style = \"fill:coral; stroke:cyan\" \</rect\>");
    str onload(str path) {
         return executeInBrowser(html=[<"attach", output>]);               
    }
    openBrowser(|project://racytoscal/src/demo/svg/Graph.html|, genScript("attach", output));   
    }
    
 /*
 int lw = 10;
 svg(400, 400, <0, 0, 100, 100>,
     rect(L(0),L(0), 100, 100, lw, "fill:antiquewhite; stroke:cyan")
       ,rect(L(0),L(0), 20, 20, lw, "fill:coral; stroke:cyan") 
       ,rect(R(100),L(0), 20, 20, lw, "fill:coral; stroke:cyan")
       ,rect(L(0),R(100), 20, 20, lw, "fill:coral; stroke:cyan") 
       ,rect(R(100),R(100), 20, 20, lw, "fill:coral; stroke:cyan" )
       ,rect(C(50),C(50), 20, 20, lw, "fill:coral; stroke:cyan")    
    )
 svg(400, 400, <0, 0, 100, 100>,
     rect(LT(0,0), 100, 100, lw, "fill:antiquewhite; stroke:cyan")
       ,foreignObject(C(50,50), 20, 20, lw, "fill:coral; stroke:cyan", "\<div\>Hallo\</div\>")
    )
 svg(400, 400, <0, 0, 100, 100>,
     rect(LT(0,0), 100, 100, lw, "fill:antiquewhite; stroke:cyan")
       ,path("M 10 10 H 90 V 90 H 10 Z", "stroke-width:2")
    )
 svg(400, 400, <0, 0, 100, 100>,
     rect(LT(0,0), 100, 20, lw, "fill:antiquewhite; stroke:cyan")
       ,text("hallo"), viewBox=<0,0,0, 20>
    )
 svg(400, 400, <0, 0, 100, 100>,
     rect(LT(0,0), 100, 100, lw, "fill:antiquewhite; stroke:cyan")
       ,ellipse(TL(0,0), 20, 20, lw, "fill:coral; stroke:cyan") 
       ,ellipse(RT(100,0), 20, 20, lw, "fill:coral; stroke:cyan")
       ,ellipse(LB(0,100), 20, 20, lw, "fill:coral; stroke:cyan") 
       ,ellipse(RB(100,100), 20, 20, lw, "fill:coral; stroke:cyan" )
       ,ellipse(C(50,50), 20, 20, lw, "fill:coral; stroke:cyan")    
    )
 */
 
 
 