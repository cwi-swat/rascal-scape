module demo::Graph
import display::SocketConnection;
import rascalscape::RascalScape;
import Prelude;
import util::Math;
import util::HtmlDisplay;

list[NodeShape] nodeShape = [
     NodeShape::ellipse()
    ,NodeShape::triangle()
    ,NodeShape::rectangle()
    ,NodeShape::roundRectangle()
    ,NodeShape::bottomRoundRectangle()
    ,NodeShape::cutRectangle()
    ,NodeShape::barrel()
    ,NodeShape::rhomboid()
    ,NodeShape::diamond()
    ,NodeShape::pentagon()
    ,NodeShape::hexagon()
    ,NodeShape::concaveHexagon()
    ,NodeShape::heptagon ()
    ,NodeShape::octagon()
    ,NodeShape::star()
    ,NodeShape::\tag()
    ,NodeShape::vee()
    ];

 public void main() {
    int n=17;
    lrel[int, int] aap = [<i%n, (i+2)%n>|int i<-[0..n]];
    list[Ele] edges = [e_("<a[0]>_<a[1]>", "<a[0]>", "<a[1]>")
        |a<-aap];
    list[Ele]  nodes = [n_("<i>", style=style(shape=nodeShape[i])) | int i<-[0..n]];
    str output = genScript("cy", cytoscape(
        elements= nodes+edges
       ,styles = [<"edge", style(  
                 edgeShape=straight(),
                 arrowShape=[
                     ArrowShape::chevron(
                     arrowScale=3, arrowColor="red", pos = midSource())]
                     ,lineColor="blue")           
                  >,
                  <"node", style(backgroundColor="antiquewhite"
                  , label = label("data(id)", vAlign="center")
                  ,borderColor="darkgrey"
                  ,borderWidth=2)>]
        ,\layout = circle("")
        ));
    println(output);
    writeFile(|project://racytoscal/src/Output.js|, output);
    loc html = |project://racytoscal/src/Racytoscal.html|;
    htmlDisplay(html); 
    }
