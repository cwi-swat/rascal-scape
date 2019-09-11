module Chart
import Prelude;
import lang::json::IO;


data Point = point(list[tuple[num x , num y]] pnt)|vec(list[num z] v);


public map[str, value] adt2map(node t) {
   map[str, value] q = getKeywordParameters(t);
   map[str, value] r = (replaceLast(d,"_",""):q[d]|d<-q);
   for (d<-r) {
        if (vec(list[num] y):= r[d]) r[d] = y; 
        if (point(list[tuple[num, num]] z):= r[d]) r[d] = [("x":s[0],"y":s[1])|s<-z]; 
        if (node n := r[d]) {
           r[d] = adt2map(n);
        }
        if (list[node] l:=r[d]) {
           r[d] = [adt2map(e)|e<-l];
           }     
      }
   return r;
   } 

public str adt2json(node t) {
   return toJSON(adt2map(t), true);
   }
   
              
 data DataSet(str label=""
             ,Point \data=vec([])
             ) = dataSet();
    
 
 data Data(list[str] labels = [], list[DataSet] datasets=[]) = \data();
 
 data Options = options();
 
 data Config(str \type ="", Data \data=\data(), Options options = options())=config();
   
 public void main() {
     node n = config(\type="line", \data=
         \data(datasets=
              [dataSet(\data=point([<4,7>]))], options=options()));
     println(adt2json(n));
     }