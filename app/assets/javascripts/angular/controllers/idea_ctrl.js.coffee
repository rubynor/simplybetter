widget.controller 'IdeaCtrl', ['$scope', 'Idea', '$routeParams', 'Comment', '$location', ($scope, Idea, $routeParams, Comment, $location) ->
  $scope.idea = Idea.get({id: $routeParams.id, token: $scope.token, user_email: $scope.email})
  $scope.comments = Comment.query({idea_id: $routeParams.id})
  $scope.$parent.path = $location.path()

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
]
