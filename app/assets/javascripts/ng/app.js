$(document).ready(function(){


  var autobotsApp = angular.module('autobotsApp', [
    'ngRoute',
    'app.directives',
    'app.controllers',
    // Controller
    "vizLineController",
    "filterController",
    "vizHeatmapController",
    "vizForceController",
    "vizSankeyController",
    "adhocHeatmapController",
    "vizThaimapController",
    // Services
    "apiService",
    "filters",
  ]);

  // autobotsApp.config(['$routeProvider',
  //   function($routeProvider){
  //     $routeProvider
  //       .when('/timepicker', {
  //         templateUrl: 'javascript/ng/components/timepicker/module.html'
  //       })
  //   }
  // ])

  // Angular and Turbolink
  // http://stackoverflow.com/questions/14797935/using-angularjs-with-turbolinks
  $(document).on('ready page:load', function(){
    angular.bootstrap("body", ['autobotsApp'])
  });
          

});