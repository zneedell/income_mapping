
var width = 960,
    height = 600,
    centered;

var path = d3.geoPath()
    .projection(null);

var svg = d3.select("#map").append("svg")
    .attr("width", width)
    .attr("height", height);

var g = svg.append("g");

var currentKey = "meanincome";

var maxvalue

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

var div = d3.select("body").append("div") 
    .attr("class", "tooltip")       
    .style("opacity", 0);


function updateMapColors(key) {
  // Set the domain of the values (the minimum and maximum values of
  // all values of the current key) to the quantize scale.

  var color = d3.scaleQuantize()
    .range(d3.schemeBlues[9]);

  d3.select(".container")
    // .select(".legend")
    .selectAll("ul")
      .remove();

  d3.queue()
    // .defer(d3.json,"build/bgs.json")
    .defer(d3.json,"build/tracts.json")
    .await(ready);

  // d3.json("build/bgs.json", function(error, bgs) {
  function ready(error,tracts) {
    if (error) return console.error(error);



    d3.select("g")
      .selectAll("path")
      .remove();
  // Update the class (determining the color) of the features.
      g.selectAll("path")
        .attr("id","censustracts")
        .data(topojson.feature(tracts, tracts.objects.tracts).features)
        .enter().append("path")
        .attr("class", "censustract")
        .attr("d", path);
            minvalue = getMin(tracts.objects.tracts.geometries,key)
            maxvalue = getMax(tracts.objects.tracts.geometries,key)

            color.domain([
              minvalue,
              maxvalue
            ]);
      g.selectAll("path")
        .style("fill", function(d) { 
        if (getValueOfData(d.properties) == null) {return "#222222"}
          else if (getValueOfData(d.properties) == 0) {return color(0)}
          // else {return color(getValueOfData(d.properties) )};
          else {return color(+d.properties[currentKey] )};
        })
        .on("click", clicked)
        .append("title")
        .text(function(d) { return "Value: " + color.range + ' ' + currentKey; })
        .on("mouseover", function(d) {
          div.transition()
            .duration(200)
            .style("opacity", .9);
          div.html(
            '<a href= "http://google.com">' + // The first <a> tag
              'aaaaah' +
                "</a>" +                          // closing </a> tag
                "<br/>" + "bbbbb")     
            .style("left", (d3.event.pageX) + "px")             
            .style("top", (d3.event.pageY - 28) + "px");
       });

    g.append("path")
      .datum(topojson.mesh(tracts))
      .attr("class", "censustracts")
      .attr("d", path);
  ;}


    
                    // build the map legend
    var legend = d3.select('#legend')
      .append('ul')
      .attr('class', 'list-inline');
    
      var keys = legend.selectAll('li.key')
        .data(color.range());
    
        var legend_items = [+minvalue, "", "", "", "", "", "", "", +maxvalue];
    
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

d3.select('#select-key').on('change', function(a) {
  // Change the current key and call the function to update the colors.
  currentKey = d3.select(this).property('value');
  updateMapColors(currentKey);
});



updateMapColors(currentKey);


