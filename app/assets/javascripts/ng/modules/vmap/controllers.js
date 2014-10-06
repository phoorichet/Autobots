(function(){
  
  var module = angular.module('autobot.vmap.controllers', []);
  
  module.controller('VizThaimapCtrl', [ '$scope', '$log', 'Filters', 'Api',
    function($scope, $log, filters, Api) {

      //This function is sort of private constructor for controller
      //Based on passed argument you can make a call to resource
      $scope.init = function(serviceName, metricAttr){
        $scope.filters = filters || {} ;
        $scope.filters.attr = metricAttr;
        $scope.filters.vspec = { vtype: "line", x: "region", y: metricAttr, date_time: "date_time" };
        $scope.service = Api[serviceName];
      };

      // Watch filter
      $scope.$watchCollection('filters', function(newValue, oldValue){
        $scope.updateViz(newValue);
      });

      $scope.updateViz = function(attrs){
        var attr = attrs.attr,
            formatPercent = d3.format(".2f"),
            monthWeekFormat = d3.time.format("%m-%d");

        var margin = { top: 50, right: 0, bottom: 100, left: 100 },
            width = 780 - margin.left - margin.right,
            height = 1000 - margin.top - margin.bottom,
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

        d3.json("/assets/data/tha_provinces.json", function(error, tha) {
          console.log(tha);

          d3.select('#viz').select('svg').remove(); // clear the existing

          var svg = d3.select("#viz").append("svg")
              .attr("width", width)
              .attr("height", height);

          var projection = d3.geo.albers()
            .center([0, 13.7])
            .rotate([-100.52, 0])
            .parallels([5, 21])
            .scale(3000)
            .translate([width / 2, height / 2]);

          var path = d3.geo.path()
              .projection(projection)
              .pointRadius(2);
          var mapping = {
                      "Amnat Charoen" : "Northeast", 
                      "Ang Thong": "Central", 
                      "Bangkok Metropolis": "Bangkok", 
                      "Buri Ram": "Northeast", 
                      "Chachoengsao": "East", 
                      "Chai Nat": "Central", 
                      "Chaiyaphum": "Northeast", 
                      "Chanthaburi": "East", 
                      "Chiang Mai": "North", 
                      "Chiang Rai": "North", 
                      "Chon Buri": "East", 
                      "Chumphon": "South", 
                      "Kalasin": "Northeast", 
                      "Kamphaeng Phet": "North", 
                      "Kanchanaburi": "Central", 
                      "Khon Kaen": "Northeast", 
                      "Krabi": "South", 
                      "Lampang": "North", 
                      "Lamphun": "North", 
                      "Loei": "Northeast", 
                      "Lop Buri": "Central", 
                      "Mae Hong Son": "North", 
                      "Maha Sarakham": "Northeast", 
                      "Mukdahan": "Northeast", 
                      "Nakhon Nayok": "East", 
                      "Nakhon Pathom": "Central", 
                      "Nakhon Phanom": "Northeast", 
                      "Nakhon Ratchasima": "Northeast", 
                      "Nakhon Sawan": "North", 
                      "Nakhon Si Thammarat": "South", 
                      "Nan": "North", 
                      "Narathiwat": "South", 
                      "Nong Bua Lam Phu": "Northeast", 
                      "Nong Khai": "Northeast", 
                      "Nonthaburi": "Bangkok", 
                      "Pathum Thani": "Bangkok", 
                      "Pattani": "South", 
                      "Phangnga": "South", 
                      "Phatthalung (Songkhla Lake)": "South", 
                      "Phatthalung": "South", 
                      "Phayao": "North", 
                      "Phetchabun": "North", 
                      "Phetchaburi": "Central", 
                      "Phichit": "North", 
                      "Phitsanulok": "North", 
                      "Phra Nakhon Si Ayutthaya": "Central", 
                      "Phrae": "North", 
                      "Phuket": "South", 
                      "Prachin Buri": "East", 
                      "Prachuap Khiri Khan": "Central", 
                      "Ranong": "South", 
                      "Ratchaburi": "Central", 
                      "Rayong": "East", 
                      "Roi Et": "Northeast", 
                      "Sa Kaeo": "East", 
                      "Sakon Nakhon": "Northeast", 
                      "Samut Prakan": "Bangkok", 
                      "Samut Sakhon": "Central", 
                      "Samut Songkhram": "Central", 
                      "Saraburi": "Central", 
                      "Satun": "South", 
                      "Si Sa Ket": "Northeast", 
                      "Sing Buri": "Central", 
                      "Songkhla (Songkhla Lake)": "South", 
                      "Songkhla": "South", 
                      "Sukhothai": "North", 
                      "Suphan Buri": "Central", 
                      "Surat Thani": "South", 
                      "Surin": "Northeast", 
                      "Tak": "North", 
                      "Trang": "South", 
                      "Trat": "East", 
                      "Ubon Ratchathani": "Northeast", 
                      "Udon Thani": "Northeast", 
                      "Uthai Thani": "North", 
                      "Uttaradit": "North", 
                      "Yala": "South", 
                      "Yasothon": "Northeast"
                    }
          
          // Add region as a property
          var subunitObj = tha.objects.subunits.geometries;
          for (var i = subunitObj.length - 1; i >= 0; i--) {
            subunitObj[i].properties.REGION = mapping[subunitObj[i].properties.NAME_1];
          };

          var subunits = topojson.feature(tha, tha.objects.subunits);
          var places = topojson.feature(tha, tha.objects.places);

          svg.selectAll(".subunit")
              .data(subunits.features)
            .enter().append("path")
              .attr("class", function(d) { return "subunit " + d.properties.ENGTYPE_1.toLowerCase() + " "+ d.properties.REGION.toLowerCase() })
              .attr("d", path)


          $scope.service.metric_by_region(attrs, function(data){
            console.log(data);
            if (data.length === 0)
              return;

            var regionMapping = {};
            for (var i = data.length - 1; i >= 0; i--) {
              regionMapping[data[i].x] = data[i].y; 
            };

            var threshold = 95.0;

            function giveMeThecolor(value){
              if (value < 90) {
                return colorbrewer.Reds[9][6];
              }else if (value >= 90 && value < 95) {
                return colorbrewer.YlOrBr[9][3];
              }else if (value >= 95) {
                return colorbrewer.YlGn[9][6];
              }
            }

            svg.selectAll(".subunit")
                .style("fill", function(d) {return giveMeThecolor(regionMapping[d.properties.REGION]) });
            


          }); // end facebook

        }); // end d3.json

      }; // end updateViz

    }
  ]); // end module

  
}).call(this);

