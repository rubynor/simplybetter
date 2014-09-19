IdeaDirective = ->
  restrict: 'A'
  scope:
    idea: '='
  template: JST['angular/backoffice/templates/idea']
  controller: 'IdeaCtrl as ideaCtrl'

angular
  .module('Backoffice')
  .directive('idea', IdeaDirective)
