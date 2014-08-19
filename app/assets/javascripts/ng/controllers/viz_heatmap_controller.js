(function(){
  
  var module = angular.module('vizHeatmapController', []);
  
  module.controller('VizHeatmapCtrl', [ '$scope', '$log', 'Filters', 'Api',
    function($scope, $log, filters, Api) {

      //This function is sort of private constructor for controller
      //Based on passed argument you can make a call to resource
      $scope.init = function(serviceName, metricAttr){
        $scope.filters = filters || {} ;
        $scope.filters.attr = metricAttr;
        $scope.service = Api[serviceName];
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
        var attr = attrs.attr,
            formatPercent = d3.format(".2f"),
            monthWeekFormat = d3.time.format("%m-%d");

        var margin = { top: 50, right: 0, bottom: 100, left: 100 },
            width = 960 - margin.left - margin.right,
            height = 1000 - margin.top - margin.bottom,
            gridSize = Math.floor(width / 24),
            legendElementWidth = gridSize*2,
            buckets = 9,
            colors = ["#ffffd9","#edf8b1","#c7e9b4","#7fcdbb","#41b6c4","#1d91c0","#225ea8","#253494","#081d58"], // alternatively colorbrewer.YlGnBu[9]
            // days = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"],
            times = d3.range(24),
            hour = d3.time.format("%H"),
            day = d3.time.format("%d"),
            dayInYear = d3.time.format("%j"),
            week = d3.time.format("%U"),
            month = d3.time.format("%m"),
            percent = d3.format(".1%"),
            format = d3.time.format("%Y-%m-%d"),
            monthLabelFormat = d3.time.format("%b %a %d");

        $scope.service.metric(attrs, function(data){
          $log.log(data);
          
          data.forEach(function(d) {
            d.date = new Date(d.date_time);
            d.day  = day(d.date);
            d.hour = hour(d.date);
            d.dayInYear = dayInYear(d.date);
            d.dayInYearInt = parseInt(dayInYear(d.date));
          });

          var minDay = d3.min(data, function(d){ return d.dayInYearInt; }),
              maxDay = d3.max(data, function(d){ return d.dayInYearInt; });

          var dateRange = d3.extent(data, function(d) { return d.date; });
          console.log(dateRange);
          console.log(d3.time.hours(dateRange[0], dateRange[1]));

          var uniqueGroups = d3.set(data.map(function(v){ return dayInYear(v.date); })).values().sort();

          var dayHourFrequency = uniqueGroups.map(function(d){
            return {
              name: d,
              values: data.filter(function(e){ return d == dayInYear(e.date); }).map(function(d){
                return { dayInYear: d.dayInYear, hour: d.hour, value: d.value, date: d.date }
              })
            };
          });

          $log.debug(dayHourFrequency);

        /* ######### D3 goes here ###### */

        var colorScale = d3.scale.quantile()
              .domain([80, 85, 90, 95, 100])
              .range(colors);

        d3.select('#viz').select('svg').remove(); // clear the existing

        var svg = d3.select("#viz").append("svg")
              .attr("width", width + margin.left + margin.right)
              .attr("height", height + margin.top + margin.bottom)
            .append("g")
              .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        var dayRect = svg.append('g').selectAll(".dayRect")
                .data(d3.time.hours(dateRange[0], dateRange[1]))
              .enter().append("rect")
                .attr("class", ".dayRect")
                .attr("x", function(d) { return (hour(d)) * gridSize; })
                .attr("y", function(d, i) { return (dayInYear(d) - minDay) * gridSize; })
                .attr("width", gridSize)
                .attr("height", gridSize)
                .style("stroke", "#ccc")
                .style("fill", "#ddd")
                .style("fill-opacity", "0.1");


        var dayLabels = svg.append('g').selectAll(".dayLabel")
                .data(dayHourFrequency)
              .enter().append("text")
                .text(function (d) { return monthLabelFormat(d.values[0].date); })
                .attr("x", 0)
                .attr("y", function (d, i) { return i * gridSize; })
                .style("text-anchor", "end")
                .attr("transform", "translate(-6," + gridSize / 1.5 + ")")
                // .attr("class", function (d, i) { return ((i >= 0 && i <= 4) ? "dayLabel mono axis axis-workweek" : "dayLabel mono axis"); });

        var timeLabels = svg.append('g').selectAll(".timeLabel")
              .data(times)
              .enter().append("text")
                .text(function(d) { return d; })
                .attr("x", function(d, i) { return i * gridSize; })
                .attr("y", 0)
                .style("text-anchor", "middle")
                .attr("transform", "translate(" + gridSize / 2 + ", -6)")
                // .attr("class", function(d, i) { return ((i >= 7 && i <= 16) ? "timeLabel mono axis axis-worktime" : "timeLabel mono axis"); });

        var heatMap = svg.append("g").selectAll(".hour")
              .data(data)
            .enter().append("rect")
              .attr("x", function(d) { return (d.hour) * gridSize; })
              .attr("y", function(d, i) { return (d.dayInYear - minDay) * gridSize; })
              .attr("rx", 4)
              .attr("ry", 4)
              .attr("class", "hour bordered")
              .attr("width", gridSize)
              .attr("height", gridSize)
              .style("fill", colors[0]);

        heatMap.transition().duration(1000)
              .style("fill", function(d) { return colorScale(d.value); });

        heatMap.append("title").text(function(d) { return d.value + "," + d.date; });
              
          
        var legend = svg.append("g").selectAll(".legend")
            .data([0].concat(colorScale.quantiles()), function(d) { return d; })
            .enter().append("g")
            .attr("class", "legend");

        legend.append("rect")
          .attr("x", function(d, i) { return legendElementWidth * i; })
          .attr("y", height)
          .attr("width", legendElementWidth)
          .attr("height", gridSize / 2)
          .style("fill", function(d, i) { return colors[i]; });

        legend.append("text")
          .attr("class", "mono")
          .text(function(d) { return "≥ " + Math.round(d); })
          .attr("x", function(d, i) { return legendElementWidth * i; })
          .attr("y", height + gridSize);


        }); // end facebook

      }; // end updateViz


      $scope.updateVizStack = function(attrs){
        $log.log('updateing viz stack...');

        var attr = attrs.attr,
            formatPercent = d3.format(".2f");

        $scope.service.metric(attrs, function(data){
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

        }); // end $scope.service.metric

      }; // end updateViz

    }
  ]); // end module

  
}).call(this);

