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
        $scope.interval  = '1m'; 
        $scope.timepick  = 'Last 1 week'; 
        var startStop    = $scope.calculateTime('2M', 'now');
        $scope.timestart = startStop.start;
        $scope.timestop  = startStop.stop;
        $scope.setTime();

        $scope.to   = {};
        $scope.date_options   = $scope.generateIntegerArray(1, 31);
        $scope.month_options  = moment.months().map(function(d, i){ return {name: d, value: i};}) // Create a object pair
        $scope.year_options   = $scope.generateYear();
        $scope.hour_options   = $scope.generateIntegerArray(0, 24);
        $scope.minute_options = $scope.generateIntegerArray(0, 60);
        $scope.second_options = $scope.generateIntegerArray(0, 60);

        var now = moment();

        $scope.from = {
          date  : now.date(),
          month : $scope.month_options.slice(now.month())[0],
          year  : now.year(),
          hour  : $scope.hour_options[0],
          minute: $scope.minute_options[0],
          second: $scope.second_options[0],
        };

        $scope.to = {
          date  : now.date(),
          month : $scope.month_options.slice(now.month())[0],
          year  : now.year(),
          hour  : $scope.hour_options[0],
          minute: $scope.minute_options[0],
          second: $scope.second_options[0],
        };

      }

      $scope.changeRelativeTimepick = function(timeconfig){
        // console.log(timeconfig);
        $scope.timepick  = timeconfig.name;
        var startStop    = $scope.calculateTime(timeconfig.start + timeconfig.time_unit, timeconfig.stop);
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

      $scope.hideModal = function(){
        $('#customTimePicker').modal('hide')
      }

      $scope.submitRequest = function(){
        $scope.hideAccordion();
        
        // submit request to change the filter and close modal
        $scope.setTime();
      }

      $scope.changeCustomTime = function(){
        $scope.hideModal();
        $scope.hideAccordion();

        console.log($scope.buildTime($scope.from).toDate());

        $scope.timestart = $scope.buildTime($scope.from).toDate();
        $scope.timestop  = $scope.buildTime($scope.to).toDate();

        Filters.time = { 
          from: { date: $scope.timestart, time: $scope.timestart.getTime() },
          to:   { date: $scope.timestop,  time: $scope.timestop.getTime() }
        };
        console.log(Filters);
      };

      $scope.buildTime = function(time){
        var d   = _.clone(time);
        d.month = d.month.value;
        return moment(d);
      };

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


      /**
       * Generate one year ahead and afterward
       * @return {[array of int]} [year list]
       */
      $scope.generateYear =  function(){
        var currentYear =  moment().year();
        return [currentYear - 1, currentYear, currentYear + 1 ];
      }

      $scope.generateIntegerArray = function(start, stop){
        var l = [];
        for (var i = start; i < stop; i++) {
          l.push(i);
        };

        return l;
      }


    }
  ]) // end module
}());