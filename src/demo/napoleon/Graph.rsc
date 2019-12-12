module demo::napoleon::Graph
import Prelude;
import Racytoscal;
import demo::colors::ColorButton;
import util::Math;
     
num B3= _(0.5*sqrt(3.0));

num phi = PI()/6;

num alpha = PI()+PI()/3;

alias Pnt = tuple[num x, num y];

alias Triangle = tuple[Pnt C, Pnt A, Pnt B];
             
Triangle triangle(num x, num y, num phi, num teta, Pnt v, num alpha) {
             Triangle r = <<_((cos(teta)*x+sin(teta)*y+sin(phi)+v.x)), _((-sin(teta)*x+cos(teta)*y+cos(phi)+v.y))> 
              ,<_((cos(teta)*(B3+x-sin(phi))+sin(teta)*(-0.5+y-cos(phi))+sin(phi)+v.x))
              ,_((-sin(teta)*(B3+x-sin(phi))+cos(teta)*(-0.5+y-cos(phi))+cos(phi)+v.y))> 
              ,<_((cos(teta)*(-B3+x-sin(phi))+sin(teta)*(-0.5+y-cos(phi))+sin(phi)+v.x))
              , _((-sin(teta)*(-B3+x-sin(phi))+cos(teta)*(-0.5+y-cos(phi))+cos(phi)+v.y))>>;
              r = <<r.C.x*cos(alpha)+r.C.y*sin(alpha)-v.x, -r.C.x*sin(alpha)+r.C.y*cos(alpha)-v.y>
              , <r.A.x*cos(alpha)+r.A.y*sin(alpha)-v.x, -r.A.x*sin(alpha)+r.A.y*cos(alpha)-v.y>
              , <r.B.x*cos(alpha)+r.B.y*sin(alpha)-v.x, -r.B.x*sin(alpha)+r.B.y*cos(alpha)-v.y>
              >;
              return r;
              }
              
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
   
str drawNapoleonTriangle(Triangle T0, Triangle T1, Triangle T2) {
   tuple[num x, num y] P = <(T0.A.x+T1.C.x+T0.C.x)/3, (T0.A.y+T1.C.y+T0.C.y)/3>;
   tuple[num x, num y] Q = <(T0.B.x+T2.C.x+T0.C.x)/3, (T0.B.y+T2.C.y+T0.C.y)/3>;
   tuple[num x, num y] R = <(T1.B.x+T2.A.x+T0.C.x)/3, (T1.B.y+T2.A.y+T0.C.y)/3>;
   return "M <P.x> <P.y> L <Q.x> <Q.y>  L <R.x> <R.y> Z";
   }
  
 str drawNapoleonTriangle1(Triangle T0, Triangle T1, Triangle T2) {
   tuple[num x, num y] P = <(T0.A.x+T1.C.x+T0.C.x)/3, (T0.A.y+T1.C.y+T0.C.y)/3>;
   tuple[num x, num y] Q = <(T0.B.x+T2.C.x+T0.C.x)/3, (T0.B.y+T2.C.y+T0.C.y)/3>;
   tuple[num x, num y] R = <(T1.B.x+T2.A.x+T0.C.x)/3, (T1.B.y+T2.A.y+T0.C.y)/3>;
   tuple[num x, num y] vBA = <T1.B.x-T0.A.x, T1.B.y-T0.A.y>;
     tuple[num x, num y] vCB = <T1.C.x-T0.B.x, T1.C.y-T0.B.y>;
     tuple[num x, num y] vCA = <T2.C.x-T0.A.x, T2.C.y-T0.A.y>;
   tuple[num x, num y] t = p(vBA, vCB, vCA, 0, 0, 1);
   return "M < P.x+t.x> < P.y+t.y> L <Q.x> <Q.y>  L <R.x> <R.y> Z";
   }
   
   
 str drawNapoleonTriangle(Triangle T0, Triangle T1, Triangle T2, tuple[num x, num y] v) = 
      drawNapoleonTriangle(move(T0, v), move(T1, v),  move(T2, v));
   
