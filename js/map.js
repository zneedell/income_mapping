
var width = 900,
  projwidth = 960,
    height = 600,
    centered;

var margin = {top: 20, right: 40, bottom: 60, left: 60},
    plotwidth = 800 - margin.left - margin.right,
    plotheight = 600 - margin.top - margin.bottom;

// Borrowed from Jason Davies science library https://github.com/jasondavies/science.js/blob/master/science.v1.js
variance = function(x) {
  var n = x.length;
  if (n < 1) return NaN;
  if (n === 1) return 0;
  var mean = d3.mean(x),
      i = -1,
      s = 0;
  while (++i < n) {
    var v = x[i] - mean;
    s += v * v;
  }
  return s / (n - 1);
};

//A test for outliers http://en.wikipedia.org/wiki/Chauvenet%27s_criterion
function chauvenet (x) {
    var dMax = 5;
    var mean = d3.mean(x);
    var stdv = Math.sqrt(variance(x));
    var counter = 0;
    var temp = [];

    for (var i = 0; i < x.length; i++) {
        if(dMax > (Math.abs(x[i] - mean))/stdv) {
            temp[counter] = x[i]; 
            counter = counter + 1;
        }
    };

    return temp
}


var path = d3.geoPath()
    .projection(null);

var albersProjection = d3.geoAlbers()
  .scale( 170000 )
  .rotate( [71.13,0]  )
  .center( [0, 42.35]  )
  .translate( [projwidth/2,height/2] );
var geoPath = d3.geoPath()
    .projection( albersProjection );

var x = d3.scaleLinear()
  .range([margin.left,plotwidth])
  .domain([-1,1]);
    
var y = d3.scaleLinear()
  .range([plotheight,margin.bottom])
  .domain([-1,1]);

var colorBottom = d3.scaleQuantize()
    .range(d3.schemeBlues[9])

var r = d3.scaleSqrt()
  .range([0,7])
  .domain([0,10000]);


var svg = d3.select("#map").append("svg")
    .attr("width", width)
    .attr("id","topmapsvg")
    .attr("height", height);

var svg2 = d3.select("#chart").append("svg")
    .attr("width", plotwidth + margin.left + margin.right)
    .attr("height", plotheight + margin.top + margin.bottom)
    .attr("class", "chart")
    .attr("id","scatterChart")
    .append("g")
    .attr("id","scatterplotgroup")
    .attr("transform",
          "translate(" + margin.left + "," + margin.top + ")");

var xaxis = svg2.append("g")
  .call(d3.axisBottom(x))
  // .attr("transform", "translate(0,350)")
  .attr("transform","translate(0," +plotheight + ")")
var yaxis = svg2.append("g")
  .call(d3.axisLeft(y))
  // .attr("transform", "translate(0,0)")
  .attr("transform","translate(" +margin.left + ",0)")
  // .attr("translate(" + margin.left + "," + margin.top + ")")


var g = svg.append("g");

var currentKey = "households_2009";
var currentKeyX = "median_income_2009";
var currentKeyY = "median_income_2014";

var maxvalue,
  minvalue,
  truemin,
  truemax;


//var mapdata

function getValueOfData(d) {
  return +d[currentKey];
}

function getMaxOfData(d) {
  return d3.max(getValueOfData(d.properties));
}

function getMax(data, prop) {
    var max = -10000000;
    for (var i=0 ; i<data.length ; i++) {
      if (!isNaN(parseInt(data[i]["properties"][prop]))) {
        max = Math.max(parseInt(data[i]["properties"][prop]), max);
      }
    }
    return max;
}

function getMin(data, prop) {
    var min = 10000000;
    for (var i=0 ; i<data.length ; i++) {
      if (!isNaN(parseInt(data[i]["properties"][prop]))) {
        min = Math.min(parseInt(data[i]["properties"][prop]), min);
      }
    }
    return min;
}

    // https://github.com/wbkd/d3-extended
    d3.selection.prototype.moveToFront = function() {  
      return this.each(function(){
        this.parentNode.appendChild(this);
      });
    };

    d3.selection.prototype.moveToBack = function() {  
        return this.each(function() { 
            var firstChild = this.parentNode.firstChild; 
            if (firstChild) { 
                this.parentNode.insertBefore(this, firstChild); 
            } 
        });
    };

