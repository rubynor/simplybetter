widget.factory 'User', ['$resource', '$cookieStore', ($resource, $cookieStore) ->
  $resource '/widget_api/user.json',
    email: $cookieStore.get('email')
    token: $cookieStore.get('token')
  ,
    update:
      method: 'PUT'
      params:
        email: $cookieStore.get('email')
        token: $cookieStore.get('token')
]
