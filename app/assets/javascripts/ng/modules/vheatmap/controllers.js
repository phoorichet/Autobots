(function(){
  
  var module = angular.module('autobot.vheatmap.controllers', []);
  
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
        $scope.updateViz(newValue);
      });

      $scope.updateViz = function(attrs){
        var attr = attrs.attr,
            formatPercent = d3.format(".2f"),
            monthWeekFormat = d3.time.format("%m-%d");

        var margin = { top: 50, right: 0, bottom: 100, left: 100 },
            width = 960 - margin.left - margin.right,
            height = 640 - margin.top - margin.bottom,
            gridSize = Math.floor(width / 24),
            legendElementWidth = gridSize*2,
            buckets = 5,
            // colors = ["#ffffd9","#edf8b1","#c7e9b4","#7fcdbb","#41b6c4","#1d91c0","#225ea8","#253494","#081d58"], // alternatively colorbrewer.YlGnBu[9]
            colors = colorbrewer.YlGnBu[buckets]
            // days = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"],
            times = d3.range(24),
            hour = d3.time.format("%H"),
            day = d3.time.format("%d"),
            dayInYear = d3.time.format("%j"),
            week = d3.time.format("%U"),
            month = d3.time.format("%m"),
            percent = d3.format(".2%"),
            tpFormat = d3.format(".0f,"),
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

          var uniqueGroups = d3.set(data.map(function(v){ return dayInYear(v.date); })).values().sort();

          var dayHourFrequency = uniqueGroups.map(function(d){
            return {
              name: d,
              values: data.filter(function(e){ return d == dayInYear(e.date); }).map(function(v){
                return v;
              })
            };
          });

          $log.debug(dayHourFrequency);

        /* ######### D3 goes here ###### */

        var colorScale = d3.scale.quantile()
              .domain([128, 384, 1000, 2000, 3000])
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

        heatMap.append("title").text(function(d) { return tpFormat(d.value) + " Kbps"; });
              
          
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

    }
  ]); // end module


  /**
   * Heatmap controller for experiment
   */
  module.controller('AdhocHeatmapCtrl', [ '$scope', '$log', 'Filters', 'Api',
    function($scope, $log, filters, Api) {

      //This function is sort of private constructor for controller
      //Based on passed argument you can make a call to resource
      $scope.init = function(serviceName, metricAttr){
        $scope.filters = filters || {} ;
        $scope.filters.attr = metricAttr;
        $scope.service = Api[serviceName];
      };

      $scope.$watchCollection('filters', function(newValue, oldValue){
        $scope.updateViz(newValue);
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

        $scope.service.heatmap(attrs, function(data){
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

          var uniqueGroups = d3.set(data.map(function(v){ return dayInYear(v.date); })).values().sort();

          var dayHourFrequency = uniqueGroups.map(function(d){
            return {
              name: d,
              values: data.filter(function(e){ return d == dayInYear(e.date); }).map(function(v){
                return v;
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

        heatMap.append("title").text(function(d) { return d.service+", "+ d.value + "," + monthLabelFormat(d.date) });
              
          
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

    }
  ]); // end module

  
}).call(this);

