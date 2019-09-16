module Racytoscal
import Prelude;
import util::Math;
import util::HtmlDisplay;
import util::Webserver;
extend Chart;


public alias Position = tuple[Coord, Coord];
public alias ViewBox = tuple[num x, num y, num width, num height];
public alias Padding = tuple[num top,  num right, num bottom, num left];

num cut = 0.01;

public num _(num x) = round(x, cut);


public data Ele = n_(str id, Style style = style(), tuple[int x, int y] position= <-1, -1>)
         | e_(str id, str source, str target, Style style = style())
         ;
         
public data Style = style(
              str backgroundColor="", num backgroundOpacity=-1,
              str backgroundFill="", num backgroundBlacken= 0,
              str backgroundGradientStopColors="",str backgroundGradientStopPositions="", 
              str backgroundGradientDirection="",
              str borderColor= "", str borderWidth="",
              str padding= "",
              str lineColor="",
              str lineFill= "",
              str lineCap="",
              str width = "",
              str height= "",
              list[ArrowShape] arrowShape = [],
              // list[Label] label = [],
              NodeShape shape =  ellipse(),
              EdgeShape curveStyle = straight(),
              Label label =  label(""),
              Label sourceLabel = sourceLabel(""),
              Label targetLabel = targetLabel(""),
              num opacity =  -1,
              str visibility = "",
              int zIndex = -1,
   //   ---
              str color="", 
              str textOutlineColor="", 
              str textBackgroundColor="", 
              str textBorderColor="",
              int textMarginX=0, 
              int textMarginY = 0, 
              num textBackgroundOpacity=-1, 
              num textOutlineOpacity=-1,
              num textBorderOpacity=0.5, 
              str textBorderWidth="", 
              int textBackgroundPadding =0,
              str textBackgroundShape="", 
              num textOpacity=-1,
              str fontSize="",
              str fontStyle="",
              str fontWeight="",
              str loopDirection="",
              str loopSweep = ""
              );
         
public data Cytoscape = cytoscape(
  list[Ele] elements = [],
  list[tuple[str selector, Style style]] styles = [],
  Layout \layout = circle(""),
  num zoom = 1.0,
  Position pan =  <0, 0>,
  bool zoomingEnabled = true,
  bool userZoomingEnable = true,
  bool panningEnabled = true,
  bool userPanningEnabled = true,
  bool boxSelectionEnabled =false,
  str selectionType = "single",
  int touchTapThreshold = 8,
  int desktopTapThreshold = 4,
  bool autolock = false,
  bool autoungrabify = false,
  bool autounselectify = false,

  // rendering options:
  bool headless = false,
  bool styleEnabled = true,
  bool hideEdgesOnViewport = false,
  bool hideLabelsOnViewport = false,
  bool textureOnViewport = false,
  bool motionBlur = false,
  num motionBlurOpacity = 0.2,
  int wheelSensitivity = 1,
  str pixelRatio = "auto"
  );  
         
public data NodeShape
    =ellipse()
    |triangle()
    |rectangle()
    |roundRectangle()
    |bottomRoundRectangle()
    |cutRectangle()
    |barrel()
    |rhomboid()
    |diamond()
    |pentagon()
    |hexagon()
    |concaveHexagon()
    |heptagon ()
    |octagon()
    |star()
    |\tag()
    |vee()
    |defaultNodeShape()
    ;
    
 public data EdgeShape
    = haystack()
    | straight()
    | bezier(str controlPointDistances="", str controlPointWeight="", str controlPointStepSize="")
    | unbundledBezier(str controlPointDistances="", 
        str controlPointWeights="") 
    | segments()
    | taxi(TaxiDirection taxiDirection=downward(), str taxiTurn = "",
          str taxiTurnMinDistance="")
    ;
     
 public data Pos
    = source()
    | midSource()
    | target()
    | midTarget()
    ;
    
public data TaxiDirection
    =  auto()
    |  vertical()
    |  downward()
    |  upward()
    |  horizontal()
    |  rightward()
    |  leftward()
    ;
    
 public data ArrowShape(bool arrowFill = true, Pos pos= target(), num arrowScale=1.0,
     str arrowColor = "grey")
    = triangle()
    | triangleTee()
    | triangleCross()
    | triangleBackcurve()
    | vee()
    | tee()
    | square()
    | circle()
    | diamond()
    | chevron()
    | none()
    | defaultArrowShape()
    ;
    
public data Label
    = label(str \value, str hAlign = "center", str vAlign="center", int marginX=0, int marginY=0)
    | sourceLabel(str \value, int offset = 0)
    | targetLabel(str \value, int offset = 0)
    | defaultLabel()
    ;
    
    
