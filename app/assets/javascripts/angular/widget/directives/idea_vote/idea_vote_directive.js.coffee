Vote = ->
  restrict: 'E'
  template: JST["angular/widget/directives/idea_vote/idea_vote_directive_template"]
  scope:
    idea: '='
  controller: ['$scope', 'Vote', 'Session', ($scope, Vote, Session) ->
    idea = $scope.idea
    $scope.cantVote = ->
      return unless idea
      if Session.owner(idea['creator_email'])
        "You can't vote on your own idea"

    $scope.vote = (val) ->
      # Early exit, not need to send to server
      return if Session.owner(idea.creator_email)

      hash = {idea_id: idea.id, value: val, votes_count: idea.votes_count, vote: {value: val}}
      vote = new Vote(hash)
      vote.$save(
        (data) ->
          idea.voter_status = data.value
          idea.votes_count = data.votes_count
          console.log JSON.stringify(data)
      , (err) ->
        console.log 'Something went wrong..'
        console.log err
      )
  ]

angular
  .module('simplyDirectives')
  .directive('vote', Vote)
