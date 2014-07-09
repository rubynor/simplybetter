widget.controller 'IdeaCtrl', ['$scope', 'Idea', '$routeParams', 'Comment', ($scope, Idea, $routeParams, Comment) ->
  $scope.idea = Idea.get({id: $routeParams.id})
  $scope.comments = Comment.query({idea_id: $routeParams.id})

  $scope.save_comment = (newComment) ->
    $scope.error_message = undefined
    $scope.success_message = undefined
    hash = { body: newComment, idea_id: $routeParams.id, user: { email: $scope.email } }
    comment = new Comment(hash)
    comment.$save(
      (data) ->
        $scope.comments.push(data)
        $scope.newComment = undefined
        $scope.success_message = 'Thank you for your comment'
    , (err) ->
      console.log JSON.stringify(err)
      $scope.error_message = "'Comment can't be blank'"
    )
]
