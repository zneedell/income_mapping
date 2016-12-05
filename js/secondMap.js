var map_code = d3.map()
  .set("CMR410.500", "Structural")
  .set("CMR410.200 A", "Utilities")
  .set("CMR410.190", "Utilities")
  .set("CMR410.300", "Utilities")
  .set("CMR410.750 A", "Utilities")
  .set("CMR410.750 B", "Utilities")
  .set("CMR410.750 C", "Utilities")
  .set("CMR410.750 D", "Utilities")
  .set("CMR410.750 E", "Utilities")
  .set("CMR410.750 F", "Maintenance")
  .set("CMR410.750 G", "Fire Safety")
  .set("CMR410.750 H", "Security")
  .set("CMR410.750 I", "Trash")
  .set("CMR410.750 J", "Lead Paint")
  .set("CMR410.750 K", "Structural")
  .set("CMR410.750 L", "Improper Construction")
  .set("CMR410.750 M", "Asbestos")
  .set("CMR410.750 N", "Fire Safety")
  .set("CMR410.750 O", "Maintenance")
  .set("CMR410.750 P", "Maintenance")
  .set("CMR410.180", "Utilities")
  .set("CMR410.602 A", "Trash")
  .set("CMR410.602 B", "Trash")
  .set("CMR410.602 C", "Trash")
  .set("CMR410.602 D", "Trash")
  .set("CMR410.480 E", "Security")
  .set("CMR410.480 B", "Security")
  .set("CMR410.480 D", "Security")
  .set("CMR410.480 B & D", "Security")
  .set("CMR410.600 C", "Trash")
  .set("CMR410.351 A", "Maintenance")
  .set("CMR410.600 B", "Trash")
  .set("CMR410.550 B", "Pests")
  .set("CMR410.201", "Utilities")
  .set("CMR410.354 A", "Utilities")
  .set("CMR410.354 B", "Utilities")
  .set("CMR410.354 C", "Utilities")
  .set("CMR410.354 D", "Utilities")
  .set("CMR410.602 D", "Trash")
  .set("CMR410.482 A", "Fire Safety")
  .set("CMR410.482 B", "Fire Safety")
  .set("CMR410.482 C", "Fire Safety")
  .set("CMR410.501 A", "Maintenance")
  .set("CMR410.452", "Maintenance")
  .set("CMR410.352 A", "Maintenance")
  .set("CMR410.352 B", "Maintenance")
  .set("CMR410.480 A", "Security")
  .set("CMR410.451", "Fire Safety")
  .set("CMR410.810", "Inspection Request")
  .set("CMR410.820", "Inspection Request")
  .set("CMR410.351 B", "Maintenance")
  .set("CMR410.480 F", "Security")
  .set("CMR410.505", "Structural")
  .set("CMR410.551", "Maintenance")
  .set("CMR410.552", "Maintenance")
  .set("CMR410.553", "Maintenance")
  .set("CMR410.253", "Maintenance")
  .set("CMR410.253 A", "Maintenance")
  .set("CMR410.253 B", "Maintenance")
  .set("CMR410.483", "Fire Safety")
  .set("CMR410.350 A", "Utilities")
  .set("CMR410.255", "Utilities")
  .set("CMR410.503 A", "Accessibility")
  .set("CMR410.502", "Lead Paint")
  .set("CMR410.501 B", "Maintenance")
  .set("CMR410.620", "Utilities")
  .set("CMR410.481", "Maintenance")
  .set("CMR410.254 A", "Maintenance")
  .set("CMR410.254 B", "Maintenance")
  .set("CMR410.402", "Improper Construction")
  .set("CMR410.280 A", "Improper Construction")
  .set("CMR410.280 B", "Improper Construction")
  .set("CMR410.280 A & B", "Improper Construction")
  .set("CMR410.503 C", "Accessibility")
  .set("CMR410.503 B", "Accessibility")
  .set("CMR410.250 A", "Improper Construction")
  .set("CMR410.400 A", "Improper Construction")
  .set("CMR410.400 B", "Improper Construction")
  .set("CMR410.400 C", "Improper Construction")
  .set("CMR410.600 A", "Trash")
  .set("CMR410.600 B", "Trash")
  .set("CMR410.600 C", "Trash")
  .set("CMR410.600 D", "Trash")
  .set("CMR410.750 I", "Pests")
  .set("CMR410.450", "Fire Safety")
  .set("CMR410.400", "Maintenance")
  .set("CMR410.484", "Maintenance")
  .set("CMR410.151", "Maintenance")
  .set("CMR410.150 D", "Maintenance")
  .set("CMR410.504 A", "Maintenance")
  .set("CMR410.504 B", "Maintenance")
  .set("CMR410.504 C", "Maintenance")
  .set("CMR410.750 G", "Pests")
  .set("CMR410.750 K", "Pests")
  .set("CMR410.256", "Improper Construction")
  .set("CMR410.200 B", "Fire Safety")
  .set("CMR410.480 C", "Security")
  .set("CMR410.550 A", "Pests")
  .set("CMR410.280 B", "Improper Construction")
  .set("CMR410.482 B", "Fire Safety");