public data Layout
    =  concentric(str options)
        // str name = "concentric",
        //bool fit= true, // whether to fit the viewport to the graph
        //int padding= 30, // the padding on fit
        //num startAngle= 3 / 2 * PI(), // where nodes start in radians
        //num sweep= 2*PI(), // how many radians should be between the first and last node (defaults to full circle)
        //bool clockwise= true, // whether the layout should go clockwise (true) or counterclockwise/anticlockwise (false)
       //bool equidistant= false, // whether levels have an equal radial distance betwen them, may cause bounding box overflow
       // int minNodeSpacing= 10, // min spacing between outside of nodes (used for radius adjustment)
        //str boundingBox= "", // constrain layout bounds; { x1, y1, x2, y2 } or { x1, y1, w, h }
        //bool avoidOverlap= true, // prevents node overlap, may overflow boundingBox if not enough space
        //bool nodeDimensionsIncludeLabels= false, // Excludes the label when calculating node bounding boxes for the layout algorithm
        //int height= -1, // height of layout area (overrides container height)
        //int width = -1, // width of layout area (overrides container width)
        //num spacingFactor= -1 //
       
   | circle(str options)
       // name= 'circle',
      //bool fit= true, // whether to fit the viewport to the graph
      //int padding= 30, // the padding on fit
      //str boundingBox= "", // constrain layout bounds; { x1, y1, x2, y2 } or { x1, y1, w, h }
      //bool avoidOverlap= true, // prevents node overlap, may overflow boundingBox and radius if not enough space
      //bool nodeDimensionsIncludeLabels= false, // Excludes the label when calculating node bounding boxes for the layout algorithm
      //num spacingFactor= -1, // Applies a multiplicative factor (>0) to expand or compress the overall area that the nodes take up
      //int radius= -1, // the radius of the circle
      //num startAngle= 3 / 2 * PI(), // where nodes start in radians
      //num sweep= 2*PI(), // how many radians should be between the first and last node (defaults to full circle)
      //bool clockwise= true, // whether the layout should go clockwise (true) or counterclockwise/anticlockwise (false)
      // sort= undefined, // a sorting function to order the nodes; e.g. function(a, b){ return a.data('weight') - b.data('weight') }
      //bool animate= false, // whether to transition the node positions
      //int animationDuration= 500, // duration of animation in ms if enabled
      //bool animationEasing= false // easing of animation if enabled
 // animateFilter= function ( node, i ){ return true; }, // a function that determines whether the node should be animated.  All nodes animated by default on animate enabled.  Non-animated nodes are positioned immediately when the layout starts
 // ready= undefined, // callback on layoutready
 // stop= undefined, // callback on layoutstop
       
  | preset (str options)
   // name= 'preset',
  //map[str, Position] positions= (), // map of (node id) => (position obj); or function(node){ return somPos; }
  //num zoom=  1, // the zoom level to set (prob want fit = false if set)
  //Position pan= <0, 0>, // the pan level to set (prob want fit = false if set)
  //bool fit= true, // whether to fit to viewport
  //int padding= 30, // padding on fit
  ///bool animate= false, // whether to transition the node positions
  //bool animationDuration= 500, // duration of animation in ms if enabled
  //bool animationEasing= false // easing of animation if enabled
  // animateFilter= function ( node, i ){ return true; }, // a function that determines whether the node should be animated.  All nodes animated by default on animate enabled.  Non-animated nodes are positioned immediately when the layout starts
  // ready= undefined, // callback on layoutready
  // stop= undefined, // callback on layoutstop
  //   )
  | dagre (str options)
    // name= 'dagre'
   // int nodeSep= -1, // the separation between adjacent nodes in the same rank
  //int edgeSep= -1, // the separation between adjacent edges in the same rank
  //int rankSep= -1, // the separation between adjacent nodes in the same rank
  //str rankDir= "", // 'TB' for top to bottom flow, 'LR' for left to right,
  //str ranker= "", // Type of algorithm to assign a rank to each node in the input graph. Possible values= 'network-simplex', 'tight-tree' or 'longest-path'
  // minLen= function( edge ){ return 1; }, // number of ranks to keep between the source and target of the edge
  // edgeWeight= function( edge ){ return 1; }, // higher weight edges are generally made shorter and straighter than lower weight edges
  // general layout options
  //bool fit= true, // whether to fit to viewport
  //int padding= 30, // fit padding
  //num spacingFactor= -1, // Applies a multiplicative factor (>0) to expand or compress the overall area that the nodes take up
  //bool nodeDimensionsIncludeLabels= false, // whether labels should be included in determining the space used by a node
  //bool animate= false, // whether to transition the node positions
  //animateFilter= function( node, i ){ return true; }, // whether to animate specific nodes when animation is on; non-animated nodes immediately go to their final positions
  //animationDuration= 500, // duration of animation in ms if enabled
  // animationEasing= undefined, // easing of animation if enabled
  //str boundingBox= "" // constrain layout bounds; { x1, y1, x2, y2 } or { x1, y1, w, h }
  // transform= function( node, pos ){ return pos; }, // a function that applies a transform to the final node position
  // ready= function(){}, // on layoutready
  // stop= function(){} // on layoutstop
  //  )
  | breadthfirst(str options)
  //    name= 'breadthfirst',
  //bool fit= true, // whether to fit the viewport to the graph
  //bool directed= false, // whether the tree is directed downwards (or edges can point in any direction if false)
  //int padding= 30, // padding on fit
  //bool circle= false, // put depths in concentric circles if true, put depths top down if false
  //bool grid= false, // whether to create an even grid into which the DAG is placed (circle=false only)
  //num spacingFactor= 1.75, // positive spacing factor, larger => more space between nodes (N.B. n/a if causes overlap)
  //str boundingBox= "", // constrain layout bounds; { x1, y1, x2, y2 } or { x1, y1, w, h }
  //bool avoidOverlap= true, // prevents node overlap, may overflow boundingBox if not enough space
  //bool nodeDimensionsIncludeLabels= false, // Excludes the label when calculating node bounding boxes for the layout algorithm
  //list[str] roots= [], // the roots of the trees
  //bool maximal= false, // whether to shift nodes down their natural BFS depths in order to avoid upwards edges (DAGS only)
  //bool animate= false, // whether to transition the node positions
  //int animationDuration= 500, // duration of animation in ms if enabled
  //bool animationEasing= false // easing of animation if enabled,
  //animateFilter= function ( node, i ){ return true; }, // a function that determines whether the node should be animated.  All nodes animated by default on animate enabled.  Non-animated nodes are positioned immediately when the layout starts
  //ready= undefined, // callback on layoutready
  // stop= undefined, // callback on layoutstop
   // )
   | cose(str options)
   | random(str options)
   //fit: true, // whether to fit to viewport
   // padding: 30, // fit padding
   // boundingBox: undefined, 
  ;
  
