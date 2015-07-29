backoffice.controller 'ideaCtrl', ['$scope', 'Idea', 'Comment', ($scope, Idea, Comment) ->
  $scope.init = (appKey) ->
    $scope.appKey = appKey
    $scope.ideas = Idea.all({token: appKey})

  $scope.toggleVisible = (idea) ->
    updated_idea = new Idea( { id: idea.id, visible: !idea.visible } )
    idea.$show_comments = false
    updated_idea.$patch({ application_id: $scope.app_id }
      (data) ->
        idea.visible = data.visible
    )

  $scope.toggleCompleted = (idea) ->
    updated_idea = new Idea( { id: idea.id, completed: !idea.completed } )
    updated_idea.$patch({ application_id: $scope.app_id }
      (data) ->
        idea.completed = data.completed
    )

  $scope.delete = (idea, idx) ->
    if confirm 'Are you sure?'
      idea.$delete({application_id: $scope.app_id})
      $scope.ideas.splice(idx, 1)

  $scope.save = (idea) ->
    $scope.error_message = undefined
    updated_idea = new Idea({ id: idea.id, title: idea.title, description: idea.description})
    updated_idea.$patch({application_id: $scope.app_id},
      (data) ->
        angular.copy(data, idea)
    , (err) ->
      $scope.error_message = err.data
    )

  $scope.edit = (idea) ->
    $scope.copy = angular.copy(idea)
    idea.$edit = true

  $scope.cancel = (idea) ->
    idea.$edit = false
    $scope.copy.$edit = false
    angular.copy($scope.copy, idea)

  $scope.toggleVisibleComment = (comment) ->
    updated_comment = new Comment( { id: comment.id, visible: !comment.visible } )
    updated_comment.$patch(
      (data) ->
        comment.visible = data.visible
    )
]
