CommentCtrl = ($scope) ->
  @comment = $scope.comment
  return


CommentDirective = ->
  restrict: 'A'
  scope:
    comment: '='
  template: JST['angular/backoffice/templates/comment']
  controller: ['$scope', CommentCtrl]
  controllerAs: 'commentCtrl'

angular
  .module('Backoffice')
  .directive('comment', [CommentDirective])
