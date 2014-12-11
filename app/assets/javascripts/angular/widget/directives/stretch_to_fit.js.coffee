# This directive is created for #simplybetterIdeasModalContent
# it's not intended to be used anywhere else
StretchToFit = ($window, $timeout) ->
  restrict: 'A'
  link: (scope, element, attr) ->
    resize = ->
      navbarHeight = angular.element( document.querySelector( '#simplybetterNavbar' ))[0].offsetHeight
      totalHeight = angular.element( document.querySelector('#simplybetterIdeasModal'))[0].offsetHeight
      element.css('height', totalHeight - navbarHeight)

    angular.element($window).bind 'resize', ->
      resize()

    angular.element($window).bind 'mouseup', ->
      $timeout ->
        resize()
      , 550

    $timeout ->
      resize()
    , 50

angular
  .module('Simplybetter')
  .directive('stretchToFit', ['$window', '$timeout', StretchToFit])
