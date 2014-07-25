backoffice.controller 'backofficeCtrl', ['$scope', 'Idea', ($scope, Idea) ->
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
        console.log JSON.stringify(data)
        idea.visible = data.visible
    , (err) ->
      console.log JSON.stringify(err)
    )

  $scope.toggleCompleted = (idea) ->
    updated_idea = new Idea( { id: idea.id, completed: !idea.completed } )
    updated_idea.$patch({ application_id: $scope.app_id }
      (data) ->
        console.log JSON.stringify(data)
        idea.completed = data.completed
    , (err) ->
      console.log JSON.stringify(err)
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
      console.log JSON.stringify(err)
      $scope.error_message = err.data
    )

  $scope.edit = (idea) ->
    $scope.copy = angular.copy(idea)
    idea.$edit = true

  $scope.cancel = (idx) ->
    $scope.copy.$edit = false
    $scope.ideas[idx] = $scope.copy

]
