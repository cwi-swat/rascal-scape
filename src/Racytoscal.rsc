module Racytoscal
import Prelude;
import util::Math;
import util::HtmlDisplay;
import util::Webserver;
extend Chart;
extend Cytoscape;

// public App app(loc html, Script contents...,loc site = |http://localhost:8081|
//  , bool display = true 
//    ,React click = <[], nullCallback>
//    ,React keypress = <[], nullCallback>
//    ,React change = <[], nullCallback>
//   , Callback tapstart = nullCallback
//    ,Callback tapend =  nullCallback
//    ,Callback tap = nullCallback
//    ,Callback load =  nullCallback
//    ,Callback timer = nullCallback
//   )
 
// public str executeInBrowser(lrel[str, Style] styles=[], tuple[str, str] \layout=<"","">, str extra="\"extra\":\"none\"",
//       list[tuple[str attach, str tableId, str cellId, int width, int height]] table = [],
//       list[tuple[str sel, str key, str val]] css = []
//       , list[tuple[str sel, str val]] transform = []
//      , list[str] onclick=[]
//       , list[str] onkeypress=[]
 //      , list[str] onchange=[]
 //      , int setInterval= -1, str path = ""
 //      ,bool sync = true, list[tuple[str attach, str content]] html = [])

// public str svg(int width, int height, SVG content..., ViewBox viewBox=<0, 0, -1, -1>)

// public SVG box(Position pos, SVG inner ..., str id= "", str class= "", str style="", num width=1000, num height=1000
//  ,num vshrink = 1.0, num hshrink = 1.0 
//  ,num shrink = 1.0, num strokeWidth=2, ViewBox viewBox=<0, 0, -1, -1>, Dim padding = pxl(<0,0,0, 0>)
//  ,SVGLayout svgLayout = overlay()) 

// public SVG ellipse(Position pos, SVG inner ..., str id= "", str class= "", str style="", num width=1000, num height=1000
//  ,num vshrink = 1.0, num hshrink = 1.0 
//  ,num shrink = 1.0, num strokeWidth=2, ViewBox viewBox=<0, 0, -1, -1>, Dim padding = pxl(<0,0,0, 0>)
//  ,SVGLayout svgLayout = overlay())

// public SVG htmlObject(Position pos, str html, str id= "", str class= "", str frameClass = "", str style="", int width=1000, int height=1000, num vshrink = 1.0, num hshrink = 1.0, 
//     num shrink = 1.0, int strokeWidth=2) 

// public SVG text(num x, num y, str txt, str id= "", str class= "", str style= "") 

// public SVG path(str txt, str id= "", str class= "", str style= "")

public alias App = tuple[void() serve, void() stop, str() content];
public alias Script = tuple[str container, value val];
public alias Callback = str(str);
public alias React = tuple[list[str] ids, Callback callback];

public alias Position = tuple[Coord, Coord];
public alias ViewBox = tuple[num x, num y, num width, num height];
public alias Padding = tuple[num top,  num right, num bottom, num left];

data SVGLayout = grid(int nCols, str preserveAspectRatio="none", num width=-1, num height = -1)
  |overlay(str preserveAspectRatio="none");
       
data Coord = L(num  left) | R(num right) |C(num center)|L1(num  left1) | R1(num right1) |C1(num center1);
  
data Dim = pxl(num dim)|pct(num dim)|pxl(Padding tpl)|pct(Padding tpl);

str nullCallback(str id) = "";
       
data SVG  (ViewBox viewBox= <0, 0, 100, 100>, list[SVG] inner =[], str id = "", str class= "", str frameClass = "", SVG parent= root(),
          Dim padding = pxl(<0, 0, 0, 0>), SVGLayout svgLayout = overlay(), str clipId="")
        = rect(Coord x, Coord y, Dim width, Dim height, num strokeWidth, str style)
        | ellipse(Coord x, Coord y, Dim width, Dim height, num strokeWidth, str style)
        | foreignObject(Coord x, Coord y, Dim width, Dim height, num strokeWidth, str style, str html)
        | text(num x1, num y1,  str style, str txt)
        | path(str style, str txt)
        | transform(str txt)
        | root()
        | emptySvg()
        ;
 
 public Position LT = <L1(0), L1(0)>;
 public Position LC = <L1(0), C1(0.5)>;
 public Position LB = <L1(0), R1(1)>;
 public Position CT = <C1(0.5), L1(0)>;
 public Position CC = <C1(0.5), C1(0.5)>;
 public Position CB = <C1(0.5), R1(1)>;
 public Position RT = <R1(1), L1(0)>;
 public Position RC = <R1(1), C1(0.5)>;
 public Position RB = <R1(1), R1(1)>;


