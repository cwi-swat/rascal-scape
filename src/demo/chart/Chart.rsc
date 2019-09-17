module demo::chart::Chart
import Prelude;
import Racytoscal;
import util::Math;


public void main() {
     num step = PI()/2;  
     list[str] pi = ["0","\u03C0/2","\u03C0","3\u03C0/2","2\u03C0"];
     Config config(str color) = config(\type="line"
       , \data=
         \data(
              datasets=
              [dataSet(
                 \label="sin"
                 ,backgroundColor= noneColor
                 , pointBackgroundColor=color
                 , pointBorderColor=color
                 , borderColor=color
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
             )                                
              ])
       , options=options(title=title(display=true,text="aap")
            ,scales = scales(xAxes=[
                axis(
                   position="bottom", \type="linear", display = true
                  ,scaleLabel = scaleLabel(display=true, labelString="x")
                  ,ticks=ticks(min = 0,max = 2*PI(),stepSize=PI()/2,callback = tickNames(pi)                   
                    ))]
               , yAxes = [
                  axis(
                  position="left", \type="linear", display = true, 
                  ticks=ticks(min = -1,max = 1,stepSize = 1)
                  )
               ]
            )
            , tooltips = tooltips(callbacks=callbacks(\label=
                 func(arguments=["tooltipItem", "data"], body=
                   "var label=data.datasets[tooltipItem.datasetIndex].label;
                   'var idx=tooltipItem.index;
                   'return label+\\\":aap:\\\"+idx;"
                  )))
            )
       );
     println(adt2json(config("blue")));
     str output1 = genScript("attach1", config("red"));
     str output2 = genScript("attach2", config("green"));
     openBrowser(|project://racytoscal/src/demo/chart/Chart.html|, output1+output2); 
     }
    
public void exit() = disconnect(site);   
 