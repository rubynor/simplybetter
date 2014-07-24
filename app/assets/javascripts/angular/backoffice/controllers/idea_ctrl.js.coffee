backoffice.controller 'backofficeCtrl', ['$scope', 'Idea', '$routeParams', ($scope, Idea) ->
  $scope.init = (app_id) ->
    $scope.ideas = Idea.query(application_id: app_id)
]
