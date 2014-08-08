(function(){

  var module = angular.module('filters', []);

  module.factory('Filters', [
    function(){

      var initTimespan = '15m';

      var _filter = {
        from : "now-"+initTimespan,
        to: "now"
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
          time: date.getTime()
        };
      };

      var now = new Date();
      // Default values
      var filterObj = {
        'region': 'All',
        'site': 'All',
        'rncs': [],
        'time': getScopeTimeObj(kbn.parseDate(_filter.from), new Date()),
        'invterval': null,
        'apn': 'All',
        'stack': 'All'
      };

      return filterObj;
    } // function
  ]); // module

}());