public App app(loc html, Script contents...,loc site = |http://localhost:8081|
   , bool display = true 
    ,React click = <[], nullCallback>
    ,React keypress = <[], nullCallback>
    ,React change = <[], nullCallback>
   , Callback tapstart = nullCallback
    ,Callback tapend =  nullCallback
    ,Callback tap = nullCallback
    ,Callback load =  nullCallback
    ,Callback timer = nullCallback
    ) {
    str content = toScript(contents);
    App r = <() {
         openBrowser(html, content
          ,tapstart=tapstart
          ,tapend=tapend
          ,tap=tap
          ,click=click
          ,keypress=keypress
          ,load=load
          ,timer=timer
          ,display = display
          ,change=change
          );
         }
    ,() {
         println("exit");
         disconnect(site);   
         }
    ,str() {
        return content;
        }
    >;
    return r;
    }
  
public str executeInBrowser(lrel[str, Style] styles=[], tuple[str, str] \layout=<"","">, str extra="\"extra\":\"none\"",
       list[tuple[str attach, str tableId, str cellId, int width, int height]] table = [],
       list[tuple[str sel, str key, str val]] css = []
       , list[tuple[str sel, str val]] transform = []
       , list[str] onclick=[]
       , list[str] onkeypress=[]
       , list[str] onchange=[]
       , int setInterval= -1, str path = ""
       ,bool sync = true, list[tuple[str attach, str content]] html = []) {
       return 
       "{<extra>
       '<if((\layout?)){>,\"layout\":[\"<\layout[0]>\", \"<\layout[1]>\"]<}>
       '<if((\styles?)){>,\"styles\":<toString(styles)><}>
       '<if((\css?)){>,\"css\":[<toCssString(css)>]<}>
       '<if((\transform?)){>,\"transform\":[<toTransformString(transform)>]<}>
       '<if((\table?)){>,\"table\":[<toString(table)>]<}>
       '<if((\onclick?)){>,\"onclick\":[<toSelString(onclick)>]<}>
       '<if((\onkeypress?)){>,\"onkeypress\":[<toSelString(onkeypress)>]<}>
       '<if((\onchange?)){>,\"onchange\":[<toSelString(onchange)>]<}>
       '<if((\setInterval?) && setInterval>0){>,\"setInterval\":\"<setInterval>\"<}>
       '<if((\setInterval?) && setInterval<=0){>,\"clearInterval\":\"<setInterval>\"<}>
       '<if((\path?)){>,\"path\":\"<\path>\"<}>
       '<if((\sync?)){>,\"sync\":\"<\sync>\"<}>
       '<if((\html?)){>,\"html\":[<toString(html)>]<}>
       '}"; 
       }
       
public str svg(int width, int height, ViewBox viewBox, str inside) =
      "\<svg width=\"<width>px\" height=\"<height>px\", viewBox=\"<viewBox.x> <viewBox.y> <viewBox.width> <viewBox.height>\"\><inside>\</svg\>";
      