function getNiceExtent(data, prop) {
      var result = data.map(function(a) {return a.properties[prop];});
      return d3.extent(chauvenet(result))
}

function getNiceSymmetricalExtent(data, prop) {
      var result = data.map(function(a) {return a.properties[prop];});
      var trueExtent = d3.extent(chauvenet(result))
      return [d3.min([trueExtent[0],-trueExtent[1]]), d3.max([-trueExtent[0],trueExtent[1]])];
}

var activeColorDomain;

  d3.queue()
    // .defer(d3.json,"build/counties.json")
    .defer(d3.json,"build/tract2.json")
    .await(ready);

  // d3.json("build/bgs.json", function(error, bgs) {
  function ready(error,tracts) {
    if (error) return console.error(error);
    var mousebeingheld = false;
    var neighborhoods = svgBottom.append( "g" ).attr( "id", "neighborhoods" );
      neighborhoods.selectAll( "path" )
      .data(topojson.feature(tracts, tracts.objects.tracts).features)
      .enter()
      .append( "path" )
      .attr("class","bottomMapTract")
      .style("stroke", "red")    // set the line colour
      .style("fill", "none")
        .attr( "d", path )
        .attr("transform", function(d) {
           return "translate(-100,-50)translate(-50,-50)"})
        .append("title")
          .text(function(d) {
            d.Count = 0;
            return "Neighborhood: " +
          d.properties.Name
      })
      // neighborhoods.transition()
      //   .attr("transform", "translate(" +0+ "," + 0 + ")"
      //   + "scale(" + 1.1 + ")"
      //   + "translate(" + 0 + ",-100)")
      ;

      // updateFillColor(null)

    function onTractClick(elemData) {
       console.log(elemData)
       var chosenTract = svg.selectAll("path")
          .filter(function(d) {return d.id == elemData.id})
        chosenTract.classed("selected", !chosenTract.classed("selected"))
          // .moveToFront(); 
        // var chosenDot = d3.select(this)
        //   chosenDot.classed("selected", !chosenDot.classed("selected"));
        var chosenDot = d3.selectAll("circle")
          .filter(function(d) {return d.id == elemData.id})
          chosenDot.classed("selected", !chosenDot.classed("selected"))
          .moveToFront();
    }

    function clearTractStatus() {
      svg.selectAll("path")
        .classed("selected", false)
      d3.selectAll("circle")
        .classed("selected", false);
    }


    function updateScatter(KeyX,KeyY,KeyColor) {
      clearTractStatus()
    svg2.selectAll("#dots")
      .remove();
      var result = tracts.objects.tracts.geometries.map(function(a) {return a.properties[KeyX];});
      // x.domain(d3.extent(result))//.nice()
      x.domain(getNiceExtent(tracts.objects.tracts.geometries,KeyX))//.nice()
      var result = tracts.objects.tracts.geometries.map(function(a) {return a.properties[KeyY];});
      // y.domain(d3.extent(result))//.nice()
      y.domain(getNiceExtent(tracts.objects.tracts.geometries,KeyY))//.nice()
      xaxis.call(d3.axisBottom(x))
        // .attr("transform", "translate(0,350)")
      yaxis.call(d3.axisLeft(y))
    allpoints = svg2.append("g")
      .attr("id","dots")
      .selectAll("circle")
      .data(tracts.objects.tracts.geometries)
      .enter()
      .append("circle")
      .attr("class","scatterplot")
      .classed("selected",false)
      .filter(function(d){return d.properties[KeyX] > -1000 && d.properties[KeyX] !== null && d.properties[KeyY] !== null && d.properties[KeyY] > -2000 && d.properties[KeyX] !== 0 && d.properties[KeyY] !== 0})
      .attr("r",function(d) {return r(d.properties.population_2014)})
      .attr("cx", function(d) {return x(d.properties[KeyX])})
      .attr("cy", function(d) {return y(d.properties[KeyY])})
      .attr("id", function(d) {
        return d.id})
      .on("click",onTractClick)
      .on("mouseover", function(d){
          if (mousebeingheld == true)
            {onTractClick(d)}
        })
      .style("fill",function(d) {return color(d.properties[KeyColor])})
       .append("title")
         .text(function(d) {return "coords: " + d.properties[KeyX] + ", " + d.properties[KeyY]})
    svg2.selectAll(".axlabel")
       .remove()
    svg2.append("text")
        .attr("class","axlabel")
        .attr("transform", "rotate(-90)")
        .attr("y", 0)
        .attr("x", -250)
        // .attr("dy", "1em")
        .style("text-anchor", "middle")
        .text(function(d) {return KeyY.replace(/_/g , " ")});
    svg2.append("text")
        .attr("class","axlabel")
        .attr("y", 560)
        .attr("x", 400)
        // .attr("dy", "1em")
        .style("text-anchor", "middle")
        .text(function(d) {return KeyX.replace(/_/g , " ")});
      }

    var color = d3.scaleQuantize()
      // .range(d3.schemeGreens[9])

    function updateColors(key){
      truemin = getMin(tracts.objects.tracts.geometries,key)
      truemax = getMax(tracts.objects.tracts.geometries,key)
      minvalue = d3.min([truemin,0-truemax])
      maxvalue = d3.max([0-truemin,truemax])
      if (key.slice(key.length-6,key.length) == "Change") {
        activeColorDomain = getNiceSymmetricalExtent(tracts.objects.tracts.geometries,key);
        color.domain(getNiceSymmetricalExtent(tracts.objects.tracts.geometries,key))
        .range(d3.schemeRdBu[9]);
      }
      else {
        activeColorDomain = getNiceExtent(tracts.objects.tracts.geometries,key);
        color.domain(getNiceExtent(tracts.objects.tracts.geometries,key))
        .range(d3.schemeBlues[9]);
      };
      d3.select("#legend")
        .selectAll("ul")
        .remove();
      var legend = d3.select('#legend')
        .append('ul')
        .attr('class', 'list-inline');
         var keys = legend.selectAll('li.key')
          .data(color.range());
          var legend_items = [d3.format(",.2r")(activeColorDomain[0]), "", "", "", "", "", "", "", d3.format(",.2r")(activeColorDomain[1])];
          // console.log(activeColorDomain)
          keys.enter().append('li')
            .attr('class', 'key')
            .style('border-top-color', String)
            .text(function (d, i) {
             return legend_items[i];
              });
      return color
    }

    function updateMap(key) {
    clearTractStatus()
    updateColors(key)
    // console.log(topojson.feature(tracts, tracts.objects.tracts).features)
    d3.select("g")
      .selectAll("path")
      .remove();
  // Update the class (determining the color) of the features.
      g.selectAll("path")
        .attr("id","censustracts")
        .data(topojson.feature(tracts, tracts.objects.tracts).features)
        .enter().append("path")
        .attr("class", "censustract")
        .attr("d", path)
        .classed("selected",false)
        .attr("id", function(d) {
          d.properties.selected = false
          return d.id})
        // .attr("selected", function(d) {return false})
        .style("fill", function(d) { 
        if (d.properties.perc_water > 0.5) {return "blue"}
          else if (d.properties[currentKey] == null) {return "grey"}
          // else {return color(getValueOfData(d.properties) )};
          else {return color(+d.properties[currentKey] )};
        })
        .on("click", onTractClick)
        // .on("mouseover", function(d){
        //   if (mousebeingheld == true)
        //     {onTractClick(d)}
        // })
        .append("title")
        .text(function(d) { return "Value: " + d.properties[currentKey]  + ' ' + currentKey; })
       //  .on("mouseover", function(d) {
       //    div.transition()
       //      .duration(200)
       //      .style("opacity", .9);
       //    div.html(
       //      '<a href= "http://google.com">' + // The first <a> tag
       //        'aaaaah' +
       //          "</a>" +                          // closing </a> tag
       //          "<br/>" + "bbbbb")     
       //      .style("left", (d3.event.pageX) + "px")             
       //      .style("top", (d3.event.pageY - 28) + "px");
       // });
  ;}

  d3.select('#select-key').on('change', function(a) {
  // Change the current key and call the function to update the colors.
    currentKey = d3.select(this).property('value');
    updateMap(currentKey);
    updateScatter(currentKeyX,currentKeyY,currentKey);
    })
  d3.select('#select-key-x').on('change', function(a) {
  // Change the current key and call the function to update the colors.
    currentKeyX = d3.select(this).property('value');
    updateScatter(currentKeyX,currentKeyY,currentKey);
    })
  d3.select('#select-key-y').on('change', function(a) {
  // Change the current key and call the function to update the colors.
    currentKeyY = d3.select(this).property('value');
    updateScatter(currentKeyX,currentKeyY,currentKey);
    })

  d3.select("#scatterChart")
    .each(function(d) {
      console.log("loaded something")})
     .on("mousedown",function(a){
      mousebeingheld = !mousebeingheld;
      return mousebeingheld})
     .on("mouseup",function(a){
      mousebeingheld = false;
      return mousebeingheld})
  d3.select("#topmapsvg")
    .each(function(d) {
      console.log("loaded something")})
     .on("mousedown",function(a){
      mousebeingheld = !mousebeingheld;
      return mousebeingheld})
     .on("mouseup",function(a){
      mousebeingheld = false;
      return mousebeingheld})
updateMap(currentKey);
updateScatter(currentKeyX,currentKeyY,currentKey);
updateData(dataKey,timeKey)
  // updateXaxis(currentKeyX);
  // updateYaxis(currentKeyY);
  console.log("first map update")
  return color
}

