# racytoscal

The idea is to add a graphical interface to rascal which is as concise as possible and takes a much as possible advantage of *svg*, *html*, and *css*, such that the full functionallity of those tools can be used. A second goal was providing an interface for building graphs. It uses the tool *cytoscape*, which includes *dagre*. This is the reason of the name *racytoscal* which is a connection between *rascal* and *cytoscape*.

An unit which is a directory containing a pair of files. A `.html` and a `.rsc` file. An example is the directory simple which contains the files *Graph.rsc* and *Graph.html*.
```
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Simple</title>
<script src="lib/racytoscal.js"></script>
<style>
.cell{fill:steelblue;stroke:red}
.kernel{fill:yellow;stroke:brown}
title {display:block}
</style>
</head>
<body onunload="handleOnClose()">
<div id='attach'>
<script src="init"></script>
</div>
</body>
</html>
```
and
```
module demo::simple::Graph
import Prelude;
import Racytoscal;
import util::Math;

public list[tuple[Pos, Pos]] getPositions() = [LT, LC, LB, CT, CC, CB, RT, RC, RB];

SVG cell(tuple[Pos, Pos] pos) = box(CC
            ,box(pos, class="kernel", shrink=0.3)
         ,class="cell",shrink=1); 
    
public void main() {
    str output = svg( 800, 800, box(LT, [cell(p)|p<-getPositions()]
        ,svgLayout=grid(3)));    
    openBrowser(|project://racytoscal/src/demo/simple/Graph.html|, <"attach", output>); 
    }   
```
The command `openBrowser(|project://racytoscal/src/demo/simple/Graph.html|, <"attach", output>)` opens an `.html`-file and attaches the `html`-string *output* to the `<div id='attach'>` line standing in that file. 

## SVG Commands

* `svg(int width , int height,  SVG content ..., ViewBox viewBox= <0, 0, width, height>)`
    produces an `.svg` string from a *content* of type *list\[SVG\]* with attributes *width*, *height*, and *viewBox*.
*  
``` 
   SVG box(tuple[Pos, Pos] pos, SVG inner ..., str id = "", str class = "", str style = ""
              ,num vshrink = 1, num hshrink = 1, shrink = 1, num strokeWidth = 2
              ,ViewBox viewBox=<0, 0, 100, 100>
              ,Dim padding = pxl(<0,0,0,0>)
              ,SVGLayout svgLayout = overlay()
```
where *pos* is the position with respect to the viewBox of the outer SVG figure,
             *inner* is the list of inner figures,
             *hshrink* the relative size with respect to the width of the outer SVG figure,
             *vshrink* the relative size with respect to the height of the outer SVG figure,
             *strokeWidth* the width of the stroke with respect to the viewPort of the outer figure,
             *viewBox* will be applied to each inner figure,
             *padding* applied to each inner figure,       
             if *svgLayout* = `overlay()` then the inner figures will be overlayed,        
             if *svgLayout* = `grid(ncols)` then the inner figure will be laid next to each other,
produces a rect with attributes *width*, *height*, and *viewBox* on *pos*.
* `SVG ellipse` has the same parameters as `box`. There are no parameters *rx* and *ry*.
* `SVG text(num x, num y, str txt, str id= "", str class= "", str style= "") places *txt* in position *(x,y)* with 
   respect to the viewbox of the parent figure.
*  
```
   SVG htmlObject(tuple[Pos, Pos] pos, str html, str id= "", str class= "", str frameClass = "",
   str style="", int width=100, int height=100, num vshrink = 1.0, num hshrink = 1.0, 
   num shrink = 1.0, int strokeWidth=2)
``` 
places the html code defined in string  *html* in position *pos* with respect to the viewbox of the parent. 
* `SVG path(str graph, str id= "", str class= "", str style= "")` adds the svg path definition (as defined in the format after `path -d`) in string  *graph* . Coordinates are relative to the viewbox defined in the parent.
             