// var width = 1000,
//     height = 750,
//     centered;

var pointClass = null;

var pointDescription = null;

var classSubString = null;
    timeSubString = null;

var dataKey = "Permits";
    timeKey = "in2013";

var counter = 0;

var appTokenString = "$$app_token=cMhQ1bToHzZ7lZd1JuSAlwNke"

var APIstring = "https://data.cityofboston.gov/resource/hfgw-p5wb.json?$$app_token=cMhQ1bToHzZ7lZd1JuSAlwNke&$where=within_circle(location, 42.3, -71.16, 20000) AND declared_valuation > 200000 AND issued_date between '2013-01-01T12:00:00' AND '2014-01-01T12:00:00'"

function updateAPIstring(dataKey,timeKey) {
  if (dataKey == "Permits"){classSubString = "https://data.cityofboston.gov/resource/hfgw-p5wb.json?$$app_token=cMhQ1bToHzZ7lZd1JuSAlwNke&$where=within_circle(location, 42.3, -71.16, 50000) AND declared_valuation > 50000 AND worktype in('ERECT','EXTREN','Service','INTEXT','VIOL','Capital','ADDITION','SITE','RAZE') AND issued_date "}
  else if (dataKey == "Crime")
      {classSubString = "https://data.cityofboston.gov/resource/ufcx-3fdn.json?$$app_token=cMhQ1bToHzZ7lZd1JuSAlwNke&$where=ucrpart in('Part One','Part Two') AND fromdate "}
  else {classSubString = "https://data.cityofboston.gov/resource/w39n-pvs8.json?$$app_token=cMhQ1bToHzZ7lZd1JuSAlwNke&$where=starts_with(code,%20'CMR') AND within_circle(location, 42.3, -71.16, 200000) AND status_dttm "};
  if (timeKey == "Pre2010"){timeSubString = "<'2010-01-01T12:00:00'"}
    else if (timeKey == "in2010")
      {timeSubString = "between '2010-01-01T12:00:00' AND '2011-01-01T12:00:00'"}
    else if (timeKey == "in2011")
      {timeSubString = "between '2011-01-01T12:00:00' AND '2012-01-01T12:00:00'"}
    else if (timeKey == "in2012")
      {timeSubString = "between '2012-01-01T12:00:00' AND '2013-01-01T12:00:00'"}
    else if (timeKey == "in2013")
      {timeSubString = "between '2013-01-01T12:00:00' AND '2014-01-01T12:00:00'"}
    else if (timeKey == "in2014")
      {timeSubString = "between '2014-01-01T12:00:00' AND '2015-01-01T12:00:00'"}
    else if (timeKey == "post2014")
      {timeSubString = "> '2015-01-01T12:00:00'"}
    APIstring = classSubString + timeSubString + "&$limit=5000"
    return APIstring
};