str addKeyValue(str key, str val) = isEmpty(val)?"":"\"<key>\":\"<val>\"";

str addKeyValue(str key, int val) = val==-1?"":"\"<key>\":\"<val>\"";

str addKeyValue(str key, bool val) = "\"<key>\":<val>";

str addKeyNumValue(str key, num val) = val==-1?"":"\"<key>\":\"<val>\"";
    
str getArrowShape(ArrowShape arg) {
    list[str] r = [];
    if (defaultArrowShape():=arg) return "";
    Pos pos = arg.pos;
    if ((arg.arrowFill?))
         r+= addKeyValue("<getName(pos)>-arrow-fill", arg.arrowFill?"filled":"hollow");
    if ((arg.arrowColor?))
         r+= addKeyValue("<getName(pos)>-arrow-color", arg.arrowColor);
    if ((arg.arrowScale?))
    r+= addKeyNumValue("arrow-scale", arg.arrowScale);
    r+= addKeyValue("<getName1(pos)>-arrow-shape", getName(arg));
    return intercalate(",", r);
    }
 
str toString(Label arg) {  
    list[str] r = [];
    switch(arg) {
       case label(str \value): { 
            if (isEmpty(\value)) return "";
            r+=addKeyValue("label", \value);
            if ((arg.hAlign?))
               r+=addKeyValue("text-halign", arg.hAlign);
            if ((arg.vAlign?))
               r+=addKeyValue("text-valign", arg.vAlign);
             if ((arg.marginX?))
               r+=addKeyValue("text-margin-x", arg.marginX);
            if ((arg.marginY?))
               r+=addKeyValue("text-margin-y", arg.marginY);
            }
       case sourceLabel(str \value): {
            if (isEmpty(\value)) return "";
            r+=addKeyValue("source-label", \value);
            if ((arg.offset?))
            r+=addKeyValue("source-text-offset", arg.offset);
            }
       case targetLabel(str \value): {
            if (isEmpty(\value)) return "";
            r+=addKeyValue("target-label", \value);
             if ((arg.offset?))
            r+=addKeyValue("target-text-offset", arg.offset);
            }
         }
    
    return intercalate(",", r);
    }
    
 str getCurveStyle(EdgeShape arg) {  
    list[str] r = [];
    switch(arg) {
       case taxi(): { 
            if ((arg.taxiDirection?))
               r+=addKeyValue("taxi-direction", getName(arg.taxiDirection));
            if ((arg.taxiTurn?))
               r+=addKeyValue("taxi-turn", arg.taxiTurn);
            if ((arg.taxiTurnMinDistance?))
               r+=addKeyValue("taxi-turn-min-distance", arg.taxiTurnDistance);
            }
        case unbundledBezier(): {
            if ((arg.controlPointDistances?))
               r+=addKeyValue("control-point-distances", arg.controlPointDistances);
            if ((arg.controlPointWeights?))
               r+=addKeyValue("control-point-weights", arg.controlPointWeights);
            }
         case bezier(): {
            if ((arg.controlPointDistances?))
               r+=addKeyValue("control-point-distances", arg.controlPointDistances);
            if ((arg.controlPointWeight?))
               r+=addKeyValue("control-point-weight", arg.controlPointWeight);
            if ((arg.controlPointStepSize?))
               r+=addKeyValue("control-point-step-size", arg.controlPointStepSize);
             }
         }
         
    r+= addKeyValue("curve-style", getName1(arg));
    return intercalate(",", r);
    }
    
str getName1(NodeShape arg) {
    str s = getName(arg);
    switch(s) {
        case "roundRectangle": return "round-rectangle";
        case "bottomRoundRectangle": return "bottom-round-rectangle";
        case "cutRectangle": return "cut-rectangle";
        case "concaveHaxagon": return "concave-hexagon";
        }
    return s;
    }
    
str getName1(EdgeShape arg) {
    str s = getName(arg);
    switch(s) {
        case "unbundledBezier": return "unbundled-bezier";
        }
    return s;
    }
    
