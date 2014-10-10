(function(){
  
  var module = angular.module('autobot.regionmap.controllers', ['autobot.api.services', 'autobot.filter.services']);

  module.controller('RegionmapCtrl', ['$scope', 'Api', 'Filters',
    function($scope, Api, Filters){
      /**
       * Initialize  all the variables
       */
      $scope.initialize = function(element, attributes){
        $scope.element = element;
        $scope.width   = attributes.width;
        $scope.height  = attributes.height;
        $scope.attr    = attributes.attr;
        $scope.filters = Filters;
        $scope.service = Api[attributes.service];

        // Interesting region
        if (attributes.region !== null){
          $scope.region  = attributes.region;
          // $scope.filters['region'] = $scope.region;
        }
      }

      $scope.$watchCollection('filters', function(newValue, oldValue){
        $scope.updateViz(newValue);
      });

      $scope.updateViz = function(filters){
        var formatPercent = d3.format(".2f"),
            monthWeekFormat = d3.time.format("%m-%d");

        var margin = { top: 50, right: 0, bottom: 100, left: 100 },
            width  = $scope.width - margin.left - margin.right,
            height = $scope.width - margin.top - margin.bottom;


        d3.json("/assets/data/tha_provinces.json", function(error, tha) {
          console.log(tha);

          var container = $scope.element.find(".viz");

          d3.select(container[0]).select('svg').remove(); // clear the existing

          var svg = d3.select(container[0]).append("svg")
              .attr("width", width)
              .attr("height", height);

          var projection = d3.geo.albers()
            .center([0, 13.7])
            .rotate([-100.60, 0])
            .parallels([5, 21])
            .scale(2000)
            .translate([width / 2, height / 2]);

          function adjustProject(region, projection){
            var proj = projection;

            switch(region) {
              case "North":
                proj = projection.center([0, 16]);
                break;
              case "Northeast":
                proj = projection.center([0, 16]);
                break;
              case "Central":
                proj = projection.center([0, 14]);
                break;
              case "Bangkok":
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
          };
          
          // Add region as a property
          var subunitObj = tha.objects.subunits.geometries;
          for (var i = subunitObj.length - 1; i >= 0; i--) {
            subunitObj[i].properties.REGION = mapping[subunitObj[i].properties.NAME_1];
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
          submitFilters.filters['attr']  = $scope.attr;
          submitFilters.filters['vspec'] = { vtype: "map", x: "region", y: $scope.attr, date_time: "date_time" };
          if ($scope.region) {
            submitFilters['region'] = $scope.region;
          }

          $scope.service.metric_by_region(submitFilters, function(data){
            console.log(data);
            if (data.length === 0)
              return;

            var sum = 0;
            var regionMapping = {};
            for (var i = data.length - 1; i >= 0; i--) {
              regionMapping[data[i].x] = data[i].y; 
              sum += data[i].y;
            };
            var avg = sum/data.length;

            console.log(regionMapping);

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

          }); // end facebook

        }); // end d3.json

      }


    }
  ]) // end module
}());