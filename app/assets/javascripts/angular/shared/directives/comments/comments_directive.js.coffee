Comments = ->
  restrict: 'E'
  template: JST['angular/shared/directives/comments/comments']
  controller: ['$scope', '$location', '$timeout', '$routeParams', 'Session', 'Comment', ($scope, $location, $timeout, $routeParams, Session, Comment) ->
    $scope.comments = Comment.query {idea_id: $routeParams.id}
    $scope.comment_id = $location.search().comment_id
    $scope.highlight = { comment: false }
    $scope.user = Session.user_signed_in()

    $scope.editComment = undefined

    resetAllEdit = ->
      angular.forEach($scope.comments, (comment) ->
        comment.$edit = false
      )

    $scope.toggleEdit = (c) ->
      resetAllEdit() unless c.$edit
      c.$edit = !c.$edit
      $scope.editComment = angular.copy(c) if c.$edit

    $scope.isAdmin = Session.isAdmin()

    $scope.toggleVisible = (c) ->
      hash = { comment: {visible: !c.visible }, idea_id: $scope.idea.id, id: c.id }
      comment = new Comment(hash)
      comment.$update(
        (data) ->
          c.visible = data.visible
      )

    $scope.owner = (c) ->
      owner = Session.owner(c.creator_email)
      owner

    $scope.updateComment = (original, c) ->
      original.$edit = false
      $scope.error_message = undefined
      $scope.success_message = undefined
      hash = { comment: { body: c.body }, idea_id: $scope.idea.id, id: c.id }
      comment = new Comment(hash)
      comment.$update(
        (data) ->
          original.body = data.body
          setTimeout  (->
            $scope.success_message = undefined
            $scope.$apply()
          ), 2000
          $scope.success_message = 'Your comment has been updated'
        , (err) ->
          $scope.error_message = err.data
      )


    unhighlightComment = ->
      $scope.highlight.comment = false
      $scope.hasHighlighted = true

    commentNotFound = (elm) ->
      if elm.length == 0
        $scope.error_message = 'This comment is not available'
        true
      else
        $scope.error_message = undefined
        false
    
    highlightComment = ->
      $elm = $("##{$scope.comment_id}")
      return if commentNotFound($elm)
      $('#simplybetterIdeasModalContent').animate({scrollTop: ($elm.position().top - 150)},'slow')
      $scope.highlight.comment = true
      $timeout(unhighlightComment, 3000)

    shouldHighlightComment = ->
      $scope.comment_id && $scope.comment_id != 'null'

    $scope.$on 'ngRepeatFinished', (ngRepeatFinishedEvent)  ->
      highlightComment() if shouldHighlightComment()

    $scope.save_comment = (newComment) ->
      $scope.error_message = undefined
      $scope.success_message = undefined
      hash = { body: newComment, idea_id: $scope.idea.id }
      comment = new Comment(hash)
      comment.$save(
        (data) ->
          $scope.comments.push(data)
          $scope.idea.comments_count += 1
          $scope.newComment = undefined
          $scope.success_message = 'Thank you for your comment'
          $scope.comment_id = data.id
      , (err) ->
        console.log JSON.stringify(err)
        $scope.error_message = err.data
      )
  ]

angular.module('shared').directive('comments', Comments)
