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
    
int nMayor = 12; 
int nMinor = 60;
num stepMayor  =2*PI()/nMayor; 
num stepMinor  =2*PI()/nMinor; 
int scale = 1000;
int delta = 0;
int width = 100;
int height = 100;
int strokeWidth = 18;
int r = 400;
int lmayor = 50;
int lminor = 25;
     
public App def() { 
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
                       num phi<-[0,stepMinor..2*PI()+stepMinor/2]
                    ]            
               , viewBox=<-(1000+width)/2, -(1000+height)/2, 1000+width, 1000+height>          
               ,class="frame", strokeWidth=4      
             )
              ,viewBox = viewBox             
          )
          ; 
    println(html(<0, 0, 100, 100>));   
    App ap = app(|project://racytoscal/src/demo/clock/Graph.html|
       , <"attach", html(<0, 0, 100, 100>)>
       );  
    return ap; 
    }

    
 
 
 