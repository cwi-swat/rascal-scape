module demo::preset::Graph
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
    int n = 3;
    str onTap(str path) {
       list[tuple[str, Style]] r = [];
       for (int i<-[0..n]) {
          int z = arbInt(400);
          r+=<"#<i>", style(
             width="<z>", height="<z>", borderColor=pickColor()
             )>;
         }
         str result = Racytoscal::toString(r);
         return  "{\"styles\": <result>, \"layout\":\"preset\"}";        
    }
    list[Ele]  nodes = [n_("<i>"
         , position=<200, 200>
         , style = style(
             borderColor=pickColor()
             ,width="<100*(i+1)>", height="<100*(i+1)>"
         )
        )|int i<-[0..n]];
    // list[Ele] edges = [e_("<i>_<i+1>", "<i>", "<i+1>")|int i<-[0..n-1]];
    str output = genScript("cy", cytoscape(
        elements= nodes
       ,styles = [
                  <"node", style(
                    shape=ellipse(),
                    backgroundOpacity=0.0,
                    borderWidth = 4              
                  )>
                  ]
         ,\layout = preset("")
        )
      ); 
    openBrowser(|project://racytoscal/src/demo/preset/Graph.html|, output,tap = onTap);  
    }