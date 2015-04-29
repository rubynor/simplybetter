IdeaAdminOptions = ->
  restrict: 'E'
  template: JST['angular/shared/directives/idea_admin_options/idea_admin_options_directive_template']
  scope:
    idea: '='
    collection: '='
  controller: ['$scope', 'Redirect', 'Idea', 'Session', ($scope, Redirect, Idea, Session) ->
    @visible = false

    @toggle = =>
      @visible = !@visible

    @ideaToggleCompleted = =>
      $scope.idea.completed = !$scope.idea.completed
      $scope.idea.$update {}, ->
        return
      , ->
        $scope.idea.completed = !$scope.idea.completed

    @ideaToggleVisible = =>
      $scope.idea.visible = !$scope.idea.visible
      $scope.idea.$update {}, ->
        return
      , ->
        $scope.idea.visible = !$scope.idea.visible

    @ideaDelete = ->
      #$scope.idea.$delete()
      console.log $scope
      index = $scope.ideas.indexOf($scope.idea)
      $scope.ideas.splice(index, 1)
      Redirect('overview')

    @isAdmin = ->
      Session.isAdmin()

    return
  ]
  controllerAs: 'options'

angular
  .module('shared')
  .directive('ideaAdminOptions', IdeaAdminOptions)