public str svg(int width, int height, SVG content..., ViewBox viewBox=<0, 0, -1, -1>) {
      if (viewBox.width<0) viewBox.width=width;
      if (viewBox.height<0) viewBox.height=height;
      SVG parent =  root(viewBox = viewBox);
      content = addParent(parent, content);
      str inside = "<for(SVG c <- content){>  <eval(viewBox, 0, c, "")> <}>";
      return "\<svg width=\"<width>px\" height=\"<height>px\"  viewBox=\"<viewBox.x> <viewBox.y> <viewBox.width> <viewBox.height>\"\>
      <inside>\</svg\>";
      }
      
 tuple[num, num] getDimFromCell(SVGLayout svgLayout, list[SVG] inner, num width, num height) {
      if (grid(int ncols):=svgLayout && (svgLayout.width?)&&(svgLayout.width?)) {
           num d = size(inner);
           num f = d/ncols;
           num nrows = ceil(f);
           return <ncols*svgLayout.width, nrows*svgLayout.height>;
           }
      return <width, height>; 
      }
 
 public SVG box(Position pos, SVG inner ..., str id= "", str class= "", str style="", num width=-1, num height=-1, num vshrink = 1.0, num hshrink = 1.0, 
     num shrink = 1.0, num strokeWidth=0, ViewBox viewBox=<0, 0, -1, -1>, Dim padding = pxl(<0,0,0, 0>)
     , SVGLayout svgLayout = overlay(), str clipId="") {
     if ((shrink?)) {vshrink = shrink; hshrink = shrink;}
     <width, height>= getDimFromCell(svgLayout, inner, width, height);
     // if (grid(_):=svgLayout) println("HELP: <width?> <width> <height>");
     SVG c =  rect(pos[0], pos[1], (width==-1)?pct(hshrink*100) :pxl(width) 
                                 , (height==-1)?pct(vshrink*100) :pxl(height)
                                 , strokeWidth, style, inner = inner, id = id, class = class, viewBox = viewBox, padding = padding
                                 , svgLayout = svgLayout, clipId = clipId);
     return c;
 }
 
 public SVG vcat(Position pos,SVG inner ..., str id= "", str class= "", num vshrink = 1.0, num hshrink = 1.0, 
     num shrink = 1.0, num width = -1, num height = -1, ViewBox viewBox=<0,0,-1, -1>, num strokeWidth=0) 
       = box(pos, inner, svgLayout=grid(1), id=id, class=class
          ,vshrink = vshrink, hshrink = hshrink, shrink= shrink, width = width, height = height, viewBox = viewBox
          ,strokeWidth=strokeWidth);
 
 public SVG hcat(Position pos, SVG inner ..., str id= "", str class= "", num vshrink = 1.0, num hshrink = 1.0, 
     num shrink = 1.0, num width = -1, num height = -1, ViewBox viewBox=<0,0,-1, -1>, num strokeWidth=0) = 
        box(pos, inner, svgLayout=grid(size(inner)), id=id, class=class
                            ,vshrink = vshrink, hshrink = hshrink, shrink= shrink, width = width, height = height
                            , viewBox = viewBox, strokeWidth=strokeWidth);
 
 
 public SVG ellipse(Position pos, SVG inner ..., str id= "", str class= "", str style="", num width=-1, num height=-1,
     num rx = -1, num ry = -1, 
     num vshrink = 1.0, num hshrink = 1.0, 
     num shrink = 1.0, num strokeWidth=0, ViewBox viewBox=<0, 0, -1, -1>,  Dim padding = pxl(<0,0,0, 0>)
     , SVGLayout svgLayout = overlay(), str clipId="") {
     if ((shrink?)) {vshrink = shrink; hshrink = shrink;}
     if (rx>=0 && ry>=0) {width = 2*rx; height = 2*ry;}
     <width, height>= getDimFromCell(svgLayout, inner, width, height);
     SVG c =  ellipse(pos[0], pos[1], width==-1?pct(hshrink*100) :pxl(width) 
                                    , height==-1?pct(vshrink*100) :pxl(height)
                                    , strokeWidth, style, inner = inner, id = id
                                    , class= class, viewBox = viewBox, padding = padding, clipId = clipId);
     return c;
 }
 
public SVG htmlObject(Position pos, str html, str id= "", str class= "", str frameClass = "", str style="", int width=-1, int height=-1, num vshrink = 1.0, num hshrink = 1.0, 
     num shrink = 1.0, int strokeWidth=0) {
     if ((shrink?)) {vshrink = shrink; hshrink = shrink;}
     SVG c =  foreignObject(pos[0], pos[1], width==-1?pct(hshrink*100) :pxl(width) 
                                 , height==-1?pct(vshrink*100) :pxl(height)
                                 , strokeWidth, style, html, id = id, class=class, frameClass = frameClass);
     return c;
 }
 
 // Only to be used inside htmlObject.  The classes innerX and innerY must be defined in .html file.
 public str centerText(str txt...) = div(div(div(txt), class = "innerX"), class = "innerY");
 
 public SVG text(num x, num y, str txt, str id= "", str class= "", str style= "") {
     SVG c = text(x, y, style, txt, id =id, class = class);
     return c;
 }
 
