module demo::napoleon::Graph
import Prelude;
extend Racytoscal;
import util::Math;
     
num B3= _(0.5*sqrt(3.0));

num phi = PI()/6;

num alpha = PI()+PI()/3;

alias Pnt = tuple[num x, num y];

alias Triangle = tuple[Pnt C, Pnt A, Pnt B];
             
Triangle triangle(num x, num y, num phi, num teta) = 
             <<_(cos(teta)*x+sin(teta)*y+sin(phi)), _(-sin(teta)*x+cos(teta)*y+cos(phi))> 
              ,<_(cos(teta)*(B3+x-sin(phi))+sin(teta)*(-0.5+y-cos(phi))+sin(phi))
              ,_(-sin(teta)*(B3+x-sin(phi))+cos(teta)*(-0.5+y-cos(phi))+cos(phi))> 
              ,<_(cos(teta)*(-B3+x-sin(phi))+sin(teta)*(-0.5+y-cos(phi))+sin(phi))
              , _(-sin(teta)*(-B3+x-sin(phi))+cos(teta)*(-0.5+y-cos(phi))+cos(phi))>>;
              
str draw(Triangle t) = "M <t.C.x>,<t.C.y> L <t.A.x>,<t.A.y> L <t.B.x>,<t.B.y> Z";

Triangle move(Triangle t, tuple[num x, num y] v) = <<t.C.x+v.x, t.C.y+v.y>, <t.A.x+v.x, t.A.y+v.y>, <t.B.x+v.x, t.B.y+v.y>>;

str drawHex(Triangle T0, Triangle T1, Triangle T2) = 
      "<draw(T0)> <draw(T1)> <draw(T2)>";
      
str drawTriangle(Triangle T0, Triangle T1, Triangle T2, str kind) {
   switch(kind) {
      case "AC": return "M <T0.A.x> <T0.A.y> L <T1.C.x> <T1.C.y>  L <T0.C.x> <T0.C.y> Z";
      case "BC": return "M <T0.B.x> <T0.B.y> L <T2.C.x> <T2.C.y>  L <T0.C.x> <T0.C.y> Z";
      case "BA": return "M <T1.B.x> <T1.B.y> L <T2.A.x> <T2.A.y>  L <T0.C.x> <T0.C.y> Z";
      }
   }
      

str drawHex(Triangle T0, Triangle T1, Triangle T2, tuple[num x, num y] v) = drawHex(move(T0, v)
        , move(T1, v),  move(T2, v));
        
str drawTriangle(Triangle T0, Triangle T1, Triangle T2, tuple[num x, num y] v, str kind) = drawTriangle(move(T0, v)
        , move(T1, v),  move(T2, v), kind);
 
tuple[num x, num y] p(tuple[num x, num y] vBA, tuple[num x, num y] vCB, tuple[num x, num y] vCA, int k1, int k2, int k3)
= <k1*(vBA.x)+k2*(vCB.x)+k3*(vCA.x), k1*(vBA.y)+k2*(vCB.y)+k3*(vCA.y)>;

public str output() {
    Triangle T0 = triangle(0, 0, phi, 0), T1 = triangle(-B3+sin(phi), 0.5+cos(phi), phi, PI()-PI()/3),
             T2 = triangle(B3+sin(phi), 0.5+cos(phi), phi, -2*PI()/3);
    tuple[num x, num y] vBA = <T1.B.x-T0.A.x, T1.B.y-T0.A.y>;
    tuple[num x, num y] vCB = <T1.C.x-T0.B.x, T1.C.y-T0.B.y>;
    tuple[num x, num y] vCA = <T2.C.x-T0.A.x, T2.C.y-T0.A.y>;
    list[tuple[num x, num  y]] ts = [p(vBA, vCB, vCA, k1, k2, k3)|int k1<-[2,1..-4], int k2<-[2,1..-4], int k3<-[2,1..-4]];
    str output = svg( 800, 800
        ,box(LT, 
               path("<for(tuple[num x, num y] t<-ts){> <drawHex(T0, T1, T2, t)> <}>") 
               ,path("<for(tuple[num x, num y] t<-ts){> <drawTriangle(T0, T1, T2, t, "AC")> <}>", class="AC") 
               ,path("<for(tuple[num x, num y] t<-ts){> <drawTriangle(T0, T1, T2, t, "BC")> <}>", class="BC")
               ,path("<for(tuple[num x, num y] t<-ts){> <drawTriangle(T0, T1, T2, t, "BA")> <}>", class="BA") 
             ,viewBox=<-7.5,-7.5, 15, 15>, strokeWidth = 2, clipId="clip"
         ));    
    return output;
    }   
     
 public App def() { 
    App ap = app( |project://racytoscal/src/demo/napoleon/Graph.html|, <"attach", output()>);
    return ap;
    } 
      
 