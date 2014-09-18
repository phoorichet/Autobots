(function(){
  var module = angular.module('app.controllers', []);
  module.controller('TimepickerCtrl', ['$scope', 'Api',
    function($scope, Api){

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
        $scope.timepick         = 'Last 15 minutes from now'; 
        var startStop = $scope.calculateTime('15m', 'now');
        $scope.timestart = startStop.start;
        $scope.timestop  = startStop.stop;
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

      $scope.submitRequest = function(){
        // submit request to change the filter and close modal
        
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


    }
  ]) // end module
}());