str drawBoundHex1(Triangle T0, Triangle T1, Triangle T2, str kind) {
   switch(kind) {
      case "AC": return "M <T0.A.x> <T0.A.y> L <T1.C.x> <T1.C.y>";
      case "BC": return "M <T0.B.x> <T0.B.y> L <T2.C.x> <T2.C.y>";
      case "BA": return "M <T1.B.x> <T1.B.y> L <T2.A.x> <T2.A.y>";
      }
   }
   
str drawBoundHex1(Triangle T0, Triangle T1, Triangle T2, tuple[num x, num y] v, str kind) = drawBoundHex1(move(T0, v)
        , move(T1, v),  move(T2, v), kind);
      

str drawHex(Triangle T0, Triangle T1, Triangle T2, tuple[num x, num y] v) = drawHex(move(T0, v)
        , move(T1, v),  move(T2, v));
        
str drawTriangle(Triangle T0, Triangle T1, Triangle T2, tuple[num x, num y] v, str kind) = drawTriangle(move(T0, v)
        , move(T1, v),  move(T2, v), kind);
 
tuple[num x, num y] p(tuple[num x, num y] vBA, tuple[num x, num y] vCB, tuple[num x, num y] vCA, int k1, int k2, int k3)
= <k1*(vBA.x)+k2*(vCB.x)+k3*(vCA.x), k1*(vBA.y)+k2*(vCB.y)+k3*(vCA.y)>;

public str problem() {
     Triangle T0 = triangle(0, 0, phi, 0, <0, 0>, 0), T1 = triangle(-B3+sin(phi), 0.5+cos(phi), phi, PI()-PI()/3, <0, 0>,0),
             T2 = triangle(B3+sin(phi), 0.5+cos(phi), phi, -2*PI()/3, <0, 0>,0);
     tuple[num x, num y] vBA = <T1.B.x-T0.A.x, T1.B.y-T0.A.y>;
     tuple[num x, num y] vCB = <T1.C.x-T0.B.x, T1.C.y-T0.B.y>;
     tuple[num x, num y] vCA = <T2.C.x-T0.A.x, T2.C.y-T0.A.y>;
     tuple[num, num] t = <0, 0>,
     t1 = p(vBA, vCB, vCA, 0, 0, 1);
     str output = svg(400, 400
          ,path(drawTriangle(T0, T1, T2, t1, "AC"), class="AC 1") 
          ,path(drawTriangle(T0, T1, T2, t, "BC"), class="BC 2")
          ,path(drawTriangle(T0, T1, T2, t, "BA"), class="BA 3")
          ,path(drawNapoleonTriangle1(T0, T1, T2),class="napoleon0 4")
    ,viewBox=<-3, -1, 5, 5>, strokeWidth = 2);
    return output;
    }

