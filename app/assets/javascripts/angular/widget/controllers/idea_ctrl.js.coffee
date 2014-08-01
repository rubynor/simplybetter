widget.controller 'IdeaCtrl', ['$scope', '$routeParams', '$location', '$timeout', 'Idea', 'Redirect', ($scope, $routeParams, $location, $timeout, Idea, Redirect) ->
  $scope.idea = Idea.get({id: $routeParams.id, token: $scope.token, user_email: $scope.email},
    (data) ->
  , (err) ->
    $scope.error_message = 'Not available'
  )
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
    idea.$patch({token: $scope.token, user_email: $scope.email}
      (data) ->
        Redirect('idea', { id: id })
    , (err) ->
      $scope.error_message = err.data
    )
]
