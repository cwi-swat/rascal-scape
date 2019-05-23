module demo::tetris::Graph
import Prelude;
import Racytoscal;
import util::Math;

list[str] colors = ["blue", "coral", "cyan",  "gray", "green","pink","salmon"
     , "seagreen","skyblue", "slategray","steelblue", "yellow"];
     
str pickColor() {
    int d = arbInt(size(colors));
    return "<colors[d]>";
    }
    
//list[str] hBar = [*["cells_<i>_<j>"|j<-[0..8]]|i<-[3..5]];
//list[str] vBar = [*["cells_<i>_<j>"|j<-[3..5]]|i<-[0..8]];
list[str] vBar = [*["cells_<i>_<j>"|j<-[1..7]]|i<-[2..4]]+[*["cells_<i>_<j>"|j<-[3..5]]|i<-[4..6]];
list[str] hBar = [*["cells_<i>_<j>"|j<-[1..7]]|i<-[4..6]]+[*["cells_<i>_<j>"|j<-[3..5]]|i<-[2..4]];
list[tuple[str, str, str]] clear = [*[<"cells_<i>_<j>","background-color", "antiquewhite">|j<-[0..8]]|i<-[0..8]];

list[str] current = [];

public void main() {
    str onLoad(str path) {
         current = vBar;
         return executeInBrowser(table=<"attach","table","cells", 8, 8 >
                                ,css=clear+[<v,"background-color","red">|v<-current], onclick="attach");   
             
    }
    str onClick(str path) {
         current = current==vBar?hBar:vBar;
         return executeInBrowser(css=clear+[<v,"background-color","red">|v<-current]);   
             
    }
    openBrowser(|project://racytoscal/src/demo/tetris/Graph.html|, "",load = onLoad, click=onClick);  
    }