public str output() {
    Triangle T0 = triangle(0, 0, phi, 0, <0, 0>, 0), T1 = triangle(-B3+sin(phi), 0.5+cos(phi), phi, PI()-PI()/3, <0, 0>,0),
             T2 = triangle(B3+sin(phi), 0.5+cos(phi), phi, -2*PI()/3, <0, 0>,0);
    tuple[num x, num y] C = <(T0.A.x+T1.C.x+T0.C.x)/3, (T0.A.y+T1.C.y+T0.C.y)/3>;
    tuple[num x, num y] vBA = <T1.B.x-T0.A.x, T1.B.y-T0.A.y>;
    tuple[num x, num y] vCB = <T1.C.x-T0.B.x, T1.C.y-T0.B.y>;
    tuple[num x, num y] vCA = <T2.C.x-T0.A.x, T2.C.y-T0.A.y>;
    Triangle T0_60 = triangle(0, 0, phi, 0, <-C.x, -C.y>, 2*PI()/3), T1_60 = triangle(-B3+sin(phi), 0.5+cos(phi), phi, PI()-PI()/3, <-C.x, -C.y>, 2*PI()/3),
             T2_60 = triangle(B3+sin(phi), 0.5+cos(phi), phi, -2*PI()/3, <-C.x, -C.y>, 2*PI()/3);
    Triangle T0_120 = triangle(0, 0, phi, 0, <-C.x, -C.y>, 4*PI()/3), T1_120 = triangle(-B3+sin(phi), 0.5+cos(phi), phi, PI()-PI()/3, <-C.x, -C.y>, 4*PI()/3),
             T2_120 = triangle(B3+sin(phi), 0.5+cos(phi), phi, -2*PI()/3, <-C.x, -C.y>, 4*PI()/3);
    list[tuple[num x, num  y]] ts = [p(vBA, vCB, vCA, k1, k2, k3)|int k1<-[3,2..-5], int k2<-[3,2..-5], int k3<-[0]
          // ,k1!=0||k2!=0
          ];
    str output = svg( 800, 800
        ,box(LT, 
               // path(drawHex(T0, T1, T2), class = "base")
               path("<for(tuple[num x, num y] t<-ts){> <drawHex(T0, T1, T2, t)> <}>") 
               ,path("<for(tuple[num x, num y] t<-ts){> <drawTriangle(T0, T1, T2, t, "AC")> <}>", class="AC 1") 
               ,path("<for(tuple[num x, num y] t<-ts){> <drawTriangle(T0, T1, T2, t, "BC")> <}>", class="BC 2")
               ,path("<for(tuple[num x, num y] t<-ts){> <drawTriangle(T0, T1, T2, t, "BA")> <}>", class="BA 3")
               ,path("<for(tuple[num x, num y] t<-ts){> <drawBoundHex1(T0, T1, T2, t, "AC")> <}>", class="bound-hex0 4") 
               ,path("<for(tuple[num x, num y] t<-ts){> <drawBoundHex1(T0, T1, T2, t, "BC")> <}>", class="bound-hex0 4")
               ,path("<for(tuple[num x, num y] t<-ts){> <drawBoundHex1(T0, T1, T2, t, "BA")> <}>", class="bound-hex0 4")
               ,path("<for(tuple[num x, num y] t<-ts){> <drawBoundHex1(T0_60, T1_60, T2_60, t, "AC")> <}>", class="bound-hex60 5") 
               ,path("<for(tuple[num x, num y] t<-ts){> <drawBoundHex1(T0_60, T1_60, T2_60, t, "BC")> <}>", class="bound-hex60 5")
               ,path("<for(tuple[num x, num y] t<-ts){> <drawBoundHex1(T0_60, T1_60, T2_60, t, "BA")> <}>", class="bound-hex60 5")
               ,path("<for(tuple[num x, num y] t<-ts){> <drawBoundHex1(T0_120, T1_120, T2_120, t, "AC")> <}>", class="bound-hex120 6") 
               ,path("<for(tuple[num x, num y] t<-ts){> <drawBoundHex1(T0_120, T1_120, T2_120, t, "BC")> <}>", class="bound-hex120 6")
               ,path("<for(tuple[num x, num y] t<-ts){> <drawBoundHex1(T0_120, T1_120, T2_120, t, "BA")> <}>", class="bound-hex120 6")
               ,path("<for(tuple[num x, num y] t<-ts){> <drawNapoleonTriangle(T0, T1, T2, t)> <}>",class="napoleon0 4")
               ,path("<for(tuple[num x, num y] t<-ts){> <drawNapoleonTriangle(T0_60, T1_60, T2_60, t)> <}>",class="napoleon60 5")
               ,path("<for(tuple[num x, num y] t<-ts){> <drawNapoleonTriangle(T0_120, T1_120, T2_120, t)> <}>",class="napoleon120 6")          
             ,viewBox=<-7.5,-7.5, 15, 15>, strokeWidth = 2
         ));    
    return output;
    }   
     
 public App def() { 
    App ap = app( |project://racytoscal/src/demo/napoleon/Graph.html|
    , <"attach1", problem()>
    , <"attach2", output()>
     ,<"colors", rows(12, 6)>
     ,<"panel", panel()>
     ,click = <["button"], onClick>);
    return ap;
    } 
      
 