@simplyDirectives = angular.module('simplyDirectives', []);

simplyDirectives.directive 'ideaNew', ->
  restrict: 'E'
  template: JST['angular/directives/templates/idea_new']

simplyDirectives.directive 'ideaItem', ->
  restrict: 'E'
  template: JST["angular/directives/templates/idea_item"]

simplyDirectives.directive 'vote', ->
  restrict: 'E'
  template: JST["angular/directives/templates/vote"]
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
  template: JST['angular/directives/templates/comments']
  scope:
    comments: '='
  controller: ['$scope', '$location', '$timeout', 'Comment', ($scope, $location, $timeout, Comment) ->
    $scope.comment_id = $location.search().comment_id
    $scope.highlight = {comment: false}

    $scope.unhighlight = ->
      $scope.highlight.comment = false

    $scope.highlight = ->
      if $scope.comment_id != 'null'
        $scope.highlight.comment = true
        $timeout($scope.unhighlight, 3000)

    $timeout($scope.highlight, 500)

    $scope.save_comment = (newComment) ->
      $scope.error_message = undefined
      $scope.success_message = undefined
      hash = { body: newComment, idea_id: $scope.$parent.idea.id, user: { email: $scope.$parent.email } }
      comment = new Comment(hash)
      comment.$save(
        (data) ->
          $scope.comments.push(data)
          $scope.$parent.idea.comments_count += 1
          $scope.newComment = undefined
          $scope.success_message = 'Thank you for your comment'
      , (err) ->
        console.log JSON.stringify(err)
        $scope.error_message = err.data
      )
  ]

simplyDirectives.directive 'notifications', ->
  restrict: 'E'
  template: JST['angular/directives/templates/notifications'],
  controller: ['$scope', 'Notification', ($scope, Notification) ->
    $scope.notifications = Notification.query({token: $scope.token, user_email: $scope.email})
    $scope.goToIdea = (notification) ->
      $scope.$parent.notificationactive = !$scope.$parent.notificationactive
      notification.checked = true
      updated = new Notification(notification)
      updated.$update(
        (data) ->
          console.log JSON.stringify(data)
          window.location = "#/widget/#{notification.idea_id}?comment_id=#{notification.comment_id}"
      , (err) ->
        console.log(JSON.stringify(err))
      )
  ]