str getName1(Pos arg) {
    str s = getName(arg);
    switch(s) {
        case "midSource": return "mid-source";
        case "midTarget": return "mid-target";
        }
    return s;
    }
 
str toString(Style arg) {
    list[str] r=[];
    if ((arg.backgroundColor?))
    r+= addKeyValue("background-color", arg.backgroundColor);
    if ((arg.backgroundOpacity?))
    r+= addKeyNumValue("background-opacity", arg.backgroundOpacity);
    if ((arg.backgroundFill?))
    r+= addKeyValue("background-fill", arg.backgroundFill);
    if ((arg.backgroundBlacken?))
    r+= addKeyNumValue("background-blacken", arg.backgroundBlacken);
    if ((arg.backgroundGradientStopColors?))
    r+= addKeyValue("background-gradient-stop-colors", arg.backgroundGradientStopColors);
    if ((arg.backgroundGradientStopPositions?))
    r+= addKeyValue("background-gradient-stop-positions", arg.backgroundGradientStopPositions);
    if ((arg.backgroundGradientDirections?))
    r+= addKeyValue("background-gradient-directions", arg.backgroundGradientDirections);
    if ((arg.borderColor?))
    r+= addKeyValue("border-color", arg.borderColor);
    if ((arg.borderWidth?))
    r+= addKeyValue("border-width", arg.borderWidth);
    if ((arg.padding?))
    r+= addKeyValue("padding", arg.padding);
    if ((arg.width?))
    r+= addKeyValue("width", arg.width);
    if ((arg.height?))
    r+= addKeyValue("height", arg.height);
    if ((arg.shape?))
    r+= addKeyValue("shape", getName1(arg.shape));
    if ((arg.lineColor?))
    r+= addKeyValue("line-color", arg.lineColor);
    if ((arg.lineFill?))
    r+= addKeyValue("line-fill", arg.lineFill);
    if ((arg.lineCap?))
    r+= addKeyValue("line-cap", arg.lineCap);
    if ((arg.arrowShape?))
    for (ArrowShape arrowShape<-arg.arrowShape)
       r+= getArrowShape(arrowShape);
    if ((arg.curveStyle?))
        r+= getCurveStyle(arg.curveStyle);
    if ((arg.label?))
       r+=toString(arg.label);
    // r+=getEdgeStyle(selector, style.edgeShape);
    if ((arg.opacity?))
        r+= addKeyNumValue("opacity", arg.opacity);
    if ((arg.visibility?))
        r+= addKeyValue("visibility", arg.visibility);
    if ((arg.zIndex?))
        r+= addKeyValue("z-index", arg.zIndex);
    if ((arg.textMarginX?))
         r+= addKeyValue("text-margin-x", arg.textMarginX);
    if ((arg.textMarginY?))
         r+= addKeyValue("text-margin-y", arg.textMarginY);
    if ((arg.color?))
         r+= addKeyValue("color", arg.color);
    if ((arg.textOutlineColor?))
         r+= addKeyValue("text-outline-color", arg.textOutlineColor);
    if ((arg.textBackgroundColor?))
         r+= addKeyValue("text-background-color", arg.textBackgroundColor);
    if ((arg.textOutlineOpacity?))
         r+= addKeyNumValue("text-outline-opacity", arg.textOutlineOpacity);
    if ((arg.textOpacity?))
         r+= addKeyNumValue("text-opacity", arg.textOpacity);
    if ((arg.textBackgroundOpacity?))
         r+= addKeyNumValue("text-background-opacity", arg.textBackgroundOpacity);
    if ((arg.textBackgroundPadding?))
         r+= addKeyNumValue("text-background-padding", arg.textBackgroundPadding);
    if ((arg.textBorderColor?))
         r+= addKeyValue("text-border-color", arg.textBorderColor);
    if ((arg.textBorderOpacity?))
         r+= addKeyNumValue("text-border-opacity", arg.textBorderOpacity);
    if ((arg.textBorderWidth?))
         r+= addKeyValue("text-border-width", arg.textBorderWidth);
    if ((arg.textBackgroundShape?))
    r+= addKeyValue("text-background-shape", arg.textBackgroundShape);
    if ((arg.fontSize?))
    r+= addKeyValue("font-size", arg.fontSize);
    if ((arg.fontStyle?))
    r+= addKeyValue("font-style", arg.fontStyle);
    if ((arg.fontWeight?))
    r+= addKeyValue("font-weight", arg.fontWeight);
    if ((arg.loopDirection?))
    r+= addKeyValue("loop-direction", arg.loopDirection);
    if ((arg.loopSweep?))
    r+= addKeyValue("loop-sweep", arg.loopSweep);
    return intercalate(",", r);
    }

// str toString(tuple[str selector, Style style] d) = "{\"selector\": \"<d.selector>\", \"style\":{<toString(d.style)>}}";
    
str getStyleArgument(str selector, Style argument) {
    str r = toString(argument);
    return isEmpty(r)?"":"{\"selector\":\"<selector>\", \"style\": {
        '<r>
        }
     }
    "
    ;
    }
    
