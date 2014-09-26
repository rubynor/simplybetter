# This directive is created for #simplybetterIdeasModalContent
# it's not intended to be used anywhere else
StretchToFit = ($window) ->
  restrict: 'A'
  link: (scope, element, attr) ->
    resize = ->
      navbarHeight = element.siblings('#simplybetterNavbar')[0].offsetHeight
      totalHeight = element.parent()[0].offsetHeight
      element.css('height', totalHeight - navbarHeight)

    angular.element($window).bind 'resize', ->
      resize()

    resize()

angular
  .module('Simplybetter')
  .directive('stretchToFit', ['$window', StretchToFit])