function getClass(dataKey) {
  if (dataKey == "Permits")
      {pointClass = "permittypedescr"}
      // {pointClass = "Neighborhood"}
    // {pointClass = "occupancytype"}
    // {pointClass = "worktype"}
    else if (dataKey == "Crime")
      {pointClass = "weapontype"}
      // {pointClass = "ucrpart"}
    else 
      {pointClass = "code"}
    return pointClass
};

function getDescription(dataKey) {
  if (dataKey == "Permits")
      {pointDescription = "comments"}
    else if (dataKey == "Crime")
      {pointDescription = "incident_type_description"}
    else 
      {pointDescription = "description"}
    // {pointDescription = "code"}
    return pointDescription
};

function classifyPoint(d,dataKey) {
  if (dataKey == "Code") {if (map_code.get(d[pointClass]) == null) {return "other"}
    else {return map_code.get(d[pointClass])}}
        else {
      return d[pointClass]}
}

function isInside(geom, point) {
  // Modified version of d3.polygonInside
  var insideAny = false;
  for (var polyID = 0; polyID < geom.coordinates.length; ++polyID) {
    var polygon = geom.coordinates[polyID];
    if (polygon.length == 1) {polygon = polygon[0]}
    var n = polygon.length,
      x = point[0], y = point[1],
      inside = false;
    var j = n-1;
    for (var i = 0; i < n; i++) {
      var pi = polygon[i],
        pj = polygon[j],
        xi = pi[0],
        yi = pi[1],
        xj = pj[0],
        yj = pj[1];
      j = i;
      if ( ((yi>y) !== (yj>y)) && (x < (xj-xi) * (y-yi) / (yj-yi) + xi) )
       {inside = !inside};
  }
   if (inside) {
    insideAny = true};
   }
  return insideAny;
}

var svgBottom = d3.select( "#map2" )
  .append( "svg" )
  .attr( "width", width -200)
  .attr( "height", height );

var allpermits = svgBottom.append( "g" )
  .attr( "id", "permits" )
  .attr("class","bubble");

var fillColor = d3.scaleQuantize()
  .range(d3.schemeBlues[9])
  .domain([0,200]);

// var albersProjection = d3.geoAlbers()
//   .scale( 190000 )
//   .rotate( [71.057,0] )
//   .center( [0, 42.313] )
//   .translate( [width/2 - 150,height/2] );
// var geoPath = d3.geoPath()
//     .projection( albersProjection );

var selectedType = null;

