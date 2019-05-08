module demo::preset::Graph
import Prelude;
import Racytoscal;
import util::Math;

list[str] colors = ["blue", "coral", "cyan",  "gray", "green","pink","salmon"
     , "seagreen","skyblue", "slategray","steelblue", "yellow"];
     
str pickColor() {
    int d = arbInt(size(colors));
    return "<colors[d]> light<colors[d]>";
    }

public void main() {
    int n = 5000;
    list[Ele]  nodes = [n_("TEST<i>"
         , position=<arbInt(400), arbInt(400)>
         , style = style(backgroundGradientStopColors= pickColor())
        )|int i<-[0..n]];
    // list[Ele] edges = [*[e_("<i>_<j>", "<i>", "<j>")|int j<-[0..i]]|int i<-[0..n]];
    println(pickColor());
    str output = genScript("cy", cytoscape(
        elements= nodes
       ,styles = [
                  <"node", style(
                    width = "5px",
                    height= "5px", 
                    // backgroundColor="antiquewhite",
                    shape=ellipse(),
                    backgroundFill="radial-gradient",
                    backgroundGradientStopPositions="0% 20% 25% 30% 40% 50% 60% 70% 80& 90% 100%",
                    backgroundOpacity=1.0,
                    borderWidth = 0 , borderColor="antiquewhite"
                   // ,padding = 10 
                   // ,\label=\label("Test", vAlign="center")
                  )>
                  ]
         ,\layout = preset("")
        )
      ); 
    openBrowser(|project://racytoscal/src/demo/preset/Graph.html|, output);  
    }