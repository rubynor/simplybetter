IdeaCtrl = ($scope) ->
  @idea = $scope.idea
  return

IdeaDirective = ->
  restrict: 'A'
  scope:
    idea: '='
  template: JST['angular/backoffice/templates/idea']
  controller: ['$scope', IdeaCtrl]
  controllerAs: 'ideaCtrl'

angular
  .module('Backoffice')
  .directive('idea', [IdeaDirective])
