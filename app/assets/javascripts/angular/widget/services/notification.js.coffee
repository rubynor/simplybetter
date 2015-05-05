widget.factory 'Notification', ['$resource', 'Session', ($resource, Session) ->
  console.log 'Not factory called'
  $resource '/widget_api/notifications/:id.json', { id: '@id', info: Session.info }, { update: { method: 'PUT' } }
]
