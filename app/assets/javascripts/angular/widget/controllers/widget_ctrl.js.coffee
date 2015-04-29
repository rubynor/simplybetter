widget.controller 'WidgetCtrl', ['$scope', 'Idea', 'FindSimilarIdea', 'Redirect', 'Session', ($scope, Idea, FindSimilarIdea, Redirect, Session) ->
  $scope.newIdea = Idea.new

  $scope.signed_in = Session.user_signed_in()
  $scope.email = Session.email

  $scope.reset_path = () ->
    $scope.path = undefined
    $scope.ideas = Idea.query()

  $scope.ideas = Idea.all()

  $scope.find_similar = (txt) ->
    return unless txt.length > 10
    FindSimilarIdea.query({ query: txt },
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

    Idea.create { idea: newIdea }, ->
      $scope.newIdea = undefined
      Redirect('idea', {id: data.id})
    , (err) ->
      $scope.error_message = ''
      $scope.error_message += "Title #{err.data.title}, " if err.data.title
      $scope.error_message += "Description #{err.data.description}" if err.data.description

]
