backoffice.controller 'ideaCtrl', ['$scope', 'Idea', 'Comment', ($scope, Idea, Comment) ->
  $scope.init = (app_id) ->
    $scope.app_id = app_id
    $scope.ideas = Idea.query(application_id: app_id)
    $scope.activeClass = 'all'

  $scope.showAll = ->
    $scope.activeClass = 'all'
    $scope.selectedFilter = undefined

  $scope.showCompleted = ->
    $scope.activeClass = 'completed'
    $scope.selectedFilter = { completed: true }

  $scope.hideCompleted = ->
    $scope.activeClass = 'hide_completed'
    $scope.selectedFilter = { completed: false }

  $scope.showVisible = ->
    $scope.activeClass = 'visible'
    $scope.selectedFilter = { visible: true }

  $scope.hideVisible = ->
    $scope.activeClass = 'hide_visible'
    $scope.selectedFilter = { visible: false }

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

  $scope.save = (idea, idx) ->
    $scope.error_message = undefined
    updated_idea = new Idea({ id: idea.id, title: idea.title, description: idea.description})
    updated_idea.$patch({application_id: $scope.app_id},
      (data) ->
        $scope.ideas[idx] = data
    , (err) ->
      $scope.error_message = err.data
    )

  $scope.edit = (idea) ->
    $scope.copy = angular.copy(idea)
    idea.$edit = true

  $scope.cancel = (idx) ->
    $scope.copy.$edit = false
    $scope.ideas[idx] = $scope.copy

  $scope.remove_comment = (idea, comment, idx) ->
    if confirm 'Are you sure?'
      deleted_comment = new Comment(comment)
      deleted_comment.$remove(
        (success) ->
          idea.comments.splice(idx, 1)
      , (error) ->
        console.log JSON.stringify(error)
      )

  $scope.toggleVisibleComment = (comment) ->
    updated_comment = new Comment( { id: comment.id, visible: !comment.visible } )
    updated_comment.$patch(
      (data) ->
        comment.visible = data.visible
    )
]
