widget.factory 'NotificationsCount', ['$resource', 'Session', ($resource, Session) ->
  $resource '/widget_api/notifications/count', { token: Session.token, user_email: Session.email }
]
