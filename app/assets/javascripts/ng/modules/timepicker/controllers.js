(function(){
  
  var module = angular.module('autobot.timepicker.controllers', ['autobot.api.services', 'autobot.filter.services']);

  module.controller('TimepickerCtrl', ['$scope', 'Api', 'Filters',
    function($scope, Api, Filters){

      // Get async data
      Api.TimeConfig.index(function(data){
        $scope.data = data;
        $scope.realtimeOptions = data.filter(function(d) { return d.time_type === "_relative" ? d : null});
      });

      /**
       * Initialize  all the variables
       */
      $scope.initialize = function(){
        
        // $scope.realtimeOptions  = ['15m','1h','6h','12h','24h','2d','7d', '15d','30d', '45d', '60d'];
        // $scope.abstimeOptions   = ['This week', 'Last Week', 'This month', 'Last Month'];
        $scope.refreshIntervals = ['1m','5m','15m','30m','1h','2h'];

        // default value
        $scope.interval         = '1m'; 
        $scope.timepick         = 'Last 1 month'; 
        var startStop = $scope.calculateTime('1M', 'now');
        $scope.timestart = startStop.start;
        $scope.timestop  = startStop.stop;
        $scope.setTime();
      }

      $scope.changeRelativeTimepick = function(timeconfig){
        $scope.timepick = timeconfig.name;
        var startStop = $scope.calculateTime(timeconfig.start, timeconfig.stop);
        $scope.timestart = startStop.start;
        $scope.timestop  = startStop.stop;
      }

      $scope.changeAbsTimepick = function(option){
        $scope.timepick = option;
        $scope.interval = null;
      }

      $scope.changeInterval = function(option){
        $scope.interval = option;
      }

      $scope.hideAccordion = function(){
        $("#collapseTimepicker").collapse('hide');
      }

      $scope.submitRequest = function(){
        $scope.hideAccordion();
        
        // submit request to change the filter and close modal
        $scope.setTime();
      }

      /**
       * Calculate actual time object based on the selected criteria
       */
      $scope.calculateTime = function(start, stop){
        // Currently support only now for stop
        if (stop !== 'now'){
          return null;
        }

        var digitReg = /\d+/,
            wordReg  = /\D/;

        var digit = digitReg.exec(start)[0];
        var word  = wordReg.exec(start)[0];

        return {
          start: moment().subtract(digit, word).toDate(),
          stop : moment().toDate()
        };

      }


      $scope.setTime = function(){
        Filters.time = { 
          from: { date: $scope.timestart, time: $scope.timestart.getTime() },
          to:   { date: $scope.timestop,  time: $scope.timestop.getTime() }
        };
        console.log(Filters);
      }


    }
  ]) // end module
}());