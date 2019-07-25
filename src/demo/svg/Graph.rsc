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
    int x = 20, y = 20, width = 60, height = 20;
    str output = svg(400, 400, <0, 0, 100, 100>,
         "\<rect width=<width> height=<height> x=<x> y = <y>
         ' style = \'fill:coral; stroke:cyan\' \</rect\>");
    str onload(str path) {
         return executeInBrowser(html=[<"attach", output>]);               
    }
    openBrowser(|project://racytoscal/src/demo/svg/Graph.html|, load=onload);  
    }