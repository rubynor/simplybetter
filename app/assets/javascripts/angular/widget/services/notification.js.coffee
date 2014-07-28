widget.factory 'Notification', ['$resource', ($resource) ->
  $resource '/widget_api/notifications/:id.json', { id: '@id', token: token, user_email: email}, { update: { method: 'PUT' } }
]