str getElStyle(Ele ele) {
    switch(ele) {
       case v:n_(str id): return getStyleArgument("node#<id>", v.style);
       case v:e_(str id, str source, str target): return getStyleArgument("edge#<id>", v.style);
       }
    }
    
public str toJSON(list[tuple[str selector, Style style]] styles) = toString(styles);

str toString(list[tuple[str selector, Style style]] styles) {
    // println("ToString");
    list[str] r = [getStyleArgument(t.selector, t.style)|
       tuple[str selector, Style style] t<-styles];
    r = [t|str t<-r,!isEmpty(t)];
    return "["+intercalate(",", r)+"]";
    }
    
str getElStyles(list[Ele] eles) {
    list[str] r = [getElStyle(ele)| Ele ele<-eles];
    r = [t|str t<-r,!isEmpty(t)];
    return "["+intercalate(",", r)+"]";
    }
    
str getNodeElement(str id) = 
    "\'nodes\',
    'data: {
    '  id: \'<id>\'
    '}\n";
    
str getEdgeElement(str id, str source, str target) = 
    "\'edges\',
    'data: {
    '  id: \'<id>\',
    '  source:\'<source>\',
    '  target:\'<target>\',
    '}\n";
    
str getElement(Ele ele) {
    str r = "{ group:";
    switch(ele) {
       case v:n_(str id): r+=getNodeElement(id);
       case v:e_(str id, str source, str target): r+=getEdgeElement(id, source, target);
       }
    if (n_(_):=ele && ele.position?) 
       r+=",position: {x: <ele.position.x>, y:<ele.position.y>}";
    r+= "}\n";
    return r;
    }
    
str getElements(list[Ele] eles) {
    list[str] r = [getElement(ele)| Ele ele<-eles];
    return intercalate(",", r);
    }
 
  
str getLayout(Layout \layout) {
    str options = (isEmpty(\layout.options))?"{name:\'<getName(\layout)>\'}":
        "{name:\'<getName(\layout)>\',<\layout.options>}";
    //str r = "var options = <options>;\n";
    // r+="var layout = cy.layout(options);\n";
    //r+="layout.run();";
    return options;
    }
 
public str genScript(str container, Cytoscape cy, str extra ="") {
  str r =  
  "cy[\"<container>\"] = cytoscape({
  'container: document.getElementById(\'<container>\'), 
  'style: <toString(cy.styles)>.concat(<getElStyles(cy.elements)>),
  'elements: [<getElements(cy.elements)>],
  'layout: <getLayout(cy.\layout)>
  '});
  '<extra>
  "
  ;
  return r;
  }
  
public str genScript(str container, str content) {
  str r= 
  "attach[\"<container>\"] = document.getElementById(\'<container>\');
  'attach[\"<container>\"].innerHTML=\'<replaceAll(content,"\n"," ")>\';
  ";
  return r;
  }
  
public loc openBrowser(loc html, tuple[str container, str content] attach, bool display = true 
    ,str(str id) tapstart = str(str id){return "";}
    ,str(str id) tapend = str(str id){return "";}
    ,str(str id) tap = str(str id){return "";}
    ,str(str id) click = str(str id){return "";}
    ,str(str id) keypress = str(str id){return "";}
    ,str(str id) load = str(str id){return "";}
    ,str(str id) timer = str(str id){return "";}
    ) {  
    return openBrowser(html, genScript(attach.container, attach.content)
          ,tapstart=tapstart
          ,tapend=tapend
          ,tap=tap
          ,click=click
          ,keypress=keypress
          ,load=load
          ,timer=timer
          );  
    }
  
public loc openBrowser(loc html, bool display = true 
    ,str(str id) tapstart = str(str id){return "";}
    ,str(str id) tapend = str(str id){return "";}
    ,str(str id) tap = str(str id){return "";}
    ,str(str id) click = str(str id){return "";}
    ,str(str id) keypress = str(str id){return "";}
    ,str(str id) load = str(str id){return "";}
    ,str(str id) timer = str(str id){return "";}
    ) {
      return openBrowser(html, ""
          ,tapstart=tapstart
          ,tapend=tapend
          ,tap=tap
          ,click=click
          ,keypress=keypress
          ,load=load
          ,timer=timer
          );
    }
    
