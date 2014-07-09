widget.controller 'IdeaCtrl', ['$scope', 'Idea', '$routeParams', ($scope, Idea, $routeParams) ->
  $scope.idea = Idea.get({id: $routeParams.id})
]
