'use strict';

(function(){
  
  var module = angular.module('autobot.regionmap.controllers', ['autobot.api.services', 'autobot.filter.services']);

  module.controller('RegionmapCtrl', ['$scope', 'Api', 'Filters',
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
        $scope.attr        = attributes.attr;
        
        $scope.filters     = Filters;
        $scope.service     = attributes.service;
        $scope.serviceApi  = Api[attributes.service];

        $scope.spinner     = element.find("#robot-spinner");
      }

      $scope.$watchCollection('filters', function(newValue, oldValue){
        $scope.updateViz(newValue);
      });

      $scope.$watchCollection('region', function(newValue, oldValue){
        if (newValue !== oldValue) {
          $scope.updateViz(newValue);
        }
      });      

      $scope.mapping = {
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
      };

      $scope.updateViz = function(filters){
        var formatPercent = d3.format(".2f"),
            monthWeekFormat = d3.time.format("%m-%d");

        var margin = { top: 50, right: 0, bottom: 100, left: 100 },
            width  = $scope.width - margin.left - margin.right,
            height = $scope.height - margin.top - margin.bottom;

        var container = $scope.element.find(".viz");

        d3.select(container[0]).select('svg').remove(); // clear the existing

        var svg = d3.select(container[0]).append("svg")
            .attr("width", width)
            .attr("height", height);

        var projection = d3.geo.albers()
          .center([0, 13.7])
          .rotate([-100.60, 0])
          .parallels([5, 21])
          .scale(1000)
          .translate([width / 2, height / 2]);

        function adjustProject(region, projection){
          var proj = projection;

          switch(region) {
            case "North":
              proj = projection.center([0, 17.5]);
              break;
            case "Northeast":
              proj = projection.center([0, 16]);
              break;
            case "Central":
              proj = projection.center([0, 14]);
              break;
            case "Bangkok":
              proj = projection.center([0.2, 13.8]);
              proj = projection.scale(6000);
              break;
            case "East":
              // proj = projection.center([0, 14]);
              break;
            case "South":
              proj = projection.center([0, 8]);
              break;
            default:
              break;
          }

          return proj;
        }

        projection = adjustProject($scope.region, projection);

        var path = d3.geo.path()
            .projection(projection)
            .pointRadius(2);

        $scope.spinner.removeClass("hide");

        d3.json("/assets/data/tha_provinces.json", function(error, tha) {
          // console.log($scope.filters);

          // Add region as a property
          var subunitObj = tha.objects.subunits.geometries;
          for (var i = subunitObj.length - 1; i >= 0; i--) {
            subunitObj[i].properties.REGION = $scope.mapping[subunitObj[i].properties.NAME_1];
          };

          if ($scope.region != null){
            var interestedSubunits = tha.objects.subunits.geometries.filter(function(d) { return d.properties.REGION === $scope.region; })
            // console.log(interestedSubunits);

            // Reassign subunit with only interested subunits
            tha.objects.subunits.geometries = interestedSubunits;
          }

          var subunits = topojson.feature(tha, tha.objects.subunits);
          var places = topojson.feature(tha, tha.objects.places);

          svg.selectAll(".subunit")
              .data(subunits.features)
            .enter().append("path")
              .attr("class", function(d) { return "subunit " + d.properties.ENGTYPE_1.toLowerCase() + " "+ d.properties.REGION.toLowerCase() })
              .attr("d", path);

          // Modify filter so that it is local
          var submitFilters = _.clone($scope.filters);
          submitFilters['id'] = $scope.metricId;
          submitFilters['attr']  = $scope.attr;
          // submitFilters['vspec'] = { vtype: "map", x: "region", y: $scope.attr, date_time: "date_time" };
          submitFilters['region'] = $scope.region;
          submitFilters['filters'] = { region: $scope.region, apn: $scope.apn, sgsn: $scope.sgsn, site: $scope.site };

          $scope.serviceApi.mapreduce_join_mslocation(submitFilters, function(data){
            console.log(data);

            $scope.spinner.addClass("hide");

            if (data.length === 0)
              return;

            var sum = 0;
            var regionMapping = {};
            for (var i = data.length - 1; i >= 0; i--) {
              regionMapping[data[i].groups.stack] = data[i].values.y; 
              sum += data[i].values.y;
            };
            var avg = sum/data.length;

            // console.log(regionMapping);

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

            var radial = $scope.element.find(".viz-radial");
            // Create radial percentage
            radialProgress(radial[0])
                .label("% pass")
                .diameter(100)
                // .minValue(100)
                // .maxValue(200)
                .value(avg)
                .render();

          },
          function(error){
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

            // console.log(error.statusText);
          }); // end facebook

        }); // end d3.json

      }


    }
  ]) // end module
}());