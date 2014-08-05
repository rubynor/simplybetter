widget.factory 'Vote', ['$resource', '$cookieStore', ($resource, $cookieStore) ->
  $resource '/widget_api/votes/cast.json', { token: $cookieStore.get('token'), voter_email: $cookieStore.get('email') }
]
