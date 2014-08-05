widget.factory 'Session', ['$cookieStore', ($cookieStore) ->
  user_signed_in: ->
    $cookieStore.get('email') && $cookieStore.get('token')
]
