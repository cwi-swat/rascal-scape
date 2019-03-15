module demo::Graph
import Racytoscal;
import Prelude;
import util::Math;
import util::HtmlDisplay;

 lrel[int, int] getCircle(int n) = [<i%n, (i+2)%n>|int i<-[0..n]];
 
  lrel[int, int] genTree(int n, int depth) { 
      int name=1;
      lrel[int, int] result = [];
      lrel[int, int] nextLevel(list[int] level, int n) {
         if (depth==0) return [];
         lrel[int, int] r = []; 
         for (int k<-level) {
             int d = arbInt(n);
             // println(d); println(n);
             r+= [<k, dest>|int dest<-[name..d+name]];
             name+=d;
             }
         return r;
         } 
      lrel[int, int] l = nextLevel([0], n);
      result+=l;
      for (int _ <-[1..depth]) {
          l=nextLevel(range(l), n);
          result+=l;
          }
      return result;
      }

 public void main() {
    // int n=8;
    
    lrel[int, int] rl  = genTree(5, 3);
    list[Ele] edges = [e_("<a[0]>_<a[1]>", "<a[0]>", "<a[1]>")
        |a<-rl];
    list[Ele]  nodes = [n_("<i>"
      // , style=style(shape=nodeShape[i])
       ) | int i<-dup(carrier(rl))];
    str output = genScript("cy", cytoscape(
        elements= nodes+edges
       ,styles = [<"edge", style(  
                 curveStyle=taxi(),
                 arrowShape=[
                     ArrowShape::triangle(
                     arrowScale=3, arrowColor="red", pos = target())]
                     ,lineColor="blue"
                    /* ,label=label("data(id)"
                         ,backgroundColor="antiquewhite"
                     ,backgroundOpacity=1
                     ,borderColor="brown"
                     ,borderOpacity=1
                     ,borderWidth=2
                     ,backgroundPadding=5
                     ,backgroundShape="roundrectangle"
                     )
                   */
               )
                  >,
                  <"node", style(backgroundColor="antiquewhite"
                  , label = label("data(id)", vAlign="center")
                  ,borderColor="darkgrey"
                  ,borderWidth=2,shape=roundRectangle())>
                  ]
        ,\layout = breadthfirst("directed:true")
        ));
    println(output);
    writeFile(|project://racytoscal/src/Output.js|, output);
    loc html = |project://racytoscal/src/Racytoscal.html|;
    htmlDisplay(html); 
    }
