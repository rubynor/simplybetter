IdeaItem = ->
  restrict: 'E'
  template: JST["angular/shared/directives/idea_item/idea_item_directive_template"]
  transclude: true
  scope:
    idea: '='
    expanded: '='
  controller: ['$scope', 'Session', 'Idea', ($scope, Session, Idea) ->
    $scope.owner = ->
      Session.owner($scope.idea.creator_email) if $scope.idea

    @editMode = false
    @editIdea = Idea.dupe($scope.idea)

    @ideaUpdate = =>
      $scope.idea = @editIdea
      Idea.update($scope.idea)
      @editMode = false

    @cancelIdeaUpdate = =>
      @editIdea = Idea.dupe($scope.idea)
      @editMode = false

    return
  ]
  controllerAs: 'ideaItemCtrl'

angular
  .module('shared')
  .directive('ideaItem', IdeaItem)
