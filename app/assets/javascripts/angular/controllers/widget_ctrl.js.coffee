widget.controller 'WidgetCtrl', ['$scope', 'Idea', ($scope, Idea) ->
  $scope.init = (token, email) ->
    $scope.email = email
    $scope.token = token
    console.log 'Inside init'
    console.log "Token = #{token} og email = #{email}"
    $scope.ideas = Idea.query({token: token, user_email: email})

  $scope.save_idea = (newIdea) ->
    hash = { idea: newIdea, user: {email: $scope.email}, token: $scope.token}
    idea = new Idea(hash)
    idea.$save()
]
