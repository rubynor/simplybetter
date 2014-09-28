widget.factory 'Support', ['$resource', 'Session', ($resource, Session) ->
  $resource '/widget_api/support_messages/:id.json', { id: '@id', token: Session.token(), user_email: Session.email() }
]
