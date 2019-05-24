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
//list[str] vBar = [*["cells_<i>_<j>"|j<-[1..7]]|i<-[2..4]]+[*["cells_<i>_<j>"|j<-[3..5]]|i<-[4..6]];
int width = 40; int height = 40;
list[str] hBar(str prepend) = [*[turn(prepend, i,j)|j<-[1..7]]|i<-[4..6]]+[*[turn(prepend, i,j)|j<-[3..5]]|i<-[2..4]];
list[tuple[str, str, str]] clear(int x, int y) = [*[<"cells_<i+y>_<j+x>","background-color", "antiquewhite">|j<-[0..8]]|i<-[0..8]];

list[tuple[int rot, int x, int y]] current = [];

str turn(str prepend, int i, int j) {
    if (isEmpty(current)) return "<prepend>cells_<i>_<j>";
    int x = current[0].x;
    int y = current[0].y;
    switch(current[0].rot) {
         case 0:return "<prepend>cells_<i+y>_<j+x>";
         case 1:return "<prepend>cells_<j+y>_<7-i+x>";
         case 2:return "<prepend>cells_<7-i+y>_<7-j+x>";
         case 3:return "<prepend>cells_<7-j+y>_<i+x>";
         }
    }

public void main() {
    str onLoad(str path) {
         return executeInBrowser(table=[<"attach","table","cells", width, height >, <"T","T_table","T_cells", 8, 8>]
                                ,css= [<v,"background-color","red">|v<-hBar("T_")], onclick=[
                                "rotate","left", "right", "up", "down", "new"]);               
    }
    str onClick(str path) {
         println("Help:<path>");
         if (isEmpty(current)) 
              if (path=="new") {
                 current=[<0, 0, 0>];
                 return executeInBrowser(css=[<v,"background-color","red">|v<-hBar("")]);    
                 }
              else return "";
         int x = current[0].x;
         int y = current[0].y;
         switch(path) {
          case "rotate": current[0].rot = (current[0].rot+1)%4;
          case "left": current[0].x = current[0].x-1;
          case "right": current[0].x = current[0].x+1;
          case "up": current[0].y = current[0].y-1;
          case "down": current[0].y = current[0].y+1;
          }
         return executeInBrowser(css=clear(x, y)+[<v,"background-color","red">|v<-hBar("")]);               
    }
    openBrowser(|project://racytoscal/src/demo/tetris/Graph.html|, "",load = onLoad, click=onClick);  
    }