IdeaItem = ->
  restrict: 'E'
  template: JST["angular/shared/directives/idea_item/idea_item_directive_template"]
  transclude: true
  scope:
    idea: '='
    expanded: '='
  controller: ['$scope', 'Session', ($scope, Session) ->
    $scope.owner = ->
      Session.owner($scope.idea.creator_email) if $scope.idea
    return
  ]

angular
  .module('shared')
  .directive('ideaItem', IdeaItem)
