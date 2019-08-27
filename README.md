# racytoscal

The idea is to add a graphical interface to rascal which is as concise as possible and takes a much as possible advantage of *svg*, *html*, and *css*, such that the full functionallity of those tools can be used. A second goal was providing an interface for building graphs. It uses the tool *cytoscape*, which includes *dagre*. This is the reason of the name racytoscal which is a connection of rascal and cytoscape.

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
The command `openBrowser(|project://racytoscal/src/demo/simple/Graph.html|, <"attach", output>)` opens an `.html`-file and attaches the `html`-string *output* to the `<div id='attach'>` line standing in that file. All the other commands produce `.html`-strings.


