module demo::tetris::Graph
import Prelude;
import Racytoscal;
import util::Math;

alias el = tuple[int rot, int x, int y, rel[int, int] state, str kind] ;

list[str] colors = ["blue", "coral", "cyan",  "gray", "green","pink","salmon"
     , "seagreen","skyblue", "slategray","steelblue", "yellow"];
     
str pickColor() {
    int d = arbInt(size(colors));
    return "<colors[d]>";
    }
    
list[el] current = [];

el nullEl = <0, 0, 0, {}, "">;

list[str] rFig = ["T","I", "Z", "L", "L1", "O"];
    
int width = 20; int height = 40;

list[tuple[int x, int y]] computeI() =  [*[<i, j>|j<-[3..5]]|i<-[0..8]];
list[tuple[int x, int y]] computeT() =  [*[<i, j>|int j<-[1..7]]|int i<-[4..6]] + [*[<i, j>|int j<-[3..5]]|int i<-[2..4]];
list[tuple[int x, int y]] computeZ() =  [*[<i, j>|int j<-[1..5]]|int i<-[2..4]] + [*[<i, j>|int j<-[3..7]]|int i<-[4..6]];
list[tuple[int x, int y]] computeL() =  [*[<i, j>|int j<-[2..4]]|int i<-[1..7]] + [*[<i, j>|int j<-[4..6]]|int i<-[5..7]];
list[tuple[int x, int y]] computeL1() = [*[<i, j>|int j<-[4..6]]|int i<-[1..7]] + [*[<i, j>|int j<-[2..4]]|int i<-[5..7]];
list[tuple[int x, int y]] computeO() =  [*[<i, j>|int j<-[2..6]]|int i<-[2..6]];

list[str] fig(str prepend, el old, str kind) {
     int last = size(current)-1;
     if (last>=0) current[last].state = {};
     lrel[int, int] fig1 = [];
     switch(kind) {
        case "T": fig1 = computeT();
        case "I": fig1 = computeI();
        case "Z": fig1 = computeZ();
        case "L": fig1 = computeL();
        case "L1": fig1 = computeL1();
        case "O": fig1 = computeO();
        }
     list[str] r =  [turn(prepend, p.x,p.y)|tuple[int x, int y] p<-fig1];
     if (!isDisjunct()) {
          current[last] = old; 
          r =  [turn(prepend, p.x,p.y)|tuple[int x, int y] p<-fig1];
          }
     return r;
     }
     
list[tuple[str, str, str]] clear(rel[int x, int y] state) = [<"cells_<d.x>_<d.y>","background-color", "antiquewhite">|d<-state];

tuple[int y, int x] space(int i, int j) {
    int x = current[-1].x;
    int y = current[-1].y;
    switch(current[-1].rot) {
         case 0:return <i+y, j+x>;
         case 1:return <j+y, 7-i+x>;
         case 2:return <7-i+y,7-j+x>;
         case 3:return <7-j+y, i+x>;
         }
    }

str turn(str prepend, int i, int j) {
    if (isEmpty(current)) return "<prepend>cells_<i>_<j>";
    int last = size(current)-1;
    tuple[int y, int x] r = space(i, j);
    // println("HELP:<r>  <current[last].state>");
    current[last].state += {r};
    return "<prepend>cells_<r.y>_<r.x>";
    }
 
bool isDisjunct() {
   if (isEmpty(current)) return true;
   rel[int y, int x] state = current[-1].state;
   for (tuple[int y, int x] t <- state) {
     if (t.y<0 || t.x<0 || t.y>=height || t.x>=width) return false;
     }
   int n = size(current)-2;
   while (n>=0 && (isEmpty(current[n].state & state))) n-=1;
   return n== -1;
   }
   
str new(str kind) {
   current+=[<0, 0, 0, {},kind>];
   return executeInBrowser(css=[<v,"background-color", getColor(kind)>|v<-fig("", nullEl, kind)]);    
   }
   
