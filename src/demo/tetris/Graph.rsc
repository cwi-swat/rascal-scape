module demo::tetris::Graph
import Prelude;
import Racytoscal;
import util::Math;

alias el = tuple[int rot, int x, int y, rel[int, int] state, str kind];

int shift  =3;

list[str] colors = ["blue", "coral", "cyan",  "gray", "green","pink","salmon"
     , "seagreen","skyblue", "slategray","steelblue", "yellow"];
     
str pickColor() {
    int d = arbInt(size(colors));
    return "<colors[d]>";
    }
    
list[el] current = [];

int cnt = 0;

el nullEl = <0, 0, 0, {}, "">;

list[str] rFig = ["T","I", "Z", "Z1", "L", "L1", "O"];
    
int width = 20; int height = 40;

int minY = height;
list[tuple[int y, int x]] computeClr() =  [*[<i, j>|j<-[0..8]]|i<-[0..8]];
list[tuple[int y, int x]] computeI() =  [*[<i, j>|j<-[3..5]]|i<-[0..8]];
list[tuple[int y, int x]] computeT() =  [*[<i, j>|int j<-[1..7]]|int i<-[4..6]] + [*[<i, j>|int j<-[3..5]]|int i<-[2..4]];
list[tuple[int y, int x]] computeZ() =  [*[<i, j>|int j<-[1..5]]|int i<-[2..4]] + [*[<i, j>|int j<-[3..7]]|int i<-[4..6]];
list[tuple[int y, int x]] computeZ1() =  [*[<i, j>|int j<-[1..5]]|int i<-[4..6]] + [*[<i, j>|int j<-[3..7]]|int i<-[2..4]];
list[tuple[int y, int x]] computeL() =  [*[<i, j>|int j<-[2..4]]|int i<-[1..7]] + [*[<i, j>|int j<-[4..6]]|int i<-[5..7]];
list[tuple[int y, int x]] computeL1() = [*[<i, j>|int j<-[4..6]]|int i<-[1..7]] + [*[<i, j>|int j<-[2..4]]|int i<-[5..7]];
list[tuple[int y, int x]] computeO() =  [*[<i, j>|int j<-[2..6]]|int i<-[2..6]];

list[tuple[int y, int x]] cornerI = [<0, 3>, <7, 3>, <7, 4>, <0, 4>];
list[tuple[int y, int x]] cornerT = [<2, 1>, <5, 1>, <5, 6>, <2, 6>];
list[tuple[int y, int x]] cornerZ = [<2, 1>, <5, 1>, <5, 6>, <2, 6>];
list[tuple[int y, int x]] cornerZ1 = [<2, 1>, <5, 1>, <5, 6>, <2, 6>];
list[tuple[int y, int x]] cornerL = [<1, 2>, <6, 2>, <6, 5>, <1, 5>];
list[tuple[int y, int x]] cornerL1 = [<1, 2>, <6, 2>,  <6, 5>, <1, 5>];
list[tuple[int y, int x]] cornerO = [<2, 2>, <5, 2>, <5, 5>, <2, 5>];
list[tuple[int y, int x]] cornerClr = [<0, 0>, <7, 0>, <7, 7>, <7, 7>];

list[str] fig(str prepend, el old, str kind) {
     int last = size(current)-1;
     if (last>=0) current[last].state = {};
     lrel[int y, int x] fig1 = [];
     switch(kind) {
        case "T": fig1 = computeT();
        case "I": fig1 = computeI();
        case "Z": fig1 = computeZ();
        case "Z1": fig1 = computeZ1();
        case "L": fig1 = computeL();
        case "L1": fig1 = computeL1();
        case "O": fig1 = computeO();
        case "Clr": fig1 = computeClr();
        }
     list[str] r =  [turn(prepend, p.y, p.x, 8)|tuple[int y, int x] p<-fig1];
     if (!isDisjunct()) {
          current[last] = old; 
          r =  [turn(prepend, p.y, p.x, 8)|tuple[int y, int x] p<-fig1];
          }
     return r;
     }
     
list[tuple[str, str, str]] clear(rel[int y, int x] state) = [<"<d.y*width+d.x>cells","background-color", "antiquewhite">|d<-state];

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
 
tuple[int y, int x] space(tuple[int y, int x] t) = space(t.y, t.x); 

int rot1() {
    int angle = current[-1].rot;
     switch(current[-1].kind) {
         case "L": return space(cornerL[angle]).x;
         case "L1": return space(cornerL1[angle]).x;
         case "I": return space(cornerI[angle]).x;
         case "O": return space(cornerO[angle]).x;
         case "T": return space(cornerT[angle]).x;
         case "Z": return  space(cornerZ[angle]).x;
         case "Z1": return  space(cornerZ1[angle]).x;
         case "Clr": return  space(cornerClr[angle]).x;
      }
    return 0;
    }
    
int rot2() {
    int angle = (current[-1].rot+2)%4;
     switch(current[-1].kind) {
         case "L": return space(cornerL[angle]).x;
         case "L1": return space(cornerL1[angle]).x;
         case "I": return space(cornerI[angle]).x;
         case "O": return space(cornerO[angle]).x;
         case "T": return space(cornerT[angle]).x;
         case "Z": return  space(cornerZ[angle]).x;
         case "Z1": return  space(cornerZ1[angle]).x;
         case "Clr": return  space(cornerClr[angle]).x;
      }
    return 0;
    }  

