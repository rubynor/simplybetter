widget.controller 'IdeaCtrl', ['$scope', 'Idea', '$routeParams', 'Comment', '$location', '$timeout', ($scope, Idea, $routeParams, Comment, $location, $timeout) ->
  $scope.idea = Idea.get({id: $routeParams.id, token: $scope.token, user_email: $scope.email})
  $scope.comments = Comment.query({idea_id: $routeParams.id})
  $scope.$parent.path = $location.path()
  $scope.highlight = { idea: false }

  $scope.save_comment = (newComment) ->
    $scope.error_message = undefined
    $scope.success_message = undefined
    hash = { body: newComment, idea_id: $routeParams.id, user: { email: $scope.email } }
    comment = new Comment(hash)
    comment.$save(
      (data) ->
        $scope.comments.push(data)
        $scope.idea.comments_count += 1
        $scope.newComment = undefined
        $scope.success_message = 'Thank you for your comment'
    , (err) ->
      console.log JSON.stringify(err)
      $scope.error_message = err.data
    )

  $scope.highlight = ->
    if $location.search().comment_id == 'null'
      $scope.highlight.idea = true
      $timeout($scope.unhighlight, 3000)

  $scope.unhighlight = ->
    $scope.highlight.idea = undefined

  $timeout($scope.highlight, 500)
]
