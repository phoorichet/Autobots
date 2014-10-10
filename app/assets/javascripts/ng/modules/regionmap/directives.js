(function(){

  var module = angular.module('autobot.regionmap.directives', ['autobot.regionmap.controllers']);
  
  module.directive('regionmapPanel', function(){
    return {
      restrict: "AE",
      replace: true,
      // template: "<p>Test Directive hahaha</p>",
      templateUrl: '/assets/ng/modules/regionmap/template.html',
      controller: 'RegionmapCtrl',
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