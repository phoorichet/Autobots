(function(){

  var module = angular.module("filterController", ['filters']);

  module.controller("FilterCtrl", ["$scope", "Filters", 
    function($scope, filters){

      $scope.filters = filters;
      // console.log($scope.filters);

      var kbn = window.kbn;
      // Set and populate defaults
      $scope.panel = {
        time_options  : ['15m','1h','6h','12h','24h','2d','7d', '15d','30d', '45d', '60d'],
        refresh_intervals : ['5s','10s','30s','1m','5m','15m','30m','1h','2h','1d'],
        region_options : ['All', 'North', 'Northeast', 'East', 'Central', 'Bangkok', 'South'],
        site_options: ['All', 'CWD', 'SUK', 'TLS'],
        apn_options: ["All", "internet", "3GGSNSUK11H", "3GGSNCWD7N", "3GGSNCWD5N", "3GGSNSUK8N", "3GGSNSUK9N", "3GGSNCWD2N", "3GGSNSUK7N", "3GGSNSUK4N", "3GGSNCWD8N", "3GGSNSUK6N", "3GGSNSUK3N", "3GGSNCWD11H", "3GGSNSUK5N", "3GGSNCWD3N", "3GGSNCWD6N", "3GGSNSUK2N", "3GGSNCWD4N"],
        stack_options: ['All', 'RNC', 'GGSN'],
        sgsn_options: ['All', '3SGSNBPL1H', '3SGSNBPL2H', '3SGSNBPL3H', '3SGSNCMI1H', '3SGSNCWD2H', '3SGSNPLK1H', '3SGSNSNI1H', '3SGSNSUK1H', '3SGSNSUK2H', '3SGSNTWA2H', '3SGSNTWA3H']
      };

      $scope.setRelativeFilter = function(timespan) {
        $scope.panel.now = true;

        var _filter = {
          from : "now-"+timespan,
          to: "now"
        };

        // this.filter.setTime(_filter);
        // $scope.filters.from = kbn.parseDate(_filter.from);
        // $scope.filters.to   = new Date();

        // $scope.filters.time = { from: kbn.parseDate(_filter.from), to: new Date() };

        $scope.filters.time = getScopeTimeObj(kbn.parseDate(_filter.from), new Date());

      };

      $scope.setRegionFilter = function(region) {
        $scope.filters.region = region;
      };

      $scope.setSiteFilter = function(site) {
        $scope.filters.site = site;
      };

      $scope.setApnFilter = function(apn) {
        $scope.filters.apn = apn;
      };

      $scope.setStackFilter = function(stack){
        $scope.filters.stack = stack;
      }

      $scope.setSgsnFilter = function(sgsn){
        $scope.filters.sgsn = sgsn;
      }

      var getScopeTimeObj = function(from,to) {
        return {
          from: getTimeObj(from),
          to: getTimeObj(to)
        };
      };

      var getTimeObj = function(date) {
        return {
          date: new Date(date),
          // hour: pad(date.getHours(),2),
          // minute: pad(date.getMinutes(),2),
          // second: pad(date.getSeconds(),2),
          // millisecond: pad(date.getMilliseconds(),3),
          "time": date.getTime()
        };
      };


      var pad = function(n, width, z) {
        z = z || '0';
        n = n.toString();
        return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
      };



    } // end function
  ]); //end module
  
}).call(this);