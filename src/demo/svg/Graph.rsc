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

public void main() {
    int lw  = 4;
    int x = 20, y = 20, width = 30, height = 20;
    str output = svg(400, 400, <0, 0, 100, 100>,
     rect(L(0),L(0), 100, 100, lw, "fill:antiquewhite; stroke:cyan"
       ,inner=[
        rect(L(0),L(0), width, height, lw/2, "fill:beige; stroke:red")
       //,rect(R(100),L(0), width, height, lw, "fill:beige; stroke:red")
       //,rect(L(0),R(100), width, height, lw, "fill:beige; stroke:red") 
       ,rect(R(100),R(100), width, height, lw/2, "fill:beige; stroke:red"
         inner=[rect(L(0),L(0), 15, 15, 3, "fill:yellow; stroke:blue")])
       // ,rect(C(50),C(50), width, height, lw, "fill:beige; stroke:red") 
      ])   
    );
    println(output);
    //str output = svg(400, 400, <0, 0, 100, 100>,
    //     "\<rect width=<width> height=<height> x=<x> y = <y>
    //     ' style = \"fill:coral; stroke:cyan\" \</rect\>");
    str onload(str path) {
         return executeInBrowser(html=[<"attach", output>]);               
    }
    // {rect(), width(50), height(100), style("fill:coral; stroke:cyan")};
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
 
 
 