public loc openBrowser(loc html, str script, bool display = true 
    ,str(str id) tapstart = str(str id){return "";}
    ,str(str id) tapend = str(str id){return "";}
    ,str(str id) tap = str(str id){return "";}
    ,str(str id) click = str(str id){return "";}
    ,str(str id) keypress = str(str id){return "";}
    ,str(str id) load = str(str id){return "";}
    ,str(str id) timer = str(str id){return "";}
    ) {
  	loc site = |http://localhost:8081|;
  	loc base = |project://racytoscal|;
  	   
  	 Response page(get(/^\/tap\/<id:\S+>$/)) { 
        return response(tap(id));
      }
      
      Response page(get(/^\/click\/<path:\S+>$/)) { 
        // println("HELP0:<id>");
        return response(click(path));
      }
      
      Response page(get(/^\/keypress\/<path:\S+>$/)) { 
        // println("HELP0:<id>");
        return response(keypress(path));
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
        
       while (true) {
          try {
            println("Trying ... <site>");
            serve(site, page);
            if (display) htmlDisplay(site); 
            return site;
            }  
          catch IO(_): {
            site.port += 1; 
            }
       }
    }
    
str toCssString(list[tuple[str sel, str key, str val]] css) {
    list[str] r =[];
    for (cs<-css) {
         r+= "{\"sel\":\"<cs.sel>\",\"key\":\"<cs.key>\",\"val\":\"<cs.val>\"}";
         }
    return intercalate(",", r);
    }
    
 str toSelString(list[str] sels) {
   list[str] r = ["\"<q>\""|q<-sels];
    return intercalate(",", r);
    }
    
 str toString(list[tuple[str attach, str tableId, str cellId, int width, int height]] tables) {
         list[str ] r = [];
         for (table <- tables)
           r+="{\"attach\":\"<table.attach>\", \"tableId\":\"<table.tableId>\",\"cellId\":\"<table.cellId>\", \"width\":\"<table.width>\",\"height\":\"<table.height>\"}";
         return intercalate(",", r);
    }
    
str toString(list[tuple[str attach, str content]] htmls) {
         list[str ] r = [];
         for (html <- htmls)
           r+="{\"attach\":\"<html.attach>\", \"content\":\"<replaceAll(replaceAll(html.content,"\n",""),"\"","\\\"")>\"}";
         return intercalate(",", r);
    }
    
 public str executeInBrowser(lrel[str, Style] styles=[], tuple[str, str] \layout=<"","">, str extra="\"extra\":\"none\"",
       list[tuple[str attach, str tableId, str cellId, int width, int height]] table = [],
       list[tuple[str sel, str key, str val]] css = [], list[str] onclick=[], list[str] onkeypress=[], int setInterval= -1, str path = ""
       ,bool sync = true, list[tuple[str attach, str content]] html = []) {
       return 
       "{<extra>
       '<if((\layout?)){>,\"layout\":[\"<\layout[0]>\", \"<\layout[1]>\"]<}>
       '<if((\styles?)){>,\"styles\":<toString(styles)><}>
       '<if((\css?)){>,\"css\":[<toCssString(css)>]<}>
       '<if((\table?)){>,\"table\":[<toString(table)>]<}>
       '<if((\onclick?)){>,\"onclick\":[<toSelString(onclick)>]<}>
       '<if((\onkeypress?)){>,\"onkeypress\":[<toSelString(onkeypress)>]<}>
       '<if((\setInterval?) && setInterval>0){>,\"setInterval\":\"<setInterval>\"<}>
       '<if((\setInterval?) && setInterval<=0){>,\"clearInterval\":\"<setInterval>\"<}>
       '<if((\path?)){>,\"path\":\"<\path>\"<}>
       '<if((\sync?)){>,\"sync\":\"<\sync>\"<}>
       '<if((\html?)){>,\"html\":[<toString(html)>]<}>
       '}"; 
       }
       
  data SVGLayout = grid(int nCols)|overlay();
       
  data Coord = L(num  left) | R(num right) |C(num center)|L1(num  left1) | R1(num right1) |C1(num center1);
  
  data Dim = pxl(num dim)|pct(num dim)|pxl(Padding tpl)|pct(Padding tpl);
       
  data SVG  (ViewBox viewBox= <0, 0, 100, 100>, list[SVG] inner =[], str id = "", str class= "", str frameClass = "", SVG parent= root(),
          Dim padding = pxl(<0, 0, 0, 0>), SVGLayout svgLayout = overlay())
        = rect(Coord x, Coord y, Dim width, Dim height, num strokeWidth, str style)
        | ellipse(Coord x, Coord y, Dim width, Dim height, num strokeWidth, str style)
        | foreignObject(Coord x, Coord y, Dim width, Dim height, num strokeWidth, str style, str html)
        | text(num x1, num y1,  str style, str txt)
        | path(str style, str txt)
        | root()
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
 
 
 public SVG box(Position pos, SVG inner ..., str id= "", str class= "", str style="", num width=100, num height=100, num vshrink = 1.0, num hshrink = 1.0, 
     num shrink = 1.0, num strokeWidth=2, ViewBox viewBox=<0, 0, 1000, 1000>, Dim padding = pxl(<0,0,0, 0>)
     , SVGLayout svgLayout = overlay()) {
     if ((shrink?)) {vshrink = shrink; hshrink = shrink;}
     // println("<vshrink?> <vshrink>");
     SVG c =  rect(pos[0], pos[1], (!(width?))?pct(hshrink*100) :pxl(width) 
                                 , (!(height?))?pct(vshrink*100) :pxl(height)
                                 , strokeWidth, style, inner = inner, id = id, class = class, viewBox = viewBox, padding = padding
                                 , svgLayout = svgLayout);
     return c;
 }
 
 public SVG ellipse(Position pos, SVG inner ..., str id= "", str class= "", str style="", num width=100, num height=100, num vshrink = 1.0, num hshrink = 1.0, 
     num shrink = 1.0, num strokeWidth=2, ViewBox viewBox=<0, 0, 1000, 1000>,  Dim padding = pxl(<0,0,0, 0>)) {
     if ((shrink?)) {vshrink = shrink; hshrink = shrink;}
     // println("<padding>");
     SVG c =  ellipse(pos[0], pos[1], ((hshrink?)||(shrink?))?pct(hshrink*100) :pxl(width) 
                                 , ((vshrink?)||(shrink?))?pct(vshrink*100) :pxl(height)
                                 , strokeWidth, style, inner = inner, id = id, class= class, viewBox = viewBox, padding = padding);
     return c;
 }
 
 
 
 public SVG htmlObject(Position pos, str html, str id= "", str class= "", str frameClass = "", str style="", int width=100, int height=100, num vshrink = 1.0, num hshrink = 1.0, 
     num shrink = 1.0, int strokeWidth=2) {
     if ((shrink?)) {vshrink = shrink; hshrink = shrink;}
     // println("<vshrink?> <vshrink>");
     SVG c =  foreignObject(pos[0], pos[1], ((hshrink?)||(shrink?))?pct(hshrink*100) :pxl(width) 
                                 , ((vshrink?)||(shrink?))?pct(vshrink*100) :pxl(height)
                                 , strokeWidth, style, html, id = id, class=class, frameClass = frameClass);
     return c;
 }
 
 
 public SVG text(num x, num y, str txt, str id= "", str class= "", str style= "") {
     // println("<vshrink?> <vshrink>");
     SVG c = text(x, y, style, txt, id =id, class = class);
     return c;
 }
 
 
 public SVG path(str txt, str id= "", str class= "", str style= "") {
     // println("<vshrink?> <vshrink>");
     SVG c = path(style, txt, id =id, class = class);
     return c;
 }
 
