module demo::chart::Chart
import Prelude;
import Rascalscape;
import Chart;
import util::Math;

public App def() { 
    num step = PI()/2;  
    list[str] pi = ["0","\u03C0/2","\u03C0","3\u03C0/2","2\u03C0"];
    Config config(str color) = config(\type="line"
       , \data=\data(
              datasets= [
                 dataSet(
                 \label="sin"
                  ,backgroundColor= "yellow"
                  ,pointBackgroundColor="antiquewhite"
                  ,pointBorderColor="blue"
                  ,borderColor=color
                  ,fill = false
                  ,\data=points(
                         [<x, sin(x)>|num x<-[0,step..2*PI()+step]]
                  )
              ,xAxisId="x"
              ,yAxisId="y"
              )
                 ,
                 dataSet(
                  \label="cos"
                  ,backgroundColor= "grey"
                  ,pointBackgroundColor="antiquewhite"
                  ,pointBorderColor="magenta"
                  ,borderColor=color
                  ,fill = false
                  ,\data=points(
                       [<x, cos(x)>|num x<-[0,step..2*PI()+step]]
                  )
             )                                
              ])
       , options=options(title=title(display=true,text="gonio")
            ,scales = scales(xAxes=[
                axis(
                   position="bottom", \type="linear", display = true
                  ,scaleLabel = scaleLabel(display= true, labelString="x")
                  ,ticks=ticks(min = 0,max = 2*PI(),stepSize=PI()/2,callback = tickNames(pi)                   
                    ))]
               , yAxes = [
                axis(
                   position="left", \type="linear", display = true
                  ,scaleLabel = scaleLabel(display= true,labelString="y")
                  ,ticks=ticks(min = -1,max = 1,stepSize = 1)
                  )
               ]
            )
            ,tooltips = tooltips(backgroundColor="darkblue"
                 ,callbacks=callbacks(
                   \label=
                       func(arguments=["tooltipItem", "data"], body=
                         "var label=data.datasets[tooltipItem.datasetIndex].label;
                         'var idx=tooltipItem.index;
                          'var pi = <toJavascriptArray(pi)>;
                          'return label+\\\":value:\\\"+pi[idx];"
                       )
                   ,title = func(arguments=["tooltipItems", "data"], body=
                     "return \\\"tip:\\\"+tooltipItems[0].value;")
                  ))
            ,elements = elements(point=point(pointStyle="rectRounded", radius=5, backgroundColor="yellow", borderWidth=2)
                               ,line=line(tension=0.4)
                               ,rectangle=Chart::rectangle(backgroundColor="yellow"))
            ,legend = legend(position="right", labels=labels(usePointStyle=true)
                       
                       )
            )
       ); 
    App ap = app(|project://<project>/src/demo/chart/Chart.html|
             ,<"attach1", config("red")>
             ,<"attach2", config("green")>
            );
    return ap;
    } 
 