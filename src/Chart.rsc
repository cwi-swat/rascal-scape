module Chart
import Prelude;
import lang::json::IO;
import Racytoscal;
import util::Math;

data Points = points(list[tuple[num x , num y]] pnt)
              |bubble(list[tuple[num x , num y, num r]] pnt3d)
              |vec(list[num z] v);

public alias Color = str;

public Color noneColor = "rgba(220, 220, 220, 0)";

public str defaultColor="";

public data Options = options(
     set[str] keys = {"scales", "title", "legend", "tooltips", "elements"}
     , Scales scales=scales()
     , Title title=title()
     , Legend legend = legend()
     , Tooltips tooltips = tooltips()
     , Elements elements = elements()
     );

public data DataSet(
             set[str] keys = {"label","data","backgroundColor","borderCapStyle","borderColor"
                 ,"borderDash","borderDashOffset","borderJoinStyle","borderWidth"
                 ,"cubicInterpolationMode","fill","lineTension","pointBackgroundColor"
                 ,"pointBorderColor","pointBorderWidth","pointHitRadius","pointHoverBackgroundColor"
                 ,"pointHoverBorderColor","pointHoverBorderWidth","pointRadius","pointRotation"
                 ,"pointStyle", "showLine","spanGaps","steppedLine","xAxisId","yAxisId","stack"}
             , str label=""
             , Points \data=vec([])
             , Color backgroundColor = defaultColor
             , str borderCapStyle = "butt"   // butt, round, square
             , Color borderColor = defaultColor
             , list[num] borderDash = []
             , num borderDashOffset = 0
             , str borderJoinStyle = "miter" // bevel, round, miter
             , num borderWidth = 1
             , str cubicInterpolationMode = "default"
             , value fill = false
             , int lineTension = 0
             , Color pointBackgroundColor  = defaultColor
             , Color pointBorderColor  = defaultColor
             , num pointBorderWidth = 0
             , num pointHitRadius = 0
             , Color pointHoverBackgroundColor  = defaultColor
             , Color pointHoverBorderColor  = defaultColor
             , int pointHoverBorderWidth = 1
             , num pointRadius = 0  
             , num pointRotation = 0
             , str pointStyle = "circle" 
// circle cross crossRot dash line rect rectRounded rectRot star triangle
             , bool showLine = true
             , bool spanGaps = false
             , value steppedLine = false
             , str xAxisId = ""
             , str yAxisId = ""
             , str stack = ""
             ) = dataSet();
    
 public data Data(
      set[str] keys = {"labels", "datasets"}
      , list[str] labels = []
      , list[DataSet] datasets=[]) = \data();
 
 public  data GridLine(
       set[str] keys = {"display", "circular","defaultColor"
          ,"borderDash","borderDashOffset","lineWidth","drawBorder","drawOnChartArea"
          ,"drawTicks","tickMarkLength","zeroLineColor","zeroLineBorderDash","offsetGridLines"}
      , bool display = true
      , bool circular = true
      , Color color = defaultColor
      , list[num] borderDash = []
      , num borderDashOffset = 0
      , num lineWidth = 1
      , bool drawBorder = true
      , bool drawOnChartArea = true
      , bool drawTicks = true
      , num tickMarkLength = 10
      , Color zeroLineColor = defaultColor
      , list[num] zeroLineBorderDash = []
      , bool offsetGridLines = false
      // If true, grid lines will be shifted to be between labels. 
      ) = gridLine();
      
public data ScaleLabel(
      set[str] keys = {"display","labelString","lineHeight","fontColor"
        ,"fontSize","fontStyle","fontFamily","padding"}
      , bool display = true
      , str labelString = ""
      , value lineHeight = ""
      , Color fontColor = "black"
      , num fontSize = 12
      , str fontStyle =  ""
      , str fontFamily = ""
      , value padding = 0
    ) = scaleLabel();
    
public data Title(
      set[str] keys = {"display","text","position","lineHeight","fontColor"
       ,"fontSize","fontStyle","fontFamily","padding"}
      , bool display = true
      , str text = ""
      , str position="top"
      , value lineHeight = ""
      , Color fontColor = "black"
      , num fontSize = 12
      , str fontStyle =  ""
      , str fontFamily = ""
      , value padding = 0
    ) = title();
    
