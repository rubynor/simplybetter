widget.factory 'Vote', ['$resource', 'Session', ($resource, Session) ->
  $resource '/widget_api/votes/cast.json', { token: Session.token, voter_email: Session.email }
]
