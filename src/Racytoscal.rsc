module Racytoscal
import Prelude;
import util::Math;
import util::HtmlDisplay;

alias Position = tuple[int x, int y];

public data Ele(Position position= <-1, -1>)  = n_(str id, Style style = style())
         | e_(str id, str source, str target, Style style = style())
         ;
         
public data Style = style(
              str backgroundColor="", num backgroundOpacity=-1,
              str borderColor= "", int borderWidth=-1,
              int padding=-1, int width=-1, str height = -1,
              str lineColor="",
              str lineFill= "",
              str lineCap="",
              str width = "",
              str height= "",
              list[ArrowShape] arrowShape = [],
              list[Label] label = [],
              NodeShape shape =  ellipse(),
              EdgeShape curveStyle = straight(),
              Label label =  label(""),
              Label sourceLabel = sourceLabel(""),
              Label targetLabel = targetLabel(""),
              num opacity =  -1,
              str visibility = "",
              int zIndex = -1
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
    | bezier()
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
    
public data Label(str color="", str outlineColor="", str backgroundColor="", str borderColor="",
      int marginX=0, int marginY = 0, num backgroundOpacity=-1, num outlineOpacity=-1
         ,num borderOpacity=0.5, int borderWidth=-1, int backgroundPadding =0
         ,str backgroundShape="")
    = label(str \value, str hAlign = "center", str vAlign="center")
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
  
str addKeyValue(str key, str val) = isEmpty(val)?"":"\'<key>\':\'<val>\',";

str addKeyValue(str key, int val) = val==-1?"":"\'<key>\':\'<val>\',";

str addKeyValue(str key, bool val) = "\'<key>\':\'<val>\',";

str addKeyNumValue(str key, num val) = val==-1?"":"\'<key>\':\'<val>\',";
    
str getArrowShape(ArrowShape arg) {
    str r = "";
    if (defaultArrowShape():=arg) return r;
    Pos pos = arg.pos;
    r+= addKeyValue("<getName(pos)>-arrow-fill", arg.arrowFill);
    r+= addKeyValue("<getName(pos)>-arrow-color", arg.arrowColor);
    r+= addKeyNumValue("arrow-scale", arg.arrowScale);
    r+= addKeyValue("<getName1(pos)>-arrow-shape", getName(arg));
    return r;
    }
 
str getLabel(Label arg) {  
    str r = "";
    switch(arg) {
       case label(str \value): { 
            if (isEmpty(\value)) return "";
            r+=addKeyValue("label", \value);
            if ((arg.hAlign?))
               r+=addKeyValue("text-halign", arg.hAlign);
            if ((arg.vAlign?))
               r+=addKeyValue("text-valign", arg.vAlign);
            }
       case sourceLabel(str \value): {
            if (isEmpty(\value)) return "";
            r+=addKeyValue("source-label", \value);
            if ((arg.offset?))
            r+=addKeyValue("offset", arg.offset);
            }
       case targetLabel(str \value): {
            if (isEmpty(\value)) return "";
            r+=addKeyValue("target-label", \value);
             if ((arg.offset?))
            r+=addKeyValue("offset", arg.offset);
            }
         }
    r+= addKeyValue("text-margin-x", arg.marginX);
    r+= addKeyValue("text-margin-y", arg.marginY);
    r+= addKeyValue("color", arg.color);
    r+= addKeyValue("text-outline-color", arg.outlineColor);
    r+= addKeyValue("text-background-color", arg.backgroundColor);
    r+= addKeyNumValue("text-outline-opacity", arg.outlineOpacity);
    r+= addKeyNumValue("text-background-opacity", arg.backgroundOpacity);
    r+= addKeyNumValue("text-background-padding", arg.backgroundPadding);
    r+= addKeyValue("text-border-color", arg.borderColor);
    r+= addKeyNumValue("text-border-opacity", arg.borderOpacity);
    r+= addKeyValue("text-border-width", arg.borderWidth);
    r+= addKeyValue("text-background-shape", arg.backgroundShape);
    return r;
    }
    
 str getCurveStyle(EdgeShape arg) {  
    str r = "";
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
               r+=addKeyValue("control-point-distances", getName(arg.controlPointDistances));
            if ((arg.controlPointWeights?))
               r+=addKeyValue("control-point-weights", arg.controlPointWeights);
            }
         }
    r+= addKeyValue("curve-style", getName1(arg));
    return r;
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
 
str getStyle(str selector, Style arg) {
    r="";
    if ((arg.backgroundColor?))
    r+= addKeyValue("background-color", arg.backgroundColor);
    if ((arg.backgroundOpacity?))
    r+= addKeyNumValue("background-opacity", arg.backgroundOpacity);
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
    r+=getLabel(arg.label);
    // r+=getEdgeStyle(selector, style.edgeShape);
    if ((arg.opacity?))
        r+= addKeyNumValue("opacity", arg.opacity);
    if ((arg.visibility?))
        r+= addKeyValue("visibility", arg.visibility);
    if ((arg.zIndex?))
        r+= addKeyValue("z-index", arg.zIndex);
    return isEmpty(r)?"":"{selector:\'<selector>\', style: {
        '<r>
        }
     }
    "
          ;
    }
    
str getElStyle(Ele ele) {
    switch(ele) {
       case v:n_(str id): return getStyle("node#<id>", v.style);
       case v:e_(str id, str source, str target): return getStyle("edge#<id>", v.style);
       }
    }

str getStyles(list[tuple[str selector, Style style]] styles) {
    list[str] r = [getStyle(t.selector, t.style)|
       tuple[str selector, Style style] t<-styles];
    r = [t|str t<-r,!isEmpty(t)];
    return intercalate(",", r);
    }
    
str getElStyles(list[Ele] eles) {
    list[str] r = [getElStyle(ele)| Ele ele<-eles];
    r = [t|str t<-r,!isEmpty(t)];
    return intercalate(",", r);
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
    if (ele.position?) 
       r+=",position: {x: <ele.position.x>, y:<ele.position.y>}";
    r+= "}\n";
    return r;
    }
    
str getElements(list[Ele] eles) {
    list[str] r = [getElement(ele)| Ele ele<-eles];
    return intercalate(",", r);
    }
 
  
str getLayout(Layout \layout, loc extra= |std:///|) {
    str options = (isEmpty(\layout.options))?"{name:\'<getName(\layout)>\'}":
        "{name:\'<getName(\layout)>\',<\layout.options>}";
    str r = "var options = <options>;\n";
    r+="var layout = cy.layout(options);\n";
    if (extra.scheme!="std") r+=readFile(extra);
    r+="layout.run();";
    return r;
    }
 
public str genScript(str container, Cytoscape cy, loc extra =|std:///|) {
  str r =  
  "var cy = cytoscape({
  'container: document.getElementById(\'<container>\'), 
  'style: [<getStyles(cy.styles)+","+getElStyles(cy.elements)>],
  'elements: [<getElements(cy.elements)>]
  '
  '});
  <getLayout(cy.\layout, extra=extra)>
  "
  ;
  return r;
  }
  
// private bool isUppercase(str s) 
 
  /*
  style: [ // the stylesheet for the graph
    {
      selector: 'node',
      style: {
        'background-color': 'antiquewhite',
        'border-color': 'darkgrey',
        'border-width': 2,
        'label': 'data(id)',
        'text-valign':'center',
        // 'label':'aap',
        
      }
     },
   }
   */