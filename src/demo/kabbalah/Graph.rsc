module demo::kabbalah::Graph
import Prelude;
import Rascalscape;
import Cytoscape;
import util::Math;
import Content;

Cytoscape getGraph() {
    list[Ele]  nodes = 
        [
         n_("keter", position=<300, 160> ,style = style(label = label("\u05DB\u05EA\u05E8", vAlign = "center")))
        ,n_("binah", position=<100, 260> ,style = style(label = label("\u05D1\u05D9\u05E0\u05D4", vAlign = "center")))
        ,n_("chokmah", position=<500, 260> ,style = style(label = label("\u05D7\u05DB\u05DE\u05D4", vAlign = "center")))
        ,n_("geburah", position=<100, 460> ,style = style(label = label("\u05D2\u05D1\u05D5\u05E8\u05D4", vAlign = "center")))
        ,n_("chessed", position=<500, 460> ,style = style(label = label("\u05D7\u05E1\u05D3", vAlign = "center")))
        ,n_("hod", position=<100, 660> ,style = style(label = label("\u05D4\u05D5\u05D3", vAlign = "center")))
        ,n_("nezach", position=<500, 660> ,style = style(label = label("\u05D5\u05E5\u05D7", vAlign = "center")))
        ,n_("tiferet", position=<300, 560> ,style = style(label = label("\u05EA\u05E4\u05D0\u05E8\u05EA", vAlign = "center")))
        ,n_("jesod", position=<300, 760> ,style = style(label = label("\u05D9\u05E1\u05DF\u05D3", vAlign = "center")))
        ,n_("malkuth", position=<300, 960> ,style = style(label = label("\u05DE\u05DC\u05DB\u05D5\u05EA", vAlign = "center")))
        ];
    list[Ele] edges = [e_("waf", "keter", "binah", style=style(label=label("\u05D5")))
                      ,e_("he", "keter", "chokmah", style=style(label=label("\u05D4")))
                      ,e_("gimel", "binah", "geburah", style=style(label=label("\u05D2")))
                      ,e_("beth", "chokmah", "chessed", style=style(label=label("\u05D1")))
                      ,e_("kuf", "binah", "chessed", style=style(label=label("\u05E7", marginX=-30, marginY = -30)))
                      ,e_("zaijn", "chokmah", "geburah", style=style(label=label("\u05D6", marginX=30, marginY = -30)))
                      ,e_("aijn", "binah", "tiferet", style=style(label=label("\u05E2", marginX=30, marginY = 30)))
                      ,e_("tet", "chokmah", "tiferet", style=style(label=label("\u05D8", marginX=0, marginY = 30)))
                      ,e_("tsadek", "geburah", "tiferet", style=style(label=label("\u05E6")))
                      ,e_("het", "chessed", "tiferet", style=style(label=label("\u05D7")))
                      ,e_("sameg", "hod", "tiferet", style=style(label=label("\u05E1")))
                      ,e_("jut", "nezach", "tiferet", style=style(label=label("\u05D9")))
                      ,e_("mem", "hod", "nezach", style=style(label=label("\u05DE", marginY=30, marginX=10)))
                      ,e_("aleph", "geburah", "chessed", style=style(label=label("\u05D0", marginX=40)))
                      ,e_("sjin", "binah", "chokmah", style=style(label=label("\u05E9", marginX=40)))
                      ,e_("dalet", "keter", "tiferet", style=style(label=label("\u05D3", marginY=40)))
                      ,e_("reesh", "tiferet", "jesod", style=style(label=label("\u05E8", marginX=40)))
                      ,e_("lamed", "hod", "jesod", style=style(label=label("\u05DC")))
                      ,e_("nun", "nezach", "jesod", style=style(label=label("\u05E0")))
                      ,e_("tav", "jesod", "malkuth", style=style(label=label("\u05EA")))
                      ,e_("pe", "geburah", "hod", style=style(label=label("\u05E4")))
                      ,e_("kaf", "chessed", "nezach", style=style(label=label("\u05DB")))
                      ];
     Cytoscape cy = cytoscape(
        elements= nodes + edges
       ,styles = [
                  <"node", style(
                    width = "50px",
                    height= "50px", 
                    shape=NodeShape::ellipse(),
                    backgroundFill="radial-gradient",
                    backgroundGradientStopPositions="0% 20% 25% 30% 40% 50% 60% 70% 80& 90% 100%",
                    backgroundGradientStopColors= "lightsteelblue steelblue",
                    backgroundOpacity=1.0,
                    borderWidth = "0" , borderColor="antiquewhite"
                  )>
                ,<"edge", style(lineColor="khaki"
                     ,textBackgroundColor="whitesmoke", textBackgroundPadding=1
                     ,textBackgroundOpacity=1, textOpacity= 1
                     ,color="grey"
                     ,fontSize="20pt"
                   )>
                ,<"edge#sjin,#aleph,#mem", style(lineColor="pink")>
                ,<"edge#waf,#pe,#gimel, #lamed, #nun, #kaf, #beth, #he, #tav"
                                          ,style(lineColor="lightblue")>
                ]
         ,\layout = preset("")
        );
        return cy;
      }
      
   public App def() {
    App ap = app(|project://<project>/src/demo/kabbalah/Graph.html|, <"cy", getGraph()>, display = true);  
    return ap;
    }
    
    public Content show() {  
    return show(|project://<project>/src/demo/kabbalah/Graph.html| 
           ,<"cy", getGraph()>
          );
    }    