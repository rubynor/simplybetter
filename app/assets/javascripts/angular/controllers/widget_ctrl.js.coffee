widget.controller 'WidgetCtrl', ['$scope', 'Idea', 'NotificationsCount', ($scope, Idea, NotificationsCount) ->
  $scope.newIdea = new Idea({})
  $scope.notificationactive = false

  $scope.reset_path = (token, email) ->
    $scope.path = undefined
    $scope.ideas = Idea.query({token: token, user_email: email})

  $scope.init = (token, email) ->
    $scope.email = email
    $scope.token = token
    console.log 'Inside init'
    console.log "Token = #{token} og email = #{email}"
    $scope.ideas = Idea.query({token: token, user_email: email})
    if email
      $scope.new_notifications = NotificationsCount.get({token: token, user_email: email})

  $scope.save_idea = (newIdea) ->
    $scope.success_message = undefined
    $scope.error_message = undefined
    hash = { idea: newIdea, user: {email: $scope.email}, token: $scope.token}
    idea = new Idea(hash)
    idea.$save(
      (data) ->
        window.location = "#/widget/#{data.id}"
    , (err) ->
      error = JSON.stringify(err)
      $scope.error_message = ''
      $scope.error_message += "Title #{err.data.title}, " if err.data.title
      $scope.error_message += "Description #{err.data.description}" if err.data.description
    )

  $scope.updateCount = ->
    $scope.new_notifications = NotificationsCount.get({token: $scope.token, user_email: $scope.email})
    console.log 'update count'
]