public SVG path(str txt, str id= "", str class= "", str style= "") {
     // println("<vshrink?> <vshrink>");
     SVG c = path(style, txt, id =id, class = class);
     return c;
 }
 
public SVG frame(num hshrink, num vshrink, tuple[str \class, list[str] d] xAxe, tuple[str \class, list[str] d] yAxe
    , tuple[str \class, lrel[num x, num y] d] graphs... ,ViewBox viewBox =<0, 0, 100, 100>,
    num width = 1000, num height = 1000) {
    num shrnk = 0.9;
    println("width: <width>");
    num shift = (1-shrnk)/2;
    num dx = viewBox.width/(size(xAxe.d)-1), dy = viewBox.height/(size(yAxe.d)-1);
    yAxe.d = reverse(yAxe.d);
    ViewBox  viewBoxXaxe = <-width*shift, 0, width*(hshrink*shrnk+2*shift), shift*height>,
             viewBoxYaxe = <0, -height*shift, shift*width, height*(vshrink*shrnk+2*shift)>;  
    num dxX = (width*hshrink*shrnk)/(size(xAxe.d)-1), 
        dyY = (height*vshrink*shrnk)/(size(yAxe.d)-1);            
    SVG r = box(LT, box(<L1(shift),L1(shift)>
             ,[path(
                "<for (num i<-[viewBox.y+dy,viewBox.y+2*dy..viewBox.y+viewBox.height-dy/2]){> M <_(viewBox.x)> <_(i)> H <_(viewBox.x+viewBox.width)> <}>"
                ,class=xAxe.class) 
              ,path(
                "<for (num i<-[viewBox.x+dx,viewBox.x+2*dx..viewBox.x+viewBox.width-dx/2]){> M <_(i)> <_(viewBox.y)> V <_(viewBox.y+viewBox.height)> <}>"
               ,class=yAxe.class
                )]
               +graph(viewBox, graphs)
                ,hshrink=hshrink*shrnk, vshrink = vshrink*shrnk, viewBox= viewBox, strokeWidth=2)
              ,box(<L1(0), L1(0)>,
                   [text(viewBoxYaxe.width/2, y, yAxe.d[i], class=yAxe.class)
                     | int i <-[0..size(yAxe.d)], num y := (i*dyY)]             
                   , vshrink=vshrink*shrnk+2*shift, hshrink = shift, class=yAxe.class
                   , viewBox=viewBoxYaxe)
              ,box(<L1(0), L1(vshrink*shrnk+shift)>
                    , [text(x, viewBoxXaxe.height/2, xAxe.d[i], class=xAxe.class)
                    | int i<-[0..size(xAxe.d)], num x := i*dxX]
                   , vshrink= shift, hshrink = hshrink*(shrnk+2*shift), class=xAxe.class
                    , viewBox=viewBoxXaxe)
                    , strokeWidth=0
                ,viewBox=<0, 0, width, height>
               );
    return r;
    }
    
// Private
 
private num posX(num dim, num offset, num width, Coord p, num lw) {
    switch(p) {
       case L1(num x): return offset+x*dim+lw/2;
       case R1(num x): return offset+x*dim-width +lw/2;
       case C1(num x): return offset+x*dim-width/2+lw/2;
       case L(num x): return x+lw/2;
       case R(num x): return x-width +lw/2;
       case C(num x): return x-width/2+lw/2;
       }
    return 0;
    }
    
private num posY(num dim, num offset, num height, Coord p, num lw) {
    switch(p) {
       case L1(num y): return offset+y*dim+lw/2;
       case R1(num y): return offset+y*dim-height +lw/2;
       case C1(num y): return offset+y*dim-height/2+lw/2;
       case L(num y): return y+lw/2;
       case R(num y): return y-height+lw/2;
       case C(num y): return y-height/2+lw/2;
       }
    return 0;
    }
    
private SVG newParent(SVG d, SVG parent) {
   d.parent = parent; 
   return d;
   }
    
