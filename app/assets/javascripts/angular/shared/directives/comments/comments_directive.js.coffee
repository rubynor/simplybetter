Comments = ->
  restrict: 'E'
  template: JST['angular/shared/directives/comments/comments']
  controller: ['$scope', '$location', '$timeout', '$stateParams', 'Session', 'ngToast', 'Comment', ($scope, $location, $timeout, $stateParams, Session, ngToast, Comment) ->
    $scope.isSaving = false
    $scope.comments = Comment.query {idea_id: $stateParams.id}
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
      Session.owner(c.creator_email)

    $scope.updateComment = (original, c) ->
      original.$edit = false
      hash = { comment: { body: c.body }, idea_id: $scope.idea.id, id: c.id }
      comment = new Comment(hash)
      comment.$update(
        (data) ->
          original.body = data.body
          ngToast.create(
            content: 'Your comment has been updated'
          )
        , (err) ->
          ngToast.create(
            content: err.data.error
            className: 'danger'
          )
      )


    unhighlightComment = ->
      $scope.highlight.comment = false
      $scope.hasHighlighted = true

    commentNotFound = (elm) ->
      if elm.length == 0
        ngToast.create(
          content: 'This comment is not available'
          className: 'danger'
        )
        true
      else
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
      $scope.isSaving = true
      hash = { body: newComment, idea_id: $scope.idea.id }
      comment = new Comment(hash)
      comment.$save (data) ->
        $scope.comments.push(data)
        $scope.idea.comments_count += 1
        $scope.newComment = undefined
        ngToast.create(
          content: 'Than you for your comsdfsfment'
        )
        $scope.isSaving = false
        $scope.comment_id = data.id
      , (err) ->
        ngToast.create(
          content: err.data.error,
          className: 'danger'
        )
        $scope.isSaving = false

  ]

angular.module('shared').directive('comments', Comments)
