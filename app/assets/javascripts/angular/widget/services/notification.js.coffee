widget.factory 'Notification', ['$resource', 'Session', ($resource, Session) ->
  $resource '/widget_api/notifications/:id.json', { id: '@id', token: Session.token, user_email: Session.email }, { update: { method: 'PUT' } }
]
