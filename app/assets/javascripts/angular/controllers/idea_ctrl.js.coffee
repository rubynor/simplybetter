widget.controller 'IdeaCtrl', ['$scope', 'Idea', '$routeParams', 'Comment', ($scope, Idea, $routeParams, Comment) ->
  $scope.idea = Idea.get({id: $routeParams.id})
  $scope.comments = Comment.query({idea_id: $routeParams.id})

  $scope.save_comment = (newComment) ->
    hash = { body: newComment, idea_id: $routeParams.id, user: { email: $scope.email } }
    comment = new Comment(hash)
    comment.$save()
]
