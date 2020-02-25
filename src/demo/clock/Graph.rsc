module demo::clock::Graph
import Prelude;
import Rascalscape;
import util::Math;
import Content;

list[str] colors = ["blue", "coral", "cyan",  "gray", "green","pink","salmon"
     , "seagreen","skyblue", "slategray","steelblue", "yellow"];
     
str pickColor() {
    int d = arbInt(size(colors));
    return "<colors[d]>";
    } 
    
int nMayor = 12; 
int nMinor = 60;
num stepMayor  =2*PI()/nMayor; 
num stepMinor  =2*PI()/nMinor; 
int scale = 1000;
int delta = 0;
int width = 100;
int height = 100;
int labelWidth = 100;
int labelHeight = 100;
int strokeWidth = 18;
int r = 400;
int lmayor = 30;
int lminor = 15;
int rdot = 20;
    
str onChange(str path) {
    int rot = toInt(split("/", path)[1]);
    int deg = 6*rot;
    return update(transform=[<"time", "rotate(<deg>)">]);
    }

SVG pointer(num rad, num r) {
   return rotate(rad, path(
   "M 0 0 L <0> <_(-r)> M -20, <_(-r)> A 20,40 0,0,1 20, <_(-r)> L -20 <_(-r)>"
   , class="pointer"), id = "time");
   }
     

 str html(ViewBox viewBox)  = svg(400,400      
         ,box(CC,  [ellipse(CC, width=2*r+strokeWidth, height = 2*r+strokeWidth, class="bound", 
                   strokeWidth=strokeWidth)]
                   +[ellipse(<C(r*cos(phi)), C(r*sin(phi))>
                       , path("M <_(-strokeWidth/2*cos(phi))> <_(-strokeWidth/2*sin(phi))> L <_(-lmayor*cos(phi))> <_(-lmayor*sin(phi))>", class="mayor")
                       , width=width, height=height
                       , class = "mayorC", viewBox=<-50, -50,100, 100>)|
                       num phi<-[0,stepMayor..2*PI()+stepMayor/2]
                    ] +
                    [ellipse(<C(r*cos(phi)), C(r*sin(phi))>
                       , path("M <_(-strokeWidth/2*cos(phi))> <_(-strokeWidth/2*sin(phi))> L <_(-lminor*cos(phi))> <_(-lminor*sin(phi))>", class="minor")
                       , width=width, height=height
                       , class = "minorC", viewBox=<-50, -50,100, 100>)|
                       num phi<-[0,stepMinor..2*PI()+stepMinor/2
                    ]
                   ]
                   +[
                    box(<R(-r), C(0)>
                        ,text(0, 0, "9", class="text"), class = "label"
                        ,width=labelWidth, height = labelHeight
                         ,viewBox=<-50, - 50, 100, 100>)
                    ,box(<C(0), R(-r)>
                        ,text(0, 0, "12", class="text"), class = "label"
                        ,width=labelWidth, height = labelHeight
                         ,viewBox=<-50, - 50, 100, 100>)
                    ,box(<L(r), C(0)>
                        ,text(0, 0, "3", class="text"), class = "label"
                        ,width=labelWidth, height = labelHeight
                         ,viewBox=<-50, - 50, 100, 100>)
                    ,box(<C(0), L(r)>
                        ,text(0, 0, "6", class="text"), class = "label"
                        ,width=labelWidth, height = labelHeight
                         ,viewBox=<-50, - 50, 100, 100>)
                    ] 
                 + pointer(0, 0.8*r)
                 + ellipse(CC, rx = rdot, ry= rdot, strokeWidth=2, id ="dot")        
               , viewBox=<-(1000+width)/2, -(1000+height)/2, 1000+width, 1000+height>          
               ,class="frame", strokeWidth=4      
             )
              ,viewBox = viewBox             
          )
          ; 
          
public App def() { 
    // println(html(<0, 0, 100, 100>));   
    App ap = app(|project://<project>/src/demo/clock/Graph.html|
       , <"attach", html(<0, 0, 100, 100>)>, change = <["slider"], onChange>
       );  
    return ap; 
    }
    
Content clock() { 
    Content ap = show(|project://<project>/src/demo/clock/Graph.html|, <"attach", html(<0, 0, 100, 100>)>
    , change = <["slider"], onChange>);
    return ap;
}  

    
 
 
 