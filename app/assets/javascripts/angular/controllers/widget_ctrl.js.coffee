widget.controller 'WidgetCtrl', ['$scope', 'Idea', ($scope, Idea) ->
  $scope.init = (token, email) ->
    console.log 'Inside init'
    console.log "Token = #{token} og email = #{email}"
    $scope.ideas = Idea.query({token: token, user_email: email})
]
