widget.controller 'IdeaCtrl', ['$scope', 'Idea', '$routeParams', 'Comment', '$location', '$timeout', ($scope, Idea, $routeParams, Comment, $location, $timeout) ->
  $scope.idea = Idea.get({id: $routeParams.id, token: $scope.token, user_email: $scope.email})
  $scope.comments = Comment.query({idea_id: $routeParams.id})
  $scope.$parent.path = $location.path()
  $scope.highlight = { idea: false }

  $scope.highlight = ->
    if $location.search().comment_id == 'null'
      $scope.highlight.idea = true
      $timeout($scope.unhighlight, 3000)

  $scope.unhighlight = ->
    $scope.highlight.idea = undefined

  $timeout($scope.highlight, 500)
]