num posX(num dim, num width, Coord p, num lw) {
    switch(p) {
       case L1(num x): return x*dim+lw/2;
       case R1(num x): return x*dim-width +lw/2;
       case C1(num x): return x*dim-width/2+lw/2;
       case L(num x): return x+lw/2;
       case R(num x): return x-width +lw/2;
       case C(num x): return x-width/2+lw/2;
       }
    return 0;
    }
    
num posY(num dim, num height, Coord p, num lw) {
    switch(p) {
       case L1(num y): return y*dim+lw/2;
       case R1(num y): return y*dim-height +lw/2;
       case C1(num y): return y*dim-height/2+lw/2;
       case L(num y): return y+lw/2;
       case R(num y): return y-height+lw/2;
       case C(num y): return y-height/2+lw/2;
       }
    return 0;
    }
       
public str svg(int width, int height, ViewBox viewBox, str inside) =
      "\<svg width=\"<width>px\" height=\"<height>px\", viewBox=\"<viewBox.x> <viewBox.y> <viewBox.width> <viewBox.height>\"\><inside>\</svg\>";
      
public SVG addParent(SVG parent, SVG s) {
       s.parent = parent;
       s.inner = addParent(s, s.inner);
       return s;
       }
 
public list[SVG] addParent(SVG parent, list[SVG] content) =  [addParent(parent, c)|SVG c<-content]; 
  
public str svg(int width, int height, SVG content..., ViewBox viewBox=<0, 0, width, height>) {
      SVG parent =  root(viewBox = viewBox);
      content = addParent(parent, content);
      str inside = "<for(SVG c <- content){>  <eval(viewBox, 0, c)> <}>";
      return "\<svg width=\"<width>px\" height=\"<height>px\"  viewBox=\"<viewBox.x> <viewBox.y> <viewBox.width> <viewBox.height>\"\>
      <inside>\</svg\>";
      }
      
str useId(SVG c) {
   if ((c.id?) && !isEmpty(c.id)) return "id=\"<c.id>\"";
   return "";
   }
   
str useClass(SVG c) {
   if ((c.class?) && !isEmpty(c.class)) return "class=\"<c.class>\"";
   return "";
   }
   
str useFrameClass(SVG c) {
   if ((c.frameClass?) && !isEmpty(c.frameClass)) return "class=\"<c.frameClass>\"";
   return "";
   }
   
num checkShrink(num dim, Dim d) {
   // println("checkshrink <dim> <d>");
   if (pxl(num v):=d) return v;
   if (pct(num v):=d) return dim*v/100;
   } 
   
Padding getPadding(num width, num height, Dim d) {
   if (pxl(Padding v):=d) return v;
   if (pct(Padding v):=d) return <floor(height*v.top/100),floor(width*v.right/100),floor(height*v.bottom/100),floor(width*v.left/100)>;
   } 
   
str gridLayout(num x, num y, num width, num height, num lw, int nCols, ViewBox vb, list[SVG] inner) {
   int nRows = (size(inner)-1)/nCols+1;
   ViewBox newVb = <vb.x, vb.y, vb.width*nCols,  vb.height*nRows>;
   num posX = x+lw/2, posY = y+lw/2;
   str r = "";
   int cnt = 0;
   int row = 0;
   for (int row<-[0..nRows]) {
      for (_<-[row..row+nCols] && cnt<size(inner)) {   
       r+= "
          ' \<svg x=\"<posX>\"  y=\"<posY>\"  viewBox=\"<newVb.x> <newVb.y> <_(newVb.width)> <_(newVb.height)>\" 
          ' preserveAspectRatio=\"none\"\>
          ' <eval(newVb, lw, inner[cnt])>
          ' \</svg\>
          ";
         posX+=(width/nCols);
         cnt += 1;
        }
        posX = x+lw/2; 
        posY+=(height/nRows);
      }
    return r;
   }

