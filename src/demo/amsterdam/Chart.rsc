module demo::amsterdam::Chart
import Prelude;
extend Racytoscal;
import util::Math;

public App def() { 
    Config conf() = config(\type="bar"
       , \data=\data(
              labels = ["2014","2015","2016","2017","2018"]
              ,datasets= [
                dataSet(
                 \label="alleenstaand"
                  ,backgroundColor= "yellow"
                  ,\data=Points::vec([232762,235152,239179,242253,246378])
                // ,stack="stack"
                  )
               , dataSet(
                 \label="samenwonend0"
                  ,backgroundColor= "lightblue"
                 ,\data=vec([87701,89826,91984,93748, 95647]) 
                // ,stack="stack"
                  )
               , dataSet(
                 \label="samenwonend1"
                  ,backgroundColor= "blue"
                 ,\data=vec([71097,71902,72733,73116,73670])
                 // ,stack="stack"
                  )
             , dataSet(
                 \label="eenoudergezin"
                 ,backgroundColor= "beige"
                ,\data=vec([39452,39727,39920,40441,40651]) 
                //,stack="stack"
                ) 
              , dataSet(
                 \label="overig"
                  ,backgroundColor= "lightgreen"
                 ,\data=vec([5926,6086,6232,6429,6238]) 
                // ,stack="stack"
                  )
               ] 
               )                                    
       , options=options(title=title(display=true,text="Amsterdam")
            ,scales = scales(xAxes=[
                axis(
                   stacked = true                 
                    )]
               , yAxes = [
                  axis(
                      stacked = true
                  )
               ]
            )             
            )
       );
    App ap = app(|project://racytoscal/src/demo/amsterdam/Chart.html|
            , <"attach", conf()>
            );
    return ap;
    } 
 