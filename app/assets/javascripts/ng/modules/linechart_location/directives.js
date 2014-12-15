(function(){

  var module = angular.module('autobot.linechartlocation.directives', ['autobot.linechartlocation.controllers']);
  
  module.directive('linechartlocationPanel', function(){
    return {
      restrict: "AE",
      replace: true,
      // template: "<p>Test Directive hahaha</p>",
      templateUrl: '/assets/ng/modules/linechart_location/template.html',
      controller: 'LinechartLocationCtrl',
      link: function(scope, element, attributes){
        // Init the scope
        scope.initialize(element, attributes);

        // $(document).ready(function() { $("#e1").select2(); });
        // console.log(element.find("#e1"));

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