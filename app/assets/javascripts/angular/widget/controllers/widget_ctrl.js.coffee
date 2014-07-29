widget.controller 'WidgetCtrl', ['$scope', 'Idea', 'FindSimilarIdea', ($scope, Idea, FindSimilarIdea) ->
  $scope.newIdea = new Idea({})

  $scope.init = (token, email) ->
    $scope.email = email
    $scope.token = token

  $scope.reset_path = () ->
    $scope.path = undefined
    $scope.ideas = Idea.query()

  $scope.ideas = Idea.query()

  $scope.find_similar = (txt) ->
    return unless txt.length > 10
    FindSimilarIdea.query({ token: $scope.token, query: txt },
      (response) ->
        $scope.similar_ideas = response
    )

  $scope.show_this_idea = (idea) ->
    $scope.ideas = [idea]

  $scope.show_similar = ->
    $scope.similar_ideas && $scope.similar_ideas.length > 0

  $scope.hide_similar = ->
    $scope.similar_ideas = undefined

  $scope.save_idea = (newIdea) ->
    $scope.success_message = undefined
    $scope.error_message = undefined
    hash = { idea: newIdea, user: {email: $scope.email}, token: $scope.token}
    idea = new Idea(hash)
    idea.$save(
      (data) ->
        $scope.newIdea = undefined
        window.location = "#/widget/#{data.id}"
    , (err) ->
      $scope.error_message = ''
      $scope.error_message += "Title #{err.data.title}, " if err.data.title
      $scope.error_message += "Description #{err.data.description}" if err.data.description
    )
]
