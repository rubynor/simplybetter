IdeaAdminOptions = ->
  restrict: 'E'
  template: JST['angular/shared/directives/idea_admin_options/idea_admin_options_directive_template']
  require: '^ideaItem'
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
      Idea.delete($scope.idea)
      Redirect('overview')

    @isAdmin = ->
      Session.isAdmin()

    return
  ]
  controllerAs: 'options'
  link: (scope, element, attrs, ideaItemCtrl) ->
    scope.options.ideaEdit = ->
      ideaItemCtrl.editMode = true

angular
  .module('shared')
  .directive('ideaAdminOptions', IdeaAdminOptions)
