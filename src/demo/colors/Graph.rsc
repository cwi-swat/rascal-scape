module demo::colors::Graph
import demo::colors::ColorButton;

public App def() { 
    App ap = app( |project://racytoscal/src/demo/colors/Graph.html|
    , <"attach", rows(18, 3)>
     , <"panel", panel()>
    , change=<["slider"], onChange>, click = <["button"], onClick>);
    return ap;
    } 