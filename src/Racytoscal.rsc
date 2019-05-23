module Racytoscal
import Prelude;
import util::Math;
import util::HtmlDisplay;
import util::Webserver;

alias Position = tuple[int x, int y];

public data Ele = n_(str id, Style style = style(), Position position= <-1, -1>)
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
  // str container = "",
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
  "var cy = cytoscape({
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
    
public loc openBrowser(loc html, str script
    ,str(str id) tapstart = str(str id){return "";}
    ,str(str id) tapend = str(str id){return "";}
    ,str(str id) tap = str(str id){return "";}
    ,str(str id) click = str(str id){return "";}
    ,str(str id) load = str(str id){return "";}
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
        shutdown(site);
	    return response("shutdown");
      }
      
      Response page(get(/^\/init$/)) { 
        // println("INIT");
	    return response(script);
      }
     
     default Response page(get(str path)) {
       if   (path=="/") {
	       return response(html);
           }
       // println("HELP:<path>");
       return response(base + path); 
       } 
        
       while (true) {
          try {
            println("Trying ... <site>");
            serve(site, page);
            htmlDisplay(site); 
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
    
 public str executeInBrowser(lrel[str, Style] styles=[], str \layout="", str extra="{\"extra\":\"none\"}",
       tuple[str attach, str tableId, str cellId, int width, int height] table = <"","", "", 0,0>,
       list[tuple[str sel, str key, str val]] css = [], str onclick="") {
       return 
       "{<extra[1..-1]>
       '<if((\layout?)){>,\"layout\":\"<\layout>\"<}>
       '<if((\styles?)){>,\"styles\":<toString(styles)><}>
       '<if((\css?)){>,\"css\":[<toCssString(css)>]<}>
       '<if((\table?)){>,\"table\":
       ' {\"id\":\"<table.attach>\", \"tableId\":\"<table.tableId>\",\"cellId\":\"<table.cellId>\", \"width\":\"<table.width>\",\"height\":\"<table.height>\"}<}>
       '<if((\onclick?)){>,\"onclick\":\"<onclick>\"<}>
       '}"; 
       }
   