IdeaAdminOptions = ->
  restrict: 'E'
  template: JST['angular/shared/directives/idea_admin_options/idea_admin_options_directive_template']
  scope:
    idea: '='
  controller: ['$scope', 'Idea', 'Session', ($scope, Idea, Session) ->
    @visible = false

    @toggle = =>
      @visible = !@visible

    @ideaToggleCompleted = =>
      $scope.idea.completed = !$scope.idea.completed
      $scope.idea.$update {}, ->
        return
      , ->
        $scope.idea.completed = !$scope.idea.completed
      return

    @isAdmin = ->
      Session.isAdmin()

    return
  ]
  controllerAs: 'options'

angular
  .module('shared')
  .directive('ideaAdminOptions', IdeaAdminOptions)
