widget.controller 'IdeaCtrl', ['$scope', '$routeParams', '$location', '$timeout', 'Idea', 'Redirect', ($scope, $routeParams, $location, $timeout, Idea, Redirect) ->
  Idea.get({id: $routeParams.id},
    (data) ->
      $scope.idea = data
  , (err) ->
    $scope.error_message = 'Not available'
  )

  $scope.$on 'ngRepeatFinished', ->
    $scope.no_ideas = true if $scope.ideas.length == 0

  $scope.$parent.path = $location.path()
  $scope.highlight = { idea: false }

  $scope.highlight = ->
    if $location.search().comment_id == 'null'
      $scope.highlight.idea = true
      $timeout($scope.unhighlight, 3000)

  $scope.unhighlight = ->
    $scope.highlight.idea = undefined

  $timeout($scope.highlight, 500)

  $scope.update_idea = (idea) ->
    id = idea.id
    idea.$patch(
      (data) ->
        Redirect('idea', { id: id })
    , (err) ->
      $scope.error_message = err.data
    )
]
