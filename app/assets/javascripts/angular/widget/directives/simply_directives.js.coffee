@simplyDirectives = angular.module('simplyDirectives', [])

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
  controller: ['$scope', 'Session', ($scope, Session) ->
    $scope.user = Session.user_signed_in()
  ]

simplyDirectives.directive 'ideaItem', ->
  restrict: 'E'
  template: JST["angular/widget/directives/templates/idea_item"]
  controller: ['$scope', '$cookieStore', 'Session', ($scope, $cookieStore, Session) ->

    $scope.owner = (idea) ->
      Session.owner(idea.creator_email)
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
  controller: ['$scope', '$location', '$timeout', '$routeParams', 'Session', 'Comment', ($scope, $location, $timeout, $routeParams, Session, Comment) ->
    $scope.comments = Comment.query {idea_id: $routeParams.id}
    $scope.comment_id = $location.search().comment_id
    $scope.highlight = { comment: false }
    $scope.user = Session.user_signed_in()

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
          $('#simplybetterIdeasModalContent').animate({scrollTop: ($elm.position().top - 150)},'slow')
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
  controller: ['$scope', 'Session', 'Notification', 'NotificationsCount', 'Redirect', ($scope, Session, Notification, NotificationsCount, Redirect) ->
    user = Session.user_signed_in()
    $scope.notifications = Notification.query() if user

    $scope.notificationsActive = false
    $scope.new_notifications = undefined

    $scope.updateNotiCount = ->
      $scope.new_notifications = NotificationsCount.get()

    $scope.toggleNotifications = ->
      $scope.notificationsActive = !$scope.notificationsActive

    if user
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
  controller: ['$scope', 'Session', ($scope, Session) ->
    @hidden = true
    if Session.user_signed_in()
      @hidden = false
  ]
  controllerAs: 'button'

simplyDirectives.directive 'emailSettings', ->
  restrict: 'E'
  template: JST['angular/widget/directives/templates/email_settings']
  controller: ['$scope', '$timeout', 'EmailSettings', ($scope, $timeout, EmailSettings) ->
    @justSubscribed = false
    @justUnsubscribed = false
    @error = false

    @settings = EmailSettings.get()

    @submit = ->
      EmailSettings.update( =>
        if @settings.unsubscribed
          @justUnsubscribed = true
          @hideAlert()
        else
          @justSubscribed = true
          @hideAlert()
        @hideError()
      , (error) =>
        @error = true
      )

    @hideAlert = () ->
      $timeout( =>
        @justSubscribed = false
        @justUnsubscribed = false
      , 3000)

    @hideError = ->
      @error = false

    $scope.$watch 'emailSetting.settings.unsubscribed', (newValue, oldValue) =>
      unless oldValue == undefined || newValue == undefined
        @submit()

    return
  ]
  controllerAs: 'emailSetting'
