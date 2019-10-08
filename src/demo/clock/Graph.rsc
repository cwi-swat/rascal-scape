module demo::clock::Graph
import Prelude;
extend Racytoscal;
import util::Math;

list[str] colors = ["blue", "coral", "cyan",  "gray", "green","pink","salmon"
     , "seagreen","skyblue", "slategray","steelblue", "yellow"];
     
str pickColor() {
    int d = arbInt(size(colors));
    return "<colors[d]>";
    } 
    
int nMayor = 60; 
num step  =2*PI()/nMayor; 
int scale = 600;
int delta = 0;
int width = 25;
int height = 25;
int strokeWidth = 18;
     
public App def() { 
    str html(ViewBox viewBox)  = svg(400,400      
         ,box(LT,  ellipse(CC, width=scale-width/2+strokeWidth, height = scale-height/2+strokeWidth, class="bound", 
                   strokeWidth=strokeWidth)
                   ,ellipse(CC, [box(<C(500*cos(phi)), C(500*sin(phi))>, width=width, height=height, class = "mayor")|
                       num phi<-[0,step..2*PI()+step/2]
                  ], viewBox=<-(1000+width)/2, -(1000+height)/2, 1000+width, 1000+height>,
                     width= scale, height = scale, class = "outer", strokeWidth=0 
                   )
                   
               , viewBox=<-(1000+width)/2, -(1000+height)/2, 1000+width, 1000+height>          
               ,class="frame", strokeWidth=4      
             )
              ,viewBox = viewBox             
          )
          ;    
    App ap = app(|project://racytoscal/src/demo/clock/Graph.html|
       , <"attach", html(<0, 0, 100, 100>)>
       );  
    return ap; 
    }

    
 
 
 