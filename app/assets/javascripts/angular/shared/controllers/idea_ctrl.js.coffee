IdeaCtrl = ($scope, $stateParams, $location, $timeout, Idea) ->
  $scope.idea = Idea.get($stateParams.id)
  $scope.error_message = 'Not available' unless $scope.idea

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
  .controller('IdeaCtrl', ['$scope', '$stateParams', '$location', '$timeout', 'Idea', IdeaCtrl])
