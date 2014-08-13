(function(){
  
  var module = angular.module('vizLineController', ['filters', 'facebookService']);
  
  module.controller('VizLineCtrl', [ '$scope', '$log', 'Filters', 'Facebook',
    function($scope, $log, filters, Facebook) {

      //This function is sort of private constructor for controller
      //Based on passed argument you can make a call to resource
      $scope.init = function(metric_attr){
        $log.log("Hello!!");
        $scope.filters = filters || {} ;
        $scope.filters.attr = metric_attr;
      };

      $scope.$watchCollection('filters', function(newValue, oldValue){
        $log.log(newValue);
        if(newValue.stack === "All"){
          $scope.updateViz(newValue);
        }else{
          $scope.updateVizStack(newValue);
        }
      });

      $scope.updateViz = function(attrs){
        $log.log('updateing viz...');

        var attr = attrs.attr,
            formatPercent = d3.format(".2f");

        Facebook.metric(attrs, function(data){
          $log.log(data);
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
              .y(function(d){ return y(d.value); });

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
              .on("click", function() { $log.log(d3.mouse(this)); });

        var bisectDate = d3.bisector(function(d) { return d.date; }).left,
              dateFormat = d3.time.format("%a %b %H:%M");

        function mousemove() {
          if(data.length > 0){
            var x0 = x.invert(d3.mouse(this)[0]),
                i = bisectDate(data, x0, 1),
                d0 = data[i - 1],
                d1 = data[i],
                d = x0 - d0.date > d1.date - x0 ? d1 : d0;
            focus.attr("transform", "translate(" + x(d.date) + "," + y(d.value) + ")");
            focus.select("text").text(formatPercent(d.value) + " % " + dateFormat(d.date));
          }
        }
          /* ######### end D3 ###### */

          // tick();

          function tick(){
            setInterval(function(){
              $log.log('tick...' + data.length);
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

      }; // end updateViz


      $scope.updateVizStack = function(attrs){
        $log.log('updateing viz stack...');

        var attr = attrs.attr,
            formatPercent = d3.format(".2f");

        Facebook.metric(attrs, function(data){
          $log.log(data);
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
              .y(function(d){ return y(d.value); });

        var uniqueGroups = d3.set(data.map(function(v){ return v.group; })).values().sort();

        var color = d3.scale.category10()
              .domain(uniqueGroups);

        var groups = color.domain().map(function(name){
          return {
            name: name,
            values: data.filter(function(d){ return d.group === name }).map(function(d){
              return { date: d.date, value: d.value }
            })
          }
        });

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

        var rnc = svg.selectAll('rcn')
              .data(groups)
            .enter().append('g')
              .attr('class', 'rnc');

        rnc.append("path")
            .attr("class", "line")
            .attr("d", function(d) { return line(d.values); })
            .style("stroke", function(d) { return color(d.name); });

        rnc.append("text")
              .datum(function(d) { return {name: d.name, value: d.values[d.values.length - 1]}; })
              .attr("transform", function(d) { return "translate(" + x(d.value.date) + "," + y(d.value.value) + ")"; })
              .attr("x", 3)
              .attr("dy", ".35em")
              .text(function(d) { return d.name; });


        // var totalLength = rnc.node().getTotalLength();

        // rnc.attr("stroke-dasharray", totalLength + " " + totalLength)
        //     .attr("stroke-dashoffset",  function() { return this.getTotalLength(); })
        //     .transition()
        //       .duration(1500)
        //       .ease("linear")
        //       .attr("stroke-dashoffset", 0);

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
              .on("click", function() { $log.log(d3.mouse(this)); });

        var bisectDate = d3.bisector(function(d) { return d.date; }).left,
              dateFormat = d3.time.format("%a %b %H:%M");

        function mousemove() {
          if(data.length > 0){
            var x0 = x.invert(d3.mouse(this)[0]),
                i = bisectDate(data, x0, 1),
                d0 = data[i - 1],
                d1 = data[i],
                d = x0 - d0.date > d1.date - x0 ? d1 : d0;
            focus.attr("transform", "translate(" + x(d.date) + "," + y(d.value) + ")");
            focus.select("text").text(formatPercent(d.value) + " % " + d.group+ " " + dateFormat(d.date));
          }
        }
          /* ######### end D3 ###### */

        //   // tick();

        //   function tick(){
        //     setInterval(function(){
        //       $log.log('tick...' + data.length);
        //       // redraw path, shift path left
        //       path.attr("d", line)
        //           .attr("transform", null)
        //           .transition()
        //           // .duration(500)
        //           .ease("linear")
        //           // .attr("transform", "translate(" + x(-1) + ")")
        //           .each("end", tick);

        //       data.shift();
        //     }, 1000);
        //   }

        }); // end facebook

      }; // end updateViz

    }
  ]); // end module

  
}).call(this);

