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

    if $scope.idea.$promise
      $scope.idea.$promise.then (idea) =>
        @editIdea = Idea.dupe(idea)
    else
      @editIdea = Idea.dupe($scope.idea)

    @ideaUpdate = =>
      Idea.updateOptimistic $scope.idea, @editIdea, =>
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