function clicked(d) {
  var x, y, k;

  if (d && centered !== d) {
    var centroid = path.centroid(d);
    x = centroid[0];
    y = centroid[1];
    k = 3;
    centered = d;
  } else {
    x = width / 2;
    y = height / 2;
    k = 1;
    centered = null;
  }

  g.selectAll("path")
      .classed("active", centered && function(d) { return d === centered; });

  g.transition()
      .duration(750)
      .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")scale(" + k + ")translate(" + -x + "," + -y + ")")
      .style("stroke-width", 1 / k + "px");
}

var neighborhoods_boston = svg.append( "g" ).attr( "id", "neighborhoodsBOS" );
// var topology = topojson.topology(neighborhoods_boston_json)

// svg.insert("path")
//   .datum(topojson.mesh(topology),topology)
//   .attr("d", path);
neighborhoods_boston.selectAll( "path" )
  
  .data( neighborhoods_boston_json.features )
  .enter()
  .append( "path" )
  .attr( "d", geoPath )
  .attr("class", "neighborhood")
  .style("fill-opacity", 0)
  .style("stroke","black")
  .style("stroke-width",1)
  .style("stroke-opacity", 1)
  .append("title")
    .text(function(d) {
    d.Count = 0;
    return "Neighborhood: " +
      d.properties.Name
     });
var neighborhoods_cambridge = svg.append( "g" ).attr( "id", "neighborhoodsCAM" );
neighborhoods_cambridge.selectAll( "path" )
  .data( neighborhoods_cambridge_json.features )
  .enter()
  .append( "path" )
  .attr( "d", geoPath )
  .attr("class", "neighborhood")
  .style("fill-opacity", 0)
  .style("stroke","black")
  .style("stroke-width",1)
  .style("stroke-opacity", 1)
  .append("title")
    .text(function(d) {
    d.Count = 0;
    return "Neighborhood: " +
      d.properties.NAME
     });
// console.log(neighborhoods_boston_json)
// console.log(neighborhoods_cambridge_json)




