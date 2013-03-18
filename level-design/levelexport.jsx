if(typeof JSON!=="object"){JSON={}}(function(){"use strict";function f(e){return e<10?"0"+e:e}function quote(e){escapable.lastIndex=0;return escapable.test(e)?'"'+e.replace(escapable,function(e){var t=meta[e];return typeof t==="string"?t:"\\u"+("0000"+e.charCodeAt(0).toString(16)).slice(-4)})+'"':'"'+e+'"'}function str(e,t){var n,r,i,s,o=gap,u,a=t[e];if(a&&typeof a==="object"&&typeof a.toJSON==="function"){a=a.toJSON(e)}if(typeof rep==="function"){a=rep.call(t,e,a)}switch(typeof a){case"string":return quote(a);case"number":return isFinite(a)?String(a):"null";case"boolean":case"null":return String(a);case"object":if(!a){return"null"}gap+=indent;u=[];if(Object.prototype.toString.apply(a)==="[object Array]"){s=a.length;for(n=0;n<s;n+=1){u[n]=str(n,a)||"null"}i=u.length===0?"[]":gap?"[\n"+gap+u.join(",\n"+gap)+"\n"+o+"]":"["+u.join(",")+"]";gap=o;return i}if(rep&&typeof rep==="object"){s=rep.length;for(n=0;n<s;n+=1){if(typeof rep[n]==="string"){r=rep[n];i=str(r,a);if(i){u.push(quote(r)+(gap?": ":":")+i)}}}}else{for(r in a){if(Object.prototype.hasOwnProperty.call(a,r)){i=str(r,a);if(i){u.push(quote(r)+(gap?": ":":")+i)}}}}i=u.length===0?"{}":gap?"{\n"+gap+u.join(",\n"+gap)+"\n"+o+"}":"{"+u.join(",")+"}";gap=o;return i}}if(typeof Date.prototype.toJSON!=="function"){Date.prototype.toJSON=function(e){return isFinite(this.valueOf())?this.getUTCFullYear()+"-"+f(this.getUTCMonth()+1)+"-"+f(this.getUTCDate())+"T"+f(this.getUTCHours())+":"+f(this.getUTCMinutes())+":"+f(this.getUTCSeconds())+"Z":null};String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(e){return this.valueOf()}}var cx=/[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,escapable=/[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,gap,indent,meta={"\b":"\\b"," ":"\\t","\n":"\\n","\f":"\\f","\r":"\\r",'"':'\\"',"\\":"\\\\"},rep;if(typeof JSON.stringify!=="function"){JSON.stringify=function(e,t,n){var r;gap="";indent="";if(typeof n==="number"){for(r=0;r<n;r+=1){indent+=" "}}else if(typeof n==="string"){indent=n}rep=t;if(t&&typeof t!=="function"&&(typeof t!=="object"||typeof t.length!=="number")){throw new Error("JSON.stringify")}return str("",{"":e})}}if(typeof JSON.parse!=="function"){JSON.parse=function(text,reviver){function walk(e,t){var n,r,i=e[t];if(i&&typeof i==="object"){for(n in i){if(Object.prototype.hasOwnProperty.call(i,n)){r=walk(i,n);if(r!==undefined){i[n]=r}else{delete i[n]}}}}return reviver.call(e,t,i)}var j;text=String(text);cx.lastIndex=0;if(cx.test(text)){text=text.replace(cx,function(e){return"\\u"+("0000"+e.charCodeAt(0).toString(16)).slice(-4)})}if(/^[\],:{}\s]*$/.test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,"@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,"]").replace(/(?:^|:|,)(?:\s*\[)+/g,""))){j=eval("("+text+")");return typeof reviver==="function"?walk({"":j},""):j}throw new SyntaxError("JSON.parse")}}})();
var _document = app.activeDocument;

(function main() {
  var pond = {
    name: _document.name.replace(".psd", ""), 
    start: vec2(0,0), eggs: [], ice: []
  };

  eachTriangleInLayer("ice", function(triangle) {
    pond.ice.push(triangle);
  });

  eachTriangleInLayer("start", function(triangle) {
    pond.start = triangleOrigin(triangle);
  });

  eachTriangleInLayer("eggs", function(triangle) {
    var origin = triangleOrigin(triangle);
    pond.eggs.push(origin);
  });

  writePondToFile(pond);
})();


function eachTriangleInLayer(layer, run) {
  app.preferences.rulerUnits = Units.POINTS;
  var shapelayer = _document.layers.getByName(layer);
  var points = [];

  _document.activeLayer = shapelayer;
  
  var path = _document.pathItems[_document.pathItems.length - 1];

  for(var i=0;i<path.subPathItems.length;i++) {
    var subpath = path.subPathItems[i]
    var tri = [];

    for(var j=0;j<3;j++) {
      var point = subpath.pathPoints[j].anchor
      tri.push(vec2(point[0],point[1]));
    }

    run(tri)
  }
}

function triangleOrigin(triangle) {
  var x = 0, y = 0;
  for(var i=0;i<3;i++) {
    x += triangle[i].x;
    y += triangle[i].y;
  }

  return vec2(x / 3, y / 3);
}

function eachPixelInLayer(layer, run) {
  hideInverseLayers(layer);
  for(var i=0; i < pondWidth * pondHeight; i++) {
    var y = Math.floor(i / pondWidth), x = i % pondWidth;
    var rgb = getColor(x,y);
    if(isWhite(rgb)) continue;

    run(x,(pondHeight-1)-y,rgb);
  }
}

function getColor(x,y) {
  var sampler;
  try {
    sampler = app.activeDocument.colorSamplers[0];
  } catch(ex) {
    app.preferences.rulerUnits = Units.PIXELS;
    sampler = app.activeDocument.colorSamplers.add([0, 0]);
  }

  sampler.move([x+.5,y+.5]);
  return sampler.color.rgb;
}

function isWhite(rgb) {
  var r = Math.round(rgb.red), 
      g = Math.round(rgb.green), 
      b = Math.round(rgb.blue);

  return r == 255 && g == 255 && b == 255;
}

function hideInverseLayers(layerToKeep) {
  var layers = app.activeDocument.artLayers;
  for(var i = 0; i<layers.length; i++) {
    layers[i].visible = layers[i].name == "Background" || layers[i].name == layerToKeep
  }  
}

function writePondToFile(pond) {
  var file = new File("~/Desktop/"+pond.name+".pond");
  file.open("w");
  file.write(JSON.stringify(pond));
  file.close();  
  alert("ok done");
}

function vec2(x,y) {
  return {x:round(x),y:round(y)};
}

function round(n) {
  return Math.floor(n * 1000) / 1000;
}
