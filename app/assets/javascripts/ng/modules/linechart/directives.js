(function(){

  var module = angular.module('autobot.linechart.directives', ['autobot.linechart.controllers']);
  
  module.directive('linechartPanel', function(){
    return {
      restrict: "AE",
      replace: true,
      // template: "<p>Test Directive hahaha</p>",
      templateUrl: '/assets/ng/modules/linechart/template.html',
      controller: 'LinechartCtrl',
      link: function(scope, element, attributes){
        // Init the scope
        scope.initialize(element, attributes);

        // element.on('click', function(){
        //   var filters = { attr: attributes.metric };
        //   var elem = element.find(".viz");
        //   scope.updateViz(filters, elem);
          
        // });
      },
      scope: {},
    }
  });

}());