public data Ticks(
      set[str] keys = {"display","fontColor","beginAtZero","min","max"
      ,"maxTickLimits","precision","stepSize","suggestedMax","suggestMin","callback"}
    ,  bool display = true
    , Color fontColor = Black()
    , bool beginAtZero = false
    , num min = 0
    , num max = 0
    , num maxTickLimits = 11
    , num precision = 0
    , num stepSize = 0
    , num suggestedMax = 0
    , num suggestMin = 0
    , Func callback = func()
   ) = ticks();
 
 public data Axis(
         set[str] keys = {"type","position","offset","display","id","gridLine","scaleLabel"
                        ,"ticks","stacked"}
         ,str \type = ""
         // linear, logarithmic, category, time
        ,str position = ""
        ,bool offset = false
        ,bool display = true
        ,str id = ""
        ,GridLine  gridLine = gridLine()
        ,ScaleLabel scaleLabel = scaleLabel()
        ,Ticks ticks = ticks()
        ,bool stacked = false
        ) = axis();
        
 data Scales(
        set[str] keys = {"xAxes", "yAxes"}
        ,list[Axis] xAxes = []
        ,list[Axis] yAxes = []
        ) = scales();
        
 public data Legend(
        set[str] keys = {"display","position","fullWidth","onclick","onhover","onLeave",
           "reverse","labels"}
        ,bool display = true
        ,str position = "top"
        ,bool fullWidth = true
        ,Func onclick = fun()
        ,Func onhover = fun()
        ,Func onLeave = fun()
        ,bool reverse = true
        ,Chart::Labels labels = Chart::labels
        ) = legend();
        
 public  data Labels(
        set[str] keys = {"boxWidth","fontSize","fontStyle","fontColor","fontFamily", "padding"
            // ,"generateLabels" ,"filter"
            ,"usePointStyle"}
        ,num boxWidth = 40
        ,num fontSize = 12
        ,str fontStyle = ""
        ,str fontColor = ""
        ,str fontFamily = ""
        ,num padding = 10
        ,bool usePointStyle = false
        ) = labels();
  
 public data Func(
    set[str] keys = {"arguments", "body"}
    ,list[str] arguments =[]
    ,str  body= "") = func();
    
public data Point(
     set[str] keys = {"radius","pointStyle", "rotation"
         , "backgroundColor",  "borderWidth", "borderColor"
         ,"hitRadius", "hoverRadius", "hoverBorderWidth"}
         ,num radius = 3
         ,str pointStyle  = ""
         , num rotation = 0 //degrees
         , str backgroundColor=""
         , num borderWidth=1
         , str borderColor=""
         , num hitRadius=1
         , num hoverRadius=4
         , num hoverBorderWidth=1
    ) =point();
    
public  data Line(
   set[str] keys = {"tension","backgroundColor", "borderWidth"
         , "borderColor",  "borderCapStyle", "borderDash"
         ,"borderDashOffset", "borderJoinStyle", "capBezierPoints"
         ,"fill", "stepped"}
      , num tension = 0.4
      , Color backgroundColor = defaultColor
      , num borderWidth =3
      , Color borderColor = defaultColor
      , str borderCapStyle = "butt"
      , list[num] borderDash = []
      , num borderDashOffset = 0
      , str borderJoinStyle = ""
      , bool capBezierPoints = false
      , value fill = true
      , bool stepped = false   
   ) = line();
   
public data Rectangle(
   set[str] keys = {"backgroundColor", "borderWidth", "borderColor", "borderSkipped"}
   , Color backgroundColor = defaultColor
   , num borderWidth = 3
   , Color borderColor = "#fff"
   , str borderSkipped = "bottom"
   ) = rectangle();
   
public data Arc(
  set[str] keys = {"backgroundColor", "borderWidth", "borderColor", "borderAlign"}
  , Color backgroundColor = defaultColor
  , num borderWidth = 2
  , Color borderColor = "#fff"
  , str borderAlign = "center"
  ) = arc();
    
