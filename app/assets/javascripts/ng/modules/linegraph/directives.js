(function(){

  var module = angular.module('autobot.linegraph.directives', ['autobot.linegraph.controllers']);
  
  module.directive('linegraphPanel', function(){
    return {
      restrict: "AE",
      replace: true,
      // template: "<p>Test Directive hahaha</p>",
      templateUrl: '/assets/ng/modules/linegraph/template.html',
      controller: 'LinegraphCtrl',
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