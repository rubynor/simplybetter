CommentsCtrl = ($scope, Comment) ->
  @comment = $scope.comment
  @toggleVisibleComment = =>
    updated_comment = new Comment( { id: @comment.id, visible: !@comment.visible } )
    updated_comment.$patch (data) =>
      @comment.visible = data.visible

  return

angular
  .module('Backoffice')
  .controller('CommentsCtrl', ['$scope', 'Comment', CommentsCtrl])
