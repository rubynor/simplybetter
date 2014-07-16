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

simplyDirectives.directive 'notifications', ->
  restrict: 'E'
  template: JST['angular/directives/templates/notifications'],
  controller: ['$scope', 'Notification', ($scope, Notification) ->
    $scope.notifications = Notification.query({token: $scope.token, user_email: $scope.email})
    $scope.goToIdea = (notification) ->
      # TODO: Update checked on click..
      $scope.$parent.notificationactive = !$scope.$parent.notificationactive
      notification.checked = true
      updated = new Notification(notification)
      updated.$update(
        (data) ->
          console.log JSON.stringify(data)
          window.location = "#/widget/#{notification.idea_id}"
      , (err) ->
        console.log(JSON.stringify(err))
      )
  ]
