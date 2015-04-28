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
  controller: ['$scope', 'Session', ($scope, Session) ->

    $scope.owner = (idea) ->
      Session.owner(idea.creator_email) if idea
  ]

simplyDirectives.directive 'vote', ->
  restrict: 'E'
  template: JST["angular/widget/directives/templates/vote"]
  controller: ['$scope', 'Vote', 'Session', ($scope, Vote, Session) ->
    $scope.cant_vote = (idea) ->
      return unless idea
      if Session.owner(idea.creator_email)
        "You can't vote on your own idea"

    $scope.vote = (idea, val) ->
      # Early exit, not need to send to server
      return if Session.owner(idea.creator_email)

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
