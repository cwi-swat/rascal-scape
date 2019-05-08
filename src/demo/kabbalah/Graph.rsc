module demo::kabbalah::Graph
import Prelude;
import Racytoscal;
import util::Math;

list[str] colors = ["blue", "coral", "cyan",  "gray", "green","pink","salmon"
     , "seagreen","skyblue", "slategray","steelblue", "yellow"];
     

public void main() {
    int n = 5000;
    list[Ele]  nodes = 
        [
         n_("keter", position=<300, 160> ,style = style(label = label("\u05DB\u05EA\u05E8", vAlign = "center")))
        ,n_("binah", position=<100, 260> ,style = style(label = label("\u05D1\u05D9\u05E0\u05D4", vAlign = "center")))
        ,n_("chokmah", position=<500, 260> ,style = style(label = label("\u05D7\u05DB\u05DE\u05D4", vAlign = "center")))
        ,n_("geburah", position=<100, 460> ,style = style(label = label("\u05D2\u05D1\u05D5\u05E8\u05D4", vAlign = "center")))
        ,n_("chessed", position=<500, 460> ,style = style(label = label("\u05D7\u05E1\u05D3", vAlign = "center")))
        ,n_("hod", position=<100, 660> ,style = style(label = label("\u05D4\u05D5\u05D3", vAlign = "center")))
        ,n_("nezach", position=<500, 660> ,style = style(label = label("\u05D5\u05E5\u05D7", vAlign = "center")))
        ,n_("tiferet", position=<300, 560> ,style = style(label = label("\u05EA\u05E4\u05D0\u05E8\u05DA", vAlign = "center")))
        ,n_("jesod", position=<300, 760> ,style = style(label = label("\u05D9\u05E1\u05DF\u05D3", vAlign = "center")))
        ,n_("malkuth", position=<300, 960> ,style = style(label = label("\u05DE\u05DC\u05DB\u05D5\u05EA", vAlign = "center")))
        ];
    list[Ele] edges = [e_("waf", "keter", "binah")
                      ,e_("he", "keter", "chokmah")
                      ,e_("gimel", "binah", "geburah")
                      ,e_("beth", "chokmah", "chessed")
                      ,e_("kuf", "binah", "chessed")
                      ,e_("zaijn", "chokmah", "geburah")
                      ,e_("aijn", "binah", "tiferet")
                      ,e_("tet", "chokmah", "tiferet")
                      ,e_("tsadek", "geburah", "tiferet")
                      ,e_("het", "chessed", "tiferet")
                      ,e_("sameg", "hod", "tiferet")
                      ,e_("jut", "nezach", "tiferet")
                      ,e_("mem", "hod", "nezach")
                      ,e_("aleph", "geburah", "chessed")
                      ,e_("sjin", "binah", "chokmah")
                      ,e_("dalet", "keter", "tiferet")
                      ,e_("reesh", "tiferet", "jesod")
                      ,e_("lamed", "hod", "jesod")
                      ,e_("nun", "nezach", "jesod")
                      ,e_("tav", "jesod", "malkuth")
                      ,e_("pe", "geburah", "hod")
                      ,e_("kaf", "chessed", "nezach")
                      ];
   println(size(edges));
    str output = genScript("cy", cytoscape(
        elements= nodes + edges
       ,styles = [
                  <"node", style(
                    width = "50px",
                    height= "50px", 
                    // backgroundColor="antiquewhite",
                    shape=ellipse(),
                    backgroundFill="radial-gradient",
                    backgroundGradientStopPositions="0% 20% 25% 30% 40% 50% 60% 70% 80& 90% 100%",
                    backgroundGradientStopColors= "lightsteelblue steelblue",
                    backgroundOpacity=1.0,
                    borderWidth = 0 , borderColor="antiquewhite"
                   // ,padding = 10 
                   // ,\label=\label("Test", vAlign="center")
                  )>
                  ,
                  <"edge#sjin,#aleph,#mem", style(lineColor="red")>
                  ]
         ,\layout = preset("")
        )
      ); 
    openBrowser(|project://racytoscal/src/demo/kabbalah/Graph.html|, output);  
    }