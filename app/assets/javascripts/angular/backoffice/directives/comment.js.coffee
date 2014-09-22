CommentDirective = ->
  restrict: 'A'
  scope:
    comment: '='
  template: JST['angular/backoffice/templates/comment']
  controller: 'CommentsCtrl'
  controllerAs: 'commentCtrl'

angular
  .module('Backoffice')
  .directive('comment', [CommentDirective])