str turn(str prepend, int i, int j, int n) {
    if (isEmpty(current)) return "<i*n+j><prepend>cells";
    int last = size(current)-1;
    tuple[int y, int x] r = space(i, j);
    // println("HELP:<r>  <current[last].state>");
    current[last].state += {r};
    return "<r.y*width+r.x><prepend>cells";
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
   cnt=cnt+1;
   return executeInBrowser(css=[<v,"background-color", getColor(kind)>|v<-fig("", nullEl, kind)]
        , extra="\"x1\":\"<rot1()>\", \"y1\":\"<0>\", \"x2\":\"<rot2()>\", \"y2\":\"<0>\",\"cnt\",\"<cnt>\""
        );    
   }
   
str getColor(str kind) {
   switch(kind) {
      case "T":return "red";
      case "I":return "blue";
      case "Z":return "goldenrod";
      case "Z1":return "orange";
      case "L":return "brown";
      case "L1":return "green";
      case "O":return "cyan";
      case "Clr":return "grey";
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
         minY=current[-1].y;
         }
    }

public void main() {
    current = [];
    str onLoad(str path) {
         return executeInBrowser(table=[<"attach","table","cells", width, height >]
                                       , onclick=["rotate","left", "right", "up", "down", "fall", "reset"]
                                       , onkeypress=["manager"]
                                       , setInterval=300
                                       , sync = false
                                       , html=[<"test", "Number of fields <width*height>">]
                                );               
    }
    
    str onTimer(str path) {
       // println(path);
       str kind = rFig[arbInt(7)];
       cnt = cnt+1;
       if (size(current)>=1) {
          el old = current[-1];
          rel[int, int] state = old.state;
          fall();
          if (minY<10) {
              current[size(current)-1] = old;
              current+=[<0,0,0, {}, "Clr">];
              return executeInBrowser(extra="\"clearInterval\":\"\"",
                    css=[<v,"background-color", getColor("Clr")>|v<-fig("", nullEl, "Clr")]);
              }
          list[tuple[str, str, str]] oldArg = [<v,"background-color",getColor(current[-1].kind)>|v<-fig("",old,current[-1].kind)];
          current+=[<0, 0, 0, {},kind>];
         
          return executeInBrowser(css=clear(state)+oldArg
                                                  +[<v,"background-color", getColor(kind)>|v<-fig("", nullEl, kind)],
                                                  extra="\"x1\":\"<rot1()>\", \"y1\":\"<0>\", \"x2\":\"<rot2()>\", \"y2\":\"<0>\", \"cnt\":\"<cnt>\"");  
          }
       current+=[<0, 0, 0, {},kind>]; 
       return executeInBrowser(css=[<v,"background-color", getColor(kind)>|v<-fig("", nullEl, kind)]
       ,extra="\"x1\":\"<rot1()>\", \"y1\":\"<0>\", \"x2\":\"<rot2()>\", \"cnt\":\"<cnt>\"");   
       }
    
    str onKeypress(str path) {
       str s = split("/", path)[1];
        switch (s) {
            case "8": return onClick("up");
            case "4": return onClick("left");
            case "5": return onClick("rotate");
            case "6": return onClick("right");
            case "2": return onClick("down");
            case "1": return onClick("reset");
            case "3": return onClick("fall");
            }
       return  "";
       }
       
    str onClick(str path) {
         // println("onClick: <path>");
         /*
         switch (path) {
               case "T_table": return new("T");
               case "I_table": return new("I");
               case "Z_table": return new("Z");
               case "L_table": return new("L");
               case "L1_table": return new("L1");
               case "O_table": return new("O");
               }
         */
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
          case "reset": {
                 cnt = 0;
                 str r = executeInBrowser(css= [*clear(d.state)|d<-current], path = path, extra="\"cnt\":\"0\""
                   ,setInterval=150);
                 current= []; 
                 minY = height;
                 return r;
                 }
          case "fall": {
                 fall();
                 list[tuple[str, str, str]] oldArg = [<v,"background-color",getColor(current[-1].kind)>|v<-fig("",old,current[-1].kind)];
                 //str kind = rFig[arbInt(6)];
                 // current+=[<0, 0, 0, {},kind>];
                 return executeInBrowser(css=clear(state)+oldArg
                                                 // +[<v,"background-color", getColor(kind)>|v<-fig("", nullEl, kind)]
                                                 ,
                                                 extra="\"x1\":\"<rot1()>\", \"y1\":\"<0>\", \"x2\":\"<rot2()>\", \"y2\":\"<0>\"", path = path);  
                 }
          }
         return executeInBrowser(css=clear(state)+[<v,"background-color",getColor(current[-1].kind)>|v<-fig("",old,current[-1].kind)]
           , extra="\"x1\":\"<rot1()>\", \"y1\":\"<0>\", \"x2\":\"<rot2()>\", \"y2\":\"<0>\"" ,path = path);  
         }
    return "";             
    }
    openBrowser(|project://racytoscal/src/demo/tetris/Graph.html|, "",load = onLoad, click=onClick
       , timer = onTimer, keypress = onKeypress
    );  
    }