private SVG addParent(SVG parent, SVG c) {
       if (c.viewBox[2]<0)  c.viewBox[2] = parent.viewBox[2];
       if (c.viewBox[3]<0)  c.viewBox[3] = parent.viewBox[3];
       c.parent = parent;
       c.inner = addParent(c, c.inner);
       if (transform(_):=c) {
           c.inner = [newParent(d, parent)|SVG d<-c.inner];        
          }
       return c;
       }
 
private str toString(SVG content) {
    str inside = "<for(SVG c <- content){>  <eval(viewBox, 0, c,"")> <}>";
    }
  

private  list[SVG] addParent(SVG parent, list[SVG] content) =  [addParent(parent, c)|SVG c<-content];       
private str useId(SVG c) {
   if ((c.id?) && !isEmpty(c.id)) return "id=\"<c.id>\"";
   return "";
   }
private str useClipId(str clipId) {
   if (!isEmpty(clipId)) return "clip-path=\"url(#<clipId>)\"";
   return "";
   }
   
private str useClass(SVG c) {
   if ((c.class?) && !isEmpty(c.class)) return "class=\"<c.class>\"";
   return "";
   }
   
private str useFrameClass(SVG c) {
   if ((c.frameClass?) && !isEmpty(c.frameClass)) return "class=\"<c.frameClass>\"";
   return "";
   }
   
private num checkShrink(num dim, Dim d) {
   // println("checkshrink <dim> <d>");
   if (pxl(num v):=d) return v;
   if (pct(num v):=d) return dim*v/100;
   } 
   
private Padding getPadding(num width, num height, Dim d) {
   if (pxl(Padding v):=d) return v;
   if (pct(Padding v):=d) return <floor(height*v.top/100),floor(width*v.right/100),floor(height*v.bottom/100),floor(width*v.left/100)>;
   } 
   
private str gridLayout(num x, num y, num width, num height, num lw, int nCols, ViewBox vb, list[SVG] inner
    str preserveAspectRatio = "xMinYMin slice") {
   int nRows = (size(inner)-1)/nCols+1;
   ViewBox newVb = <vb.x, vb.y, vb.width*nCols,  vb.height*nRows>;
   num posX = x+lw/2, posY = y+lw/2;
   str r = "";
   //r+= " \<svg x=\"<lw>\"  y=\"<lw>\"\>";
   int cnt = 0;
   int row = 0;
   for (int row<-[0..nRows]) {
      for (_<-[row..row+nCols] && cnt<size(inner)) {   
       r+= "
          ' \<svg x=\"<_(posX)>\"  y=\"<_(posY)>\"  viewBox=\"<newVb.x> <newVb.y> <_(newVb.width)> <_(newVb.height)>\" 
          ' preserveAspectRatio=\"<preserveAspectRatio>\"\>
          ' <eval(newVb, lw, inner[cnt],"")>
          ' \</svg\>
          ";
         posX+=width/nCols;
         cnt += 1;
        }
        posX = x+lw/2; 
        posY+=height/nRows;
      }
    //r+="\</svg\>";
    return r;
   }
   
str clipPath(str clipId, num x, num y, num width, num height) {
   return "\<clipPath id=\"<clipId>\"\>\<rect x=\"<_(x)>\" y=\"<_(y)>\" width=\"<_(width)>\" height=\"<_(height)>\" /\> \</clipPath\>";
   }

