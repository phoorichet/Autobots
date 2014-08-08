(function(){
  
  var module = angular.module('vizLineController', ['filters', 'facebookService']);
  
  module.controller('VizLineCtrl', [ '$scope', 'Filters', 'Facebook', 
    function($scope, filters, Facebook) {

      $scope.filters = filters || {} ;
      $scope.filters.attr = gon.metric.attr;

      console.log("Hello!!");

      $scope.$watchCollection('filters', function(newValue, oldValue){
        console.log(newValue);
        $scope.updateViz(newValue);
      });

      $scope.updateViz = function(attrs){
        console.log('updateing viz...');

        var attr = attrs.attr,
            formatPercent = d3.format(".2f");

        Facebook.metric(attrs, function(data){
          console.log(data);
          // Calculate the date
          data.forEach(function(d) {
            d.date = new Date(d.date_time);
          });

        /* ######### D3 goes here ###### */
          
        var margin = {top: 20, right: 20, bottom: 30, left: 50},
            width = 960 - margin.left - margin.right,
            height = 500 - margin.top - margin.bottom;

        var x = d3.time.scale()
              .domain(d3.extent(data, function(d){ return d.date; }))
              .range([0, width]);

        var y = d3.scale.linear()
              // .domain(d3.extent(data, function(d){ return d[attr]; }))
              .domain([0, 100])
            .range([height, 0]);

        var xAxis = d3.svg.axis()
              .scale(x)
              .orient("bottom")
              .ticks(d3.time.day, 2);

        var yAxis = d3.svg.axis()
              .scale(y)
              .orient("left");

        var line = d3.svg.line()
              .x(function(d){ return x(d.date); })
              .y(function(d){ return y(d[attr]); });

        d3.select('#viz').select('svg').remove(); // clear the existing

        var svg = d3.select("#viz").append("svg")
              .attr("width", width + margin.left + margin.right)
              .attr("height", height + margin.top + margin.bottom)
            .append("g")
              .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        svg.append("g")
              .attr("class", "x axis")
              .attr("transform", "translate(0," + height + ")")
              .call(xAxis);

        svg.append("g")
              .attr("class", "y axis")
              .call(yAxis)
            .append("text")
              .attr("transform", "rotate(-90)")
              .attr("y", 6)
              .attr("dy", ".71em")
              .style("text-anchor", "end")
              .text("%");


        var path = svg.append("path")
              .datum(data)
              .attr("class", "line")
              .attr("d", line);

        var totalLength = path.node().getTotalLength();

        path.attr("stroke-dasharray", totalLength + " " + totalLength)
            .attr("stroke-dashoffset",  function() { return this.getTotalLength(); })
            .transition()
              .duration(1500)
              .ease("linear")
              .attr("stroke-dashoffset", 0);

        var dots = svg.append('g')
            .attr('class', 'dot-group');
        
        dots.selectAll(".dot")
              .data(data)
            .enter().append("circle")
              .attr("class", "dot")
              .attr("cx", line.x())
              .attr("cy", line.y())
              .attr("r", 1);

        var focus = svg.append("g")
              .attr("class", "focus")
              .style("display", "none");

        focus.append("circle")
              .attr("r", 4.5);

        focus.append("text")
              .attr("x", 9)
              .attr("dy", "-.35em");

        svg.append("rect")
              .attr("class", "overlay")
              .attr("width", width)
              .attr("height", height)
              .on("mouseover", function() { focus.style("display", null); })
              .on("mouseout", function() { focus.style("display", "none"); })
              .on("mousemove", mousemove)
              .on("click", function() { console.log(d3.mouse(this)); });

        var bisectDate = d3.bisector(function(d) { return d.date; }).left,
              dateFormat = d3.time.format("%a %b %H:%M");

        function mousemove() {
          if(data.length > 0){
            var x0 = x.invert(d3.mouse(this)[0]),
                i = bisectDate(data, x0, 1),
                d0 = data[i - 1],
                d1 = data[i],
                d = x0 - d0.date > d1.date - x0 ? d1 : d0;
            focus.attr("transform", "translate(" + x(d.date) + "," + y(d[attr]) + ")");
            focus.select("text").text(formatPercent(d[attr]) + " % " + dateFormat(d.date));
          }
        }
          /* ######### end D3 ###### */

          // tick();

          function tick(){
            setInterval(function(){
              console.log('tick...' + data.length);
              // redraw path, shift path left
              path.attr("d", line)
                  .attr("transform", null)
                  .transition()
                  // .duration(500)
                  .ease("linear")
                  // .attr("transform", "translate(" + x(-1) + ")")
                  .each("end", tick);

              data.shift();
            }, 1000);
          }

        }); // end facebook

      };

    }
  ]); // end module

  
}).call(this);

