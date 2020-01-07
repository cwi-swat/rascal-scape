module demo::directoryTree::Tree
import Rascalscape;
import Cytoscape;
import Prelude;
import util::Math;

lrel[int, int] genRandomTree(int n, int depth) { 
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
    if (id[0]=="-") return "";
    Style styl = style(
       textBackgroundOpacity=1, textBackgroundColor="lightgrey", textBackgroundPadding=10, textOpacity=1, color="black");
    // str r = "{\"styles\":<Racytoscal::toString([<"node#<id>", styl>])>}";
    str r = update(styles=[<"node#<id>", styl>]);
    return r;
    }
    
str callbackTapend(str id) {
    // println("end: <id>");
    if (id[0]=="-") return "";
    Style styl = style(textBackgroundOpacity=0, textOpacity=0, color="red");
    str r = update(styles=[<"node#<id>", styl>]);
    return r;
    }
    
 public App def() = def(|project://racytoscal/src/demo|);
 
 public App def(loc file) {
    lrel[loc, loc] rl  = genTree(file, 4);
    // println(rl);
    // lrel[int, int] rl  = genRandomTree(5, 3);
    list[Ele] edges = [e_("-<esc(a[0])>_<esc(a[1])>", esc(a[0]), esc(a[1]))
        |a<-rl];
    list[Ele]  nodes = 
         [n_(esc(i)
              ,style=style(
                 // color=i.file,
                 color = "darkgrey",
                 label=label(isEmpty(i.file)?i.path:i.file ,vAlign="center")
                )
            )|loc i<-dup(carrier(rl))
         ];
    Cytoscape cy = cytoscape(
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
          ,\layout = dagre("")
      );  
    App ap = app(|project://<project>/src/demo/directoryTree/Tree.html|, <"cy", cy>, tapstart = callbackTapstart, tapend=callbackTapend);
    return ap; 
    }
   
    

