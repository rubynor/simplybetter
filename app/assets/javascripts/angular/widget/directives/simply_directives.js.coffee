@simplyDirectives = angular.module('simplyDirectives', []);

simplyDirectives.directive 'onFinishRender', ['$timeout', ($timeout) ->
  restrict: 'A'
  link: (scope, element, attr) ->
    if scope.$last == true
      $timeout ->
        scope.$emit('ngRepeatFinished')
  ]

simplyDirectives.directive 'ideaNew', ->
  restrict: 'E'
  template: JST['angular/widget/directives/templates/idea_new']

simplyDirectives.directive 'ideaItem', ->
  restrict: 'E'
  template: JST["angular/widget/directives/templates/idea_item"]

simplyDirectives.directive 'vote', ->
  restrict: 'E'
  template: JST["angular/widget/directives/templates/vote"]
  controller: ['$scope', 'Vote', ($scope, Vote) ->
    $scope.vote = (idea, val) ->
      hash = {idea_id: idea.id, voter_email: $scope.email, value: val, votes_count: idea.votes_count, token: $scope.token, vote: {value: val}}
      vote = new Vote(hash)
      vote.$save(
        (data) ->
          $scope.idea.voter_status = data.value
          $scope.idea.votes_count = data.votes_count
          console.log JSON.stringify(data)
      , (err) ->
        console.log 'Something went wrong..'
        console.log err
      )
  ]

simplyDirectives.directive 'comments', ->
  restrict: 'E'
  template: JST['angular/widget/directives/templates/comments']
  controller: ['$scope', '$location', '$timeout', 'Comment', '$routeParams', ($scope, $location, $timeout, Comment, $routeParams) ->
    $scope.comments = Comment.query {idea_id: $routeParams.id}
    $scope.comment_id = $location.search().comment_id
    $scope.highlight = {comment: false}

    $scope.unhighlight = ->
      $scope.highlight.comment = false
      $scope.hasHighlighted = true

    $scope.highlight = ->
      if $scope.shouldHighlight()
        $elm = $("##{$scope.comment_id}")
        $('#simplybetterIdeasModalContent').animate({scrollTop: ($elm.offset().top - 150)},'slow')
        $scope.highlight.comment = true
        $timeout($scope.unhighlight, 3000)

    $scope.shouldHighlight = ->
      $scope.comment_id && $scope.comment_id != 'null'

    $scope.$on 'ngRepeatFinished', (ngRepeatFinishedEvent)  ->
      $scope.highlight()

    $scope.save_comment = (newComment) ->
      $scope.error_message = undefined
      $scope.success_message = undefined
      hash = { body: newComment, idea_id: $scope.idea.id, user: { email: $scope.email } }
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

simplyDirectives.directive 'notifications', ->
  restrict: 'E'
  template: JST['angular/widget/directives/templates/notifications'],
  controller: ['$scope', 'Notification', 'NotificationsCount', ($scope, Notification, NotificationsCount) ->
    $scope.notifications = Notification.query()

    $scope.notificationsActive = false
    $scope.new_notifications = {}

    $scope.new_notifications = NotificationsCount.get()

    $scope.toggleNotifications = ->
      $scope.notificationsActive = !$scope.notificationsActive

    $scope.timeago = (time) ->
      $.timeago(time)

    $scope.goToIdeaAndUpdateNotiCount = (notification) ->
      $scope.toggleNotifications()
      notification.checked = true
      updated = new Notification(notification)

      updated.$update(
        (data) ->
          window.location = "#/widget/#{notification.idea_id}?comment_id=#{notification.comment_id}"
          $scope.updateNotiCount();
      , (err) ->
        console.log(JSON.stringify(err))
      )
  ]
