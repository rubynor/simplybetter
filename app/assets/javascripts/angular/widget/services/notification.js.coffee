widget.factory 'Notification', ['$resource', '$cookieStore', ($resource, $cookieStore) ->
  $resource '/widget_api/notifications/:id.json', { id: '@id', token: $cookieStore.get('token'), user_email: $cookieStore.get('email') }, { update: { method: 'PUT' } }
]
