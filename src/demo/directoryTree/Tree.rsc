module demo::directoryTree::Tree
import Racytoscal;
import Prelude;
import util::Math;

 lrel[int, int] genCircle(int n) = [<i%n, (i+2)%n>|int i<-[0..n]];
 
 lrel[int, int] genTree(int n, int depth) { 
      int name=1;
      lrel[int, int] result = [];
      lrel[int, int] nextLevel(list[int] level, int n) {
         if (depth==0) return [];
         lrel[int, int] r = []; 
         for (int k<-level) {
             int d = arbInt(n);
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
      
 lrel[loc, loc] genTree(loc root, int depth) { 
      lrel[loc  , loc] result = [];
      lrel[loc parent, loc child] nextLevel(list[loc] parents)  {
          if (depth==0) return [];
          lrel[loc, loc] r = []; 
           for (loc k<-parents) {
              if (isDirectory(k)) {
                 list[str] childs = listEntries(k);
                 r+=[<k, k+c>| str c<-childs];
                 }
              }
          return r;
         }
          
      lrel[loc, loc] l = nextLevel([root]);
      result+=l;
      for (int _ <-[1..depth]) {
          l=nextLevel(range(l));
          result+=l;
          }
      return result;
      }
      
 str esc(loc v)= escape(v.path, (".":"_", "/":"_"));
 
 str callbackTapstart(str id) {
   // println("start: <id>");
    Style styl = style(
       textBackgroundOpacity=1, textBackgroundColor="lightgrey", textBackgroundPadding=10, textOpacity=1, color="black");
    str r = "{\"styles\":<Racytoscal::toString([<"node#<id>", styl>])>}";
    return r;
    }
    
str callbackTapend(str id) {
    // println("end: <id>");
    Style styl = style(textBackgroundOpacity=0, textOpacity=0, color="red");
    str r = "{\"styles\":<Racytoscal::toString([<"node#<id>", styl>])>}";
    return r;
    }
 
 public void main() {
    int n=8;
    lrel[loc, loc] rl  = genTree(|project://racytoscal|, 4);
    // lrel[int, int] rl  = genTree(5, 3);
    list[Ele] edges = [e_("<esc(a[0])>_<esc(a[1])>", esc(a[0]), esc(a[1]))
        |a<-rl];
    list[Ele]  nodes = [n_(esc(i)
       , style=style(
          , label=label(isEmpty(i.file)?i.path:i.file 
            ,vAlign="center"
            )
            )
       ) | loc i<-dup(carrier(rl))];
    str output = genScript("cy", cytoscape(
        elements= nodes+edges
       ,styles = [<"edge", style(  
                 curveStyle=taxi(taxiDirection=downward()),
                 arrowShape=[
                     ArrowShape::triangle(
                     arrowScale=2, arrowColor="red", pos = target())]
                     ,lineColor="blue"
               )
                  >,
                  <"node", style(
                    width = "15px",
                    height= "15px", 
                    backgroundColor="antiquewhite", shape=ellipse(),
                    borderWidth = "2", borderColor="brown"
                   ,padding = "10" 
                  )>
                  ]
         //,\layout = breadthfirst("directed:true")
          ,\layout = dagre("")
        )
      ); 
    openBrowser(|project://racytoscal/src/demo/directoryTree/Tree.html|, output, tapstart = callbackTapstart, tapend=callbackTapend);  
    }
    