public data Elements(
      set[str] keys = {"rectangle", "arc", "line", "point"}
      ,Rectangle rectangle = rectangle()
      ,Arc arc = arc()
      ,Line line = line()
      ,Point point = point()
     ) = elements();  
         
 
     
 public data Tooltips(
     set[str] keys = {"enabled","costum","mode","intersect","position","callbacks"
          ,"backgroundColor"
          ,"titleFontFamily","titleFontSize","titleFontStyle","titleFontColor"
          ,"titleSpacing","titleMarginBottom"
          ,"bodyFontFamily","bodyFontSize","bodyFontStyle","bodyFontColor"
          ,"bodySpacing","bodyMarginBottom"
          ,"footerFontFamily","footerFontSize","footerFontStyle","footerFontColor"
          ,"footerSpacing","footerMarginBottom"
          ,"xPadding", "yPadding", "caretPadding", "caretSize"
          ,"cornerRadius", "multiKeyBackground", "displayColors", "borderColor","borderWidth"
          }
     ,bool enabled = true
     ,Func costum = func()
     ,str mode = "nearest"
     ,bool intersect = true
     ,str position = "average"
     // average, nearest
     ,Callbacks callbacks = callbacks()
     ,Color backgroundColor = defaultColor
     ,str titleFontFamily = ""
     ,num titleFontSize = 12
     ,str titleFontStyle = ""
     ,Color titleFontColor = defaultColor
     ,num titleSpacing  = 2
     ,num titleMarginBottom = 6
     ,str bodyFontFamily = ""
     ,num bodyFontSize = 12
     ,str bodyFontStyle = ""
     ,Color bodyFontColor = defaultColor
     ,num bodySpacing  = 2
     ,num bodyMarginBottom = 6
     ,str footerFontFamily = ""
     ,num footerFontSize = 12
     ,str footerFontStyle = ""
     ,Color footerFontColor = defaultColor
     ,num footerSpacing  = 2
     ,num footerMarginBottom = 6
     ,num xPadding = 6
     ,num yPadding = 6
     ,num caretPadding = 2
     ,num caretSize = 5
     ,num cornerRadius=6
     ,str multiKeyBackground=""
     ,bool displayColors=true
     ,str borderColor=""
     ,num borderWidth = 0
     ) = tooltips();
     
 data Callbacks (
     set[str] keys = {"label","labelColor","labelTextColor", "title"}
     ,Func label = func()
     ,Func labelColor = func()
     ,Func labelTextColor = func()
     ,Func title = func()
    ) = callbacks();  
 
public data Config(
     set[str] keys = {"type","data","options"}
     ,str \type ="" 
     ,Data \data=\data()
     ,Options options = options())=config();
     
public str toJavascriptArray(list[str] names) = "[<intercalate(",", ["\\\"<v>\\\""|str v<-names])>]"; 
 
public Func tickNames(list[str] names) {
     str t = toJavascriptArray(names);
     return func(arguments=["value", "index", "values"]
     , body = "var v = <t>;return v[index];");
     }
     
public str genScript(str attach, Config config) {
     str parameters = adt2json(config);
     // println(parameters);
     str r = 
     "var div = document.getElementById(\'<attach>\');
     'var ctx = document.createElement(\'canvas\');
     'ctx.setAttribute(\'id\', \'-<attach>\');
     'div.appendChild(ctx);
     '// alert(JSON.stringify(JSON.parse(\'<parameters>\')));
     'chart[\"<attach>\"] = new Chart(ctx, walkThroughCardConfiguration(JSON.parse(\'<parameters>\')));
     ";
     return r;
     }
     
private value newLine(value v) = (str s:=v)?replaceAll(s,"\n",""):v;

private map[str, value] adt2map(node t) {
   map[str, value] q = getKeywordParameters(t);
   map[str, value] r = (d:newLine(q[d])|d<-q);
   for (str x<-domain(r)) {if (x notin getKeys(t)) throw "Illegal keyword parameter: <x>";}
   for (str d<-r) {
        if (vec(list[num] y):= r[d]) r[d] = [_(g)|num g<-y];
        if (points(list[tuple[num, num]] z):= r[d]) r[d] = [("x":_(s[0]),"y":_(s[1]))|s<-z];
        if (bubble(list[tuple[num, num, num]] z):= r[d]) r[d] = [("x":_(s[0]),"y":_(s[1]),"r":_(s[2]))|s<-z];  
        if (node n := r[d]) {
           r[d] = adt2map(n);
        }
        if (list[node] l:=r[d]) {
           r[d] = [adt2map(e)|e<-l];
           }     
      }
   return r;
   } 

private str adt2json(node t) {
   return toJSON(adt2map(t), true);
   }
   
private set[str] getKeys(node v) {
    switch (v) {
        case DataSet q: return q.keys;
        case Data q: return q.keys;
        case GridLine q: return q.keys;
        case ScaleLabel q: return q.keys;
        case Title q: return q.keys;
        case Ticks q: return q.keys;
        case Axis q: return q.keys;
        case Scales q: return q.keys;
        case Legend q: return q.keys;
        case Labels q: return q.keys;
        case Func q: return q.keys;
        case Options q: return q.keys;
        case Config q: return q.keys;
        case Tooltips q: return q.keys;
        case Callbacks q: return q.keys;
        case Point q: return q.keys;
        case Line q: return q.keys;
        case Arc q: return q.keys;
        case Rectangle q: return q.keys;
        case Elements q: return q.keys;
        }
    }