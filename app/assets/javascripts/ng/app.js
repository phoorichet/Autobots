$(document).ready(function(){


  var autobotApp = angular.module('autobotsApp', [
    // Controller
    "vizLineController",
    "filterController",
    "vizHeatmapController",
    "adhocHeatmapController",
    // Services
    "apiService",
    "filters",
  ]);

  // Angular and Turbolink
  // http://stackoverflow.com/questions/14797935/using-angularjs-with-turbolinks
  $(document).on('ready page:load', function(){
    angular.bootstrap("body", ['autobotsApp'])
  });
          

});