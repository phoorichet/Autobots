(function(){

  var module = angular.module("filterController", ['filters']);

  module.controller("FilterCtrl", ["$scope", "Filters", 
    function($scope, filters){

      $scope.filters = filters;
      // console.log($scope.filters);

      var kbn = window.kbn;
      // Set and populate defaults
      $scope.panel = {
        time_options  : ['15m','1h','6h','12h','24h','2d','7d','30d'],
        refresh_intervals : ['5s','10s','30s','1m','5m','15m','30m','1h','2h','1d'],
        region_options : ['All', 'North', 'Northeast', 'East', 'Central', 'Bangkok', 'South'],
        site_options: ['All', 'CWDC', 'SUK']
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
          time: date.getTime()
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