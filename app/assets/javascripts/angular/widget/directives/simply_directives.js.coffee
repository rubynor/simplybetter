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
  controller: ['$scope', '$cookieStore', ($scope, $cookieStore) ->
    $scope.user = $cookieStore.get('email')
  ]

simplyDirectives.directive 'ideaItem', ->
  restrict: 'E'
  template: JST["angular/widget/directives/templates/idea_item"]
  controller: ['$scope', '$cookieStore', ($scope, $cookieStore) ->
    email = $cookieStore.get('email')

    $scope.owner = (idea) ->
      idea.creator_email == email
  ]

simplyDirectives.directive 'vote', ->
  restrict: 'E'
  template: JST["angular/widget/directives/templates/vote"]
  controller: ['$scope', 'Vote', ($scope, Vote) ->
    $scope.vote = (idea, val) ->
      hash = {idea_id: idea.id, value: val, votes_count: idea.votes_count, vote: {value: val}}
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
  controller: ['$scope', '$location', '$timeout', '$routeParams', 'Comment', ($scope, $location, $timeout, $routeParams, Comment) ->
    $scope.comments = Comment.query {idea_id: $routeParams.id}
    $scope.comment_id = $location.search().comment_id
    $scope.highlight = { comment: false }

    $scope.unhighlight = ->
      $scope.highlight.comment = false
      $scope.hasHighlighted = true

    $scope.highlight = ->
      if $scope.shouldHighlight()
        $elm = $("##{$scope.comment_id}")
        if $elm.length == 0
          $scope.error_message = 'This comment is not available'
        else
          $scope.error_message = undefined
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

simplyDirectives.directive 'notifications', ->
  restrict: 'E'
  template: JST['angular/widget/directives/templates/notifications'],
  controller: ['$scope', '$cookieStore', 'Notification', 'NotificationsCount', 'Redirect', ($scope, $cookieStore, Notification, NotificationsCount, Redirect) ->
    $scope.notifications = Notification.query() if $cookieStore.get('email')

    $scope.notificationsActive = false
    $scope.new_notifications = undefined

    $scope.updateNotiCount = ->
      $scope.new_notifications = NotificationsCount.get()

    $scope.toggleNotifications = ->
      $scope.notificationsActive = !$scope.notificationsActive

    if $cookieStore.get('email')
      $scope.updateNotiCount()

    $scope.timeago = (time) ->
      $.timeago(time)

    $scope.goToIdeaAndUpdateNotiCount = (notification) ->
      $scope.toggleNotifications()
      notification.checked = true
      updated = new Notification(notification)

      updated.$update(
        (data) ->
          Redirect('idea', { id: notification.idea_id }, "?comment_id=#{notification.comment_id}")
          $scope.updateNotiCount();
      , (err) ->
        console.log(JSON.stringify(err))
      )
  ]

simplyDirectives.directive 'accountSettingsButton', ->
  restrict: 'E'
  template: JST['angular/widget/directives/templates/account_settings_button']
  controller: ['$scope', ($scope) ->
    @hidden = true
    if $scope.email
      @hidden = false
  ]
  controllerAs: 'button'
