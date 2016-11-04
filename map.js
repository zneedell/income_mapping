
var width = 960,
    height = 600,
    centered;

var path = d3.geoPath()
    .projection(null);

var svg = d3.select("#map").append("svg")
    .attr("width", width)
    .attr("height", height);

var color = d3.scaleQuantize()
    .range(d3.schemeBlues[9])
    .domain([0,250000]);

var g = svg.append("g");

var currentKey = "meanincome";

function getValueOfData(d) {
  return +d[currentKey];
}


d3.json("build/bgs.json", function(error, bgs) {
  if (error) return console.error(error);

  // color.domain([
  //     d3.min(bgs, function(d) { return getValueOfData(d); }),
  //     d3.max(bgs, function(d) { return getValueOfData(d); })
  //   ]);

g.append("g")
    .selectAll("path")
    .attr("id","tracts")
    .data(topojson.feature(bgs, bgs.objects.bgs).features)
    .enter().append("path")
    .attr("class", "tract")
    .attr("d", path)
    .style("fill", function(d) { 
      if (getValueOfData(d.properties) == null) {return "#222222"}
      else if (getValueOfData(d.properties) == 0) {return "#cccccc"}
        else {return color(getValueOfData(d.properties) )}; })
    .on("click", clicked)
    .append("title")
      .text(function(d) { return "Value: " + getValueOfData(d.properties); });
});


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