private str eval(ViewBox vb,  num lw0, SVG c, str clipId) {
      str r  = "", styl = "", txt = "";
      ViewBox vb1  = c.viewBox;
      ViewBox vb2  = c.parent.viewBox;
      // println("eval <vb2>");
      // println(getName(c));
      num x  = 0, y = 0, lw = 0;
      num width  = 0, height = 0;
      list[SVG] inner = c.inner;
      switch (c) {
          case fig:rect(Coord x1, Coord y1, Dim widthDim, Dim heightDim, num lw1, str style1): {
                 num width1 = checkShrink(vb2.width, widthDim), height1 = checkShrink(vb2.height, heightDim);
                 Padding p = getPadding(vb1.width,vb1.height, c.padding);   
                 x = posX(vb2.width, vb2.x, width1, x1, lw1)+p.left; 
                 y = posY(vb2.height,vb2.y, height1,  y1, lw1)+p.top; 
                 width = width1-lw1-p.left-p.right; height  = height1-lw1-p.top-p.bottom; lw = lw1;
                 style1+=";stroke-width:<_(lw)>"; 
                 r+= "\<rect <useId(c)> <useClass(c)> <useClipId(clipId)> x=\"<_(x)>\" y=\"<_(y)>\"  width=\"<_(width)>\" height=\"<_(height)>\" style=\"<style1>\" /\>";
                 }
          case fig:ellipse(Coord x1, Coord y1, Dim widthDim, Dim heightDim, num lw1, str style1): {
                 num width1 = checkShrink(vb2.width, widthDim), height1 = checkShrink(vb2.height, heightDim);
                 Padding p = getPadding(vb1.width,vb1.height, c.padding);
                 x = posX(vb2.width, vb2.x, width1, x1, lw1)+p.left; 
                 y = posY(vb2.height, vb2.y, height1,  y1, lw1)+p.top; 
                 width = width1-lw1-p.left-p.right; height  = height1-lw1-p.top-p.bottom; lw = lw1;
                 style1+=";stroke-width:<_(lw)>"; 
                 r+= "\<ellipse <useId(c)> <useClass(c)> cx=\"<_(x+width/2)>\" cy=\"<_(y+height/2)>\"  rx=\"<_(width/2)>\" ry=\"<_(height/2)>\" style=\"<style1>\"/\>";
                 }
          case fig:foreignObject(Coord x1, Coord y1, Dim widthDim, Dim heightDim, num lw1, str style1, str html): {
                 num width1 = checkShrink(vb2.width, widthDim), height1 = checkShrink(vb2.height, heightDim);
                 x = posX(vb2.width, vb2.x, width1, x1, lw1); 
                 y = posY(vb2.height, vb2.y, height1,  y1, lw1); width = width1-lw1; height  = height1-lw1; lw = lw1;
                 style1+=";stroke-width:<_(lw)>"; 
                 r+= "\<rect <useFrameClass(c)> x=\"<_(x)>\" y=\"<_(y)>\"  width=\"<_(width)>\" height=\"<_(height)>\" style=\"<style1>\" stroke-width=\"<lw>\"/\>";
                 r+= "\<foreignObject <useClass(c)> x=\"<_(x+lw/2)>\" y=\"<_(y+lw/2)>\" width=\"<_(width-lw)>\" height=\"<_(height-lw)>\"  style=\"<style1>\"\>
                    '\<div class=\"htmlObject\"\>
                    '<html>
                    '\</div\>
                    '\</foreignObject\>       
                    ";
                }
          case fig:text(num x, num y, str style, str txt): {
                 r+= "\<text <useId(c)> <useClass(c)> x=\"<_(x)>\" y=\"<_(y)>\"  style=\"<style>\"\>
                    '<txt>
                    '\</text\>       
                    ";
                 }
          case fig:path(str style, str txt): {
                 r+= "\<path <useId(c)> <useClass(c)> <useClipId(clipId)> d=\"<txt>\" style=\"<style>\"/\>       
                    ";
                 }
          case fig:transform(str txt): {
                r+="\<g  <useId(c)> transform=\"<txt>\"\>";
                for (SVG b<-fig.inner) {
                     r+= eval(vb,  lw0, b, clipId);
                     }
                r+="\</g\>";
                return r;
                }
          }
      if (getName(c) notin ["foreignObject", "text", "path"]) {  
        num h = height-lw, w = width-lw;   
        ViewBox newVb = <_(vb1.x), _(vb1.y), _((vb.width*vb1.width)/w),  _((vb.height*vb1.height)/h)>;
        if (!isEmpty(c.inner)) {
        str viewBox = "viewBox = \"<newVb.x> <newVb.y> <_(newVb.width)> <_(newVb.height)>\"";
        // str viewBox = "";
        if (overlay():=c.svgLayout)
        r+= "
          ' \<svg x=\"<_(x+lw/2)>\"  y=\"<_(y+lw/2)>\"  <viewBox>   
          ' preserveAspectRatio=\"<c.svgLayout.preserveAspectRatio>\"\>
          ' <if(!isEmpty(c.clipId)) {> <clipPath(c.clipId, vb1.x, vb1.y, vb1.width, vb1.height)> <}>
          ' <for(SVG s<-c.inner){> <eval(newVb, lw, s, c.clipId)><}>
          ' \</svg\>
          ";
       if (grid(int nCols):=c.svgLayout) {
         // println(c.svgLayout.preserveAspectRatio);
         r+=gridLayout(x, y, w, h, lw, nCols, newVb, c.inner
           , preserveAspectRatio=c.svgLayout.preserveAspectRatio
           );
         }
       }
       }
      // println(r);
      return r;
      }
      
