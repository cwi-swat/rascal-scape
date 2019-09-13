module Chart
import Prelude;
import lang::json::IO;
import Racytoscal;
import util::Math;


data Point = point(list[tuple[num x , num y]] pnt)|vec(list[num z] v);

// data Color = rgba(int r, int g, int b, num a);

alias Color = str;

Color none = "rgba(220, 220, 220, 0)";

//Color Black = rgba(1, 1, 1, 1);
//Color Red = rgba(255, 99, 132, 1);
//Color Blue = rgba(54, 162, 235, 1);
//Color Yellow = rgba(255, 206, 86, 1);
//Color Green = rgba(75, 192, 192, 1);
//Color Purple = rgba(153, 102, 255, 1);
//Color Orange = rgba(255, 159, 64, 1);
//Color DefaultColor = rgba(0,0,0,0.1);
str defaultColor="";

public map[str, value] adt2map(node t) {
   map[str, value] q = getKeywordParameters(t);
   map[str, value] r = (replaceLast(d,"_",""):q[d]|d<-q);
   for (d<-r) {
        if (vec(list[num] y):= r[d]) r[d] = [_(d)|d<-y]; 
        if (point(list[tuple[num, num]] z):= r[d]) r[d] = [("x":_(s[0]),"y":_(s[1]))|s<-z]; 
        if (node n := r[d]) {
           r[d] = adt2map(n);
        }
        if (list[node] l:=r[d]) {
           r[d] = [adt2map(e)|e<-l];
           }     
      }
   return r;
   } 

public str adt2json(node t) {
   return toJSON(adt2map(t), true);
   }
   
              
 data DataSet(str label=""
             , Point \data=vec([])
             , Color backgroundColor = defaultColor
             , str borderCapStyle = "butt"
 // butt, round, square
             , Color borderColor = defaultColor
             , list[num] borderDash = []
             , num borderDashOffset = 0
             , str borderJoinStyle = "miter"
 // bevel, round, miter
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
             ) = dataSet();
    
 
 data Data(list[str] labels = [], list[DataSet] datasets=[]) = \data();
 
 data GridLine(
        bool display = true
      , bool circular = true
      , Color color = defaultColor()
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
      ) = gridLine();
      
data ScaleLabel(bool display = true
      , str labelString = ""
      , value lineHeight = ""
      , Color fontColor = "black"
      , num fontSize = 12
      , str fontStyle =  ""
      , str fontFamily = ""
      , value padding = 0
    ) = scaleLabel();
    
data Title(bool display = true
      , str text = ""
      , str position="top"
      , value lineHeight = ""
      , Color fontColor = "black"
      , num fontSize = 12
      , str fontStyle =  ""
      , str fontFamily = ""
      , value padding = 0
    ) = title();
    
data Ticks(
      bool display = true
    , Color fontColor = Black()
    , bool beginAtZer0 = false
    , num min = 0
    , num max = 0
    , num maxTickLimits = 11
    , num precision = 0
    , num stepSize = 0
    , num suggestedMax = 0
    , num suggestMin = 0
    , Func callback = func()
   ) = ticks();
 
 data Axis(
         str \type = ""
         // linear, logarithmic, category, time
        ,str position = ""
        ,bool offset = false
        ,bool display = true
        ,str id = ""
        ,GridLine  gridLine = gridLine()
        ,ScaleLabel scaleLabel = scaleLabel()
        ,Ticks ticks = ticks()
        ) = axis();
        
 data Scales(
        list[Axis] xAxes = []
        ,list[Axis] yAxes = []
        ) = scales();
  
 data Func(list[str] arguments =[], str  body= "") = func();       
 
 data Options = options(Scales scales=scales(), Title title=title());
 
 data Config(str \type ="", Data \data=\data(), Options options = options())=config();
   
 public void main() {
     num step = PI()/2;  
     list[str] pi = ["0","\u03C0/2","\u03C0","3\u03C0/2","2\u03C0"];
     Config config = config(\type="line"
       , \data=
         \data(
              // labels = ["a", "b", "c"]
              datasets=
              [dataSet(
                 \label="sin"
                 ,backgroundColor= none
                 , pointBackgroundColor="red"
                 , pointBorderColor="red"
                 , borderColor="red"
                 ,\data=point(
                   [<x, sin(x)>|num x<-[0,step..2*PI()+step]]
                  )
              ,xAxisId="x"
              ,yAxisId="y"
                  )
               ,
               dataSet(
               \label="cos"
               ,\data=point(
                   [<x, cos(x)>|num x<-[0,step..2*PI()+step]]
                  )
              ,xAxisId="x"
              ,yAxisId="y")                                
              ])
       , options=options(title=title(text="aap")
            ,scales = scales(xAxes=[axis(position="bottom", \type="linear", display = true
               , scaleLabel = scaleLabel(display=true, labelString="x")
               , ticks=ticks(
                 , min = 0
                 , max = 2*PI()
                 , stepSize=PI()/2
                 , callback = func(arguments=["value", "index", "values"], body =
                         "return v[index];")
                        
               ), id = "x")]
               , yAxes = [axis(position="left", \type="linear", display = true, ticks=ticks( 
               min = -2
               ,max = 2
               ,stepSize = 1
               ), id = "y")
               ]
            ))
       );
     println(adt2json(config));
     str output = chart("attach", config);
     openBrowser(|project://racytoscal/src/demo/frame/Graph.html|, output); 
     }
     
 str chart(str attach, Config config) {
     str parameters = adt2json(config);
     // println(parameters);
     str r = 
     "var ctx = document.getElementById(\'<attach>\').getContext(\'2d\');
     '// alert(JSON.stringify(JSON.parse(\'<parameters>\')));
     'new Chart(ctx, JSON.parse(\'<parameters>\'));
     ";
     return r;
     }