# racytoscal  


racytoscal is an added graphical functionality to rascal which makes use of *svg*, *html*, *css*, *cytoscape*, and *dagre*.  The name *racytoscal* indicates the connection between *rascal* and *cytoscape*.

An unit is a directory containing a `.html` and a `.rsc` file. An example is the unit *simple* which contains the files *Graph.rsc* and *Graph.html*.
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

public list[Position] getPositions() = [LT, LC, LB, CT, CC, CB, RT, RC, RB];

SVG cell(Position pos) = box(CC
            ,box(pos, class="kernel", shrink=0.3)
         ,class="cell",shrink=1); 
    
public void main() {
    str output = svg( 800, 800, box(LT, [cell(p)|p<-getPositions()]
        ,svgLayout=grid(3)));    
    openBrowser(|project://racytoscal/src/demo/simple/Graph.html|, <"attach", output>); 
    }   
```
The command `openBrowser(|project://racytoscal/src/demo/simple/Graph.html|, <"attach", output>)` opens an `.html`-file and attaches the `html`-string *output* to the `<div id='attach'>` line standing in that file. 
The belonging picture is stored in [Simple.png](images/Simple.md).

## SVG Commands

* `svg(int width , int height,  SVG content ..., ViewBox viewBox= <0, 0, width, height>)`
    produces an `.svg` string from a *content* of type *list\[SVG\]* with attributes *width*, *height*, and *viewBox*.
*  
``` 
   SVG box(Position pos, SVG inner ..., str id = "", str class = "", str style = ""
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
             if *svgLayout* = `grid(ncols)` then the inner figure will be laid next to each other 
             (after *ncols* a new row will be started),
the result is a rect with attributes *width*, *height*, and *viewBox* on position *pos*.
* `SVG ellipse` has the same parameters as `box`. There are no parameters *rx* and *ry*.
* `SVG text(num x, num y, str txt, str id= "", str class= "", str style= "")` places *txt* in position *(x,y)* with 
   respect to the viewbox of the parent figure.
*  
```
   SVG htmlObject(tuple[Pos, Pos] pos, str html, str id= "", str class= "", str frameClass = "",
   str style="", int width=100, int height=100, num vshrink = 1.0, num hshrink = 1.0, 
   num shrink = 1.0, int strokeWidth=2)
``` 
places the html code defined in string  *html* in position *pos* with respect to the viewbox of the parent. 
* `SVG path(str graph, str id= "", str class= "", str style= "")` adds the svg path definition (as defined in the format after `path -d`) in string  *graph* . Coordinates are relative to the viewbox defined in the parent.
             
## Coord
The *x*- coordinate of a figure has the format:
* L(x)  stands for left *x* of a box
* C(x)  stands for center *x* of a box
* R(x)  stands for right *x* of a box
The *y*- coordinate of a figure has the format:
* L(y)  stands for top *y* of a box
* C(y)  stands for center *y* of a box
* R(y)  stands for bottom *y* of a box

*L1*, *C1* and, *R1* are the relative versions of *L*, *C*, and *R*. 

## Position
 Is a tuple consisting of a *x*- coordinate and a *y*- coordinate.
 The abbreviations: 
 * LT stands for  `<L1(0),  L1(0)>` (LeftTop)
 * LC stands for  `<L1(0),  C1(0.5)>` (LeftCenter)
 * LB stands for `<L1(0), R1(1)>`  (LeftBottom)
 * CT stands for `<C1(0.5), L1(0)>` (CenterTop)
 * CC stands for `<C1(0.5), C1(0.5)>` (CenterCenter)
 * CB stands for `<C1(0.5), R1(1)>` (CenterBottom)
 * RT stands for `<R1(1), L1(0)>` (RightTop)
 * RC stands for `<R1(1), C1(0.5)>` (RightCenter)
 * RB stands for `<R1(1), R1(1)>` (RightBottom)

## Dim
Is an abstract data type consisting of constructors *pxl* en *pct*.
* `pxl(dim)` the size in pixels
* `pct(dim)` the size in procents
* `pxl(padding)`
* `pct(padding)` padding is the tuple *<top, right, bottom, left>*

## Frame
The command
```
SVG frame(num hshrink, num vshrink, tuple[str \class, list[str] d] xAxe, tuple[str className, list[str] d] yAxe
    , tuple[str className, lrel[num x, num y] d] graphs... ,ViewBox viewBox =<0, 0, 1000, 1000>,
    num width = 1000, num height = 1000)
```
displays a set of graphs in a coordinate system. 
`hshrink` and `vshrink`  defines the proportion of the relative sizes, `xAxe` and `yAxe` are lists of labels, to each axe must be assigned a class name. `graphs` are a set of relations, where each relation defines a graph. To each graph must be assigned a class name. 
An example of this:

```
public void main() {
     num step = 0.1;
     int width =1600, height = 800;
     str output = svg(width, height, 
       box(CC
          ,box(LT, frame(1, 1, <"x-axe", ["<i>"|num i<-[0,0.1..1]]>
                        ,<"y-axe", ["<i>"|num i<-[0,0.1..1]]>
                        ,[<"left" ,[<0, x>, <1-x, 0>]>|num x<-[0,0.01..1]]
                        +[<"right",[<1, x>, <1-x, 1>]>|num x<-[0,0.01..1]]
                        ,viewBox = <0, 0, 1, 1>, width = width, height = height
                       )
          ,ellipse(CC, text(500, 500, "Hallo", class="text"), shrink = 0.3, id="sign", strokeWidth=16)
         ,strokeWidth = 2
        )
        ,
        box(LT, frame(1, 1/PI(),<"x-axe", ["0","\u03C0/2","\u03C0","3\u03C0/2","2\u03C0"]>
                               ,<"y-axe", ["-1","0","1"]>
                               ,<"sin",[<x, sin(x)>|num x<-[0,step..2*PI()+step]]>
                               ,<"cos",[<x, cos(x)>|num x<-[0,step..2*PI()+step]]>
                      ,viewBox = <0, -1, 2*PI(), 2>)
           ,strokeWidth=2)
        ,shrink = 0.8, strokeWidth = 0, svgLayout=grid(2)
        )
     );
     openBrowser(|project://racytoscal/src/demo/frame/Graph.html|, <"attach", output>); 
     }
```
The belonging `.html`:
```
<!DOCTYPE html>
<html>
<head>
<title>Frame</title>
<style>
path.x-axe{stroke-width:0.01;stroke:lightgrey}
path.y-axe {stroke-width:0.01;stroke:lightgrey}
rect{fill:none; stroke:black}
rect.x-axe{fill:none; stroke-width:0; stroke:black}
rect.y-axe{fill:none; stroke-width:0; stroke:black}
.frame{fill:antiquewhite; stroke:red}
.inner-tst{fill:lightblue; stroke:orange}
.text {
    fill:darkblue;
    font-size:120pt;
    font-style:italic;
    }
text {
    font-style:italic;
    text-anchor:middle;
    dominant-baseline:middle;
    }
text.x-axe {
    fill:darkblue;
    font-size:12pt;
    }
text.y-axe {
    fill:darkblue;
    font-size:12pt;
    }
 #sign {
    stroke: orange;
    fill:yellow;
    }
 .sin {
      stroke-width:0.01;
      stroke:green;
      fill:none
       }
 .cos {
      stroke-width:0.01;
      stroke:red;
      fill:none
       }
 .left {
      stroke-width:0.001;
      stroke:green;
      fill:none
       }
 .right {
      stroke-width:0.001;
      stroke:red;
      fill:none
       }
 .axe {
      stroke:green;
      fill:none
     }
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
The result is found in [Frame.png](images/Frame.md)

## Cytoscape

* The main abstract data type is `CytoScape` which contains the data type `NodeShape`, `EdgeShape`, `Layout`, and `Style`.

* The command `str genScript(str attach, CytoScape cytoScape)` generates the script which will be send to the browser.

Here follows an example which generates a directory tree.

```
module demo::directoryTree::Tree
import Racytoscal;
import Prelude;
import util::Math;

str esc(loc v)= escape(v.path, (".":"_", "/":"_"));

public void main() {
    lrel[loc, loc] rl  = genTree(|file:///Users/bertl/white|, 4);
    list[Ele] edges = [e_("<esc(a[0])>_<esc(a[1])>", esc(a[0]), esc(a[1]))
        |a<-rl];
    list[Ele]  nodes = 
         [n_(esc(i)
              ,style=style(color=i.file,
                 label=label(isEmpty(i.file)?i.path:i.file ,vAlign="center")
                )
            )|loc i<-dup(carrier(rl))
         ];
    str output = genScript("cy", cytoscape(
        elements= nodes+edges
       ,styles = [<"edge", style(  
                    curveStyle=taxi(taxiDirection=downward()),
                    arrowShape=[
                      ArrowShape::triangle(
                         arrowScale=2, arrowColor="red", pos = target())
                      ]
                      ,lineColor="blue"
                      )
                  >,
                  <"node", style(
                    width = "15px",
                    height= "15px", 
                    backgroundColor="antiquewhite", shape=NodeShape::ellipse(),
                    borderWidth = "2", borderColor="brown"
                   ,padding = "10" 
                   ,fontSize= "10pt"
                  )>
                  ]
         //,\layout = breadthfirst("directed:true")
          ,\layout = dagre("")
        )
      ); 
    openBrowser(|project://racytoscal/src/demo/directoryTree/Tree.html|, output);  
    }
```
The belonging `.html` file is:
```
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">
<title>index</title>
<script src="lib/cytoscape.umd.js"></script>
<script src="lib/dagre.min.js"></script>
<script src="lib/cytoscape-dagre.js"></script>
<script src="lib/racytoscal.js"></script>
<!-- <script src="src/demo/directoryTree/Tree.js"></script> -->
<style>
#cy {
  position: absolute;
  left: 0;
  top: 0;
  right: 0;
  bottom: 0;
  z-index: 999;
}
title {display:block}
</style>
</head>
<body onunload="handleOnClose()">
<h2>Directory structure</h2>
<div id='cy'>
<script src="init"></script>
</div>
</body>
</html>
```
The result is found in [Tree.png](images/Tree.md)

