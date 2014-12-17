'use strict';

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
        $scope.threshold   = attributes.threshold;
        $scope.domain_min  = parseFloat(attributes.domainmin);
        $scope.domain_max  = parseFloat(attributes.domainmax);

        $scope.default_threshold = 85;
        
        $scope.filters     = Filters;
        $scope.service     = attributes.service;
        $scope.serviceApi  = Api[attributes.service];

        $scope.spinner     = element.find("#robot-spinner");

        // $('.multiselect').multiselect();

        $scope.panel = {
          region_options : [
            {name: 'North', ticked: true}, 
            {name: 'Northeast', ticked: true}, 
            {name: 'East', ticked: true}, 
            {name: 'Central', ticked: true}, 
            {name: 'Bangkok', ticked: true}, 
            {name: 'South', ticked: true}
          ],
          site_options: [
            {name: "All", ticked: false}, 
            {name: 'CWD', ticked: false}, 
            {name: 'SUK', ticked: false}, 
            {name: 'TLS', ticked: false}
          ],
          apn_options: [
            {name: "internet", ticked: true}, 
            {name: "3GGSNSUK11H", ticked: true}, 
            {name: "3GGSNCWD7N", ticked: true}, 
            {name: "3GGSNCWD5N", ticked: true}, 
            {name: "3GGSNSUK8N", ticked: true}, 
            {name: "3GGSNSUK9N", ticked: true}, 
            {name: "3GGSNCWD2N", ticked: true}, 
            {name: "3GGSNSUK7N", ticked: true}, 
            {name: "3GGSNSUK4N", ticked: true}, 
            {name: "3GGSNCWD8N", ticked: true}, 
            {name: "3GGSNSUK6N", ticked: true}, 
            {name: "3GGSNSUK3N", ticked: true}, 
            {name: "3GGSNCWD11H", ticked: true}, 
            {name: "3GGSNSUK5N", ticked: true}, 
            {name: "3GGSNCWD3N", ticked: true}, 
            {name: "3GGSNCWD6N", ticked: true}, 
            {name: "3GGSNSUK2N", ticked: true}, 
            {name: "3GGSNCWD4N", ticked: true}
          ],
          sgsn_options: [
            {name: '3SGSNBPL1H', ticked: true}, 
            {name: '3SGSNBPL2H', ticked: true}, 
            {name: '3SGSNBPL3H', ticked: true}, 
            {name: '3SGSNCMI1H', ticked: true}, 
            {name: '3SGSNCWD2H', ticked: true}, 
            {name: '3SGSNPLK1H', ticked: true}, 
            {name: '3SGSNSNI1H', ticked: true}, 
            {name: '3SGSNSUK1H', ticked: true}, 
            {name: '3SGSNSUK2H', ticked: true}, 
            {name: '3SGSNTWA2H', ticked: true}, 
            {name: '3SGSNTWA3H', ticked: true}
          ],
          stack_options: [ 
            {key: 'None', value: null}, 
            {key: 'RNC', value: 'rncname'}, 
            {key: 'GGSN', value: 'apn'}, 
            {key: 'region', value: 'region'} 
          ],

        };

      }

      $scope.refreshSiteFilter = function(){
        var d = $scope.panel.site_options
                    .filter(function(d){ return d.ticked === true; })
                    .map(function(d){ return d.name });

        // Only allow single value for site
        if(d.length > 0){
          $scope.site = d[0];
        }
      }

      $scope.refreshApnFilter = function(){
        $scope.apn = $scope.panel.apn_options
                    .filter(function(d){ return d.ticked === true; })
                    .map(function(d){ return d.name });
        // if(d.length > 0){
        //   $scope.apn = d;
        // }
      }

      $scope.refreshRegionFilter = function(){
        $scope.region = $scope.panel.region_options
                    .filter(function(d){ return d.ticked === true; })
                    .map(function(d){ return d.name });
        // if(d.length > 0){
        //   $scope.region = d;
        // }
      }

      $scope.refreshSgsnFilter = function(){
        $scope.sgsn = $scope.panel.sgsn_options
                    .filter(function(d){ return d.ticked === true; })
                    .map(function(d){ return d.name });
        // if(d.length > 0) {
        //   $scope.sgsn = d;
        // }
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
        $scope.updateViz(newValue);
      });

      $scope.$watchCollection('region', function(newValue, oldValue){
        if(newValue !== oldValue){
          $scope.updateViz(newValue);
        }
      }); 

      $scope.$watch('site', function(newValue, oldValue){
        if(newValue !== oldValue){
          $scope.updateViz(newValue);
        }
      });   

      $scope.$watchCollection('apn', function(newValue, oldValue){
        if(newValue !== oldValue){
          $scope.updateViz(newValue);
        }
      });      

      $scope.$watchCollection('sgsn', function(newValue, oldValue){
        if(newValue !== oldValue){
          $scope.updateViz(newValue);
        }
      });      

      $scope.$watch('stack', function(newValue, oldValue){
        if(newValue !== oldValue){
          $scope.updateViz(newValue);
        }
      });

      $scope.getThreshold = function(){
        if ( parseInt($scope.threshold) !== NaN){
          return parseInt($scope.threshold);
        }else if(parseFloat($scope.threshold) !== NaN){
          return parseFloat($scope.threshold);
        }
        return $scope.default_threshold;
      }

      $scope.updateViz = function(filters){
        // Create static content for the page first
        var margin = {top: 50, right: 300, bottom: 130, left: 50},
          margin2 = {top: 400, right: 10, bottom: 20, left: 50},
          width = $scope.width - margin.left - margin.right,
          height = $scope.height - margin.top - margin.bottom, //500-50-50 = 400
          height2 = $scope.height - margin2.top - margin2.bottom, //500-400-20 = 80
          threshold = $scope.getThreshold(),
          dateFormat = d3.time.format("%x %X"),
          formatPercent = d3.format(".2f");

        var customTimeFormat = d3.time.format.multi([
          [".%L", function(d) { return d.getMilliseconds(); }],
          [":%S", function(d) { return d.getSeconds(); }],
          ["%I:%M", function(d) { return d.getMinutes(); }],
          ["%I %p", function(d) { return d.getHours(); }],
          ["%a %d", function(d) { return d.getDay() && d.getDate() != 1; }],
          ["%b %d", function(d) { return d.getDate() != 1; }],
          ["%B", function(d) { return d.getMonth(); }],
          ["%Y", function() { return true; }]
        ]);

        var container = $scope.element.find(".viz");

        d3.select(container[0]).select('svg').remove(); // clear the existing

        var svg = d3.select(container[0]).append("svg")
              .attr("width", width + margin.left + margin.right)
              .attr("height", height + margin.top + margin.bottom);

        svg.append("defs").append("clipPath")
                .attr("id", "clip")
              .append("rect")
                .attr("width", width)
                .attr("height", height);

        var main = svg.append("g")
              .attr("class", "main")
              .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        // Local filters 
        var submitFilters = _.clone($scope.filters);
        submitFilters['id'] = $scope.metricId;
        submitFilters['attr']  = $scope.attr;
        submitFilters['filters'] = { region: $scope.region, apn: $scope.apn, sgsn: $scope.sgsn, site: $scope.site };
        // console.log(submitFilters);

        $scope.spinner.removeClass("hide");

        $scope.serviceApi.mapreduce(submitFilters, function(data){
          // console.log(data);

          $scope.spinner.addClass("hide");
          
          data.forEach(function(d) {
            d.groups.date = new Date(d.groups.date_time);
          });

          /* ######### D3 goes here ###### */
            
          var x = d3.time.scale()
                .domain(d3.extent(data, function(d){ return d.groups.date; }))
                .range([0, width]);

          var x2 = d3.time.scale()
                .domain(d3.extent(data, function(d){ return d.groups.date; }))
                .range([0, width]);

          // Test domain_min, domain_max
          if (isNaN($scope.domain_min)){
            $scope.domain_min = d3.min(data, function(d){ return d.values.y; });
          }

          if (isNaN($scope.domain_max)){
            $scope.domain_max = d3.max(data, function(d){ return d.values.y; });
          }

          var y = d3.scale.linear()
                // .domain(d3.extent(data, function(d){ return d[attr]; }))
                .domain([$scope.domain_min, $scope.domain_max]) // Max at 100%
              .range([height , 0]);

          var y2 = d3.scale.linear()
                .domain([$scope.domain_min, $scope.domain_max])
              .range([height2, 0]);

          var xAxis = d3.svg.axis()
                .scale(x)
                .orient("bottom")
                .ticks(d3.time.day, 1)
                .tickFormat(d3.time.format('%e/%m/%y'))
                .innerTickSize(-height)
                .outerTickSize(0)
                .tickPadding(10);

          var xAxis2 = d3.svg.axis()
                .scale(x2)
                .orient("bottom")
                .ticks(d3.time.day, 1);

          var yAxis = d3.svg.axis()
                .scale(y)
                .orient("left")
                .innerTickSize(-width)
                .outerTickSize(0)
                .tickPadding(10);

          var brush = d3.svg.brush()
                .x(x2)
                .on("brush", brushed);

          // Bind data here
          var line = d3.svg.line()
                .x(function(d){ return x(d.groups.date); })
                .y(function(d){ return y(d.values.y); });

          var line2 = d3.svg.line()
                .x(function(d){ return x2(d.groups.date); })
                .y(function(d){ return y2(d.values.y); });

          var uniqueGroups = d3.set(data.map(function(v){ return v.groups.stack; })).values().sort();

          var color = d3.scale.category20()
                .domain(uniqueGroups);

          // Create a group where each member has unique name attribute.
          var groups = color.domain().map(function(name){
            return {
              name: name,
              // values: data.filter(function(d){ return d.groups.stack === name }).map(function(d){
              values: data.filter(function(d){ return d.groups.stack === name })
            }
          });
          
          main.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height  + ")")
                .call(xAxis);

          main.append("g")
                .attr("class", "y axis")
                .call(yAxis)
              .append("text")
                .attr("transform", "rotate(-90)")
                .attr("y", 6)
                .attr("dy", ".71em")
                .style("text-anchor", "end")
                .text("%");

          // Draw threshold line 
          main.append("line")
                .attr("class", "threshold-line")
                .style('opacity', 1)
                .attr('x1', 0)
                .attr('y1', y(threshold))
                .attr('x2', width)
                .attr('y2', y(threshold))
                .attr('stroke-dasharray', "5,5");

          // Threshold text
          main.append('text')
                .attr('x', 10)
                .attr('y', y(threshold))
                .attr("dy", "-.2em")
                .attr('class', 'threshold-text')
                .text("threshold=" + threshold);

          // Draw a stack of lines
          var lineGroups = main.selectAll('groups')
                .data(groups)
              .enter().append('g')
                .attr('class', 'groups');

          lineGroups.append("path")
              .attr("class", "lock line")
              .attr("d", function(d) { return line(d.values); })
              .style("stroke", function(d) { return color(d.name); })
              .style("clip-path", "url(#clip)");

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

          var dots = main.append('g')
                .attr('class', 'dot-group')
                .style("clip-path", "url(#clip)");
          
          dots.selectAll(".dot")
                .data(data)
              .enter().append("circle")
                .attr("class", "lock dot")
                .attr("cx", line.x())
                .attr("cy", line.y())
                .attr("r", 1)
                .classed("below-threshold", function(d) { return d.values.y < threshold ? true : false ; });

          main.selectAll(".below-threshold")
              .transition()
                .duration(500)
                .each(blink);

          var focuses = main.append("g")
                .attr("class", "focus-group");

          focuses.selectAll(".focus")
                .data(groups)
              .enter().append("circle")
                .attr("r", 4.5)
                .attr("class", function(d){ return "focus "+ d.name; })
                .style("display", "none");

          // Hover line 
          var hoverLineGroup = main.append("g") 
                    .attr("class", "hover-line-group");

          var hoverLine = hoverLineGroup // Create line with basic attributes
                .append("line")
                    .attr("class", "hover-line")
                    .attr("x1", 10).attr("x2", 10) 
                    .attr("y1", 0).attr("y2", height + 10)
                    .style("pointer-events", "none") // Stop line interferring with cursor
                    .style("opacity", 1e-6); // Set opacity to zero 

          var hoverDate = hoverLineGroup
                .append('text')
                    .attr("class", "hover-text")
                    .attr("y", -20) // hover date text position
                    .attr("x", width/3); // hover date text position

          main.append("rect")
                .attr("class", "overlay")
                .attr("width", width)
                .attr("height", height)
                // .on("mouseover", function() { focus.style("display", null); })
                // .on("mouseout", function() { focus.style("display", "none"); })
                .on("mousemove", mousemove)
                .on("mouseout", function() {
                    hoverDate.text(null); // on mouseout remove text for hover date
                    d3.select("#hover-line")
                        .style("opacity", 1e-6); // On mouse out making line invisible

                    d3.selectAll(".focus").style("display", "none");
                })
                .on("click", function() { console.log(d3.mouse(this)); });

          var bisectDate = d3.bisector(function(d) { return d.groups.date; }).left;

          var context = svg.append("g")
                .attr("class", "context")
                .attr("transform", "translate(" + margin2.left + "," + margin2.top + ")");

          var contextLine = context.selectAll('context-groups')
                .data(groups)
              .enter().append('g')
                .attr('class', 'context-groups');

          contextLine.append("path")
                .attr("class", "line")
                .attr("d", function(d) { return line2(d.values); })
                .style("stroke", function(d) { return color(d.name); });

          context.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height2 + ")")
                .call(xAxis2);

          context.append("g")
                .attr("class", "x brush")
                .call(brush)
              .selectAll("rect")
                .attr("y", -6)
                .attr("height", height2 + 7);

          function brushed() {
            // console.log(brush.extent())
            x.domain(brush.empty() ? x2.domain() : brush.extent());
            main.selectAll('.lock.line').attr("d", function(d) { return line(d.values); })
            dots.selectAll('.lock.dot')
                  .attr("cx", line.x())
                  .attr("cy", line.y())
                  .attr("r", 1)
            main.select(".x.axis").call(xAxis);
          }

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
                  .text(function(v){ return v.values === undefined ? null : formatPercent(v.values.y); })
                  .classed("legend-below-threshold", function(d) { return d.values.y < threshold ? true : false ; });;

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
            // var circle = d3.select(this);
            // (function repeat(){
            //     circle = circle.transition()
            //         .attr("r", 5)
            //       .transition()
            //         .attr("r", 1)
            //         .each("end", repeat);
            // })();
          }

        }, function(error){
          $scope.spinner.addClass("hide");
          svg.append('text')
              .attr('x', width/2)
              .attr('y', height/2)
              .attr('class', 'text-error')
              .text('Could not load the content!')
              .append('tspan')
                .attr('x', width/2+ 16)
                .attr('y', height/2 + 16)
                .text(error.statusText);

          console.log(error.statusText);
        }); // end $scope.service.metric

      } // UpdateViz

    }
  ]) // end module
}());