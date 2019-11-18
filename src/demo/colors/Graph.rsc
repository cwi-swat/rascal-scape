module demo::colors::Graph
import Prelude;
extend Racytoscal;
extend Colors;
import util::Math;

int ncols = 18;

str onChange(str path) {
    num opacity = toReal(split("/", path)[1]);
    return executeInBrowser(css=[<"ellipse", "fill-opacity","<_(opacity)>">]);
    }
    
str onClick(str path) {
    list[str] names = split("-", path);
    str name = names[0];
    str id = names[1];
    return executeInBrowser(css=[<id, "fill",name>], html=[<"c<id>", name>]);
    }
    
str buttons(str name)=
     "\<table\>\<tr\>
     '<for(int idx<-[1,2,3]){>\<td\>\<button id = \"<name>-<idx>\"\><idx>\</button\><}>
     '\</tr\>\</table\>
     ";

 
SVG cell(str name) = box(CC
            ,box(LT, text(500, 250, name), class="kernel", vshrink=1.0/3, strokeWidth=0, viewBox=<0,0, 1000, 500>)
            ,box(LC, style="fill:<name>", class="kernel", vshrink=1.0/3, strokeWidth=0, viewBox=<0,0, 1000, 500>)
            ,htmlObject(LB, "<buttons(name)>", vshrink=1.0/3) 
                   , class="cell", height=1000, width= 1000, strokeWidth=6, viewBox=<0,0, 1000, 1500>     
            ); 
           
public str rows() {
    str output = svg( 2000, 4000, box(LT, [cell(p)|p<-sort(domain(color))]
        ,svgLayout=grid(ncols
         , width=75, height = 75
        )
      , strokeWidth=4, viewBox=<0,0, 1000, 1000>));    
    return output;
    }
    
public str panel() {
    str output = svg( 300, 300
    , ellipse(<C(-0.5*sqrt(3)),C(0.5)>,  id= "1", rx=1, ry=1, style="fill:red")
    , ellipse(<C(0.5*sqrt(3)),C(0.5)>,  id = "2", rx=1, ry=1, style="fill:blue")
    , ellipse(<C(0),C(1)>, rx=1, ry=1,  id = "3", style="fill:yellow")
    , viewBox=<-2,-0.4, 4, 2>);    
    return output;
    }  
   
 public App def() { 
    App ap = app( |project://racytoscal/src/demo/colors/Graph.html|
    , <"attach", rows()>
     , <"panel", panel()>
    , change=<["slider"], onChange>, click = <["button"], onClick>);
    return ap;
    } 
      
 