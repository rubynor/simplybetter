widget.factory 'Vote', ['$resource', 'Session', ($resource, Session) ->
  $resource '/widget_api/votes/cast.json', { token: Session.token, user_email: Session.email }
]
