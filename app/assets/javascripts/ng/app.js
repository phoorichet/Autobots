'use strict';

(function(){

  var autobotsApp = angular.module('autobot', [
    'ui.router',
    'autobot.api',
    'autobot.filter',
    'autobot.vforce',
    'autobot.vheatmap',
    'autobot.vline',
    'autobot.vmap',
    'autobot.vsankey',
    'autobot.timepicker',
    'autobot.networkmap',
    'autobot.regionmap',
    'autobot.linegraph'
  ]);


  autobotsApp.config(function($stateProvider, $urlRouterProvider) {
    $stateProvider
      .state('start', {
        url: '/start',
        templateUrl: 'partials/start.html',
        controller: function($scope, $stateParams) {
          console.log('-------------Yo!');
        }
      })

    $urlRouterProvider.when('','/'); //Set default state when the page is loaded
  });

  // Angular and Turbolink
  // http://stackoverflow.com/questions/14797935/using-angularjs-with-turbolinks
  // $(document).on('ready page:load', function(){
  //   angular.bootstrap("body", ['autobot']);
  // });

  // $(function() {
  //   $('#side-menu').metisMenu();
  // });
          

}());