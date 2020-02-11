module demo::colors::Graph
import Rascalscape;
import demo::colors::ColorButton;
import Content;

public App def() { 
    App ap = app( |project://<project>/src/demo/colors/Graph.html|
    , <"attach", rows(18, 3)>
     , <"panel", panel()>
    , change=<["slider"], onChange>, click = <["button"], onClick>);
    return ap;
    } 
    
 public Content show() {  
    Content ap = show(|project://<project>/src/demo/colors/Graph.html| 
    , <"attach", rows(18, 3)>
    , <"panel", panel()>
    , change=<["slider"], onChange>, click = <["button"], onClick>
    );
    return ap;
}    