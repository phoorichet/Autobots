(function(){
  
  var module = angular.module('vizSankeyController', []);
  
  module.controller('VizSankeyCtrl', [ '$scope', '$log', 'Filters', 'Api',
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
            height = 2000 - margin.top - margin.bottom,
            format = d3.time.format("%Y-%m-%d"),
            monthLabelFormat = d3.time.format("%b %a %d");

        $scope.service.force(attrs, function(data){
          console.log(data);
          var uniqueGroup1 = d3.set(data.links.map(function(d){ return d.metric_value })).values().sort();          
          console.log(uniqueGroup1);

          var test = data.links.filter(function(d) { return (d.metric_value < 80.0 ) });
          console.log(test);
          
          /* ######### D3 goes here ###### */
          var formatNumber = d3.format(",.0f"),
              format = function(d) { return formatNumber(d) + " %"; },
              color = d3.scale.category20();

          var uniqueGroup = d3.set(data.nodes.map(function(d){ return d.node_type === "RNC" ? d.coverage_region : d.site ; })).values().sort();
          color.domain(uniqueGroup);


          // Map node type to ordinal scale
          var nodeSizes = d3.scale.ordinal()
              .domain(["RNC", "SGSN", "GGSN"])
              .range([1, 2, 3])

          var sankey = d3.sankey()
              .nodeWidth(15)
              .nodePadding(5)
              .size([width, height]);

          var path = sankey.link();

          var svg = d3.select("#viz").append("svg")
              .attr("width", width)
              .attr("height", height);

          sankey
              .nodes(data.nodes)
              .links(data.links)
              .layout(32);

          var link = svg.append("g").selectAll(".link")
              .data(data.links)
            .enter().append("path")
              .attr("class", "link")
              .attr("d", path)
              .classed("dropped-link", function(d) { return d.metric_value < 80; })
              .style("stroke-width", function(d) { return d.metric_value < 80 ? 5 : d.value ; })
              .style("stroke", function(d) { return d.metric_value < 80 ? "red" : "black" ; })
              .sort(function(a, b) { return b.dy - a.dy; });

          link.append("title")
              .text(function(d) { return d.source.name + " → " + d.target.name + "\n" + format(d.metric_value); });

          // link.selectAll(".dropped-link")
          //       .style("stroke-width", 5)
          //       .style("stroke", "red");
              // .transition()
              //   .duration(2000)
                
        
          var node = svg.append("g").selectAll(".node")
              .data(data.nodes)
            .enter().append("g")
              .attr("class", "node")
              .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; })
            .call(d3.behavior.drag()
              .origin(function(d) { return d; })
              .on("dragstart", function() { this.parentNode.appendChild(this); })
              .on("drag", dragmove));

          node.append("rect")
              .attr("height", function(d) { return d.dy; })
              .attr("width", sankey.nodeWidth())
              .style("fill", function(d) { return d.color = color(d.node_type === "RNC" ? d.coverage_region : d.site ); })
              .style("stroke", function(d) { return d3.rgb(d.color).darker(2); })
              .classed("below-threshold", function(d) { return d.name === "3SGSNBPL2H" ? true : false ; })
            .append("title")
              .text(function(d) { return d.name + "\n" + format(d.value); });

          node.append("text")
              .attr("x", -6)
              .attr("y", function(d) { return d.dy / 2; })
              .attr("dy", ".35em")
              .attr("text-anchor", "end")
              .attr("transform", null)
              .text(function(d) { return d.name; })
            .filter(function(d) { return d.x < width / 2; })
              .attr("x", 6 + sankey.nodeWidth())
              .attr("text-anchor", "start");

          node.selectAll(".below-threshold")
              .style("stroke", "red")
                .transition()
                  .duration(500)
                  .each(blink);

          function blink(){
            var rect = d3.select(this);
            (function repeat(){
                rect = rect.transition()
                    .attr("stroke-width", 1)
                  .transition()
                    .attr("stroke-width", 5)
                    .each("end", repeat);
            })();
          }

          function dragmove(d) {
            d3.select(this).attr("transform", "translate(" + d.x + "," + (d.y = Math.max(0, Math.min(height - d.dy, d3.event.y))) + ")");
            sankey.relayout();
            link.attr("d", path);
          }

        }); // end $scope.service

      }; // end updateViz

    }
  ]); // end module

  
}).call(this);

