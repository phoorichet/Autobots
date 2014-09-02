(function(){
  
  var module = angular.module('vizForceController', []);
  
  module.controller('VizForceCtrl', [ '$scope', '$log', 'Filters', 'Api',
    function($scope, $log, filters, Api) {

      //This function is sort of private constructor for controller
      //Based on passed argument you can make a call to resource
      $scope.init = function(serviceName, metricAttr){
        console.log("Force controller")
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
            height = 780 - margin.top - margin.bottom,
            format = d3.time.format("%Y-%m-%d"),
            monthLabelFormat = d3.time.format("%b %a %d");

        $scope.service.force(attrs, function(data){
          $log.log(data);
          
          // data.forEach(function(d) {
          //   d.date = new Date(d.date_time);
          //   d.day  = day(d.date);
          //   d.hour = hour(d.date);
          //   d.dayInYear = dayInYear(d.date);
          //   d.dayInYearInt = parseInt(dayInYear(d.date));
          // });

          

          /* ######### D3 goes here ###### */
          var color = d3.scale.category20();

          // Map node type to ordinal scale
          var nodeSizes = d3.scale.ordinal()
              .domain(["RNC", "SGSN", "GGSN"])
              .range([1, 2, 3])

          var force = d3.layout.force()
              .charge(-120)
              .linkDistance(200)
              .size([width, height]);

          var svg = d3.select("#viz").append("svg")
              .attr("width", width)
              .attr("height", height);

          force
              .nodes(data.nodes)
              .links(data.links)
              .start();

          var link = svg.selectAll(".link")
              .data(data.links)
            .enter().append("line")
              .attr("class", "link")
              .style("stroke-width", function(d) { return Math.sqrt(4); });
        
          var node = svg.selectAll(".node")
              .data(data.nodes)
            .enter().append("circle")
              .attr("class", "node")
              .attr("r", function(d) { return 5*nodeSizes(d.node_type); })
              .style("fill", function(d) { return color(d.node_type) })
              .call(force.drag);

          node.append("title")
              .text(function(d) { return d.name; });

          force.on("tick", function() {
            link.attr("x1", function(d) { return d.source.x; })
                .attr("y1", function(d) { return d.source.y; })
                .attr("x2", function(d) { return d.target.x; })
                .attr("y2", function(d) { return d.target.y; });

            node.attr("cx", function(d) { return d.x; })
                .attr("cy", function(d) { return d.y; });
          });

        }); // end $scope.service

      }; // end updateViz

    }
  ]); // end module

  
}).call(this);

