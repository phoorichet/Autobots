(function(){
  
  var module = angular.module('autobot.linechart.controllers', ['autobot.api.services', 'autobot.filter.services']);

  module.controller('LinechartCtrl', ['$scope', 'Api', 'Filters',
    function($scope, Api, Filters){
      /**
       * Initialize  all the variables
       */
      $scope.initialize = function(element, attributes){
        $scope.element     = element;
        
        $scope.name        = attributes.name;
        $scope.description = attributes.description;
        $scope.metricId    = attributes.metricid;
        $scope.width       = attributes.width;
        $scope.height      = attributes.height;
        $scope.region      = attributes.region || null;
        $scope.site        = attributes.site   || null;
        $scope.apn         = attributes.apn    || null;
        $scope.sgsn        = attributes.sgsn   || null;
        $scope.stack       = attributes.stack  || null;
        $scope.attr        = attributes.attr;
        
        $scope.filters     = Filters;
        $scope.service     = attributes.service;
        $scope.serviceApi  = Api[attributes.service];

        // $('.multiselect').multiselect();

        $scope.panel = {
          region_options : ['All', 'North', 'Northeast', 'East', 'Central', 'Bangkok', 'South'],
          site_options: ['All', 'CWD', 'SUK', 'TLS'],
          apn_options: ["All", "internet", "3GGSNSUK11H", "3GGSNCWD7N", "3GGSNCWD5N", "3GGSNSUK8N", "3GGSNSUK9N", "3GGSNCWD2N", "3GGSNSUK7N", "3GGSNSUK4N", "3GGSNCWD8N", "3GGSNSUK6N", "3GGSNSUK3N", "3GGSNCWD11H", "3GGSNSUK5N", "3GGSNCWD3N", "3GGSNCWD6N", "3GGSNSUK2N", "3GGSNCWD4N"],
          stack_options: [ {key: 'None', value: null}, {key: 'RNC', value: 'rncname'}, {key: 'GGSN', value: 'apn'}, {key: 'region', value: 'region'} ],
          sgsn_options: ['All', '3SGSNBPL1H', '3SGSNBPL2H', '3SGSNBPL3H', '3SGSNCMI1H', '3SGSNCWD2H', '3SGSNPLK1H', '3SGSNSNI1H', '3SGSNSUK1H', '3SGSNSUK2H', '3SGSNTWA2H', '3SGSNTWA3H']
        };

      }

      $scope.setRegionFilter = function(region) {
        $scope.region = region === "All" ? null : region;
      };

      $scope.setSiteFilter = function(site) {
        $scope.site = site === "All" ? null : site;
      };

      $scope.setApnFilter = function(apn) {
        $scope.apn = apn === "All" ? null : apn;
      };

      $scope.setStackFilter = function(stack){
        $scope.stack = stack;
      }

      $scope.setSgsnFilter = function(sgsn){
        $scope.sgsn = sgsn === "All" ? null : sgsn;
      }

      $scope.$watchCollection('filters', function(newValue, oldValue){
        console.log("Changed filters");
        $scope.updateViz(newValue);
      });

      $scope.$watch('region', function(newValue, oldValue){
        if(newValue !== oldValue){
          $scope.updateViz(newValue);
        }
      }); 

      $scope.$watch('site', function(newValue, oldValue){
        if(newValue !== oldValue){
          $scope.updateViz(newValue);
        }
      });   

      $scope.$watch('apn', function(newValue, oldValue){
        if(newValue !== oldValue){
          $scope.updateViz(newValue);
        }
      });      

      $scope.$watch('sgsn', function(newValue, oldValue){
        if(newValue !== oldValue){
          $scope.updateViz(newValue);
        }
      });      

      $scope.$watch('stack', function(newValue, oldValue){
        if(newValue !== oldValue){
          $scope.updateViz(newValue);
        }
      });      

      $scope.makeVspecs = function(){
        var opts = {};

        _.each($scope.vspecs, function(d){
          opts[d.name] = d.value;
        })

        return {
          vtype: 'line',
          x: opts['x-axis'],
          y: opts['y-axis'],
          time_series_attribute: opts['time_series_attribute'],
          stack: $scope.stack,
        };
      }

      $scope.updateViz = function(filters){
        var formatPercent = d3.format(".2f");

        var submitFilters = _.clone($scope.filters);
        // Local filters
        submitFilters['id'] = $scope.metricId;
        submitFilters['attr']  = $scope.attr;
        // submitFilters['vspec'] = $scope.makeVspecs();
        submitFilters['filters'] = { region: $scope.region, apn: $scope.apn, sgsn: $scope.sgsn, site: $scope.site };
        console.log(submitFilters);

        $scope.serviceApi.mapreduce(submitFilters, function(data){
          console.log(data);

          var spinner = $scope.element.find("#robot-spinner");
          spinner.remove();
          
          data.forEach(function(d) {
            d.groups.date = new Date(d.groups.date_time);
            // if ($scope.stack === null) {
            //   d.stack = "all";
            // }
          });

        /* ######### D3 goes here ###### */
          
        var margin = {top: 50, right: 300, bottom: 30, left: 50},
            width = $scope.width - margin.left - margin.right,
            height = $scope.height - margin.top - margin.bottom,
            threshold = 85,
            dateFormat = d3.time.format("%x %X");

        var x = d3.time.scale()
              .domain(d3.extent(data, function(d){ return d.groups.date; }))
              .range([0, width]);

        // console.log(d3.extent(data, function(d){ return d.groups.date; }));

        var y = d3.scale.linear()
              // .domain(d3.extent(data, function(d){ return d[attr]; }))
              .domain([0, 100]) // Max at 100%
            .range([height, 0]);

        var xAxis = d3.svg.axis()
              .scale(x)
              .orient("bottom")
              .ticks(d3.time.day, 2);

        var yAxis = d3.svg.axis()
              .scale(y)
              .orient("left");

        var line = d3.svg.line()
              .x(function(d){ return x(d.groups.date); })
              .y(function(d){ return y(d.values.y); });

        var uniqueGroups = d3.set(data.map(function(v){ return v.groups.stack; })).values().sort();

        var color = d3.scale.category10()
              .domain(uniqueGroups);

        // Create a group where each member has unique name attribute.
        var groups = color.domain().map(function(name){
          return {
            name: name,
            // values: data.filter(function(d){ return d.groups.stack === name }).map(function(d){
            values: data.filter(function(d){ return d.groups.stack === name })
          }
        });

        // console.log(groups);

        var container = $scope.element.find(".viz");

        d3.select(container[0]).select('svg').remove(); // clear the existing

        var svg = d3.select(container[0]).append("svg")
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

        // Draw threshold line 
        svg.append("line")
              .attr("class", "threshold-line")
              .style('opacity', 1)
              .attr('x1', 0)
              .attr('y1', y(threshold))
              .attr('x2', width)
              .attr('y2', y(threshold))
              .transition()
                .duration(1500)
                .ease("linear")
                .style('opacity', 1);

        // Draw threshold text at the end of the line
        // svg.append("text")
        //       .attr("x", width)
        //       .attr("y", y(threshold))
        //       .attr("dy", "-0.3em")
        //       .style("text-anchor", "end")
        //       .text("Threshold 85%");

        // Draw a stack of lines
        var lineGroups = svg.selectAll('groups')
              .data(groups)
            .enter().append('g')
              .attr('class', 'groups');

        lineGroups.append("path")
            .attr("class", "line")
            .attr("d", function(d) { return line(d.values); })
            .style("stroke", function(d) { return color(d.name); });

        // draw legend
        var legendSpace = 450 / lineGroups.length; // 450/number of issues (ex. 40) 
        lineGroups.append("rect")
              .attr("width", 10)
              .attr("height", 10)
              .attr("x", width + (margin.right/3) - 15) 
              .attr("y", function (d, i) { return i*(20); })  // spacing
              // .attr("transform", function(d) { return "translate(" + x(d.value.date) + "," + y(d.value.y) + ")"; })
              .attr("fill",function(d) {
                // return d.visible ? color(d.name) : "#F1F1F2"; // If array key "visible" = true then color rect, if not then make it grey 
                return color(d.name); // If array key "visible" = true then color rect, if not then make it grey 
              })
              .attr("class", "legend-box")

        lineGroups.append("text")
              .attr("class", "focus-legend")
              .attr("x", width + (margin.right/3) - 60 )
              .attr("y", function (d, i) { return i*(20); })  // spacing
              .attr("dy", ".65em");

        lineGroups.append("text")
              .attr("x", width + (margin.right/3))
              .attr("y", function (d, i) { return i*(20); })  // spacing
              .attr("dy", ".65em")
              .text(function(d) { return d.name; });

        // lineGroups.append("text")
        //       .datum(function(d) { return {name: d.name, value: d.values[d.values.length - 1]}; })
        //       .attr("transform", function(d) { return "translate(" + x(d.value.date) + "," + y(d.value.y) + ")"; })
        //       .attr("x", 3)
        //       .attr("dy", ".35em")
        //       .text(function(d) { return d.name; });
        

        // Create focusgroup
        // var focusLegend = lineGroups.select("g")
        //       .data(groups)
        //     .enter().append('g')
        //       .attr("class", "focus-legend");

        // focusLegend.append("text")
        //       .attr("class", function(d) { return "tooltip" + " " + d.name; })
        //       .attr("x", width + (margin.right/3) - 10)
        //       .attr("y", function(d, i) { return i*20; })
        //       .attr("dy", ".65em");


        var dots = svg.append('g')
              .attr('class', 'dot-group');
        
        dots.selectAll(".dot")
              .data(data)
            .enter().append("circle")
              .attr("class", "dot")
              .attr("cx", line.x())
              .attr("cy", line.y())
              .attr("r", 1)
              .classed("below-threshold", function(d) { return d.values.y < threshold ? true : false ; });

        svg.selectAll(".below-threshold")
            .transition()
              .duration(500)
              .each(blink);

        var focuses = svg.append("g")
              .attr("class", "focus-group");

        focuses.selectAll(".focus")
              .data(groups)
            .enter().append("circle")
              .attr("r", 4.5)
              .attr("class", function(d){ return "focus "+ d.name; })
              .style("display", "none");

 

        // var focus = svg.append("g")
        //       .attr("class", "focus")
        //       .style("display", "none");

        // focus.append("circle")
        //       .attr("r", 4.5);

        // focus.append("text")
        //       .attr("x", 9)
        //       .attr("dy", "-.35em");

        // Hover line 
        var hoverLineGroup = svg.append("g") 
                  .attr("class", "hover-line");

        var hoverLine = hoverLineGroup // Create line with basic attributes
              .append("line")
                  .attr("id", "hover-line")
                  .attr("x1", 10).attr("x2", 10) 
                  .attr("y1", 0).attr("y2", height + 10)
                  .style("pointer-events", "none") // Stop line interferring with cursor
                  .style("opacity", 1e-6); // Set opacity to zero 

        var hoverDate = hoverLineGroup
              .append('text')
                  .attr("class", "hover-text")
                  .attr("y", -20) // hover date text position
                  .attr("x", width/3) // hover date text position
                  .style("fill", "#E6E7E8");

        svg.append("rect")
              .attr("class", "overlay")
              .attr("width", width)
              .attr("height", height)
              // .on("mouseover", function() { focus.style("display", null); })
              // .on("mouseout", function() { focus.style("display", "none"); })
              .on("mousemove", mousemove)
              .on("mouseout", function() {
                  hoverDate.text(null) // on mouseout remove text for hover date

                  d3.select("#hover-line")
                      .style("opacity", 1e-6); // On mouse out making line invisible
              })
              .on("click", function() { console.log(d3.mouse(this)); });

        var bisectDate = d3.bisector(function(d) { return d.groups.date; }).left;

        function mousemove() {
          // http://bl.ocks.org/DStruths/9c042e3a6b66048b5bd4
          var mouse_x = d3.mouse(this)[0]; // Finding mouse x position on rect
          var graph_x = x.invert(mouse_x); // Mapping mouse x to domain x
          
          d3.select("#hover-line") // select hover-line and changing attributes to mouse position
              .attr("x1", mouse_x) 
              .attr("x2", mouse_x)
              .style("opacity", 1); // Making line visible

          if(data.length > 0){
            var x0 = x.invert(d3.mouse(this)[0]),
                i = bisectDate(data, x0, 1),
                d0 = data[i - 1],
                d1 = data[i],
                d = x0 - d0.groups.date > d1.groups.date - x0 ? d1 : d0;

            var dd = groups.map(function(v){
                var i = bisectDate(v.values, x0, 1),
                    d0 = v.values[i - 1],
                    d1 = v.values[i];

                if (d0 === undefined || d1 === undefined){
                  return {"y": "N/A"};
                }
                    
                var d = x0 - d0.groups.date > d1.groups.date - x0 ? d1 : d0;
              return d;
            });

            // console.log(dd);

            hoverDate.text(dateFormat(d.groups.date));

            d3.selectAll(".focus")
                .data(dd)
                .attr("transform", function(d){ return d.groups === undefined ? null : "translate(" + x(d.groups.date) + "," + y(d.values.y) + ")" })
                .style("display", null);
                // .select("text").text()            

            // focus.attr("transform", "translate(" + x(d.date) + "," + y(d.y) + ")");
            // focus.select("text").text(formatPercent(d.y) + " % " + d.stack + " " + dateFormat(d.date));

            d3.selectAll(".focus-legend")
                .data(dd)
                .text(function(v){ return v.values === undefined ? null : formatPercent(v.values.y); });

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


        function blink(){
          var circle = d3.select(this);
          (function repeat(){
              circle = circle.transition()
                  .attr("r", 5)
                .transition()
                  .attr("r", 1)
                  .each("end", repeat);
          })();
        }

        }); // end $scope.service.metric

      } // UpdateViz


    }
  ]) // end module
}());