str eval(ViewBox vb,  num lw0, SVG c) {
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
                 x = posX(vb2.width, width1, x1, lw1)+p.left; y = posY(vb2.height, height1,  y1, lw1)+p.top; 
                 width = width1-lw1-p.left-p.right; height  = height1-lw1-p.top-p.bottom; lw = lw1;
                 style1+=";stroke-width:<_(lw)>"; 
                 r= "\<rect <useId(c)> <useClass(c)> x=\"<_(x)>\" y=\"<_(y)>\"  width=\"<_(width)>\" height=\"<_(height)>\" style=\"<style1>\" /\>";
                 }
          case fig:ellipse(Coord x1, Coord y1, Dim widthDim, Dim heightDim, num lw1, str style1): {
                 num width1 = checkShrink(vb2.width, widthDim), height1 = checkShrink(vb2.height, heightDim);
                 Padding p = getPadding(vb1.width,vb1.height, c.padding);
                 x = posX(vb2.width, width1, x1, lw1)+p.left; y = posY(vb2.height, height1,  y1, lw1)+p.top; 
                 width = width1-lw1-p.left-p.right; height  = height1-lw1-p.top-p.bottom; lw = lw1;
                 style1+=";stroke-width:<_(lw)>"; 
                 r= "\<ellipse <useId(c)> <useClass(c)> cx=\"<_(x+width/2)>\" cy=\"<_(y+height/2)>\"  rx=\"<_(width/2)>\" ry=\"<_(height/2)>\" style=\"<style1>\"/\>";
                 }
          case fig:foreignObject(Coord x1, Coord y1, Dim widthDim, Dim heightDim, num lw1, str style1, str html): {
                 num width1 = checkShrink(vb2.width, widthDim), height1 = checkShrink(vb2.height, heightDim);
                 x = posX(vb2.width, width1, x1, lw1); y = posY(vb2.height, height1,  y1, lw1); width = width1-lw1; height  = height1-lw1; lw = lw1;
                 style1+=";stroke-width:<_(lw)>"; 
                 r= "\<rect <useFrameClass(c)> x=\"<_(x)>\" y=\"<_(y)>\"  width=\"<_(width)>\" height=\"<_(height)>\" style=\"<style1>\" stroke-width=\"<lw>\"/\>";
                 r+= "\<foreignObject <useClass(c)> x=\"<_(x+lw/2)>\" y=\"<_(y+lw/2)>\" width=\"<_(width-lw)>\" height=\"<_(height-lw)>\"  style=\"<style1>\"\>
                    '\<div class=\"htmlObject\"\>
                    '<html>
                    '\</div\>
                    '\</foreignObject\>       
                    ";
                }
          case fig:text(num x, num y, str style, str txt): {
                 r= "\<text <useId(c)> <useClass(c)> x=\"<_(x)>\" y=\"<_(y)>\"  style=\"<style>\"\>
                    '<txt>
                    '\</text\>       
                    ";
                 }
          case fig:path(str style, str txt): {
                 r= "\<path <useId(c)> <useClass(c)> d=\"<txt>\" style=\"<style>\"/\>       
                    ";
                 }
          }
      if (getName(c) notin ["foreignObject", "text", "path"]) {  
        num h = height-lw, w = width-lw;
        // int h = 10, w = 10;
        // println("height=<height> ub0=<vb.height>  ub1=<vb1.height> h=<h> ub=<vb.height*vb1.height/h>"); 
        ViewBox newVb = <vb1.x, vb1.y, _((vb.width*vb1.width)/w),  _((vb.height*vb1.height)/h)>;
        if (overlay():=c.svgLayout)
        r+= "
          ' \<svg x=\"<x+lw/2>\"  y=\"<y+lw/2>\"  viewBox=\"<newVb.x> <newVb.y> <_(newVb.width)> <_(newVb.height)>\" 
          ' preserveAspectRatio=\"none\"\>
          ' <for(SVG s<-c.inner){> <eval(newVb, lw, s)><}>
          ' \</svg\>
          ";
       if (grid(int nCols):=c.svgLayout) {
         r+=gridLayout(x, y, w, h, lw, nCols, newVb, c.inner);
         }
       }
      // println(r);
      return r;
      }
      
public str div(str txt..., str class = "") = "
    '<for (str t<-txt){> \<div <if ((class?) && !isEmpty(class)){>class=\"<class>\"<}> \> <t> \</div\><}>";
    
public str centerText(str txt...) = div(div(div(txt), class = "innerX"), class = "innerY");

list[SVG] graph(ViewBox viewBox, tuple[str \class, lrel[num x, num y] d] graphs...) {
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
                ,hshrink=hshrink*shrnk, vshrink = vshrink*shrnk, viewBox= viewBox)
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
               // ,width=width, height = height
                    , strokeWidth=0
                ,viewBox=<0, 0, width, height>
               );
    return r;
    }
   
 public void disconnect(loc site) = shutdown(site);