function updateData(dataKey,timeKey) {

// svgBottom.selectAll("g").remove();
// var neighborhoods = svgBottom.append( "g" ).attr( "id", "neighborhoods" );
// neighborhoods.selectAll( "path" )
//   .data( neighborhoods_boston_json.features )
//   .enter()
//   .append( "path" )
//   .attr( "d", geoPath )
//   .append("title")
//     .text(function(d) {
//     d.Count = 0;
//     return "Neighborhood: " +
//       d.properties.Name
//      });
// svgBottom.selectAll(".legendOriginal")
selectedType = null;
d3.select("#legendBoxBottom")
  .select("#bottomLegend")
  .selectAll("g")
  .remove()
APIstring = updateAPIstring(dataKey,timeKey);
pointClass = getClass(dataKey);
pointDescription = getDescription(dataKey);
var colorDots = d3.scaleOrdinal(d3.schemeCategory20);
d3.json(APIstring,function(error, permitData) {
  if (error) return console.warn(error);

  // d3.select("allpermits")
  allpermits.selectAll("circle")
  .remove();
    allpermits.selectAll( "circle" )
    .data(permitData)
    .enter()
    .append( "circle" )
    // .attr("Neighborhood", function(d) {
    //   var nhood = "bad";
    //   for (var i=0 ; i<neighborhoods_boston_json.features.length ; i++){
    //     var geom = (neighborhoods_boston_json.features[i].geometry);
    //     if (isInside(neighborhoods_boston_json.features[i].geometry, d.location.coordinates)) {
    //       nhood = neighborhoods_boston_json.features[i].properties.Name
    //       neighborhoods_boston_json.features[i].Count = neighborhoods_boston_json.features[i].Count + 1;
    //       };
    //   }
    //   d.Neighborhood = nhood
    //   return nhood
    // })
    .attr("class", function(d){return classifyPoint(d,dataKey)})
    .attr("r", 2)
    .style("stroke","black")
    .style("stroke-width",0)
    .on("mouseover", function()
      {if (selectedType == null) {d3.select(this).attr("r",6)}
      else {d3.select(this).style("fill","black")};
    })
    .on("mouseout", function()
      {if (selectedType == null) {d3.select(this).attr("r",2)}
      else {d3.select(this).style("fill",function(d){return colorDots(classifyPoint(d,dataKey))})};
    })
    .style("fill",function(d){return colorDots(classifyPoint(d,dataKey))})
    .attr("transform", function(d) {
      var projectionTransform = albersProjection([
        d.location.coordinates[0],
        d.location.coordinates[1]
        ]) ;
      projectionTransform[0] = projectionTransform[0] - 100
      projectionTransform[1] = projectionTransform[1] - 50
      // console.log(projectionTransform)
    return "translate(" + projectionTransform+ ")translate(-50,-50)"})
    // .attr("transform", function(d) {
    //   return "translate(0,-100)"})
    .append("title")
    .text(function(d) {
    return "(" + 
      d[pointDescription]
     + ")"
   })
    ;
d3.select("#legendBoxBottom")
  .append("svg")
  .attr("height", height/2)
  .attr("class", "legendBG")
  .append("g")
  .attr("class","legendOrdinal")
  .attr("id", "bottomLegend")



var legendOrdinal = d3.legendColor()
  // .shape("path", d3.symbol().type(d3.symbolTriangle).size(150)())
    .shapePadding(5)
    .labelFormat(d3.format(".2f"))
    .labelOffset(85)
    .scale(colorDots);

d3.select("#bottomLegend")
    // .style("stroke","red")
    .call(legendOrdinal);

// updateFillColor(null)
// onClick(selectedType);
d3.select("#legendBoxBottom")
  .select("#bottomLegend")
  // .selectAll(".cell")
  // .selectAll("g")
  .selectAll("rect")
    .style("stroke","black")
    .style("stroke-width",0)
   .on("mouseover",onMouseOver)
   .on("mouseout",onMouseOut)
   .on("click",onClick);

function onMouseOver(elemData) {
  // console.log(elemData)
  if (selectedType == null) {
  svgBottom.selectAll("circle")
  .filter( function(d) { return classifyPoint(d,dataKey) == elemData;})
  .style("stroke-width",2)
  .style("opacity",0.9)
  .attr("r", 6)
  svgBottom.selectAll("circle")
  .filter( function(d) { return classifyPoint(d,dataKey) != elemData;})
  .style("opacity",0.2)}
}

function onMouseOut(elemData) {
  if (selectedType == null) {
  svgBottom.selectAll("circle")
  .filter( function(d) { return classifyPoint(d,dataKey) == elemData;})
  .style("stroke-width",0)
  .style("opacity",1)
  .attr("r", 2)
  svgBottom.selectAll("circle")
  .filter( function(d) { return classifyPoint(d,dataKey) != elemData;})
  .style("opacity",1)}
}

function updateFillColor(matchMe) {
  var countrange = [];
  // console.log(matchMe)
  svgBottom.selectAll("path")
    .each(function(d) {
      d.properties.Count = 0;
        svgBottom.selectAll("circle")
        .filter( function(d) {
          if(matchMe == null){
            return true}
          else {
        return classifyPoint(d,dataKey) == matchMe;
         }})
        .each(function(f) { 
          if (isInside(d.geometry, albersProjection(f.location.coordinates)))
              {if (d.properties.households_2014 > 0)
              {d.properties.Count = d.properties.Count + 1/d.properties.households_2014}}}

            )
        if (d.properties.Count >= 0 && d.properties.households_2014 >= 200)
        {countrange.push(d.properties.Count)}
      })
      colorBottom.domain(d3.extent(countrange))
     // svgBottom.selectAll("path")
     //    .style("fill",function(d) {return colorBottom(d.properties.Count)})
     //    .style("opacity",0.4)
     //    .moveToBack();
    allpermits.selectAll("circle")
      .moveToFront();

}


// function onMouseOver(elemData) {
//   // console.log(elemData)
//   if (selectedType == null) {
//   svgBottom.selectAll("circle")
//   .filter( function(d) { return classifyPoint(d,dataKey) == elemData;})
//   .style("stroke-width",2)
//   .style("opacity",0.9)
//   .attr("r", 6)
//   svgBottom.selectAll("circle")
//   .filter( function(d) { return classifyPoint(d,dataKey) != elemData;})
//   .style("opacity",0.2)}
// }

function onClick(elemData) {
  if (selectedType == elemData) {
    svgBottom.selectAll("circle")
    .style("stroke-width",0)
    .style("visibility","visible")
    .attr("r", 2)
    .style("opacity",1)
    d3.select(this).style("stroke-width",0)
    updateFillColor(null)
    // svgBottom.selectAll("circle")
    //   .moveToFront();
    selectedType = null}
  else if (selectedType == null) {
    svgBottom.selectAll("circle")
    .filter( function(d) { return classifyPoint(d,dataKey) == elemData;})
    .style("stroke-width",2)
    .style("visibility","visible")
    .style("opacity",0.4)
    .attr("r", 5)
    svgBottom.selectAll("circle")
    .filter( function(d) { return classifyPoint(d,dataKey) != elemData;})
    .style("visibility","hidden")
    .attr("r", 2)
    .style("stroke-width",0)
    d3.select(this).style("stroke-width",3)
    updateFillColor(elemData)
    // svgBottom.selectAll("circle")
    //   .moveToFront();
    selectedType = elemData;
  }
  else {
    svgBottom.selectAll("circle")
    .style("stroke-width",0)
    .style("visibility","visible")
    .attr("r", 2)
    .style("opacity",1)
    svgBottom.selectAll("circle")
    .filter( function(d) { return classifyPoint(d,dataKey) == elemData;})
    .style("stroke-width",2)
    .style("visibility","visible")
    .style("opacity",0.4)
    .attr("r", 5)
    svgBottom.selectAll("circle")
    .filter( function(d) { return classifyPoint(d,dataKey) != elemData;})
    .style("visibility","hidden")
    .style("opacity",1)
    .attr("r", 2)
    .style("stroke-width",0)
    d3.selectAll("rect").style("stroke-width",0)
    d3.select(this).style("stroke-width",3)
    updateFillColor(elemData)
    // svgBottom.selectAll("circle")
    //   .moveToFront();
    selectedType = elemData
  }
  // return selectedType
}


updateFillColor(null)

  });

}
    // .attr("title")
  //   // .text(rodentData.comments)
  //   .on( "click", function(){
  //   d3.select(this).remove();
  // });
  //console.log(rodentData);
  // visualizeit();

d3.select('#select-key-time').on('change', function(a) {
  // Change the current key and call the function to update the colors.
  timeKey = d3.select(this).property('value');
  dataKey = d3.select('#select-key-data').property('value');
  updateData(dataKey,timeKey);
});

d3.select('#select-key-data').on('change', function(a) {
  // Change the current key and call the function to update the colors.
  timeKey = d3.select('#select-key-time').property('value');
  dataKey = d3.select(this).property('value');
  updateData(dataKey,timeKey);
});

// updateData(dataKey,timeKey)