str getColor(str kind) {
   switch(kind) {
      case "T":return "red";
      case "I":return "blue";
      case "Z":return "goldenrod";
      case "L":return "brown";
      case "L1":return "green";
      case "O":return "salmon";
      }
   }
 
 void fall() {  
       if (size(current)>=1) {
          int last = size(current)-1;
          rel[int y, int x] old = current[last].state;
          while (isDisjunct()) {   
            current[last].y = current[-1].y+1;
            current[last].state = {<d.y+1, d.x>|d<-old};
            old = current[last].state;
            }
         current[last].state=old;
         current[last].y = current[-1].y-1;
         }
    }

public void main() {
    current = [];
    str onLoad(str path) {
         return executeInBrowser(table=[<"attach","table","cells", width, height >
                                       ,<"T","T_table","T_cells", 8, 8>
                                       ,<"I","I_table","I_cells", 8, 8>
                                       ,<"Z","Z_table","Z_cells", 8, 8>
                                       ,<"L","L_table","L_cells", 8, 8>
                                       ,<"L1","L1_table","L1_cells", 8, 8>
                                       ,<"O","O_table","O_cells", 8, 8>
                                       ]
                                ,css= [<v,"background-color",getColor("T")>|v<-fig("T_",  nullEl, "T")]
                                     +[<v,"background-color",getColor("I")>|v<-fig("I_",  nullEl, "I")]
                                     +[<v,"background-color",getColor("Z")>|v<-fig("Z_",  nullEl, "Z")]
                                     +[<v,"background-color",getColor("L")>|v<-fig("L_",  nullEl, "L")]
                                     +[<v,"background-color",getColor("L1")>|v<-fig("L1_",  nullEl, "L1")]
                                     +[<v,"background-color",getColor("O")>|v<-fig("O_",  nullEl, "O")]
                                      , onclick=[
                                "rotate","left", "right", "up", "down", "fall", "T_table", 	"I_table", "Z_table","L_table","L1_table","O_table"]
                                 , setInterval=10000
                                );               
    }
    
    str onTimer(str path) {
       // println(path);
       str kind = rFig[arbInt(6)];
       if (size(current)>=1) {
          el old = current[-1];
          rel[int, int] state = old.state;
          fall();
          list[tuple[str, str, str]] oldArg = [<v,"background-color",getColor(current[-1].kind)>|v<-fig("",old,current[-1].kind)];
          current+=[<0, 0, 0, {},kind>];
          return executeInBrowser(css=clear(state)+oldArg
                                                  +[<v,"background-color", getColor(kind)>|v<-fig("", nullEl, kind)]);  
          }
       current+=[<0, 0, 0, {},kind>]; 
       return executeInBrowser(css=[<v,"background-color", getColor(kind)>|v<-fig("", nullEl, kind)]);   
       }
       
    str onClick(str path) {
         // println("onClick: <path>");
         switch (path) {
               case "T_table": return new("T");
               case "I_table": return new("I");
               case "Z_table": return new("Z");
               case "L_table": return new("L");
               case "L1_table": return new("L1");
               case "O_table": return new("O");
               }
         if (size(current)>=1) {
         el old = current[-1];
         rel[int, int] state = old.state;
         int last = size(current)-1;
         switch(path) {
          case "rotate": current[last].rot = (current[-1].rot+1)%4;
          case "left": current[last].x = current[-1].x-1;
          case "right": current[last].x = current[-1].x+1;
          case "up": current[last].y = current[-1].y-1;
          case "down": current[last].y = current[-1].y+1;
          case "fall": {
                 fall();
                 list[tuple[str, str, str]] oldArg = [<v,"background-color",getColor(current[-1].kind)>|v<-fig("",old,current[-1].kind)];
                 str kind = rFig[arbInt(6)];
                 current+=[<0, 0, 0, {},kind>];
                 return executeInBrowser(css=clear(state)+oldArg
                                                 +[<v,"background-color", getColor(kind)>|v<-fig("", nullEl, kind)]);  
                 }
          }
         return executeInBrowser(css=clear(state)+[<v,"background-color",getColor(current[-1].kind)>|v<-fig("",old,current[-1].kind)]
                                                 );  
         }
    return "";             
    }
    openBrowser(|project://racytoscal/src/demo/tetris/Graph.html|, "",load = onLoad, click=onClick
       , timer = onTimer
    );  
    }