widget.controller 'VoteCtrl', ['$scope', 'Vote', ($scope, Vote) ->

  $scope.vote = (idea, val) ->
    hash = {idea_id: idea.id, voter_email: $scope.email, value: val, votes_count: idea.votes_count, token: $scope.token, vote: {value: val}}
    vote = new Vote(hash)
    vote.$save(
      (data) ->
        $scope.idea.voter_status = data.value
        $scope.idea.votes_count = data.votes_count
        console.log JSON.stringify(data)
    , (err) ->
      console.log 'Somenthing went wrong..'
    )
]
