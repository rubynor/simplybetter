widget.controller 'IdeaCtrl', ['$scope', 'Idea', '$routeParams', 'Comment', ($scope, Idea, $routeParams, Comment) ->
  $scope.idea = Idea.get({id: $routeParams.id})
  $scope.comments = Comment.query({idea_id: $routeParams.id})
]
