widget.factory 'NotificationsCount', ['$resource', 'Session', ($resource, Session) ->
  $resource '/widget_api/notifications/count', { info: Session.info }
]
