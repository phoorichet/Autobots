(function(){

  angular.module('facebookService', ['ngResource']).factory('Facebook', [ '$resource', 
    function($resource) {
      return $resource('/api/v1/facebooks/:collectionCtrl:id/:memberCtrl', {
        id: '@id',
        collectionCtrl: '@collectionCtrl',
        memberCtrl: '@memberCtrl'
      }, {
        index: {
          method: 'GET',
          isArray: true,
          responseType: 'json'
        },
        metric: {
          method: 'GET',
          params: {
            collectionCtrl: 'metric'
          },
          isArray: true
        }
      });
    }
  ]);

}).call(this)
