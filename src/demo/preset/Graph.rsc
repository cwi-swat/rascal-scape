module demo::preset::Graph
import Prelude;
extend Racytoscal;
import util::Math;

list[str] colors = ["blue", "coral", "cyan",  "gray", "green","pink","salmon"
     , "seagreen","skyblue", "slategray","steelblue", "yellow"];
     
str pickColor() {
    int d = arbInt(size(colors));
    return "<colors[d]>";
    }

public App def() {
    int n1 = 3, n2 =5;
    str onTap(str path) {
       // println(path);
       if (toInt(path)>=3) return "";
       list[tuple[str, Style]] r = [];
       for (int i<-[0..n1]) {
          int z = arbInt(400);
          r+=<"#<i>", style(
             width="<z>", height="<z>", borderColor=pickColor()
             )>;
         }
         return executeInBrowser(styles=r, \layout=<"cy1","preset">);       
    }
    list[Ele]  nodes1 = [n_("<i>"
         , position=<200, 200>
         , style = style(
             borderColor=pickColor()
             ,width="<100*(i+1)>", height="<100*(i+1)>"
         )
        )|int i<-[0..n1]];
     list[Ele]  nodes2 = [n_("<n1+i>"
         , position=<200, 200>
         , style = style(
             borderColor=pickColor()
             ,width="<100*(i+1)>", height="<100*(i+1)>"
         )
        )|int i<-[0..n2]];
    // list[Ele] edges = [e_("<i>_<i+1>", "<i>", "<i+1>")|int i<-[0..n-1]];
     Cytoscape cy1 =cytoscape(
        elements= nodes1
       ,styles = [
                  <"node", style(
                    shape=NodeShape::ellipse(),
                    backgroundOpacity=0.0,
                    borderWidth = "4"              
                  )>
                  ]
         ,\layout = preset("")
      ); 
      Cytoscape cy2 = cytoscape(
        elements= nodes2
       ,styles = [
                  <"node", style(
                    shape=NodeShape::ellipse(),
                    backgroundOpacity=0.0,
                    borderWidth = "4"              
                  )>
                  ]
         ,\layout = preset("")
      ); 
     App ap = app(|project://racytoscal/src/demo/preset/Graph.html|, <"cy1", cy1>, <"cy2", cy2>
     , display = true, tap = onTap);  
    return ap; 
    }