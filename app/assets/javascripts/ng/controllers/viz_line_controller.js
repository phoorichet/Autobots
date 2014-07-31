(function(){
  
  var module = angular.module('vizLineController', []);
  
  module.controller('VizLineCtrl', [ '$scope', 'Facebook', 
    function($scope, Facebook) {

      // var start = new Date(gon.metric.start);
      // var stop  = new Date(gon.metric.stop);

      var params = {
            "attr": gon.metric.http_succ_rate
      };
      Facebook.metric(params, function(data){
        console.log(gon.metric);
        data.forEach(function(d) {
          d.date = new Date(d.date_time);
        });
        console.log(data[0]);

        // D3 goes here
        
      var margin = {top: 20, right: 20, bottom: 30, left: 50},
          width = 960 - margin.left - margin.right,
          height = 500 - margin.top - margin.bottom;

      var x = d3.time.scale()
            .domain(d3.extent(data, function(d){ return d.date; }))
            .range([0, width]);

      var y = d3.scale.linear()
            .domain(d3.extent(data, function(d){ return d.http_succ_rate; }))
          .range([height, 0]);

      var xAxis = d3.svg.axis()
            .scale(x)
            .orient("bottom");

      var yAxis = d3.svg.axis()
            .scale(y)
            .orient("left");

      var line = d3.svg.line()
            .x(function(d){ return x(d.date) })
            .y(function(d){ return y(d.http_succ_rate) });

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


      svg.append("path")
            .datum(data)
            .attr("class", "line")
            .attr("d", line);

 
      
        
        /*######### end D3 ######*/

      }); // end facebook


    }
  ]); // end module

  
}).call(this);

