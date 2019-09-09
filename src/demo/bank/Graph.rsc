module demo::bank::Graph
import Prelude;
import Racytoscal;
import util::Math;

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
   list[Ele] eles = [n_(\node)
            |str \node<-nodes]
          +[e_("<edge.from>_<edge.lab>_<edge.to>", edge.from, edge.to, style=style(label=label(edge.lab),
               curveStyle= (edge.lab=="blocked" || edge.lab=="unblock")
                  ?unbundledBezier(controlPointDistances="45")
                  :
                  (edge.lab=="deposit" || edge.lab=="interest"||edge.lab=="withdraw")
                  ?bezier(controlPointStepSize="150")
                  :straight()))|tuple[str from, str lab , str to] edge<-edges]
                  ;
   return <eles, styles>;
   }
   
 public void main() {
       tuple[str lab, int pt, int account, int interest, int amount] current = <"start", 0, -1, -1, -1>;
       str nextStep(str path) {
          // println("NextStep <path>");
          list[str] args  = split("/", path);
          Style style1 = style(backgroundColor="antiquewhite");
          Style style2 = style(backgroundColor="red");
          if (args[0]=="core") return "";
          str lab  ="";
          tuple[str lab, int pt, int account, int interest, int amount] current0 = current;
          if (size(args)>=2 && args[1]!="none") {
             current.lab = lab = args[0];
             current.pt = toInt(args[1]); 
             switch (lab) {
                 case "openAccount": current.account = arbInt(100000);
                 case "close": current.account = -1;
                 case "interest": current.amount+=floor((current.amount*current.interest)/100);
                 }    
             }  
          else {
            lab = current0.lab;
            // println(lab);
            switch (lab) {
                case "openAccount": {
                      current.interest = toInt(args[3]);
                      current.amount = toInt(args[4]);
                      }
                case "deposit":  current.amount += toInt(args[4]);
                case "withdraw": current.amount -= toInt(args[4]); 
                } 
           }    
          str result = executeInBrowser(extra="\"state\":{\"lab\":\"<lab>\", \"loc\":<current.pt>, \"account\":<current.account>,\"interest\":<current.interest>,\"amount\":<current.amount>}"
          ,styles = (lab=="init"?[<"node#<current.pt>", style2>]:[<"node#<current0.pt>", style1>,<"node#<current.pt>", style2>]));
          return result;
          }
       tuple[list[Ele], lrel[str, Style]] eles = readAut(|project://racytoscal/src/demo/bank/data.aut|);
       lrel[str, Style] styles = [<"edge", style(  
                 arrowShape=[
                     ArrowShape::triangle(
                      arrowScale=2
                     ,arrowColor="red", pos = target()
                     )
                     ]
                     ,lineColor="blue"
                     ,textBackgroundOpacity=1
                     ,textBackgroundColor="whitesmoke"
                     ,textBackgroundPadding=1
                     ,textOpacity=1
                     ,color="black"
                     ,fontSize="12pt"
                     ,loopDirection = "-90deg"
                     ,loopSweep = "-45deg"
               )
                  >,
                  <"node", style(
                    width = "5px"
                   ,height= "5px" 
                   ,shape=NodeShape::ellipse()
                   ,borderWidth = "2", borderColor="brown"
                   ,padding = "10" 
                   ,backgroundColor="antiquewhite"
                  )>
                  ]+eles[1];
       str output = genScript("cy", cytoscape(elements= eles[0], styles= styles,\layout = 
       dagre("nodeSep:50,ranker:\"network-simplex\",rankDir:\"TB\", edgeSep:50,rankSep:200")  
       // circle("")
       ),extra="var current={\'lab\':\'start\', \'loc\':-1,\'account\':-1,\'interest\':-1, \'amount\':-1};");
       openBrowser(|project://racytoscal/src/demo/bank/Graph.html|, output, click = nextStep
       ,load = nextStep);  
       }