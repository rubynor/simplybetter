widget.factory 'Idea', ['$resource', '$cookieStore', ($resource, $cookieStore) ->
  $resource '/widget_api/ideas/:id.json', {id: '@id', token: $cookieStore.get('token'), user_email: $cookieStore.get('email') }, { patch: { method: 'PATCH' } }
]
