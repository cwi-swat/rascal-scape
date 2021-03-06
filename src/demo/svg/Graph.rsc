module demo::svg::Graph
import Prelude;
import Rascalscape;
import util::Math;

list[str] colors = ["blue", "coral", "cyan",  "gray", "green","pink","salmon"
     , "seagreen","skyblue", "slategray","steelblue", "yellow"];
     
str pickColor() {
    int d = arbInt(size(colors));
    return "<colors[d]>";
    }
    
public list[tuple[str name , Rascalscape::Position pos]] getPositions() = [
      <"LT", LT>, <"LC", LC>, <"LB", LB>
    , <"CT", CT>, <"CC", CC>, <"CB", CB>, <"RT", RT>, <"RC", RC>, <"RB", RB>];
     
public App tst() { 
    str styl = "fill:beige; stroke:red";
    str html(ViewBox viewBox)  = svg(400,400      
         , box(LT
                  ,[ellipse(pos[1] , ellipse(pos[1], shrink=0.5, class="inner-tst", strokeWidth = 4)
                           , shrink=0.3, class = "tst", strokeWidth = 4
                    )|pos<-getPositions()]
                    , style=styl 
                        , hshrink = 1.0, vshrink=1.0
                       , id="frame", strokeWidth=4)
          , viewBox = viewBox)
          ; 
    str onload(str path) {
         return update(html=[<"attach1", html>,<"attach2", html>]);               
    }     
    App ap = app(|project://<project>/src/demo/svg/Graph.html|
       , <"attach1", html(<0, 0, 400, 400>)>, <"attach2", html(<0, 0, 200, 200>)>
       //, load = onload
       );  
    return ap; 
    }


public App def() { 
    str styl = "fill:beige; stroke:red";
    str html = svg(800,800
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
                    , style=styl, viewBox = <0, 0, 200, 100>, hshrink = 0.6, vshrink=0.3, style=styl)
          , box(LB, text(10, 10, "Roos tussen het vuil en nat",    class="text")
                 , text(10, 20, "Ongebroken mooi, je lachte wat",    class="text")
                 , style=styl, viewBox = <0, 0, 200, 100>, hshrink = 0.6, vshrink=0.3, style=styl)
          )
          ; 
    
    str onload(str path) {
         return update(html=[<"attach1", html>]);               
    }     
    App ap = app(|project://<project>/src/demo/svg/Graph.html|, <"attach1", html>);  
    return ap;
    }

    
 
 
 