public SVG rotate(num rad, SVG body..., str id = "") = transform("rotate(<_(180*rad/PI())>)", inner = body, id = id);

public SVG rotate(num rad, num x, num y, SVG body...,str id = "" ) = 
    transform("rotate(<_(180*rad/PI())>,<_(x)>,<_(y)>)", inner = body, id = id);

public SVG translate(num x, num y, SVG body..., str id = "") = transform("translate(<_(x)>,<_(y)>)", inner = body, id = id);

public SVG scale(num x, num y, SVG body..., str id = "") = transform("scale(<_(x)>,<_(y)>)", inner = body, id = id);
      
public str div(str txt..., str class = "") = "
    '<for (str t<-txt){> \<div <if ((class?) && !isEmpty(class)){>class=\"<class>\"<}> \> <t> \</div\><}>";
    

   
public void disconnect(loc site) = shutdown(site);

// Private 
private num cut1 = 0.01;
private num cut2 = 0.000001;
public  num _(num x) = round(x, x>1.5?cut1:cut2);
 private str genScript(str container, str htmlContent) {
  str r= 
  "attach[\"<container>\"] = document.getElementById(\'<container>\');
  'attach[\"<container>\"].innerHTML=\'<replaceAll(htmlContent,"\n"," ")>\';
  ";
  return r;
  }
  
private loc openBrowser(loc html, tuple[str container, str content] attach, bool display = true 
    ,React click = <[],nullCallback>
    ,React keypress = <[],nullCallback>
    ,React change = <[],nullCallback>
    ,Callback tapstart = nullCallback
    ,Callback tapend = nullCallback
    ,Callback tap = nullCallback  
    ,Callback load = <[],nullCallback>
    ,Callback timer = <[],nullCallback>
    
    ) {  
    return openBrowser(html, genScript(attach.container, attach.content)
          ,tapstart=tapstart
          ,tapend=tapend
          ,tap=tap
          ,click=click
          ,keypress=keypress
          ,load=load
          ,timer=timer
          ,change=change
          );  
    }
    
private loc openBrowser(loc html, bool display = true 
    ,React click = <[],nullCallback>
    ,React keypress = <[],nullCallback>
    ,React change = <[],nullCallback>
    ,Callback tapstart = nullCallback
    ,Callback tapend = nullCallback
    ,Callback tap = nullCallback
    ,Callback load = nullCallback
    ,Callback timer = nullCallback 
    ) {
      return openBrowser(html, ""
          ,tapstart=tapstart
          ,tapend=tapend
          ,tap=tap
          ,click=click
          ,keypress=keypress
          ,load=load
          ,timer=timer
          ,display = display
          ,change=  change
          );
    }
    
