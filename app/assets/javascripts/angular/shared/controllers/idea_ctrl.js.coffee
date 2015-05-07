IdeaCtrl = ($scope, $routeParams, $location, $timeout, Idea, Redirect) ->
  $scope.idea = Idea.get($routeParams.id)
  $scope.error_message = 'Not available' unless $scope.idea

  $scope.$on 'ngRepeatFinished', ->
    $scope.no_ideas = true if $scope.ideas().length == 0

  $scope.$parent.path = $location.path()
  $scope.highlight = { idea: false }

  $scope.highlight = ->
    if $location.search().comment_id == 'null'
      $scope.highlight.idea = true
      $timeout($scope.unhighlight, 3000)

  $scope.unhighlight = ->
    $scope.highlight.idea = undefined

  $timeout($scope.highlight, 500)

angular
  .module('shared')
  .controller('IdeaCtrl', ['$scope', '$routeParams', '$location', '$timeout', 'Idea', 'Redirect', IdeaCtrl])
