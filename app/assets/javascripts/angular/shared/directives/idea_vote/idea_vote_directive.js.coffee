Vote = ->
  restrict: 'E'
  template: JST["angular/shared/directives/idea_vote/idea_vote_directive_template"]
  scope:
    idea: '='
  controller: ['$scope', 'Vote', 'Session', ($scope, Vote, Session) ->
    $scope.cantVote = ->
      return unless $scope.idea
      if Session.owner($scope.idea['creator_email'])
        "You can't vote on your own idea"

    $scope.vote = (val) ->
      # Early exit, not need to send to server
      return if Session.owner($scope.idea.creator_email)

      hash = {idea_id: $scope.idea.id, value: val, votes_count: $scope.idea.votes_count, vote: {value: val}}
      vote = new Vote(hash)
      vote.$save(
        (data) ->
          $scope.idea.voter_status = data.value
          $scope.idea.votes_count = data.votes_count
      , (err) ->
        console.log 'Something went wrong..'
        console.log err
      )
  ]

angular
  .module('shared')
  .directive('vote', Vote)