private loc openBrowser(loc html, str script, bool display = true 
    ,React click = <[], nullCallback>
    ,React keypress = <[], nullCallback>
     ,React change = <[], nullCallback>
    ,Callback tapstart = nullCallback
    ,Callback tapend =  nullCallback
    ,Callback tap = nullCallback
    ,Callback load = nullCallback
    ,Callback timer = nullCallback
   
    ) {
  	loc site = |http://localhost:8081|;
  	loc base = |project://racytoscal|;
  	   
  	 Response page(get(/^\/tap\/<id:\S+>$/)) { 
        return response(tap(id));
      }
      
      Response page(get(/^\/click\/<path:\S+>$/)) { 
        // println("HELP0:<id>");
        return response(click.callback(path));
      }
      
      Response page(get(/^\/change\/<path:\S+>$/)) { 
        return response(change.callback(path));
      }
      
      Response page(get(/^\/keypress\/<path:\S+>$/)) { 
        // println("HELP0:<id>");
        return response(keypress.callback(path));
      }
      
       Response page(get(/^\/timer\/<path:\S+>$/)) { 
        // println("HELP0:<id>");
        return response(timer(path));
      }
      
      Response page(get(/^\/load\/<path:\S+>$/)) { 
        return response(load(path));
      }
      
      Response page(get(/^\/tapstart\/<id:\S+>$/)) { 
        return response(tapstart(id));
      }
      
      Response page(get(/^\/tapend\/<id:\S+>$/)) { 
        return response(tapend(id));	   
      }
      
      Response page(get(/^\/close$/)) { 
        println("shutdown"); 
        shutdown(site);
	    return response("shutdown");
      }
      
      Response page(get(/^\/init$/)) { 
        // println("INIT");
        script+="
        'if (typeof clickCallback===\'undefined\') clickCallback = fromRascal;
	    'if (typeof changeCallback===\'undefined\') changeCallback = fromRascal;
	    'if (typeof keypressCallback===\'undefined\') keypressCallback = fromRascal;
	    ";
        for (str id <-click.ids) {script+="addHandlerClick(\"click\", \"<id>\", true, clickCallback);\n";}
        for (str id <-keypress.ids) {script+="addHandlerKeypress(\"keypress\", \"<id>\", true, keypressCallback);\n";}
        for (str id <-change.ids) {script+="addHandlerValue(\"change\", \"<id>\", true, changeCallback);\n";}
	    return response(script);
      }
     
     default Response page(get(str path)) {
       // println("HELP:path=<path>  base=<base>");
       if   (path=="/") {
	       return response(html);
           } 
       // return response("");    
       return response(base + path); 
       } 
        
       // while (true) {
          try {
            println("Trying ... <site>");
            serve(site, page);
            if (display) htmlDisplay(site); 
            return site;
            }  
          catch IO(_): {
            //  site.port += 1; 
            throw "Illegal site <site>";
       }
       // }
    }
    
private str toScript(list[Script] contents) {
    str r = "";
    for (Script v<-contents) {
        value val = v.val;
        switch (val) {
            case c:Cytoscape: r+=genScript(v.container, c);
            case s:String: r+=genScript(v.container, s);
            case d:Config: r+=genScript(v.container, d);
            }
        }
        return r;
    }
    
private list[SVG] graph(ViewBox viewBox, tuple[str \class, lrel[num x, num y] d] graphs...) {
    list[SVG] r = [];
    for (tuple[str \class, lrel[num x, num y] d] graph<-graphs) {
          r+=path(
          "M <_(graph.d[0].x)> <_(2*viewBox.y+viewBox.height-graph.d[0].y)> 
          '<for (tuple[num x, num y] g <-tail(graph.d)){> L <_(g.x)> <_(2*viewBox.y+viewBox.height-g.y)> <}>"
               ,class=graph.class
                );
    }
    return r;
  }
  
 private str toCssString(list[tuple[str sel, str key, str val]] css) {
    list[str] r =[];
    for (cs<-css) {
         r+= "{\"sel\":\"<cs.sel>\",\"key\":\"<cs.key>\",\"val\":\"<cs.val>\"}";
         }
    return intercalate(",", r);
    }
    
 private str toTransformString(list[tuple[str sel, str val]] transforms) {
    list[str] r =[];
    for (transform<-transforms) {
         r+= "{\"sel\":\"<transform.sel>\",\"val\":\"<transform.val>\"}";
         }
    return intercalate(",", r);
    }
    
 private str toSelString(list[str] sels) {
   list[str] r = ["\"<q>\""|q<-sels];
    return intercalate(",", r);
    }
    
 private str toString(list[tuple[str attach, str tableId, str cellId, int width, int height]] tables) {
         list[str ] r = [];
         for (table <- tables)
           r+="{\"attach\":\"<table.attach>\", \"tableId\":\"<table.tableId>\",\"cellId\":\"<table.cellId>\", \"width\":\"<table.width>\",\"height\":\"<table.height>\"}";
         return intercalate(",", r);
    }
    
private str toString(list[tuple[str attach, str content]] htmls) {
         list[str ] r = [];
         for (html <- htmls)
           r+="{\"attach\":\"<html.attach>\", \"content\":\"<replaceAll(replaceAll(html.content,"\n",""),"\"","\\\"")>\"}";
         return intercalate(",", r);
    }