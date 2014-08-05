widget.factory 'Comment', ['$resource', '$cookieStore', ($resource, $cookieStore) ->
  $resource '/widget_api/ideas/:idea_id/comments/:id.json', {idea_id: '@idea_id', id: '@id', token: $cookieStore.get('token'), user_email: $cookieStore.get('email')}
]
