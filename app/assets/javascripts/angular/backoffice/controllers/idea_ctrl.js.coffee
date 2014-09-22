IdeaCtrl = ($scope, Idea, Comment, IdeasCache) ->
  @idea = $scope.idea
  appId = $scope.$parent.appId

  @toggleVisible = ->
    updated_idea = new Idea( { id: @idea.id, visible: !@idea.visible } )
    @idea.$showComments = false
    updated_idea.$patch { application_id: appId }
    , (data) =>
      @idea.visible = data.visible

  @toggleCompleted = ->
    updated_idea = new Idea( { id: @idea.id, completed: !@idea.completed } )
    updated_idea.$patch { application_id: appId }
    , (data) =>
      @idea.completed = data.completed

  @delete = ->
    if confirm 'Are you sure?'
      @idea.$delete({application_id: appId})
      IdeasCache.remove(@idea)

  @save = ->
    @error_message = undefined
    updated_idea = new Idea({ id: @idea.id, title: @idea.title, description: @idea.description})
    updated_idea.$patch {application_id: appId}
    , (data) =>
        @idea = data
    , (err) =>
      @error_message = err.data

  @edit = ->
    @copy = angular.copy(@idea)
    @idea.$edit = true

  @cancel = ->
    @copy.$edit = false
    @idea = @copy

  return

angular
  .module('Backoffice')
  .controller('IdeaCtrl', ['$scope', 'Idea', 'Comment', 'IdeasCache', IdeaCtrl])
