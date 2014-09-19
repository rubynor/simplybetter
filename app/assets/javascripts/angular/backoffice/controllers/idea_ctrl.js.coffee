IdeaCtrl = ($scope, Idea, Comment) ->
  @idea = $scope.idea
  @ideas = []

  $scope.init = (app_id) =>
    @app_id = app_id
    @ideas = Idea.query(application_id: app_id)

  @toggleVisible = (idea) ->
    updated_idea = new Idea( { id: idea.id, visible: !idea.visible } )
    idea.$show_comments = false
    updated_idea.$patch({ application_id: @app_id }
      (data) ->
        idea.visible = data.visible
    )

  @toggleCompleted = (idea) ->
    updated_idea = new Idea( { id: idea.id, completed: !idea.completed } )
    updated_idea.$patch({ application_id: @app_id }
      (data) ->
        idea.completed = data.completed
    )

  @delete = ->
    if confirm 'Are you sure?'
      @idea.$delete({application_id: @app_id})
      #Check if this works! @ideas.splice(idx, 1)

  @save = ->
    @error_message = undefined
    updated_idea = new Idea({ id: @idea.id, title: @idea.title, description: @idea.description})
    updated_idea.$patch({application_id: @app_id},
      (data) ->
        @idea = data
    , (err) ->
      @error_message = err.data
    )

  @edit = ->
    @copy = angular.copy(@idea)
    @idea.$edit = true

  @cancel = ->
    @copy.$edit = false
    @idea = @copy

  @toggleVisibleComment = (comment) ->
    updated_comment = new Comment( { id: comment.id, visible: !comment.visible } )
    updated_comment.$patch(
      (data) ->
        comment.visible = data.visible
    )
  return

angular
  .module('Backoffice')
  .controller('IdeaCtrl', ['$scope', 'Idea', 'Comment', IdeaCtrl])
