(function(){
  var module = angular.module('app.directives', []);
  module.directive('timepickerPanel', function(){
    return {
      restrict: "AE",
      replace: true,
      // template: "<p>Test Directive hahaha</p>",
      templateUrl: '/assets/ng/components/timepicker/template.html',
      controller: 'TimepickerCtrl',
      // link: function(scope, element, attributes){
      //   element.on('click', function(){
      //     console.log('click....');
      //   });
      // }
    }
  });

}());