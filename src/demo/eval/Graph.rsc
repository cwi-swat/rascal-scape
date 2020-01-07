module demo::eval::Graph
import Prelude;
import Rascalscape;
import util::Eval;
    
str action(str s) { 
   int idx = findFirst(s,"/");
   str expr = substring(s,idx+1);
   str result = "<eval(expr+";")>";
   return update(html=[<"result", result>]);
   }
   
 public App def() {  
    App ap = app( |project://<project>/src/demo/eval/Graph.html|
      ,change= <["enter-field"], action>);
    return ap;
    }

public void main() {
    println(eval("2+3;"));
    }
      
 