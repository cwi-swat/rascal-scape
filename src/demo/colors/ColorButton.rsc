module demo::colors::ColorButton
import Prelude;
import Rascalscape;
import Colors;
import util::Math;


public str onChange(str path) {
    num opacity = toReal(split("/", path)[1]);
    return update(css=[<"ellipse", "fill-opacity","<_(opacity)>">]);
    }
    
public str onClick(str path) {
    list[str] names = split("-", path);
    str name = names[0];
    str id = names[1];
    int idx = toInt(id);
    return update(css=[<id, idx<4?"fill":"stroke",name>], html=[<"c<id>", name>]);
    }
    
str buttons(str name, int n)=
     "\<table\>\<tr\>
     '<for(int idx<-[1,2..n+1]){>\<td\>\<button class=\"choose\" id = \"<name>-<idx>\"\><idx>\</button\><}>
     '\</tr\>\</table\>
     ";

 
SVG cell(str name, int n) = box(CC
            ,box(LT, text(500, 250, name), class="kernel", vshrink=1.0/3, strokeWidth=0, viewBox=<0,0, 1000, 500>)
            ,box(LC, style="fill:<name>", class="kernel", vshrink=1.0/3, strokeWidth=0, viewBox=<0,0, 1000, 500>)
            ,htmlObject(LB, "<buttons(name, n)>", vshrink=1.0/3) 
                   , class="cell", height=1000, width= 1000, strokeWidth=6, viewBox=<0,0, 1000, 1500>     
            ); 
           
public str rows(int ncols, int nbuttons) {
    str output = svg( 2000, 1000, box(LT, [cell(p, nbuttons)|p<-["none"]+sort(domain(color))]
        ,svgLayout=grid(ncols
         , width=75, height = 75
        )
      , strokeWidth=4, viewBox=<0,0, 1000, 1000>));    
    return output;
    }
    
public str panel() {
    str output = svg( 300, 300
    , ellipse(<C(-0.5*sqrt(3)),C(0.5)>,  strokeWidth=0.02, class= "1 4 7 circle", rx=1, ry=1, style="fill:red")
    , ellipse(<C(0.5*sqrt(3)),C(0.5)>,  strokeWidth=0.02,  class = "2 5 8 circle", rx=1, ry=1, style="fill:blue")
    , ellipse(<C(0),C(1)>, rx=1, ry=1,  strokeWidth=0.02, class = "3 6 9 circle", style="fill:yellow")
    , viewBox=<-2,-0.4, 4, 2>);    
    return output;
    }    
 
      
 