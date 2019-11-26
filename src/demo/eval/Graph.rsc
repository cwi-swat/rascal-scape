module demo::eval::Graph
import Prelude;
extend Racytoscal;
import util::Eval;
    
str action(str s) { 
   int idx = findFirst(s,"/");
   str expr = substring(s,idx+1);
   str result = "<eval(expr+";")>";
   return executeInBrowser(html=[<"result", result>]);
   }
   
 public App def() {  
    App ap = app( |project://racytoscal/src/demo/eval/Graph.html|
      ,change= <["enter-field"], action>);
    return ap;
    }

public void main() {
    println(eval("2+3;"));
    }
      
 