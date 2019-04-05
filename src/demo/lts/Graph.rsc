module demo::lts::Graph
import Prelude;
import Racytoscal;

tuple[list[Ele], lrel[str, Style]] readAut(loc file) {
   list[str] lines = tail(readFileLines(file));
   list[tuple[str from, str lab, str to]] edges = [];
   for (str line<-lines) {
        list[str] dat = split("$"
           ,replaceFirst(
               replaceFirst(line[1..-1], ",\"", "$\""), "\",","\"$"));
        edges+=[<dat[0], dat[1][1..-1], dat[2]>];
        }
   lrel[str, Style] styles = [<"node#<e.from>", style(backgroundColor="white")>| e<-edges, 
          substring(e[1],0, 1)=="s" || substring(e[1],0, 1)=="r"];
   // println(table);
   list[str] nodes = dup(domain(edges)+[v[1]|v<-range(edges)]);
   list[Ele] eles = [n_(\node
        //, style=style(
         // , label=label(\node, vAlign="center")
         //   )
          )
            |str \node<-nodes]
          +[e_("<edge.from>_<edge.to>", edge.from, edge.to, style=style(label=label(edge.lab),
               curveStyle= edge.lab=="c6(1)"?
                  unbundledBezier(controlPointDistances="250"):straight()))|tuple[str from, str lab , str to] edge<-edges]
                  ;
   return <eles, styles>;
   }
   
 public void main() {
       int current = 0;
       str nextStep(str path) {
          list[str] args  = split("/", path);
          Style style1 = style(backgroundColor="antiquewhite");
          Style style2 = style(backgroundColor="red");
          int current0 = current;
          current = toInt(args[1]);  
          str r = (args[0]=="init")?
                  Racytoscal::toString([<"node#<current>", style2>])   
                 :Racytoscal::toString([<"node#<current0>", style1>,<"node#<current>", style2>]);   
          // println(r);   
          return r;
          }
       tuple[list[Ele], lrel[str, Style]] eles = readAut(|project://racytoscal/data/buf.aut|);
       lrel[str, Style] styles = [<"edge", style(  
                 arrowShape=[
                     ArrowShape::triangle(
                     arrowScale=2, arrowColor="red", pos = target())]
                     ,lineColor="blue"
                     ,textBackgroundOpacity=1
                     ,textBackgroundColor="whitesmoke"
                     ,textBackgroundPadding=1
                     ,textOpacity=1
                     ,color="black"
                     ,fontSize="12pt"
               )
                  >,
                  <"node", style(
                     width = "5px"
                    ,height= "5px" 
                     ,shape=ellipse(),
                    borderWidth = 2, borderColor="brown"
                   ,padding = 10 
                   ,backgroundColor="antiquewhite"
                  )>
                  ]+eles[1];
       // println(eles[1]);
       str output = genScript("cy", cytoscape(elements= eles[0], styles= styles,\layout = 
       //dagre("nodeSep:350,ranker:\"network-simplex\",rankDir:\"TB\", edgeSep:300")  
       circle("")
       ),extra="var current=0;");
       openBrowser(|project://racytoscal/src/demo/lts/Graph.html|, output, click = nextStep
       ,load = nextStep);  
       }