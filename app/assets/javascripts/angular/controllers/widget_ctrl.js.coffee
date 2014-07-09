widget.controller 'WidgetCtrl', ['$scope', 'Idea', ($scope, Idea) ->
  $scope.newIdea = new Idea({idea: ''})

  $scope.init = (token, email) ->
    $scope.email = email
    $scope.token = token
    console.log 'Inside init'
    console.log "Token = #{token} og email = #{email}"
    $scope.ideas = Idea.query({token: token, user_email: email})

  $scope.save_idea = (newIdea) ->
    $scope.error_message = undefined
    hash = { idea: newIdea, user: {email: $scope.email}, token: $scope.token}
    idea = new Idea(hash)
    idea.$save(
      (data) ->
        console.log "Data = #{data}"
        console.log 'Everything ok?'
    , (err) ->
      error = JSON.stringify(err)
      $scope.error_message = ''
      $scope.error_message += "Title #{err.data.title}, " if err.data.title
      $scope.error_message += "Description #{err.data.description}" if err.data.description
      console.log "Error: #{JSON.stringify(err)}"
    )
]
