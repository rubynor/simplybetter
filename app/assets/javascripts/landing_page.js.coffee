#= require jquery
#= require bootstrap
#= require angular-1.2.18/angular

angular.module('landingPage', [])

scrollPosition = ['$window', ($window) ->
  scope:
    scroll: '=scrollPosition'

  link: (scope, element, attrs) ->
    windowEl = angular.element($window)
    handler = ->
      #TODO: find angular alternative for scrollTop
      scope.scroll = windowEl.scrollTop()
    windowEl.on('scroll', scope.$apply.bind(scope, handler))
    handler()
    return
]


angular.module('landingPage').directive('scrollPosition', scrollPosition)
