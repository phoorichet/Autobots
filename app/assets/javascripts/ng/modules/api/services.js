(function(){

  var module = angular.module('autobot.api.services', ['ngResource']);

  module.factory('Api', [ '$resource',   
    function($resource) {
      return {
        Facebook: $resource('/api/v1/facebooks/:collectionCtrl:id/:memberCtrl', {
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
                    },
                    mapreduce: {
                      method: 'GET',
                      params: {
                        // collectionCtrl: 'metric2'
                        memberCtrl: 'mapreduce'
                      },
                      isArray: true
                    },
                    metric_by_region: {
                      method: 'GET',
                      params: {
                        collectionCtrl: 'metric_by_region'
                      },
                      isArray: true
                    },
                    force: {
                      method: 'GET',
                      params: {
                        collectionCtrl: 'force'
                      },
                      isArray: false
                    }
                  }),
        Twitter: $resource('/api/v1/twitters/:collectionCtrl:id/:memberCtrl', {
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
                  }),
        Instagram: $resource('/api/v1/instagrams/:collectionCtrl:id/:memberCtrl', {
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
                  }),
        Ping: $resource('/api/v1/pings/:collectionCtrl:id/:memberCtrl', {
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
                  }),
        Speedtest: $resource('/api/v1/speedtests/:collectionCtrl:id/:memberCtrl', {
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
                  }),
        Youtube: $resource('/api/v1/youtubes/:collectionCtrl:id/:memberCtrl', {
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
                  }),
        Adhoc: $resource('/api/v1/adhocs/:collectionCtrl:id/:memberCtrl', {
                    id: '@id',
                    collectionCtrl: '@collectionCtrl',
                    memberCtrl: '@memberCtrl'
                  }, {
                    index: {
                      method: 'GET',
                      isArray: true,
                      responseType: 'json'
                    },
                    heatmap: {
                      method: 'GET',
                      params: {
                        collectionCtrl: 'heatmap'
                      },
                      isArray: true
                    }
                  }),
        TimeConfig: $resource('/api/v1/time_configs/:collectionCtrl:id/:memberCtrl', {
                    id: '@id',
                    collectionCtrl: '@collectionCtrl',
                    memberCtrl: '@memberCtrl'
                  }, {
                    index: {
                      method: 'GET',
                      isArray: true,
                      responseType: 'json'
                    }
                  }),
      }// end return
    } // end function
  ]); // end module

  // module.factory('Twitter', [ '$resource', 
  //   function($resource) {
  //     return $resource('/api/v1/twitters/:collectionCtrl:id/:memberCtrl', {
  //       id: '@id',
  //       collectionCtrl: '@collectionCtrl',
  //       memberCtrl: '@memberCtrl'
  //     }, {
  //       index: {
  //         method: 'GET',
  //         isArray: true,
  //         responseType: 'json'
  //       },
  //       metric: {
  //         method: 'GET',
  //         params: {
  //           collectionCtrl: 'metric'
  //         },
  //         isArray: true
  //       }
  //     });
  //   } // end function
  // ]); // end module

  // module.factory('Facebook', [ '$resource', 
  //   function($resource) {
  //     return $resource('/api/v1/facebooks/:collectionCtrl:id/:memberCtrl', {
  //       id: '@id',
  //       collectionCtrl: '@collectionCtrl',
  //       memberCtrl: '@memberCtrl'
  //     }, {
  //       index: {
  //         method: 'GET',
  //         isArray: true,
  //         responseType: 'json'
  //       },
  //       metric: {
  //         method: 'GET',
  //         params: {
  //           collectionCtrl: 'metric'
  //         },
  //         isArray: true
  //       }
  //     });
  //   } // end function
  // ]); // end module





  // module.factory('Instagram', [ '$resource', 
  //   function($resource) {
  //     return $resource('/api/v1/instagrams/:collectionCtrl:id/:memberCtrl', {
  //       id: '@id',
  //       collectionCtrl: '@collectionCtrl',
  //       memberCtrl: '@memberCtrl'
  //     }, {
  //       index: {
  //         method: 'GET',
  //         isArray: true,
  //         responseType: 'json'
  //       },
  //       metric: {
  //         method: 'GET',
  //         params: {
  //           collectionCtrl: 'metric'
  //         },
  //         isArray: true
  //       }
  //     });
  //   } // end function
  // ]); // end module

}).call(this)
