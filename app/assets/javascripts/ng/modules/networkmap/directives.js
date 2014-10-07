(function(){

  var module = angular.module('autobot.networkmap.directives', []);
  
  module.directive('networkmapPanel', function(){
    return {
      restrict: "AE",
      replace: true,
      // template: "<p>Test Directive hahaha</p>",
      templateUrl: '/assets/ng/modules/networkmap/template.html',
      controller: 'NetworkmapCtrl',
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