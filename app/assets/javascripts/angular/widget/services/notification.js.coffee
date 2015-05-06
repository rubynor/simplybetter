widget.factory 'Notification', ['$resource', 'Session', ($resource, Session) ->
  $resource '/widget_api/notifications/:id.json', { id: '@id', info: Session.info }, { update: { method: 'PUT' } }
]
