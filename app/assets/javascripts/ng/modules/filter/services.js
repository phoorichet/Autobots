(function(){

  var module = angular.module('autobot.filter.services', []);

  module.factory('Filters', [
    function(){

      var initTimespan = '30d';

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
        'stack': 'All',
        'sgsn': 'All'
      };

      return filterObj;
    } // function
  ]); // module

}());