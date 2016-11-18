
var width = 960,
    height = 600,
    centered;

var path = d3.geoPath()
    .projection(null);

var svg = d3.select("#map").append("svg")
    .attr("width", width)
    .attr("height", height);

var color = d3.scaleQuantize()
    .range(d3.schemeBlues[9]);

var g = svg.append("g");

var currentKey = "meanincome";

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


function updateMapColors(key) {
  // Set the domain of the values (the minimum and maximum values of
  // all values of the current key) to the quantize scale.
  
  d3.json("build/bgs.json", function(error, bgs) {
  if (error) return console.error(error);
  color.domain([
    0,
    getMax(bgs.objects.bgs.geometries,key)
  ]);
  d3.select("g")
    .selectAll("path")
    .remove();
  // Update the class (determining the color) of the features.
  g.selectAll("path")
    .attr("id","tracts")
    .data(topojson.feature(bgs, bgs.objects.bgs).features)
    .enter().append("path")
    .attr("class", "tract")
    .attr("d", path)
    .style("fill", function(d) { 
      if (getValueOfData(d.properties) == null) {return "#222222"}
      else if (getValueOfData(d.properties) == 0) {return "#cccccc"}
        else {return color(getValueOfData(d.properties) )};
    })
    .on("click", clicked)
    .append("title")
    .text(function(d) { return "Value: " + getValueOfData(d.properties) + ' ' + currentKey; })
  ;})

  d3.select("#legend")
    .selectAll('ul')
      .remove();
    
                    // build the map legend
    var legend = d3.select('#legend')
      .append('ul')
      .attr('class', 'list-inline');
    
      var keys = legend.selectAll('li.key')
        .data(color.range());
    
        var legend_items = [+color.domain[0], "", "", "", "", "", "", "", +color.domain[1]];
    
        keys.enter().append('li')
          .attr('class', 'key')
          .style('border-top-color', String)
          .text(function (d, i) {
             return legend_items[i];
            });



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

updateMapColors(currentKey);

d3.select('#select-key').on('change', function(a) {
  // Change the current key and call the function to update the colors.
  currentKey = d3.select(this).property('value');
  updateMapColors(currentKey);
});




